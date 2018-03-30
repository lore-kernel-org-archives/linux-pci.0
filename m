Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752568AbeC3VEo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 17:04:44 -0400
Subject: [PATCH v5 00/14] Report PCI device link status
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tal Gilboa <talgi@mellanox.com>
Cc: Tariq Toukan <tariqt@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        everest-linux-l2@cavium.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Date: Fri, 30 Mar 2018 16:04:40 -0500
Message-ID: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is mostly Tal's work to reduce code duplication in drivers and unify
the approach for reporting PCIe link speed/width and whether the device is
being limited by a slower upstream link.

This v5 series is based on Tal's v4 [1].

Changes since v4:
  - Added patches to replace uses of pcie_get_minimum_link() in bnx2x,
    bnxt_en, cxgb4, fm10k, and ixgbe.  Note that this is a user-visible
    change to the log messages, and in some cases changes dev_warn() to
    dev_info().  I hope we can converge on something that works for
    everybody, and it's OK if we need to tweak the text and/or level used
    in pcie_print_link_status() to get there.

  - Rebased on top of Jay Fang's patch that adds 16 GT/s decoding support.

  - Changed pcie_get_speed_cap() and pcie_get_width_cap() to return the
    values directly instead of returning both an error code and the value
    via a reference parameter.  I don't think the callers can really use
    both the error and the value.

  - Moved some declarations from linux/pci.h to drivers/pci/pci.h so
    they're not visible outside the PCI subsystem.  Also removed
    corresponding EXPORT_SYMBOL()s.  If we need these outside the PCI core,
    we can export them again, but that's not needed yet.

  - Reworked pcie_bandwidth_available() so it finds the uppermost limiting
    device and returns width/speed info for that device (previously it
    could return width from one device and speed from a different one).

The incremental diff between the v4 series (based on v4.17-rc1) and this v5
series (based on v4.17-rc1 + Jay Fang's patch) is attached.  This diff
doesn't include the new patches to bnx2x, bnxt_en, cxgb4, fm10k, and ixgbe.

I don't have any of this hardware, so this is only compile-tested.

Bjorn


[1] https://lkml.kernel.org/r/1522394086-3555-1-git-send-email-talgi@mellanox.com

---

Bjorn Helgaas (6):
      bnx2x: Report PCIe link properties with pcie_print_link_status()
      bnxt_en: Report PCIe link properties with pcie_print_link_status()
      cxgb4: Report PCIe link properties with pcie_print_link_status()
      fm10k: Report PCIe link properties with pcie_print_link_status()
      ixgbe: Report PCIe link properties with pcie_print_link_status()
      PCI: Remove unused pcie_get_minimum_link()

Tal Gilboa (8):
      PCI: Add pcie_get_speed_cap() to find max supported link speed
      PCI: Add pcie_get_width_cap() to find max supported link width
      PCI: Add pcie_bandwidth_capable() to compute max supported link bandwidth
      PCI: Add pcie_bandwidth_available() to compute bandwidth available to device
      PCI: Add pcie_print_link_status() to log link speed and whether it's limited
      net/mlx4_core: Report PCIe link properties with pcie_print_link_status()
      net/mlx5: Report PCIe link properties with pcie_print_link_status()
      net/mlx5e: Use pcie_bandwidth_available() to compute bandwidth


 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c  |   23 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |   19 --
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c   |   75 ---------
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c      |   87 -----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |   47 ------
 drivers/net/ethernet/mellanox/mlx4/main.c         |   81 ----------
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |   32 ----
 drivers/net/ethernet/mellanox/mlx5/core/main.c    |    4 +
 drivers/pci/pci-sysfs.c                           |   38 +----
 drivers/pci/pci.c                                 |  167 ++++++++++++++++++---
 drivers/pci/pci.h                                 |   20 +++
 include/linux/pci.h                               |    6 +
 12 files changed, 189 insertions(+), 410 deletions(-)



diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 1bbd6cd20213..93291ec4a3d1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3864,25 +3864,6 @@ void mlx5e_build_default_indir_rqt(u32 *indirection_rqt, int len,
 		indirection_rqt[i] = i % num_channels;
 }
 
-static int mlx5e_get_pci_bw(struct mlx5_core_dev *mdev, u32 *pci_bw)
-{
-	enum pcie_link_width width;
-	enum pci_bus_speed speed;
-	int err = 0;
-	int bw;
-
-	err = pcie_bandwidth_available(mdev->pdev, &speed, &width, &bw, NULL);
-	if (err)
-		return err;
-
-	if (speed == PCI_SPEED_UNKNOWN || width == PCIE_LNK_WIDTH_UNKNOWN)
-		return -EINVAL;
-
-	*pci_bw = bw;
-
-	return 0;
-}
-
 static bool cqe_compress_heuristic(u32 link_speed, u32 pci_bw)
 {
 	return (link_speed && pci_bw &&
@@ -3968,7 +3949,7 @@ void mlx5e_build_nic_params(struct mlx5_core_dev *mdev,
 	params->num_tc       = 1;
 
 	mlx5e_get_max_linkspeed(mdev, &link_speed);
-	mlx5e_get_pci_bw(mdev, &pci_bw);
+	pci_bw = pcie_bandwidth_available(mdev->pdev, NULL, NULL, NULL);
 	mlx5_core_dbg(mdev, "Max link speed = %d, PCI BW = %d\n",
 		      link_speed, pci_bw);
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f4b88674f029..63d0952684fb 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -158,33 +158,18 @@ static DEVICE_ATTR_RO(resource);
 static ssize_t max_link_speed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	enum pci_bus_speed speed;
-	const char *speed_str;
-	int err;
-
-	err = pcie_get_speed_cap(pci_dev, &speed);
-	if (err)
-		return -EINVAL;
-
-	speed_str = PCIE_SPEED2STR(speed);
+	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%s\n", speed_str);
+	return sprintf(buf, "%s\n", PCIE_SPEED2STR(pcie_get_speed_cap(pdev)));
 }
 static DEVICE_ATTR_RO(max_link_speed);
 
 static ssize_t max_link_width_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	enum pcie_link_width width;
-	int err;
-
-	err = pcie_get_width_cap(pci_dev, &width);
-	if (err)
-		return -EINVAL;
+	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", width);
+	return sprintf(buf, "%u\n", pcie_get_width_cap(pdev));
 }
 static DEVICE_ATTR_RO(max_link_width);
 
@@ -201,6 +186,9 @@ static ssize_t current_link_speed_show(struct device *dev,
 		return -EINVAL;
 
 	switch (linkstat & PCI_EXP_LNKSTA_CLS) {
+	case PCI_EXP_LNKSTA_CLS_16_0GB:
+		speed = "16 GT/s";
+		break;
 	case PCI_EXP_LNKSTA_CLS_8_0GB:
 		speed = "8 GT/s";
 		break;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bd8aa64d083a..b6951c44ae6c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5103,193 +5103,169 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 }
 EXPORT_SYMBOL(pcie_set_mps);
 
-/**
- * pcie_get_minimum_link - determine minimum link settings of a PCI device
- * @dev: PCI device to query
- * @speed: storage for minimum speed
- * @width: storage for minimum width
- *
- * This function use pcie_bandwidth_available() for determining the minimum
- * link width and speed of the device. Legacy code is kept for compatibility.
- */
-int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
-			  enum pcie_link_width *width)
-{
-	int bw;
-
-	return pcie_bandwidth_available(dev, speed, width, &bw, NULL);
-}
-EXPORT_SYMBOL(pcie_get_minimum_link);
-
 /**
  * pcie_bandwidth_available - determine minimum link settings of a PCIe
-			      device and its bandwidth limitation
+ *			      device and its bandwidth limitation
  * @dev: PCI device to query
- * @speed: storage for minimum speed
- * @width: storage for minimum width
- * @bw: storage for link bandwidth
  * @limiting_dev: storage for device causing the bandwidth limitation
+ * @speed: storage for speed of limiting device
+ * @width: storage for width of limiting device
  *
- * This function walks up the PCI device chain and determines the minimum width,
- * minimum speed and available bandwidth of the device.
+ * Walk up the PCI device chain and find the point where the minimum
+ * bandwidth is available.  Return the bandwidth available there and (if
+ * limiting_dev, speed, and width pointers are supplied) information about
+ * that point.
  */
-int pcie_bandwidth_available(struct pci_dev *dev, enum pci_bus_speed *speed,
-			     enum pcie_link_width *width, int *bw,
-			     struct pci_dev **limiting_dev)
+u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
+			     enum pci_bus_speed *speed,
+			     enum pcie_link_width *width)
 {
-	int err;
+	u16 lnksta;
+	enum pci_bus_speed next_speed;
+	enum pcie_link_width next_width;
+	u32 bw, next_bw;
 
 	*speed = PCI_SPEED_UNKNOWN;
 	*width = PCIE_LNK_WIDTH_UNKNOWN;
-	*bw = 0;
+	bw = 0;
 
 	while (dev) {
-		u16 lnksta;
-		enum pci_bus_speed next_speed;
-		enum pcie_link_width next_width;
-
-		err = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
-		if (err)
-			return err;
+		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 
 		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
 		next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
 			PCI_EXP_LNKSTA_NLW_SHIFT;
 
-		if (next_speed < *speed)
-			*speed = next_speed;
-
-		if (next_width < *width)
-			*width = next_width;
+		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
 
 		/* Check if current device limits the total bandwidth */
-		if (!(*bw) ||
-		    (*bw > next_width * PCIE_SPEED2MBS_ENC(next_speed))) {
+		if (!bw || next_bw <= bw) {
+			bw = next_bw;
+
 			if (limiting_dev)
 				*limiting_dev = dev;
-			*bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
+			if (speed)
+				*speed = next_speed;
+			if (width)
+				*width = next_width;
 		}
 
-		dev = dev->bus->self;
+		dev = pci_upstream_bridge(dev);
 	}
 
-	return 0;
+	return bw;
 }
 EXPORT_SYMBOL(pcie_bandwidth_available);
 
 /**
- * pcie_get_speed_cap - queries for the PCI device's link speed capability
+ * pcie_get_speed_cap - query for the PCI device's link speed capability
  * @dev: PCI device to query
- * @speed: storage for link speed
  *
- * This function queries the PCI device speed capability.
+ * Query the PCI device speed capability.  Return the maximum link speed
+ * supported by the device.
  */
-int pcie_get_speed_cap(struct pci_dev *dev, enum pci_bus_speed *speed)
+enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 {
-	u32 lnkcap;
-	int err1, err2;
+	u32 lnkcap2, lnkcap;
 
-	*speed = PCI_SPEED_UNKNOWN;
+	/*
+	 * PCIe r4.0 sec 7.5.3.18 recommends using the Supported Link
+	 * Speeds Vector in Link Capabilities 2 when supported, falling
+	 * back to Max Link Speed in Link Capabilities otherwise.
+	 */
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
+	if (lnkcap2) { /* PCIe r3.0-compliant */
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_16_0GB)
+			return PCIE_SPEED_16_0GT;
+		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
+			return PCIE_SPEED_8_0GT;
+		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
+			return PCIE_SPEED_5_0GT;
+		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
+			return PCIE_SPEED_2_5GT;
+		return PCI_SPEED_UNKNOWN;
+	}
 
-	err1 = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP,
-					  &lnkcap);
-	if (!err1 && lnkcap) {
-		if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
-			*speed = PCIE_SPEED_8_0GT;
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if (lnkcap) {
+		if (lnkcap & PCI_EXP_LNKCAP_SLS_16_0GB)
+			return PCIE_SPEED_16_0GT;
+		else if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
+			return PCIE_SPEED_8_0GT;
 		else if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
-			*speed = PCIE_SPEED_5_0GT;
+			return PCIE_SPEED_5_0GT;
 		else if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
-			*speed = PCIE_SPEED_2_5GT;
-		return 0;
-	}
-
-	err2 = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2,
-					  &lnkcap);
-	if (!err2 && lnkcap) { /* PCIe r3.0-compliant */
-		if (lnkcap & PCI_EXP_LNKCAP2_SLS_8_0GB)
-			*speed = PCIE_SPEED_8_0GT;
-		else if (lnkcap & PCI_EXP_LNKCAP2_SLS_5_0GB)
-			*speed = PCIE_SPEED_5_0GT;
-		else if (lnkcap & PCI_EXP_LNKCAP2_SLS_2_5GB)
-			*speed = PCIE_SPEED_2_5GT;
-		return 0;
+			return PCIE_SPEED_2_5GT;
 	}
 
-	return err1 ? err1 : err2;
+	return PCI_SPEED_UNKNOWN;
 }
-EXPORT_SYMBOL(pcie_get_speed_cap);
 
 /**
- * pcie_get_width_cap - queries for the PCI device's link width capability
+ * pcie_get_width_cap - query for the PCI device's link width capability
  * @dev: PCI device to query
- * @width: storage for link width
  *
- * This function queries the PCI device width capability.
+ * Query the PCI device width capability.  Return the maximum link width
+ * supported by the device.
  */
-int pcie_get_width_cap(struct pci_dev *dev, enum pcie_link_width *width)
+enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
 {
 	u32 lnkcap;
-	int err;
-
-	*width = PCIE_LNK_WIDTH_UNKNOWN;
 
-	err = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
-	if (!err && lnkcap)
-		/* Shift start of width mask by 4 to get actual speed cap */
-		*width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if (lnkcap)
+		return (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
 
-	return err;
+	return PCIE_LNK_WIDTH_UNKNOWN;
 }
-EXPORT_SYMBOL(pcie_get_width_cap);
 
 /**
- * pcie_bandwidth_capable - Calculates a PCI device's link bandwidth capability
+ * pcie_bandwidth_capable - calculates a PCI device's link bandwidth capability
  * @dev: PCI device
  * @speed: storage for link speed
  * @width: storage for link width
  *
- * This function caculates a PCI device's link bandwidth by querying for its
- * link speed and width, multiplying them, and applying encoding overhead.
+ * Calculate a PCI device's link bandwidth by querying for its link speed
+ * and width, multiplying them, and applying encoding overhead.
  */
-int pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
+u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
 			   enum pcie_link_width *width)
 {
-	pcie_get_speed_cap(dev, speed);
-	pcie_get_width_cap(dev, width);
+	*speed = pcie_get_speed_cap(dev);
+	*width = pcie_get_width_cap(dev);
 
 	if (*speed == PCI_SPEED_UNKNOWN || *width == PCIE_LNK_WIDTH_UNKNOWN)
 		return 0;
 
-	return (*width) * PCIE_SPEED2MBS_ENC(*speed);
+	return *width * PCIE_SPEED2MBS_ENC(*speed);
 }
-EXPORT_SYMBOL(pcie_bandwidth_capable);
 
 /**
- * pcie_print_link_status - Reports the PCI device's link speed and width.
+ * pcie_print_link_status - Report the PCI device's link speed and width
  * @dev: PCI device to query
  *
- * This function checks whether the PCI device current speed and width are equal
- * to the maximum PCI device capabilities.
+ * Report the available bandwidth at the device.  If this is less than the
+ * device is capable of, report the device's maximum possible bandwidth and
+ * the upstream link that limits its performance to less than that.
  */
 void pcie_print_link_status(struct pci_dev *dev)
 {
 	enum pcie_link_width width, width_cap;
-	struct pci_dev *limiting_dev = NULL;
 	enum pci_bus_speed speed, speed_cap;
-	int bw, bw_cap;
+	struct pci_dev *limiting_dev = NULL;
+	u32 bw_avail, bw_cap;
 
 	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
-	pcie_bandwidth_available(dev, &speed, &width, &bw, &limiting_dev);
+	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
 
-	if (bw >= bw_cap)
+	if (bw_avail >= bw_cap)
 		pci_info(dev, "%d Mb/s available bandwidth (%s x%d link)\n",
-			 bw, PCIE_SPEED2STR(speed), width);
+			 bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
 	else
-		pci_info(dev, "%d Mb/s available bandwidth (capable of %d Mb/s, %s x%d link)\n",
-			 bw, bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
-	if (limiting_dev && strcmp(pci_name(limiting_dev), pci_name(dev)))
-		pci_info(dev, "Bandwidth limited by device at %s\n",
-			 pci_name(limiting_dev));
+		pci_info(dev, "%d Mb/s available bandwidth, limited by %s x%d link at %s (capable of %d Mb/s with %s x%d link)\n",
+			 bw_avail, PCIE_SPEED2STR(speed), width,
+			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
+			 bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
 }
 EXPORT_SYMBOL(pcie_print_link_status);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fcd81911b127..2a50172b9803 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -253,6 +253,26 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
 
+/* PCIe link information */
+#define PCIE_SPEED2STR(speed) \
+	((speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
+	 (speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
+	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
+	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
+	 "Unknown speed")
+
+/* PCIe speed to Mb/s with encoding overhead: 20% for gen2, ~1.5% for gen3 */
+#define PCIE_SPEED2MBS_ENC(speed) \
+	((speed) == PCIE_SPEED_8_0GT ? 7877 : \
+	 (speed) == PCIE_SPEED_5_0GT ? 4000 : \
+	 (speed) == PCIE_SPEED_2_5GT ? 2000 : \
+	 0)
+
+enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
+enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
+u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
+			   enum pcie_link_width *width);
+
 /* Single Root I/O Virtualization */
 struct pci_sriov {
 	int		pos;		/* Capability position */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ef5377438a1e..86bf045f3d59 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -592,7 +592,7 @@ const unsigned char pcie_link_speed[] = {
 	PCIE_SPEED_2_5GT,		/* 1 */
 	PCIE_SPEED_5_0GT,		/* 2 */
 	PCIE_SPEED_8_0GT,		/* 3 */
-	PCI_SPEED_UNKNOWN,		/* 4 */
+	PCIE_SPEED_16_0GT,		/* 4 */
 	PCI_SPEED_UNKNOWN,		/* 5 */
 	PCI_SPEED_UNKNOWN,		/* 6 */
 	PCI_SPEED_UNKNOWN,		/* 7 */
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index d10f556dc03e..191893e19d5c 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -76,6 +76,7 @@ static const char *pci_bus_speed_strings[] = {
 	"2.5 GT/s PCIe",	/* 0x14 */
 	"5.0 GT/s PCIe",	/* 0x15 */
 	"8.0 GT/s PCIe",	/* 0x16 */
+	"16.0 GT/s PCIe",	/* 0x17 */
 };
 
 static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1a672c960c8f..5ccee29fe1b1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -256,25 +256,10 @@ enum pci_bus_speed {
 	PCIE_SPEED_2_5GT		= 0x14,
 	PCIE_SPEED_5_0GT		= 0x15,
 	PCIE_SPEED_8_0GT		= 0x16,
+	PCIE_SPEED_16_0GT		= 0x17,
 	PCI_SPEED_UNKNOWN		= 0xff,
 };
 
-#define PCIE_SPEED2STR(speed) \
-	((speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
-	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
-	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
-	 "Unknown speed")
-
-/**
- * PCIe speed to Mb/s with encoding overhead:
- * 20% for gen2, ~1.5% for gen3
- */
-#define PCIE_SPEED2MBS_ENC(speed) \
-	((speed) == PCIE_SPEED_8_0GT ? 7877 : \
-	 (speed) == PCIE_SPEED_5_0GT ? 4000 : \
-	 (speed) == PCIE_SPEED_2_5GT ? 2000 : \
-	 0)
-
 struct pci_cap_saved_data {
 	u16		cap_nr;
 	bool		cap_extended;
@@ -1096,15 +1081,9 @@ int pcie_get_readrq(struct pci_dev *dev);
 int pcie_set_readrq(struct pci_dev *dev, int rq);
 int pcie_get_mps(struct pci_dev *dev);
 int pcie_set_mps(struct pci_dev *dev, int mps);
-int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
-			  enum pcie_link_width *width);
-int pcie_bandwidth_available(struct pci_dev *dev, enum pci_bus_speed *speed,
-			     enum pcie_link_width *width, int *bw,
-			     struct pci_dev **limiting_dev);
-int pcie_get_speed_cap(struct pci_dev *dev, enum pci_bus_speed *speed);
-int pcie_get_width_cap(struct pci_dev *dev, enum pcie_link_width *width);
-int pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
-			   enum pcie_link_width *width);
+u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
+			     enum pci_bus_speed *speed,
+			     enum pcie_link_width *width);
 void pcie_print_link_status(struct pci_dev *dev);
 void pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 0c79eac5e9b8..103ba797a8f3 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -520,6 +520,7 @@
 #define  PCI_EXP_LNKCAP_SLS_2_5GB 0x00000001 /* LNKCAP2 SLS Vector bit 0 */
 #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
 #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
+#define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
@@ -547,6 +548,7 @@
 #define  PCI_EXP_LNKSTA_CLS_2_5GB 0x0001 /* Current Link Speed 2.5GT/s */
 #define  PCI_EXP_LNKSTA_CLS_5_0GB 0x0002 /* Current Link Speed 5.0GT/s */
 #define  PCI_EXP_LNKSTA_CLS_8_0GB 0x0003 /* Current Link Speed 8.0GT/s */
+#define  PCI_EXP_LNKSTA_CLS_16_0GB 0x0004 /* Current Link Speed 16.0GT/s */
 #define  PCI_EXP_LNKSTA_NLW	0x03f0	/* Negotiated Link Width */
 #define  PCI_EXP_LNKSTA_NLW_X1	0x0010	/* Current Link Width x1 */
 #define  PCI_EXP_LNKSTA_NLW_X2	0x0020	/* Current Link Width x2 */
@@ -648,8 +650,9 @@
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V2	44	/* v2 endpoints without link end here */
 #define PCI_EXP_LNKCAP2		44	/* Link Capabilities 2 */
 #define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000002 /* Supported Speed 2.5GT/s */
-#define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5.0GT/s */
-#define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8.0GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
