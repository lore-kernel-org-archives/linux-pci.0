Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F039CEFE
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120975; cv=none; b=qAQE31VO6xMj7vxKqb0k6g6D1OsPOlxI9CJw2tFFBmsu0H6OdIxKmWEriQEj24EZEqQxs9O2Vfqsv1M3Phythun7sKRQbuvtMSxXDxBk2mIYRn2/1lYS6Vp5fgCtGdtzNsZXFZaeuQvS3in90D0neXii6biLC03S0F8EmxJLL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120975; c=relaxed/simple;
	bh=GX7sZWy/Do3lWb8sgt/nLsEkqbxP3M+Tnq4ljm3Pmt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLAsb8cavuAOcNzI+itInWBJcQqXmkPfKhd26RMnWqM/ipQ2lFzxs9WiE/CIljgF61QjR81HgsaoZ1IJS/Fal5l5RM/GQ5rhjsce2st8MgcP4+OYezU+4OAss5fnwe/IqsU0JU3WFwN5nzdtCDxyilJKkZeaBbAvhL/ms64IuLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilVC9d3l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilVC9d3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1114C116C6;
	Thu, 22 Jan 2026 22:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769120974;
	bh=GX7sZWy/Do3lWb8sgt/nLsEkqbxP3M+Tnq4ljm3Pmt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ilVC9d3l2WzdOI29L1p84NmwhBLHKd8KSSymSpfvnXG7szvN5PdjddHervfcEf7Vo
	 XqY1WOVFQRNbPSRPCtcmGlYlU7L/8J2NtpAqBuVpVWliMcRvQou3YjYIfue+jZJnG3
	 jKnh1OZIQboivbrzpwyYkJkYOm+ag5gN5GWmVxRX/7e62OYBvOq3ZtqDB1gNvAIFm8
	 okH7tgtbQZXzEgOe+zP2Ut6DX3DKQ9qgHzKpxI6HZ33Xo1gltx2pKtVYtfkJtgrt1F
	 4l9hw+zBwf8yKQ4e/Wc+ooVWOxrbxBQUmdAuuTUkSq3aUweuhAXwViIgypP0uA4lHK
	 xVc3nCHK2ZduQ==
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
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 3/4] PCI: dwc: Clean up iatu index usage in dw_pcie_iatu_setup()
Date: Thu, 22 Jan 2026 23:29:17 +0100
Message-ID: <20260122222914.523238-9-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122222914.523238-6-cassel@kernel.org>
References: <20260122222914.523238-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6990; i=cassel@kernel.org; h=from:subject; bh=GX7sZWy/Do3lWb8sgt/nLsEkqbxP3M+Tnq4ljm3Pmt4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKLluzOkHtS9fJQ0pd8C4PKg2Enp659MdV2ms2i/nW99 3btjLnI0FHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJxC1j+Cs4Rb+4JWvNtRW/ Sp7mBK48ue7cv5sHtm68n2Zf+9b3Ot81Roa/WmHVqZmHPoUyTvqj5rj2h3TV1Db/tUfVle6t5L4 59Q4jAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The current iatu index usage in dw_pcie_iatu_setup() is a mess.

For outbound address translation the index is incremented before usage.
For inbound address translation the index is incremented after usage.

Incrementing the index after usage make much more sense, and:
Make the index usage consistent for both outbound and inbound address
translation.

Most likely, the overly complicated logic for the outbound address
translation is because the iatu at index 0 is reserved for CFG IOs
(dw_pcie_other_conf_map_bus()), however, we should be able to use the
exact same logic for the indexing of the outbound and inbound iatus.
(Only the starting index should be different.)

Create two new variables ob_iatu_index_to_use, ib_iatu_index_to_use,
which makes it clear from the name itself that it is the index before
increment.

Since we always check if there is an index available immediately before
programming the iATU, we can remove the useless "ranges exceed outbound
iATU size" warnings, as the code is already unreachable. For the same
reason, we can also remove the useless breaks outside of the while loops.

Also switch to use the more logical, but equivalent check if index is
smaller than length, which is the most common pattern when e.g. looping
through an array which has length items (0 to length-1), such that it is
even clearer to the reader that this is a zeroes based index.

No functional changes intended.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 59 ++++++++++---------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 991fe5b9a7b3..76be24af7cfd 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -892,9 +892,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	struct resource_entry *entry;
+	int ob_iatu_index_to_use;
+	int ib_iatu_index_to_use;
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
+	ob_iatu_index_to_use = 1;
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
+			if (!(ob_iatu_index_to_use < pci->num_ob_windows)) {
+				dev_err(pci->dev, "Cannot add outbound window for region: %pr\n",
 					entry->res);
 				return -ENOMEM;
 			}
 
-			atu.index = i;
+			atu.index = ob_iatu_index_to_use;
 			atu.size = MIN(pci->region_limit + 1, res_size);
 
 			ret = dw_pcie_prog_outbound_atu(pci, &atu);
@@ -953,6 +956,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 				return ret;
 			}
 
+			ob_iatu_index_to_use++;
 			atu.parent_bus_addr += atu.size;
 			atu.pci_addr += atu.size;
 			res_size -= atu.size;
@@ -960,8 +964,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	}
 
 	if (pp->io_size) {
-		if (pci->num_ob_windows > ++i) {
-			atu.index = i;
+		if (ob_iatu_index_to_use < pci->num_ob_windows) {
+			atu.index = ob_iatu_index_to_use;
 			atu.type = PCIE_ATU_TYPE_IO;
 			atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
 			atu.pci_addr = pp->io_bus_addr;
@@ -973,34 +977,37 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 					entry->res);
 				return ret;
 			}
+			ob_iatu_index_to_use++;
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
+		if (ob_iatu_index_to_use < pci->num_ob_windows) {
+			pp->msg_atu_index = ob_iatu_index_to_use;
+			ob_iatu_index_to_use++;
 		} else {
 			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
 			return -ENOMEM;
 		}
 	}
 
-	i = 0;
+	ib_iatu_index_to_use = 0;
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
@@ -1009,14 +1016,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 			 * middle. Otherwise, we would end up only partially
 			 * mapping a single resource.
 			 */
-			if (pci->num_ib_windows <= i) {
-				dev_err(pci->dev, "Exhausted inbound windows for region: %pr\n",
+			if (!(ib_iatu_index_to_use < pci->num_ib_windows)) {
+				dev_err(pci->dev, "Cannot add inbound window for region: %pr\n",
 					entry->res);
 				return -ENOMEM;
 			}
 
 			window_size = MIN(pci->region_limit + 1, res_size);
-			ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM, res_start,
+			ret = dw_pcie_prog_inbound_atu(pci, ib_iatu_index_to_use,
+						       PCIE_ATU_TYPE_MEM, res_start,
 						       res_start - entry->offset, window_size);
 			if (ret) {
 				dev_err(pci->dev, "Failed to set DMA range %pr\n",
@@ -1024,15 +1032,12 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 				return ret;
 			}
 
+			ib_iatu_index_to_use++;
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

