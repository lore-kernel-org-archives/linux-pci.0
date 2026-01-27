Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8D362134
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526664; cv=none; b=DpzCQPjjj/7OOVDfe7WR1hADNK3LBwH2p/qXtUtbD8EYgh52Norb2/AiOlrqNGVFR5PgHsydV/wVlFUrI2QvlwQH7ZyQqQCVrYGQglTqi65JqJTN1RPexO0OLCbrZEbu30hXb4Kn/Neeax9uVZcnqDso9Xkx+np1q02RUaYscyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526664; c=relaxed/simple;
	bh=ISEb+Eu5Q+SkKDwIob+YVqGNVOVmeBAjfYuAjFwOUTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCoSX9W2tK+Q0rfbK/odKHH7J4VjkXSkqs1F2d/DIOG8KAXREV6TnRqgGy3u7Q8t+xS29Vqlym3XVScKf0ADlRTnv2qVLfes49xA6MPeD1+in0XYxUEB9ItoYAMrT6fH/6dTWKIDWIV6L3MdaE7+8fglOzTkUKiMDYVrdO+TAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3VO8/X1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3VO8/X1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDBAC116C6;
	Tue, 27 Jan 2026 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769526664;
	bh=ISEb+Eu5Q+SkKDwIob+YVqGNVOVmeBAjfYuAjFwOUTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S3VO8/X1OhcnaC0joDCOgZRNEUFOnv3FEpU0NuVx2/XNEsc46eduMcBGZYo+r5kIE
	 Y37Y+92IyhuYXhGlXdWnwtIhHJKQCsWM6oJGKxpu+myBNkMomZMPeOvDRrVGzTlxvT
	 VAn0biTMsu6ssU+8NabXYGQMux164mR6vqlodbtJkGbCWcF7WK9Z9JucvHybQm0TLS
	 FRPxeSaYPUonq2Vbl3oX4gtvKeClS8i8BB9s3MZh6I4W6aLCx/Ttp6XaRQ5czFfqQA
	 fV1ZSsD4LmHdnhD9P3+vNlvcSo86vMeeKUrEvoM+ep6WeCpKbP59wW2sP9+7UlrQNg
	 9ikgO4GcGijvg==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Frank Li <Frank.Li@nxp.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	tim609@andestech.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	dlemoal@kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 2/3] PCI: dwc: Clean up iATU index usage in dw_pcie_iatu_setup()
Date: Tue, 27 Jan 2026 16:10:40 +0100
Message-ID: <20260127151038.1484881-7-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127151038.1484881-5-cassel@kernel.org>
References: <20260127151038.1484881-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6628; i=cassel@kernel.org; h=from:subject; bh=ISEb+Eu5Q+SkKDwIob+YVqGNVOVmeBAjfYuAjFwOUTo=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIrrhZPl3Cq9VP69j+U+2Lt8ZZrgTzpfpER7fIKz4/2S 2zPU6/pKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwEROOzD80xTgmPz22oIvnyrb YpernOs8zPKUb4XHCd6jaw2q1qv+yGRkOJTLxPli77+zD598tnFYwbAikivqtJdOlm+Wyer3l1+ cZwIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The current iATU index usage in dw_pcie_iatu_setup() is a mess.

For outbound address translation the index is incremented before usage.
For inbound address translation the index is incremented after usage.

Incrementing the index after usage make much more sense, and make the
index usage consistent for both outbound and inbound address translation.

Most likely, the overly complicated logic for the outbound address
translation is because the iATU at index 0 is reserved for CFG IOs
(dw_pcie_other_conf_map_bus()), however, we should be able to use the
exact same logic for the indexing of the outbound and inbound iATUs.
(Only the starting index should be different.)

Create two new variables ob_iatu_index and ib_iatu_index, which makes
it more clear from the name itself that it is a zeroes based index,
and only increment the index if the iATU configuration call succeeded.

Since we always check if there is an index available immediately before
programming the iATU, we can remove the useless "ranges exceed outbound
iATU size" warnings, as the code is already unreachable. For the same
reason, we can also remove the useless breaks outside of the while loops.

No functional changes intended.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 59 ++++++++++---------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d7f57d77bdf5..87e6a32dbb9a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -892,9 +892,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	struct resource_entry *entry;
+	int ob_iatu_index;
+	int ib_iatu_index;
 	int i, ret;
 
-	/* Note the very first outbound ATU is used for CFG IOs */
 	if (!pci->num_ob_windows) {
 		dev_err(pci->dev, "No outbound iATU found\n");
 		return -EINVAL;
@@ -910,16 +911,18 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	for (i = 0; i < pci->num_ib_windows; i++)
 		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, i);
 
-	i = 0;
+	/*
+	 * NOTE: For outbound address translation, outbound iATU at index 0 is
+	 * reserved for CFG IOs (dw_pcie_other_conf_map_bus()), thus start at
+	 * index 1.
+	 */
+	ob_iatu_index = 1;
 	resource_list_for_each_entry(entry, &pp->bridge->windows) {
 		resource_size_t res_size;
 
 		if (resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
-		if (pci->num_ob_windows <= i + 1)
-			break;
-
 		atu.type = PCIE_ATU_TYPE_MEM;
 		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
 		atu.pci_addr = entry->res->start - entry->offset;
@@ -937,13 +940,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 			 * middle. Otherwise, we would end up only partially
 			 * mapping a single resource.
 			 */
-			if (pci->num_ob_windows <= ++i) {
-				dev_err(pci->dev, "Exhausted outbound windows for region: %pr\n",
+			if (ob_iatu_index >= pci->num_ob_windows) {
+				dev_err(pci->dev, "Cannot add outbound window for region: %pr\n",
 					entry->res);
 				return -ENOMEM;
 			}
 
-			atu.index = i;
+			atu.index = ob_iatu_index;
 			atu.size = MIN(pci->region_limit + 1, res_size);
 
 			ret = dw_pcie_prog_outbound_atu(pci, &atu);
@@ -953,6 +956,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 				return ret;
 			}
 
+			ob_iatu_index++;
 			atu.parent_bus_addr += atu.size;
 			atu.pci_addr += atu.size;
 			res_size -= atu.size;
@@ -960,8 +964,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	}
 
 	if (pp->io_size) {
-		if (pci->num_ob_windows > ++i) {
-			atu.index = i;
+		if (ob_iatu_index < pci->num_ob_windows) {
+			atu.index = ob_iatu_index;
 			atu.type = PCIE_ATU_TYPE_IO;
 			atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
 			atu.pci_addr = pp->io_bus_addr;
@@ -973,34 +977,35 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 					entry->res);
 				return ret;
 			}
+			ob_iatu_index++;
 		} else {
+			/*
+			 * If there are not enough outbound windows to give I/O
+			 * space its own iATU, the outbound iATU at index 0 will
+			 * be shared between I/O space and CFG IOs, by
+			 * temporarily reconfiguring the iATU to CFG space, in
+			 * order to do a CFG IO, and then immediately restoring
+			 * it to I/O space.
+			 */
 			pp->cfg0_io_shared = true;
 		}
 	}
 
-	if (pci->num_ob_windows <= i)
-		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
-			 pci->num_ob_windows);
-
 	if (pp->use_atu_msg) {
-		if (pci->num_ob_windows > ++i) {
-			pp->msg_atu_index = i;
-		} else {
+		if (ob_iatu_index >= pci->num_ob_windows) {
 			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
 			return -ENOMEM;
 		}
+		pp->msg_atu_index = ob_iatu_index++;
 	}
 
-	i = 0;
+	ib_iatu_index = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
 		resource_size_t res_start, res_size, window_size;
 
 		if (resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
-		if (pci->num_ib_windows <= i)
-			break;
-
 		res_size = resource_size(entry->res);
 		res_start = entry->res->start;
 		while (res_size > 0) {
@@ -1009,14 +1014,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 			 * middle. Otherwise, we would end up only partially
 			 * mapping a single resource.
 			 */
-			if (pci->num_ib_windows <= i) {
-				dev_err(pci->dev, "Exhausted inbound windows for region: %pr\n",
+			if (ib_iatu_index >= pci->num_ib_windows) {
+				dev_err(pci->dev, "Cannot add inbound window for region: %pr\n",
 					entry->res);
 				return -ENOMEM;
 			}
 
 			window_size = MIN(pci->region_limit + 1, res_size);
-			ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM, res_start,
+			ret = dw_pcie_prog_inbound_atu(pci, ib_iatu_index,
+						       PCIE_ATU_TYPE_MEM, res_start,
 						       res_start - entry->offset, window_size);
 			if (ret) {
 				dev_err(pci->dev, "Failed to set DMA range %pr\n",
@@ -1024,15 +1030,12 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 				return ret;
 			}
 
+			ib_iatu_index++;
 			res_start += window_size;
 			res_size -= window_size;
 		}
 	}
 
-	if (pci->num_ib_windows <= i)
-		dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",
-			 pci->num_ib_windows);
-
 	return 0;
 }
 
-- 
2.52.0

