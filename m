Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp04.br.ibm.com ([32.104.18.25]:50419 "EHLO
	e24smtp04.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab3CTFZP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Mar 2013 01:25:15 -0400
Received: from /spool/local
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <lucaskt@linux.vnet.ibm.com>;
	Wed, 20 Mar 2013 02:25:11 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 855431DC0066
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2013 01:25:08 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r2K5OOl622741134
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2013 02:24:24 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r2K5P7Nu029778
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2013 02:25:08 -0300
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
Subject: [PATCHv2 3/3] ppc64: implemented pcibios_get_speed_cap_mask
Date: Wed, 20 Mar 2013 02:24:39 -0300
Message-Id: <1363757079-23550-4-git-send-email-lucaskt@linux.vnet.ibm.com>
In-Reply-To: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
References: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implementation of a architecture-specific pcibios_get_speed_cap_mask.
This implementation detects bus capabilities based on OF
ibm,pcie-link-speed-stats property.

Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/pci.c |   35 ++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 0b580f4..4da8deb 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/string.h>
+#include <linux/device.h>
 
 #include <asm/eeh.h>
 #include <asm/pci-bridge.h>
@@ -108,3 +109,37 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
 			 fixup_winbond_82c105);
+
+int pcibios_get_speed_cap_mask(struct pci_dev *dev, u32 *mask)
+{
+	struct device_node *dn, *pdn;
+	const uint32_t *pcie_link_speed_stats = NULL;
+
+	*mask = 0;
+	dn = pci_bus_to_OF_node(dev->bus);
+
+	/* Find nearest ibm,pcie-link-speed-stats, walking up the device tree */
+	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
+		pcie_link_speed_stats = (const uint32_t *) of_get_property(pdn,
+			"ibm,pcie-link-speed-stats", NULL);
+		if (pcie_link_speed_stats != NULL)
+			break;
+	}
+
+	if (pcie_link_speed_stats == NULL) {
+		dev_info(&dev->dev, "no ibm,pcie-link-speed-stats property\n");
+		return -EINVAL;
+	}
+
+	switch (pcie_link_speed_stats[0]) {
+	case 0x02:
+		*mask |= PCIE_SPEED_50;
+	case 0x01:
+		*mask |= PCIE_SPEED_25;
+	case 0x00:
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
-- 
1.7.4.4

