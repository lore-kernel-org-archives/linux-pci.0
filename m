Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp05.br.ibm.com ([32.104.18.26]:32843 "EHLO
	e24smtp05.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877Ab2LMXEK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2012 18:04:10 -0500
Received: from /spool/local
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <lucaskt@linux.vnet.ibm.com>;
	Thu, 13 Dec 2012 21:04:08 -0200
Message-ID: <50CA5EE2.30206@linux.vnet.ibm.com>
Date: Thu, 13 Dec 2012 21:04:02 -0200
From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: dri-devel@lists.freedesktop.org
CC: David Airlie <airlied@linux.ie>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	brking@linux.vnet.ibm.com, benh@au1.ibm.com
Subject: drm: Added ppc64 root device getter
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On architectures such as ppc64, there is no root bus device (it belongs
to the hypervisor). DRM attempted to get one, causing a null-pointer
dereference.

Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>

--
diff --git a/arch/powerpc/platforms/pseries/Makefile 
b/arch/powerpc/platforms/pseries/Makefile
index 890622b..ddfdda8 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -1,6 +1,8 @@
  ccflags-$(CONFIG_PPC64)			:= -mno-minimal-toc
  ccflags-$(CONFIG_PPC_PSERIES_DEBUG)	+= -DDEBUG

+drm-y			+= drm_pci.o
+
  obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
  			   setup.o iommu.o event_sources.o ras.o \
  			   firmware.o power.o dlpar.o mobility.o
diff --git a/arch/powerpc/platforms/pseries/drm_pci.c 
b/arch/powerpc/platforms/pseries/drm_pci.c
new file mode 100644
index 0000000..da6675e
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/drm_pci.c
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012 Lucas Kannebley Tavares, IBM Corporation
+ *
+ * pSeries specific routines for DRM.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+inline struct pci_device *drm_get_parent_device(struct drm_device *dev) {
+	return (dev->pdev->bus->self == NULL) ? dev->pdev : dev->pdev->bus->self;
+}
+
diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index eb37466..5a8a4f5 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -466,6 +466,10 @@ void drm_pci_exit(struct drm_driver *driver, struct 
pci_driver *pdriver)
  }
  EXPORT_SYMBOL(drm_pci_exit);

+inline __weak struct pci_device *drm_get_parent_device(struct 
drm_device *dev) {
+	return dev->pdev->bus->self;
+}
+
  int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
  {
  	struct pci_dev *root;
@@ -479,7 +483,7 @@ int drm_pcie_get_speed_cap_mask(struct drm_device 
*dev, u32 *mask)
  		return -EINVAL;

  	// find PCI device for capabilities
-	root = dev->pdev->bus->self;
+	root = drm_get_parent_device(dev);

  	// some architectures might not have host bridges as PCI devices
  	if (root == NULL)

-- 
Lucas Kannebley Tavares
Software Engineer
IBM Linux Technology Center

