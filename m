Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC05547AF57;
	Tue, 28 Apr 2026 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400711; cv=none; b=C77Dirq/8uyJN4q72a7YiciWjqLSIIaSUAtEb3N+CbKCKmOAw6PV3eYzvhLl9Lw7F9Sa1xwoZRNPgMGNKy2CPHqnxFb7T2D3ZGPYADrg6fwwZRkhLG4xAaSs0H8iyJ5cHZ34pqMnf3bkogApUcK/OWOhmvJRf6QalCWeYlDIP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400711; c=relaxed/simple;
	bh=R6z0b7UqQCAjiHTSakK9L/CvKtbVVK2M5w4wXlBcMpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nu3zh0+dO1ZBmlX5zNRvJ5DQfKLT+qs2w4RiOUQF0z+9+VnDDiV6tj8e0sqXZApvKQ6M2iW/WId5iLOs1QZrTzIuvn+dNij9D+7dEjQxTsdJY6cfhbrJpUxI9Tc3B3F31dlL7NBpxuqYDUdeeu/g7zalm9V+Z0zkKIgQjYv52s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGp54Pk+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGp54Pk+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777400710; x=1808936710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R6z0b7UqQCAjiHTSakK9L/CvKtbVVK2M5w4wXlBcMpY=;
  b=XGp54Pk+sOOBRgLW3QZjEccr5xJKe7FIU4Yq7epeR6r//5vKS//WsWPY
   8670zUkviOi8uqcOiWJQhCYz5/csQnm4dkeyTqWMM5IqQWiSv61QBeitI
   c7MlhUPf7YRmoOc6ud3yDBjMdPa0rhuMpRBH/2wouFzh2BPbNHmWJjTXO
   ZP72H51eK1vbRj5QKs6lpRO+ijbp8VvtIe5jIqumBZJScJoKk4nOuBgOC
   D0U2mWvo1TwEu5UIZPXiwL+V29qjd14ycbu/j+eHL6yDa9rjGbeXbgvXP
   uuuG9UKFKjG5qrnOImjL04GkmNDTKphgm3Fo5HOx7mbffqOtdGcXWL/ft
   w==;
X-CSE-ConnectionGUID: DCCYF10+SOuhNIQ9z+IPRg==
X-CSE-MsgGUID: OUgJBwNvR+mDcVybwqYxPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="81927223"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="81927223"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 11:25:10 -0700
X-CSE-ConnectionGUID: PDW0bTUkSbeOWeWXgXjYxQ==
X-CSE-MsgGUID: T2ibAEllQdKUXML03fBwHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="257352905"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.9])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 11:25:06 -0700
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
Subject: [PATCH 2/2] cxl/core: Recover from PM Init failure via cxl_reset_bus_function()
Date: Tue, 28 Apr 2026 20:24:35 +0200
Message-ID: <20260428182454.464655-3-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428182454.464655-1-fabio.m.de.francesco@linux.intel.com>
References: <20260428182454.464655-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL r4.0 sec 8.1.5.1 Implementation Note describes a scenario in which a
Secondary Bus Reset, a Link Down, or Downstream Port Containment on a
CXL Downstream Port prevents Port PM Init from completing when ACS
Source Validation is enabled.

During CXL enumeration, for each CXL Downstream Port in a memdev's
ancestry, check whether PM Init has completed. If it has not, invoke
cxl_reset_bus_function() which is exported for use by CXL.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/pci.c        | 30 ++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c       | 22 ++++++++++++++++++++++
 drivers/cxl/cxlpci.h          |  3 +++
 drivers/pci/pci.c             |  3 ++-
 include/linux/pci.h           |  1 +
 include/uapi/linux/pci_regs.h |  2 ++
 6 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index d1f487b3d809..de6a317df650 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -926,3 +926,33 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
 
 	return ctx.count;
 }
+
+/**
+ * cxl_port_pm_init_is_complete - check the downstream port's PM Init Complete
+ * @pdev: downstream port
+ *
+ * Read the Port Power Management Initialization Complete bit in the
+ * Downstream Port's CXL DVSEC Port Extended Status register.
+ *
+ * Return: false only when the bit is observably clear. Return true when PM
+ * init is complete, when @pdev is not a CXL port (no Port DVSEC), or when
+ * the status register cannot be read.
+ */
+bool cxl_port_pm_init_is_complete(struct pci_dev *pdev)
+{
+	u16 status;
+	u16 dvsec;
+	int rc;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_PORT);
+	if (!dvsec)
+		return true;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_PORT_EXT_STATUS,
+				  &status);
+	if (rc || PCI_POSSIBLE_ERROR(status))
+		return true;
+
+	return !!FIELD_GET(PCI_DVSEC_CXL_PORT_EXT_STATUS_PM_INIT_COMP, status);
+}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c5aacd7054f1..a91841855d3b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1825,6 +1825,28 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 		if (is_cxl_host_bridge(dport_dev))
 			return 0;
 
+		/*
+		 * Check the downstream port's PM init status, and if it has
+		 * failed retry PM init according to CXL Spec. 4.0 Sect. 8.1.5.1
+		 * - Implementation Note
+		 */
+		if (dev_is_pci(dport_dev) && dev_is_pci(iter->parent)) {
+			struct pci_dev *dport_pdev = to_pci_dev(dport_dev);
+
+			if (!cxl_port_pm_init_is_complete(dport_pdev)) {
+				dev_dbg(&cxlmd->dev,
+					"PM init failed for %s, retrying PM init\n",
+					dev_name(dport_dev));
+
+				cxl_reset_bus_function(to_pci_dev(iter->parent), false);
+
+				if (!cxl_port_pm_init_is_complete(dport_pdev))
+					dev_dbg(&cxlmd->dev,
+						"PM init failed retry for %s\n",
+						dev_name(dport_dev));
+			}
+		}
+
 		uport_dev = dport_dev->parent;
 		if (!uport_dev) {
 			dev_warn(dev, "at %s no parent for dport: %s\n",
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index b826eb53cf7b..c66ff2ce82a3 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -114,4 +114,7 @@ static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
 
 int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 		       struct cxl_register_map *map);
+
+bool cxl_port_pm_init_is_complete(struct pci_dev *pdev);
+
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 047d3b4508a5..ae30da22daf4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4974,7 +4974,7 @@ static void cxl_restore_acs_sv_bme(struct pci_dev *bridge, u16 saved_cmd,
  * Return: 0 on success, -ENOTTY if the reset cannot be issued, or an
  * errno from the reset path.
  */
-static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
+int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *bridge;
 	u16 dvsec, reg, val;
@@ -5023,6 +5023,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	pci_dev_reset_iommu_done(dev);
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_reset_bus_function, "CXL");
 
 void pci_dev_lock(struct pci_dev *dev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..1fb1360d41e8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1477,6 +1477,7 @@ int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
 int pci_reset_bus(struct pci_dev *dev);
 void pci_reset_secondary_bus(struct pci_dev *dev);
+int cxl_reset_bus_function(struct pci_dev *dev, bool probe);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350..7e2579f89041 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1369,6 +1369,8 @@
 
 /* CXL r4.0, 8.1.5: Extensions DVSEC for Ports */
 #define PCI_DVSEC_CXL_PORT				3
+#define  PCI_DVSEC_CXL_PORT_EXT_STATUS			0x0A
+#define   PCI_DVSEC_CXL_PORT_EXT_STATUS_PM_INIT_COMP	_BITUL(0)
 #define  PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define   PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
 
-- 
2.53.0

