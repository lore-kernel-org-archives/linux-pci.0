Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp03.br.ibm.com ([32.104.18.24]:43960 "EHLO
	e24smtp03.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab3CTFZN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Mar 2013 01:25:13 -0400
Received: from /spool/local
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <lucaskt@linux.vnet.ibm.com>;
	Wed, 20 Mar 2013 02:25:12 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 817241DC004E
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2013 01:25:04 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r2K5OKvl20709578
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2013 02:24:20 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r2K5P2S5029720
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2013 02:25:04 -0300
From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org
Cc: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@linux.ie>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Brian King <brking@linux.vnet.ibm.com>,
	Thadeu Cascardo <cascardo@linux.vnet.ibm.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCHv2 1/3] pci: added pcie_get_speed_cap_mask function
Date: Wed, 20 Mar 2013 02:24:37 -0300
Message-Id: <1363757079-23550-2-git-send-email-lucaskt@linux.vnet.ibm.com>
In-Reply-To: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
References: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Added function to gather the speed cap for a device and return a mask to
supported speeds. The function is divided into an interface and a weak
implementation so that architecture-specific functions can be called.

This is the first step in moving function drm_pcie_get_speed_cap_mask
from the drm subsystem to the pci one.

Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
---
 drivers/pci/pci.c   |   44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |    6 ++++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b099e00..d94ab79 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3931,6 +3931,50 @@ static int __init pci_setup(char *str)
 }
 early_param("pci", pci_setup);
 
+int __weak pcibios_get_speed_cap_mask(struct pci_dev *dev, u32 *mask)
+{
+	struct pci_dev *root;
+	u32 lnkcap, lnkcap2;
+
+	*mask = 0;
+	if (!dev)
+		return -EINVAL;
+
+	root = dev->bus->self;
+
+	/* we've been informed via and serverworks don't make the cut */
+	if (root->vendor == PCI_VENDOR_ID_VIA ||
+	    root->vendor == PCI_VENDOR_ID_SERVERWORKS)
+		return -EINVAL;
+
+	pcie_capability_read_dword(root, PCI_EXP_LNKCAP, &lnkcap);
+	pcie_capability_read_dword(root, PCI_EXP_LNKCAP2, &lnkcap2);
+
+	if (lnkcap2) {	/* PCIe r3.0-compliant */
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
+			*mask |= PCIE_SPEED_25;
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
+			*mask |= PCIE_SPEED_50;
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
+			*mask |= PCIE_SPEED_80;
+	} else {	/* pre-r3.0 */
+		if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
+			*mask |= PCIE_SPEED_25;
+		if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
+			*mask |= (PCIE_SPEED_25 | PCIE_SPEED_50);
+	}
+
+	dev_info(&dev->dev, "probing gen 2 caps for device %x:%x = %x/%x\n",
+		root->vendor, root->device, lnkcap, lnkcap2);
+	return 0;
+}
+
+int pcie_get_speed_cap_mask(struct pci_dev *dev, u32 *mask)
+{
+	return pcibios_get_speed_cap_mask(dev, mask);
+}
+EXPORT_SYMBOL(pcie_get_speed_cap_mask);
+
 EXPORT_SYMBOL(pci_reenable_device);
 EXPORT_SYMBOL(pci_enable_device_io);
 EXPORT_SYMBOL(pci_enable_device_mem);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2461033a..24a2f63 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1861,4 +1861,10 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
  */
 struct pci_dev *pci_find_upstream_pcie_bridge(struct pci_dev *pdev);
 
+#define PCIE_SPEED_25 1
+#define PCIE_SPEED_50 2
+#define PCIE_SPEED_80 4
+
+extern int pcie_get_speed_cap_mask(struct pci_dev *dev, u32 *speed_mask);
+
 #endif /* LINUX_PCI_H */
-- 
1.7.4.4

