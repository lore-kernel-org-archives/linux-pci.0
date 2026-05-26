Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAE4219FE;
	Tue, 26 May 2026 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819819; cv=none; b=H0k8VlygfZp1XKx68Zi9RukVC91KMswbLr6Mjo2k6XOyJt1i/HWM/Pz4ZXjvPUAMTsbzxsQAa7hTNct7oSy+o9Rx2m86aanlpvNQ6nfhbeowWEpMW1mEgbjHdbkVOtdArqeE2WJ60zbdNjw3aa5COeT/5My0AUg7k9pUOfULY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819819; c=relaxed/simple;
	bh=er6//o/NuFf0a2jh85ikypAifwwsOM1U95khesCi+YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfpMFC4IjBoJ7UsaX7MqFo3jYVxvIF1UXEyPOJErOLnsueh3sXcZ+DKOfkJT8wSrQXrLLgPcmhRQ7wzmFRWQVzmk3M/BYQolAEiBpGL3sxa7Aj9iq99WCv1pN2cH++7t5qOhrMB9V9SfFvuRZTbQPYXdohwGTiMFbJRP2+xmshM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A18A1F000E9;
	Tue, 26 May 2026 18:23:38 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: terry.bowman@amd.com,
	bhelgaas@google.com,
	jic23@kernel.org,
	djbw@kernel.org
Subject: [RFC PATCH 2/2] PCI/CXL: Enable usage of RDPAS to shortcut error device discovery
Date: Tue, 26 May 2026 11:23:34 -0700
Message-ID: <20260526182334.1010870-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526182334.1010870-1-dave.jiang@intel.com>
References: <20260526182334.1010870-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RDPAS allows the CXL RCH error handler to find the device directly
instead of iterating through a set number of RCiEP in order to discover
which device triggered an error. For the CXL.io protocol, the base
address provided from the cxl_rdpas xarray points to the RCRB of the
device. The RCRB mirrors the configuration space of the device via MMIO.
The error handler can walk the RCRB to find the AER capability block and
therefore read the root status as well as the error source in order
to determine the BDF of the error device.

Change the current RCH error handler behavior so it will probe the
RCRB first to see if the error device can be discovered quickly
before falling back to the current method of iterating through RCiEPs.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/pci/pcie/aer_cxl_rch.c | 103 +++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
index 37bbecf495af..0fd6c4234856 100644
--- a/drivers/pci/pcie/aer_cxl_rch.c
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -80,7 +80,7 @@ int cxl_parse_rdpas(union acpi_subtable_headers *header, void *arg,
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_parse_rdpas, "cxl_acpi");
 
-static int __maybe_unused cxl_get_rdpas_by_rcec(struct pci_dev *rcec, u64 *dsp_addr)
+static int cxl_get_rdpas_by_rcec(struct pci_dev *rcec, u64 *dsp_addr)
 {
 	u64 index;
 	u64 *addr;
@@ -134,6 +134,94 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+static u16 rcrb_to_aer(void __iomem *rcrb)
+{
+	u16 offset;
+	u32 cap_hdr;
+
+	/* Start from PCIe extended capabilities at offset 0x100 */
+	offset = PCI_CFG_SPACE_SIZE;
+	cap_hdr = readl(rcrb + offset);
+	if (cap_hdr == 0 || cap_hdr == ~0u)
+		return 0;
+
+	while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
+		offset = PCI_EXT_CAP_NEXT(cap_hdr);
+		if (!offset)
+			return 0;
+
+		if (offset >= SZ_4K)
+			return 0;
+
+		cap_hdr = readl(rcrb + offset);
+	}
+
+	return offset;
+}
+
+DEFINE_FREE(iounmap, void __iomem *, if (_T) iounmap(_T))
+static u16 cxl_rch_get_err_src_id(u64 rcrb_base)
+{
+	u32 root_status, err_src;
+	void __iomem *aer_base;
+	u16 aer_offset;
+
+	void __iomem *rcrb __free(iounmap) = ioremap(rcrb_base, SZ_4K);
+	if (!rcrb)
+		return 0;
+
+	aer_offset = rcrb_to_aer(rcrb);
+	if (!aer_offset)
+		return 0;
+
+	aer_base = rcrb + aer_offset;
+
+	root_status = readl(aer_base + PCI_ERR_ROOT_STATUS);
+	if (!(root_status & (PCI_ERR_ROOT_COR_RCV | PCI_ERR_ROOT_UNCOR_RCV)))
+		return 0;
+
+	err_src = readl(aer_base + PCI_ERR_ROOT_ERR_SRC);
+
+	if (root_status & PCI_ERR_ROOT_UNCOR_RCV)
+		return FIELD_GET(GENMASK(31, 16), err_src);
+
+	if (root_status & PCI_ERR_ROOT_COR_RCV)
+		return FIELD_GET(GENMASK(15, 0), err_src);
+
+	return 0;
+}
+
+static bool cxl_rch_handled_error_by_rdpas(struct pci_dev *rcec,
+					   struct aer_err_info *info)
+{
+	u8 bus, devfn;
+	u64 dsp_addr;
+	u16 segment;
+	u16 src_id;
+	int rc;
+
+	rc = cxl_get_rdpas_by_rcec(rcec, &dsp_addr);
+	if (rc)
+		return false;
+
+	src_id = cxl_rch_get_err_src_id(dsp_addr);
+	if (!src_id)
+		return false;
+
+	/* Try uncorrectable error source first, then correctable */
+	segment = pci_domain_nr(rcec->bus);
+	bus = FIELD_GET(GENMASK(15, 8), src_id);
+	devfn = FIELD_GET(GENMASK(7, 0), src_id);
+
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_get_domain_bus_and_slot(segment, bus, devfn);
+	if (!pdev)
+		return false;
+
+	cxl_forward_error(dev, info);
+	return true;
+}
+
 void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	/*
@@ -141,9 +229,16 @@ void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 	 * RCH's downstream port. Check and handle them in the CXL.mem
 	 * device driver.
 	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    is_aer_internal_error(info))
-		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)
+		return;
+
+	if (!is_aer_internal_error(info))
+		return;
+
+	if (cxl_rch_handled_error_by_rdpas(dev, info))
+		return;
+
+	pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
 }
 
 static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
-- 
2.54.0

