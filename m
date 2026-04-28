Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943BE47AF69;
	Tue, 28 Apr 2026 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400708; cv=none; b=gf9+TvFTFOE4WqhJMrzAwKRdtrXSsQBHAn43dCRUizlUXFJ3biVHPiFXxLbaFi4LQOMtBlxIbJpgn+oHw66g5wA13lvAjhFbFBPdvY0RDikvNpo1qXzFkNt34L/K8w9xoFJp1du79099RMvwemDNY2mq8nBcdvKb6NMFfit79Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400708; c=relaxed/simple;
	bh=JsL35ixH94B5ed9EelASawTU6bGn09a6QoHRha3fisY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ah3mLuoyc7KEzT8hPN3AWSdxlve3Knkmhfbo12ubX74w3Mv5N6nZrqUkqDcMoAXYu1npA4xYcvVmO65Kl9tKEJ8qSRed9d9yryIkinVEHDDuwHM5GzOgiOZXfrm/CUa8hKf5bK4YPsn8fJhGuP/Xi0tHs9VnrhbX4/Xgl7dWiuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1Xf9Png; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1Xf9Png"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777400706; x=1808936706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JsL35ixH94B5ed9EelASawTU6bGn09a6QoHRha3fisY=;
  b=D1Xf9PngVDX7gq1bVO9V4yrVyudvbzCXUZvustH3tk2ynsxrI2qnJDVi
   AQC3/NRvRWULvsmJyntfaLiDGutt0C5/mCshDNgMHdd7ozlvwttv3/deb
   xzNJo434wcc1xq59FfsAVYF2u9454IWuY+X3Zh1kUNMakLjBu/b5N9whD
   xPd9VfJkz1+t1Qjj17SzOTLtwDstv1A4ln7IuY/IqYxlnJiXGqyn547RI
   Bu1VdleANqVQkCvlYanz7+OVr09OTzHiKCD+vQgkyUUpgBIN1KGFtdjfT
   uScx1Tcm4ezQf5pl4hTTR6OEsE/3IdbyclbQxIuHUoYZLQvAeX47cY5p/
   Q==;
X-CSE-ConnectionGUID: thWpROWmRLSsHGwNUsOxUQ==
X-CSE-MsgGUID: 6kzPJOWUTi23zPnEMIbGOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="81927211"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="81927211"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 11:25:06 -0700
X-CSE-ConnectionGUID: Brs6jUiJRKuvj63DQKsJpA==
X-CSE-MsgGUID: lotBDMDxSACOzQ7BEjCz0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="257352897"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.9])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 11:25:03 -0700
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
Subject: [PATCH 1/2] PCI/CXL: Allow PM Init to complete on cxl_bus reset if ACS SV enabled
Date: Tue, 28 Apr 2026 20:24:34 +0200
Message-ID: <20260428182454.464655-2-fabio.m.de.francesco@linux.intel.com>
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

CXL r4.0 sec 8.1.5.1 Implementation Note describes a scenario in which
issuing a Secondary Bus Reset on a CXL Downstream Port leaves the
Port Power Management Initialization Complete bit unset when the PCIe
Access Control Service (ACS) Source Validation bit (SV) is enabled on
the Downstream Port. The spec states that another SBR alone will not
facilitate recovery and shows a software recovery sequence.

Implement the sequence by extending cxl_reset_bus_function() to save,
clear, and restore ACS SV and Bus Master Enable (BME) on the Downstream
Port around the SBR with the use of helpers.

The wait inside pci_bridge_secondary_bus_reset() covers the 100 ms
referenced by the spec. The helpers return when ACS SV is not enabled on
the Downstream Port.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/pci/pci.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc00090..047d3b4508a5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4930,10 +4930,55 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	return rc;
 }
 
+static void cxl_disable_acs_sv_bme(struct pci_dev *bridge, u16 *saved_cmd,
+				   u16 *saved_acs_ctrl)
+{
+	if (!bridge->acs_cap)
+		return;
+
+	pci_read_config_word(bridge, bridge->acs_cap + PCI_ACS_CTRL,
+			     saved_acs_ctrl);
+	if (!(*saved_acs_ctrl & PCI_ACS_SV))
+		return;
+
+	pci_read_config_word(bridge, PCI_COMMAND, saved_cmd);
+	if (*saved_cmd & PCI_COMMAND_MASTER)
+		pci_clear_master(bridge);
+
+	pci_write_config_word(bridge, bridge->acs_cap + PCI_ACS_CTRL,
+			      *saved_acs_ctrl & ~PCI_ACS_SV);
+}
+
+static void cxl_restore_acs_sv_bme(struct pci_dev *bridge, u16 saved_cmd,
+				   u16 saved_acs_ctrl)
+{
+	if (!bridge->acs_cap || !(saved_acs_ctrl & PCI_ACS_SV))
+		return;
+
+	pci_write_config_word(bridge, bridge->acs_cap + PCI_ACS_CTRL,
+			      saved_acs_ctrl);
+	if (saved_cmd & PCI_COMMAND_MASTER)
+		pci_set_master(bridge);
+}
+
+/**
+ * cxl_reset_bus_function - SBR for a child of a CXL downstream port
+ * @dev: child device whose upstream bridge is a CXL downstream port
+ * @probe: if true, only check whether the reset is supported
+ *
+ * Issues an SBR on @dev's parent bus. Temporarily sets the CXL Port
+ * DVSEC Unmask SBR bit across the reset. When ACS Source Validation
+ * is enabled on the bridge, also temporarily clears Bus Master Enable
+ * and ACS Source Validation, per CXL r4.0 sec 8.1.5.1.
+ *
+ * Return: 0 on success, -ENOTTY if the reset cannot be issued, or an
+ * errno from the reset path.
+ */
 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *bridge;
 	u16 dvsec, reg, val;
+	u16 saved_cmd = 0, saved_acs_ctrl = 0;
 	int rc;
 
 	bridge = pci_upstream_bridge(dev);
@@ -4957,6 +5002,8 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		return rc;
 	}
 
+	cxl_disable_acs_sv_bme(bridge, &saved_cmd, &saved_acs_ctrl);
+
 	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
 		val = reg;
 	} else {
@@ -4971,6 +5018,8 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
+	cxl_restore_acs_sv_bme(bridge, saved_cmd, saved_acs_ctrl);
+
 	pci_dev_reset_iommu_done(dev);
 	return rc;
 }
-- 
2.53.0

