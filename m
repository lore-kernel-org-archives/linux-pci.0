Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA821F5437;
	Thu, 18 Jun 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802448; cv=none; b=NjbWSuIRhDnj9ZW3if/vIIfy+5VfDiZneb49DJgbFL0AE/h82Whsa8rJV2gvp0nmiGXmXP6Ml25brqx+Z2AFP8rzBDId6wu53qXCi/zVIGOWVutY/xADkA9sbBjGaggw95vwObUIqhf0q37OvBj7ya8qFam+l2VUdEXJWJk6im4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802448; c=relaxed/simple;
	bh=ZjGvh+3KM7v572m4GAgr2wXokFVUiaVprSgTcOut2vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6cIytWHGO6wl7mxsquLXQlMRmMPtmlib0719X6XRuAmiwNJ1QHEfWEjdAf4OyHcU14NDfCSqpMJ5MgUnt77UJ8eBUqwL+6uUuv0MaHTC9EV1rzap3SCAz3+DU11xRjqksu48YIogcT3qFu/JbXL4fF6NS9piuPdMWXP2I4aIgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AAE1F000E9;
	Thu, 18 Jun 2026 17:07:27 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: terry.bowman@amd.com,
	bhelgaas@google.com,
	jic23@kernel.org,
	djbw@kernel.org
Subject: [RFC PATCH v2 2/2] PCI/CXL: Enable usage of RDPAS to shortcut error device discovery
Date: Thu, 18 Jun 2026 10:07:22 -0700
Message-ID: <20260618170723.2010490-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618170723.2010490-1-dave.jiang@intel.com>
References: <20260618170723.2010490-1-dave.jiang@intel.com>
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

The entries with cxl.cachemem protocol is ignored because the base address
provided by the RDPAS structure points to the Component Base Register Base
and does not provide a way for th ecode to identify the device that
triggered the error.

Change the current RCH error handler behavior so it will probe the
RCRB first to see if the error device can be discovered quickly
before falling back to the current method of iterating through RCiEPs.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Add boundary checks for MMIO reads (sashiko)
- Add checks for surprise removal of devices (sashiko)
- Use aer_info to also check severity. (Ming)
- Update to iterate list of RPs under a RCEC entry.
---
 drivers/pci/pcie/aer_cxl_rch.c | 152 ++++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
index eaab7698217e..f295e4eefbba 100644
--- a/drivers/pci/pcie/aer_cxl_rch.c
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -118,7 +118,7 @@ int cxl_rdpas_init(struct device *host)
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_rdpas_init, "cxl_acpi");
 
-static struct cxl_rdpas_rcec __maybe_unused *cxl_get_rdpas_by_rcec(struct pci_dev *rcec)
+static struct cxl_rdpas_rcec *cxl_get_rdpas_by_rcec(struct pci_dev *rcec)
 {
 	unsigned long index;
 
@@ -166,6 +166,143 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+static u16 rcrb_to_aer(void __iomem *rcrb)
+{
+	/*
+	 * The extended capability space is SZ_4K and each capability header
+	 * is dword aligned, so the chain can hold at most SZ_4K / 4 entries.
+	 * Bound the walk by that count to avoid spinning on a malformed,
+	 * looping capability list.
+	 */
+	int entries = SZ_4K / 4;
+	u16 offset;
+	u32 cap_hdr;
+
+	/* Start from PCIe extended capabilities at offset 0x100 */
+	offset = PCI_CFG_SPACE_SIZE;
+	cap_hdr = readl(rcrb + offset);
+	if (cap_hdr == 0 || PCI_POSSIBLE_ERROR(cap_hdr))
+		return 0;
+
+	while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
+		if (--entries <= 0)
+			return 0;
+
+		offset = PCI_EXT_CAP_NEXT(cap_hdr);
+		if (!offset)
+			return 0;
+
+		if (offset >= SZ_4K)
+			return 0;
+
+		cap_hdr = readl(rcrb + offset);
+		if (cap_hdr == 0 || PCI_POSSIBLE_ERROR(cap_hdr))
+			return 0;
+	}
+
+	return offset;
+}
+
+DEFINE_FREE(iounmap, void __iomem *, if (_T) iounmap(_T))
+static u16 cxl_rch_get_err_src_id(u64 rcrb_base, struct aer_err_info *info)
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
+	if (aer_offset + PCI_ERR_ROOT_STATUS + sizeof(u32) > SZ_4K)
+		return 0;
+
+	root_status = readl(aer_base + PCI_ERR_ROOT_STATUS);
+	if (!(root_status & (PCI_ERR_ROOT_COR_RCV | PCI_ERR_ROOT_UNCOR_RCV)))
+		return 0;
+
+	if (aer_offset + PCI_ERR_ROOT_ERR_SRC + sizeof(u32) > SZ_4K)
+		return 0;
+
+	err_src = readl(aer_base + PCI_ERR_ROOT_ERR_SRC);
+
+	if (info->severity == AER_CORRECTABLE &&
+	    root_status & PCI_ERR_ROOT_COR_RCV)
+		return FIELD_GET(GENMASK(15, 0), err_src);
+
+	/* Assume at this point the info->severity points to UNCOR */
+	if (root_status & PCI_ERR_ROOT_UNCOR_RCV)
+		return FIELD_GET(GENMASK(31, 16), err_src);
+
+	return 0;
+}
+
+static bool cxl_rch_forward_error_by_dsp(struct pci_dev *rcec, u64 rcrb_base,
+					 struct aer_err_info *info)
+{
+	u8 bus, devfn;
+	u16 segment;
+	u16 src_id;
+
+	src_id = cxl_rch_get_err_src_id(rcrb_base, info);
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
+	/*
+	 * The error source id resolves to whatever BDF the root port logged,
+	 * which is not guaranteed to be a natively handled CXL.mem device.
+	 * Apply the same gating as the RCiEP walk fallback before forwarding.
+	 */
+	if (!is_cxl_mem_dev(pdev) || !cxl_error_is_native(pdev))
+		return false;
+
+	cxl_forward_error(pdev, info);
+	return true;
+}
+
+static bool cxl_rch_handled_error_by_rdpas(struct pci_dev *rcec,
+					   struct aer_err_info *info)
+{
+	struct cxl_rdpas_rcec *rdpas_rcec;
+	struct cxl_rdpas_entry *entry;
+	bool handled = false;
+
+	rdpas_rcec = cxl_get_rdpas_by_rcec(rcec);
+	if (!rdpas_rcec)
+		return false;
+
+	/*
+	 * The RCEC aggregates multiple downstream ports. Each CXL.io
+	 * downstream port associated with this RCEC exposes the RCRB at its
+	 * base address; walk them all and forward the error from every port
+	 * that reports a valid error source.
+	 */
+	list_for_each_entry(entry, &rdpas_rcec->ports, list) {
+		if (entry->protocol != ACPI_CEDT_RDPAS_PROTOCOL_IO)
+			continue;
+
+		if (cxl_rch_forward_error_by_dsp(rcec, entry->address, info))
+			handled = true;
+	}
+
+	return handled;
+}
+
 void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	/*
@@ -173,9 +310,16 @@ void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
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

