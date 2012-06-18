Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:48597 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab2FRFDv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jun 2012 01:03:51 -0400
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Sun, 17 Jun 2012 23:03:51 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 37EFF19D805E
	for <linux-pci@vger.kernel.org>; Mon, 18 Jun 2012 05:03:46 +0000 (WET)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5I53aO8182162
	for <linux-pci@vger.kernel.org>; Sun, 17 Jun 2012 23:03:40 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5I53aph023872
	for <linux-pci@vger.kernel.org>; Sun, 17 Jun 2012 23:03:36 -0600
Received: from us.ibm.com ([9.123.236.202])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with SMTP id q5I53YVf023422
	for <linux-pci@vger.kernel.org>; Sun, 17 Jun 2012 23:03:35 -0600
Date: Mon, 18 Jun 2012 13:03:33 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [RFC PATCH] methods to access resources of a struct pci_dev
Message-ID: <20120618050333.GA13469@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI: methods to access resources of struct pci_dev

Currently pci_dev structure holds an array of 17 PCI resources; six base
BARs, one ROM BAR, four BRIDGE BARs, six sriov BARs.  This is wasteful.
A bridge device just needs the 4 bridge resources. A non-bridge device
just needs the six base resources and one ROM resource. The sriov
resources are needed only if the device has SRIOV capability.

The pci_dev structure needs to be re-organized to avoid unnecessary
bloating.  However too much code outside the pci-bus driver, assumes the
internal details of the pci_dev structure, thus making it hard to
re-organize the datastructure.

As a first step this patch provides generic methods to access the
resource structure of the pci_dev.

Once this patch is accepted, I have another 40+ patches that modify all
the files that directly access the resource structure, to use the new
methods provided in the first step.

Finally we can re-organize the resource structure in the pci_dev
structure and correspondingly update the methods.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>

diff --git a/include/linux/pci.h b/include/linux/pci.h
index e444f5b..475b10d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1350,6 +1350,58 @@ static inline int pci_domain_nr(struct pci_bus *bus)
 							\
 	 (pci_resource_end((dev), (bar)) -		\
 	  pci_resource_start((dev), (bar)) + 1))
+#define pci_get_std_resource(dev, bar)     (((dev)->resource)+bar)
+#define pci_get_sriov_resource(dev, bar)     (((dev)->resource)+bar+PCI_IOV_RESOURCES)
+#define pci_get_bridge_resource(dev, bar)    (((dev)->resource)+bar+PCI_BRIDGE_RESOURCES)
+#define pci_get_rom_resource(dev)    	     (((dev)->resource)+PCI_ROM_RESOURCE)
+#define pci_resource_number(dev, res)	     (res - (dev)->resource)
+
+/* code that assume the current resource layout will continue to operate */
+static inline struct resource *pci_get_resource(struct pci_dev *pdev, int bar)
+{
+	if (bar >= 0 && bar < PCI_ROM_RESOURCE)
+		return pci_get_std_resource(pdev, bar);
+	else if (bar == PCI_ROM_RESOURCE)
+		return pci_get_rom_resource(pdev);
+	else if (bar <= PCI_IOV_RESOURCE_END)
+		return pci_get_sriov_resource(pdev, bar-PCI_IOV_RESOURCES);
+	else if (bar <= PCI_BRIDGE_RESOURCE_END)
+		return pci_get_bridge_resource(pdev, bar-PCI_BRIDGE_RESOURCES);
+	else
+		return NULL;
+}
+
+#define for_each_resource(dev, res, i) \
+	for (i = 0;	\
+	    (res = pci_get_resource(dev, i)) || i < PCI_NUM_RESOURCES; \
+	     i++)
+
+#define for_each_std_resource(dev, res, i) \
+	for (i = 0;	\
+	    (res = pci_get_std_resource(dev, i)) || i <= PCI_STD_RESOURCE_END; \
+	     i++)
+
+#define for_each_std_and_rom_resource(dev, res, i) \
+	for (i = 0;	\
+	    (res = (i==PCI_ROM_RESOURCE)? pci_get_rom_resource(dev) : \
+			pci_get_std_resource(dev, i)) || \
+			i <= PCI_ROM_RESOURCE; \
+	     i++)
+
+#define for_each_sriov_resource(dev, res, i) \
+	for (i = 0;	\
+	    (res = pci_get_sriov_resource(dev, i)) || i < PCI_SRIOV_NUM_BARS; \
+	     i++)
+
+#define for_each_bridge_resource(dev, res, i) \
+	for (i = 0;	\
+	    (res = pci_get_bridge_resource(dev, i)) || i < PCI_BRIDGE_RESOURCE_NUM; \
+	     i++)
+
+#define pci_get_res_attr(dev, bar) (((dev)->res_attr)[bar])
+#define pci_get_res_attrwc(dev, bar) (((dev)->res_attr_wc)[bar])
+#define pci_set_res_attr(dev, bar, value) (((dev)->res_attr)[bar] = value)
+#define pci_set_res_attrwc(dev, bar, value) (((dev)->res_attr_wc)[bar] = value)

 /* Similar to the helpers above, these manipulate per-pci_dev
  * driver-specific data.  They are really just a wrapper around

