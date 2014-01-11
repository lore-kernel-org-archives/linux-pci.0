Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:65419 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaAKB07 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2014 20:26:59 -0500
Received: by mail-pd0-f171.google.com with SMTP id x10so563688pdj.30
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2014 17:26:58 -0800 (PST)
Subject: [PATCH v2 02/12] PCI: Remove unused Latency Tolerance Reporting
 support
To: Stephen Hemminger <stephen@networkplumber.org>,
	linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yu Zhao <yu.zhao@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Fri, 10 Jan 2014 18:26:56 -0700
Message-ID: <20140111012656.14505.15407.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

My philosophy is unused code is dead code.  And dead code is subject to bit
rot and is a likely source of bugs.  Use it or lose it.

This reverts 51c2e0a7e5bc ("PCI: add latency tolerance reporting
enable/disable support"), removing these interfaces:

    pci_enable_ltr()
    pci_disable_ltr()
    pci_set_ltr()

[bhelgaas: split to separate patch, also remove prototypes from pci.h]
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>
---
 drivers/pci/pci.c   |  123 ---------------------------------------------------
 include/linux/pci.h |    4 --
 2 files changed, 127 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 33120d156668..020f672deabb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2223,129 +2223,6 @@ void pci_disable_obff(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_disable_obff);
 
-/**
- * pci_ltr_supported - check whether a device supports LTR
- * @dev: PCI device
- *
- * RETURNS:
- * True if @dev supports latency tolerance reporting, false otherwise.
- */
-static bool pci_ltr_supported(struct pci_dev *dev)
-{
-	u32 cap;
-
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
-
-	return cap & PCI_EXP_DEVCAP2_LTR;
-}
-
-/**
- * pci_enable_ltr - enable latency tolerance reporting
- * @dev: PCI device
- *
- * Enable LTR on @dev if possible, which means enabling it first on
- * upstream ports.
- *
- * RETURNS:
- * Zero on success, errno on failure.
- */
-int pci_enable_ltr(struct pci_dev *dev)
-{
-	int ret;
-
-	/* Only primary function can enable/disable LTR */
-	if (PCI_FUNC(dev->devfn) != 0)
-		return -EINVAL;
-
-	if (!pci_ltr_supported(dev))
-		return -ENOTSUPP;
-
-	/* Enable upstream ports first */
-	if (dev->bus->self) {
-		ret = pci_enable_ltr(dev->bus->self);
-		if (ret)
-			return ret;
-	}
-
-	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
-					PCI_EXP_DEVCTL2_LTR_EN);
-}
-EXPORT_SYMBOL(pci_enable_ltr);
-
-/**
- * pci_disable_ltr - disable latency tolerance reporting
- * @dev: PCI device
- */
-void pci_disable_ltr(struct pci_dev *dev)
-{
-	/* Only primary function can enable/disable LTR */
-	if (PCI_FUNC(dev->devfn) != 0)
-		return;
-
-	if (!pci_ltr_supported(dev))
-		return;
-
-	pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2,
-				   PCI_EXP_DEVCTL2_LTR_EN);
-}
-EXPORT_SYMBOL(pci_disable_ltr);
-
-static int __pci_ltr_scale(int *val)
-{
-	int scale = 0;
-
-	while (*val > 1023) {
-		*val = (*val + 31) / 32;
-		scale++;
-	}
-	return scale;
-}
-
-/**
- * pci_set_ltr - set LTR latency values
- * @dev: PCI device
- * @snoop_lat_ns: snoop latency in nanoseconds
- * @nosnoop_lat_ns: nosnoop latency in nanoseconds
- *
- * Figure out the scale and set the LTR values accordingly.
- */
-int pci_set_ltr(struct pci_dev *dev, int snoop_lat_ns, int nosnoop_lat_ns)
-{
-	int pos, ret, snoop_scale, nosnoop_scale;
-	u16 val;
-
-	if (!pci_ltr_supported(dev))
-		return -ENOTSUPP;
-
-	snoop_scale = __pci_ltr_scale(&snoop_lat_ns);
-	nosnoop_scale = __pci_ltr_scale(&nosnoop_lat_ns);
-
-	if (snoop_lat_ns > PCI_LTR_VALUE_MASK ||
-	    nosnoop_lat_ns > PCI_LTR_VALUE_MASK)
-		return -EINVAL;
-
-	if ((snoop_scale > (PCI_LTR_SCALE_MASK >> PCI_LTR_SCALE_SHIFT)) ||
-	    (nosnoop_scale > (PCI_LTR_SCALE_MASK >> PCI_LTR_SCALE_SHIFT)))
-		return -EINVAL;
-
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
-	if (!pos)
-		return -ENOTSUPP;
-
-	val = (snoop_scale << PCI_LTR_SCALE_SHIFT) | snoop_lat_ns;
-	ret = pci_write_config_word(dev, pos + PCI_LTR_MAX_SNOOP_LAT, val);
-	if (ret != 4)
-		return -EIO;
-
-	val = (nosnoop_scale << PCI_LTR_SCALE_SHIFT) | nosnoop_lat_ns;
-	ret = pci_write_config_word(dev, pos + PCI_LTR_MAX_NOSNOOP_LAT, val);
-	if (ret != 4)
-		return -EIO;
-
-	return 0;
-}
-EXPORT_SYMBOL(pci_set_ltr);
-
 static int pci_acs_enable;
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1084a15175e0..ee26454746ba 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1009,10 +1009,6 @@ enum pci_obff_signal_type {
 int pci_enable_obff(struct pci_dev *dev, enum pci_obff_signal_type);
 void pci_disable_obff(struct pci_dev *dev);
 
-int pci_enable_ltr(struct pci_dev *dev);
-void pci_disable_ltr(struct pci_dev *dev);
-int pci_set_ltr(struct pci_dev *dev, int snoop_lat_ns, int nosnoop_lat_ns);
-
 /* For use by arch with custom probe code */
 void set_pcie_port_type(struct pci_dev *pdev);
 void set_pcie_hotplug_bridge(struct pci_dev *pdev);

