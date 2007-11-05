/*
 * File   : $Source: /alkacon/cvs/alkacon/com.alkacon.opencms.newsletter/src/com/alkacon/opencms/newsletter/admin/CmsNewsletterToolHandler.java,v $
 * Date   : $Date: 2007/10/26 14:53:40 $
 * Version: $Revision: 1.2 $
 *
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (c) 2002 - 2007 Alkacon Software GmbH (http://www.alkacon.com)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * For further information about Alkacon Software GmbH, please see the
 * company website: http://www.alkacon.com
 *
 * For further information about OpenCms, please see the
 * project website: http://www.opencms.org
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

package com.alkacon.opencms.newsletter.admin;

import com.alkacon.opencms.newsletter.CmsNewsletterManager;

import org.opencms.main.CmsException;
import org.opencms.workplace.CmsWorkplace;
import org.opencms.workplace.tools.CmsDefaultToolHandler;

/**
 * Newsletter management tool handler that hides the tool if the current user
 * has not the needed privileges or no newsletter ou is available.<p>
 * 
 * @author Andreas Zahner  
 * 
 * @version $Revision $ 
 * 
 * @since 7.0.3 
 */
public class CmsNewsletterToolHandler extends CmsDefaultToolHandler {

    /**
     * @see org.opencms.workplace.tools.A_CmsToolHandler#isEnabled(org.opencms.workplace.CmsWorkplace)
     */
    public boolean isEnabled(CmsWorkplace wp) {

        if (getPath().equals("/newsletter")) {
            // only display the newsletter icon if there is at least one mailing list ou you can manage
            try {
                return !CmsNewsletterManager.getOrgUnits(wp.getCms()).isEmpty();
            } catch (CmsException e) {
                return false;
            }
        }

        return true;
    }

    /**
     * @see org.opencms.workplace.tools.A_CmsToolHandler#isVisible(org.opencms.workplace.CmsWorkplace)
     */
    public boolean isVisible(CmsWorkplace wp) {

        // only display the newsletter icon if there is at least one mailing list ou you can manage
        try {
            return !CmsNewsletterManager.getOrgUnits(wp.getCms()).isEmpty();
        } catch (CmsException e) {
            return false;
        }
    }
}