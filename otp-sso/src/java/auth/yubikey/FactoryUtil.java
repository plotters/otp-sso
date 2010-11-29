/*
 * Copyright 2008 Yubico
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); 
 * you may not use this file except in compliance with the License. 
 *
 * You may obtain a copy of the License at 
 *   http://www.apache.org/licenses/LICENSE-2.0 
 * 
 * Unless required by applicable law or agreed to in writing, software 
 * distributed under the License is distributed on an "AS IS" BASIS, 
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
 *
 * See the License for the specific language governing permissions and 
 * limitations under the License.
 *
 */
package auth.yubikey;

import java.util.Iterator;
import java.util.Map;

public class FactoryUtil
{
  static Map normalize (Map map)
  {
    Iterator iter = map.entrySet ().iterator ();
    while (iter.hasNext ())
      {
	Map.Entry me = (Map.Entry) iter.next ();
	Object o = me.getValue ();
	if (o instanceof String)
	  {
	    continue;
	  }
	else if (o instanceof String[])
	  {
	    String[]s = (String[])o;
	    me.setValue (s[0]);
	  }
	else
	  {
	    throw new IllegalArgumentException ("Cannot normalize " + o);
	  }
      }
    return map;
  }
}
