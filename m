Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D2C36F423;
	Fri,  6 Mar 2026 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826767; cv=none; b=cenf0HV2QhoCo+D4eWpf9QpNCGfjqve9BhEZH9qS3VR8svn+OFC6feXHdsoIJxkObXLO8QeOmvSAZlmAPazG//ytXM9+qWdsu1Vua/vtvoXH8RoiDSgsYZuIE0mNH2ZWBp7XRib7MDhovQMRCfWmj1SY75mTwT/2RxE2BIQPaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826767; c=relaxed/simple;
	bh=wjM5lhp+pwP4m4G2E8trPuynl+8iyLHTnGcP8/gUnjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZJzpzdQSQUliYgdbsP/w5O0ywTGZrx/mqnFJQlTe0gNUL2dg3nS+enQELN8RdhnF3tJcS47deoLyPZARvhoLiuTi0kw00Gw79n45Zs3sDZQdnSn401Z9iGS6R8nQXsvrJVpi3KYjhPdr0QHWerbz9pGZDbYKS17Dp9LTxpOPAEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F287v65j; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F287v65j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772826764; x=1804362764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wjM5lhp+pwP4m4G2E8trPuynl+8iyLHTnGcP8/gUnjg=;
  b=F287v65jHgyGEsPPHK7BO1bwyII+quqh9EL1IIUKXhR9GI6Xjca63cbZ
   jAFrmErUtYSGjleECgfJBbyoQgmAq33zycKB6yu18pSlbZScIsHWjHX5d
   jqt4ehYM0dWrC9ptmNbxrXAb8uQiyFzv5gybPzQUFmJn3pDKq2qrtKN/f
   wz0YCsW9kVZsPR0+XS4oq4tqxHYpGHgMJ9U7bGpa2erbrP77KrJaylhJN
   0YGWgOjmDQgvRYg4rpWeg7ysNl7ukPavDna/+8F8kKrEnnfBvzywh2Sqk
   YK1k96WzA3khS5BlPnwkao0IWUM6UNlzekHc7AgMGVK+p+3Yhxe2ocbky
   w==;
X-CSE-ConnectionGUID: gJo48twGSv2M3/0cjARErw==
X-CSE-MsgGUID: 4IzqCQ0WQTe9AOAegLEKLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="99412894"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="99412894"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 11:52:43 -0800
X-CSE-ConnectionGUID: 5FvXMtnMTwi7WF0iA2TD9Q==
X-CSE-MsgGUID: nwSyPQieSpqa5hiMmJP2zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="257026626"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 11:52:39 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [RFC PATCH] PCI: Work around CXL Port PM Init failure when ACS SV enabled
Date: Fri,  6 Mar 2026 20:50:54 +0100
Message-ID: <20260306195232.388814-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Compute Express Link (CXL) Specification Revision 4.0, Version 1.0, Section
8.1.5.1 - CXL Port Extension Status, Implementation Note, describes a
scenario where a CXL downstream port may fail PM initialization:

"Certain conditions such as Link Down, Secondary Bus Reset, or Downstream
Port Containment reset the Downstream Component’s bus number. If the
Component generates the CREDIT_RTN IP2PM message with Requester Bus=0, the
Downstream Port may reject the IP2PM message if software has enabled ACS
Source Validation. In this scenario, Power Management initialization may
fail to complete and another Secondary Bus Reset alone will not facilitate
recovery".

Implement the recommended workaround for this scenario, which involves
saving and disabling the ACS Source Validation and Bus Master Enable bits,
issuing a secondary bus reset, waiting for PM init to complete, and then
restoring those bits.

This is an RFC because it checks for PM init failures in ports enumeration,
where an SBR might not be very welcome. Maybe other call sites are more
appropriate for this workaround?

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/pci.c        | 170 ++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c       |  19 ++++
 drivers/cxl/cxlpci.h          |   3 +
 drivers/pci/pci.c             |   3 +-
 include/uapi/linux/pci_regs.h |   4 +
 5 files changed, 198 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f96ce884a213..76b69ff17b74 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -869,3 +869,173 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
 
 	return ctx.count;
 }
+
+struct pci_saved_flags {
+	u16 pci_command;
+	u16 acs_ctrl;
+};
+
+/*
+ * pci_disable_acs_bme - disable ACS Source Validation and BME
+ * @pdev: downstream port
+ * @saved: pointer to pci_saved_acs_bme struct, for saving bit values
+ *
+ * Save the current ACS Source Validation and Bus Master Enable (BME)
+ * bits before disabling them.
+ */
+static void pci_disable_acs_bme(struct pci_dev *pdev,
+				struct pci_saved_flags *saved)
+{
+	int pos;
+	u16 field;
+
+	pos = pdev->acs_cap;
+	if (!pos)
+		return;
+
+	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &field);
+	saved->acs_ctrl = field;
+
+	if (field & PCI_ACS_SV)
+		pci_write_config_word(pdev, pos + PCI_ACS_CTRL,
+				      field & ~PCI_ACS_SV);
+
+	pci_read_config_word(pdev, PCI_COMMAND, &field);
+	saved->pci_command = field;
+
+	if (field & PCI_COMMAND_MASTER)
+		pci_clear_master(pdev);
+}
+
+/*
+ * pci_enable_acs_bme - enable ACS Source Validation and BME
+ * @pdev: downstream port
+ * @saved: pointer to pci_saved_acs_bme struct, for restoring bit values
+ *
+ * Restore the previously saved ACS Source Validation and Bus Master
+ * Enable (BME) bits.
+ */
+static void pci_enable_acs_bme(struct pci_dev *pdev,
+			       struct pci_saved_flags *saved)
+{
+	int pos;
+	u16 field;
+
+	pos = pdev->acs_cap;
+	if (!pos)
+		return;
+
+	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &field);
+	if (saved->acs_ctrl & PCI_ACS_SV)
+		pci_write_config_word(pdev, pos + PCI_ACS_CTRL,
+				      field | PCI_ACS_SV);
+
+	pci_read_config_word(pdev, PCI_COMMAND, &field);
+	if (saved->pci_command & PCI_COMMAND_MASTER)
+		pci_set_master(pdev);
+}
+
+/**
+ * cxl_port_pm_init_is_complete - check if the downstream port has completed PM
+ * init
+ *
+ * @pdev: downstream port
+ *
+ * Check if the Port Power Management Initialization Complete bit is set in the
+ * Downstream Port's CXL DVSEC Port Extended Status register.
+ *
+ * Returns true if PM init is complete, false otherwise.
+ */
+bool cxl_port_pm_init_is_complete(struct pci_dev *pdev)
+{
+	int pm_init_complete;
+	u16 status;
+	u16 dvsec;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_PORT);
+	if (!dvsec)
+		return false;
+
+	pci_read_config_word(pdev, dvsec + CXL_DVSEC_PORT_EXT_STATUS, &status);
+	pm_init_complete = FIELD_GET(CXL_DVSEC_PORT_EXT_STATUS_PM_INIT_COMP_MASK,
+				     status);
+
+	return !!pm_init_complete;
+}
+
+static void mask_sbr(struct pci_dev *pdev)
+{
+	int dvsec;
+	u16 reg;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_PORT);
+	if (!dvsec)
+		return;
+
+	pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+
+	pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+			      reg & ~PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR);
+}
+
+static void unmask_sbr(struct pci_dev *pdev)
+{
+	int dvsec;
+	u16 reg;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_PORT);
+	if (!dvsec)
+		return;
+
+	pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+
+	pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+			      reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR);
+}
+
+/**
+ * cxl_port_retry_failed_pm_init - retry a downstream port's failed PM init
+ *
+ * @pdev: downstream port
+ *
+ * Retry a downstream CXL port's failed PM init according to CXL Erratum for
+ * Section 8.1.5.1 - Port Power Management Initialization Complete.
+ *
+ * This entails saving and disabling the ACS Source Validation and Bus Master
+ * enable bits, and unmasking and masking the SBR, before doing a secondary bus
+ * reset and then restoring and re-enabling those bits.
+ *
+ * return: 0 on success, errors otherwise.
+ */
+int cxl_port_retry_failed_pm_init(struct pci_dev *pdev)
+{
+	struct pci_saved_flags saved;
+	int ret;
+
+	if (!is_cxl_port(pdev->dev.parent))
+		return -EINVAL;
+
+	pci_disable_acs_bme(pdev, &saved);
+	unmask_sbr(pdev);
+
+	/* Generate Secondary Bus Reset */
+	ret = pci_reset_bus(pdev);
+	if (ret)
+		dev_dbg(&pdev->dev, "Bus reset failed: %d\n", ret);
+
+	/*
+	 * Wait until the Port Power Management Initialization
+	 * Complete bit is set in the Downstream Port. CXL Spec 4.0
+	 * Section 8.1.5.1 of the CXL spec specifies 100 ms as the
+	 * max time needed for the PM Init Complete bit to be set.
+	 */
+	msleep(100);
+
+	mask_sbr(pdev);
+	pci_enable_acs_bme(pdev, &saved);
+
+	return ret;
+}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b69c2529744c..62fabcdf0faf 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1829,12 +1829,31 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 retry:
 	for (iter = dev; iter; iter = grandparent(iter)) {
 		struct device *dport_dev = grandparent(iter);
+		struct pci_dev *dport_pdev = to_pci_dev(dport_dev);
 		struct device *uport_dev;
 		struct cxl_dport *dport;
 
 		if (is_cxl_host_bridge(dport_dev))
 			return 0;
 
+		/*
+		 * Check the downstream port's PM init status, and if it has
+		 * failed retry PM init according to CXL Spec. 4.0 Sect. 8.1.5.1
+		 * - Implementation Note
+		 */
+		if (!cxl_port_pm_init_is_complete(dport_pdev)) {
+			dev_dbg(&cxlmd->dev,
+				"PM init failed for %s, retrying PM init\n",
+				dev_name(dport_dev));
+
+			cxl_port_retry_failed_pm_init(dport_pdev);
+
+			if (!cxl_port_pm_init_is_complete(dport_pdev))
+				dev_dbg(&cxlmd->dev,
+					"PM init failed retry for %s\n",
+					dev_name(dport_dev));
+		}
+
 		uport_dev = dport_dev->parent;
 		if (!uport_dev) {
 			dev_warn(dev, "at %s no parent for dport: %s\n",
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0cf64218aa16..0458096be2c4 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -101,4 +101,7 @@ static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 #endif
 
+bool cxl_port_pm_init_is_complete(struct pci_dev *pdev);
+int cxl_port_retry_failed_pm_init(struct pci_dev *pdev);
+
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f..511fc9e70e2a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4881,7 +4881,7 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
 					 PCI_DVSEC_CXL_PORT);
 }
 
-static bool cxl_sbr_masked(struct pci_dev *dev)
+bool cxl_sbr_masked(struct pci_dev *dev)
 {
 	u16 dvsec, reg;
 	int rc;
@@ -4904,6 +4904,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 
 	return true;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_sbr_masked, "CXL");
 
 static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 {
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ec1c54b5a310..1a12552fa89a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1397,4 +1397,8 @@
 #define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID		__GENMASK(15, 8)
 #define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW	__GENMASK(31, 16)
 
+/* CXL 4.0 8.1.5.1: CXL Port Extension Status */
+#define CXL_DVSEC_PORT_EXT_STATUS 0xA
+#define CXL_DVSEC_PORT_EXT_STATUS_PM_INIT_COMP_MASK GENMASK(1, 0)
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.53.0

