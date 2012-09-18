package com.cabletech.core.common;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;

import org.apache.log4j.Logger;

/**
 * 反射工具类
 * @author cqp
 *
 */
public class ReflectUtil {
	private static Logger log = Logger.getLogger(ReflectUtil.class);
	/**
	 * 对对象进行反射
	 * @param obj 目标对象
	 * @param fieldName 字段名称
	 * @param fieldVal 字段值
	 * @param type 字段类型
	 * @return
	 */
	private static Object operate(Object obj, String fieldName, Object fieldVal, String type) {
		Object ret = null;
		try {// 获得对象类型
//			obj.getClass()  获得对象类型
//			classType.getDeclaredFields() 获得对象的所有属性
			for (int i = 0; i < obj.getClass().getDeclaredFields().length; i++) {
				Field field = obj.getClass().getDeclaredFields()[i];
				if (field.getName().equals(fieldName)) {
					String firstLetter = fieldName.substring(0, 1).toUpperCase(); // 获得和属性对应的getXXX()方法的名字
					if ("set".equals(type)) {
						String setMethodName = "set" + firstLetter+ fieldName.substring(1); // 获得和属性对应的getXXX()方法
						Method setMethod = obj.getClass().getMethod(setMethodName,new Class[] { field.getType() }); // 调用原对象的getXXX()方法
						ret = setMethod.invoke(obj, new Object[] { fieldVal });
					}
					if ("get".equals(type)) {
						String getMethodName = "get" + firstLetter	+ fieldName.substring(1); // 获得和属性对应的setXXX()方法的名字
						Method getMethod = obj.getClass().getMethod(getMethodName,new Class[] {});
						ret = getMethod.invoke(obj, new Object[] {});
					}
					return ret;
				}
			}
		} catch (Exception e) {
			log.warn("reflect error:" + fieldName, e);
		}
		return ret;
	}
	
	/**
	 * 根据对象和字段名称返回值
	 * @param obj 对象
	 * @param fieldName 字段名称
	 * @return
	 */
	public static Object getVal(Object obj, String fieldName) {
		return operate(obj, fieldName, null, "get");
	}

	/**
	 * 设置对象的属性值
	 * @param obj 对象
	 * @param fieldName 字段名称
	 * @param fieldVal 字段值
	 */
	public static void setVal(Object obj, String fieldName, Object fieldVal) {
		operate(obj, fieldName, fieldVal, "set");
	}

	/**
	 * @param object 对象
	 * @param methodName 字段名称
	 * @param parameterTypes 类型
	 * @return
	 */
	private static Method getDeclaredMethod(Object object, String methodName,
			Class<?>[] parameterTypes) {
		for (Class<?> superClass = object.getClass(); superClass != Object.class; superClass = superClass
				.getSuperclass()) {
			try {
				// superClass.getMethod(methodName, parameterTypes);
				return superClass.getDeclaredMethod(methodName, parameterTypes);
			} catch (NoSuchMethodException e) {
				// Method 不在当前类定义, 继续向上转型
			}
		}

		return null;
	}

	/**
	 * 
	 * @param field 文件
	 */
	private static void makeAccessible(Field field) {
		if (!Modifier.isPublic(field.getModifiers())) {
			field.setAccessible(true);
		}
	}
	/**
	 * 
	 * @param object  对象
	 * @param filedName 字段名
	 * @return
	 */
	private static Field getDeclaredField(Object object, String filedName) {
		for (Class<?> superClass = object.getClass(); superClass != Object.class; superClass = superClass
				.getSuperclass()) {
			try {
				return superClass.getDeclaredField(filedName);
			} catch (NoSuchFieldException e) {
				// Field 不在当前类定义, 继续向上转型
			}
		}
		return null;
	}

	/**
	 * 
	 * @param object 对象	
	 * @param methodName 方法名
	 * @param parameterTypes 类型
	 * @param parameters 属性
	 * @return
	 * @throws InvocationTargetException
	 */
	public static Object invokeMethod(Object object, String methodName,
			Class<?>[] parameterTypes, Object[] parameters)
			throws InvocationTargetException {
		Method method = getDeclaredMethod(object, methodName, parameterTypes);

		if (method == null) {
			throw new IllegalArgumentException("Could not find method ["
					+ methodName + "] on target [" + object + "]");
		}

		method.setAccessible(true);

		try {
			return method.invoke(object, parameters);
		} catch (IllegalAccessException e) {

		}

		return null;
	}
	/**
	 * 
	 * @param object 对象
	 * @param fieldName 字段名
	 * @param value 值
	 */
	public static void setFieldValue(Object object, String fieldName,
			Object value) {
		Field field = getDeclaredField(object, fieldName);

		if (field == null)
			throw new IllegalArgumentException("Could not find field ["
					+ fieldName + "] on target [" + object + "]");

		makeAccessible(field);

		try {
			field.set(object, value);
		} catch (IllegalAccessException e) {
		}
	}
		/**
		 * 
		 * @param object 对象
		 * @param fieldName 字段名
		 * @return
		 */
	public static Object getFieldValue(Object object, String fieldName) {
		Field field = getDeclaredField(object, fieldName);
		if (field == null)
			throw new IllegalArgumentException("Could not find field ["
					+ fieldName + "] on target [" + object + "]");

		makeAccessible(field);

		Object result = null;
		try {
			result = field.get(object);
		} catch (IllegalAccessException e) {
		}

		return result;
	}
}
