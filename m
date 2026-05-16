Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9373E3C69;
	Sat, 16 May 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945853; cv=none; b=TBc9LOSFvcn59TlHp665RrDLJgiZ4URH6FXY8iQJxnjrJ7c2hbjTs4N3SkUoNjvZ3YDj5/A2uQAdopP7iQTbpXYmGd/H4okbOg4VUL2nB7vi7piQPUl9sKkgK5qLKpCm08ReyQehT5HxPbxgmETjK1WL1RIJE3RM/ZoO22i+4NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945853; c=relaxed/simple;
	bh=h/qzQYlE7lUe5P8Av6aQLnQFrUQVp75HdpY89nVwQwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b1YBezeZlX+n0niCBZ9frAZWTg0a/S61zp6RqCUvOtaXYQMMsNogs3KLJUuk03h8xDT8Pkbz7ZVxRJdfNi1+GMXE4hVOstk8/zMMwdaxVPHK8o8NZahXI64Azh0f8PDhHU+sbBpuzDFV0UgI2HvtWSQ2gYiqh8unRLX8gmpA15g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WzSS3PZw; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WzSS3PZw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4B
	+PdJ0CMlJUVeqlTg08VI37BUIgRRoNVGBsNRbSpds=; b=WzSS3PZwJH/n5W6ZLV
	8228URS9IEO9q/8s+CY+v05Tt0gL2hNXQ4stAZnnWs/jCqvSyMKcjEv7Tv4RsPA8
	/f0TTeLHjxZs8GMYDQbC0UqBaZ+CmpCa+QF2Yd4H8RXatINN3pRmkJmir3Z1F6dG
	6qDt5UeE9GaBCa8EhnGkbs8/U=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3XzoajwhqfCYHBw--.40848S4;
	Sat, 16 May 2026 23:36:59 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	mani@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 2/3] PCI: dwc: Replace ATU type macros with common TLP type macros
Date: Sat, 16 May 2026 23:36:56 +0800
Message-Id: <20260516153657.65214-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516153657.65214-1-18255117159@163.com>
References: <20260516153657.65214-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3XzoajwhqfCYHBw--.40848S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xw4xtr4UGFW7Gw4DGF18AFb_yoW3Gw4DpF
	W5JFWSyF18JFsxuFs0y3WDZF1Sy3ZI9FyUGrsxW34Iqa4Iyry8Kr48ArW3K3saqr40yrWS
	yw1aq34xJa13GFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRF4E_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBuGKmoIjxug6QAA3M

The dwc driver defines its own ATU type macros (PCIE_ATU_TYPE_MEM,
PCIE_ATU_TYPE_IO, PCIE_ATU_TYPE_CFG0, PCIE_ATU_TYPE_CFG1,
PCIE_ATU_TYPE_MSG) with the same numerical values as the newly
introduced common TLP type macros.

Remove the local definitions and switch all dwc users to the common
PCIE_TLP_TYPE_* macros. This eliminates redundancy and improves
consistency across PCI controller drivers.

No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   |  6 +++---
 .../pci/controller/dwc/pcie-designware-host.c | 20 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.c  |  2 +-
 drivers/pci/controller/dwc/pcie-designware.h  |  5 -----
 .../pci/controller/dwc/pcie-tegra194-acpi.c   |  4 ++--
 5 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index d4dc3b24da60..461f7fc62e85 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -584,9 +584,9 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 config_atu:
 	if (!(flags & PCI_BASE_ADDRESS_SPACE))
-		type = PCIE_ATU_TYPE_MEM;
+		type = PCIE_TLP_TYPE_MEM_RDWR;
 	else
-		type = PCIE_ATU_TYPE_IO;
+		type = PCIE_TLP_TYPE_IO_RDWR;
 
 	if (epf_bar->num_submap)
 		ret = dw_pcie_ep_ib_atu_addr(ep, func_no, type, epf_bar);
@@ -659,7 +659,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ob_atu_cfg atu = { 0 };
 
 	atu.func_no = func_no;
-	atu.type = PCIE_ATU_TYPE_MEM;
+	atu.type = PCIE_TLP_TYPE_MEM_RDWR;
 	atu.parent_bus_addr = addr - pci->parent_bus_offset;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index c9517a348836..b0ff421dbb5b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -434,7 +434,7 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
 	 * remaining buses need type 1 iATU configuration.
 	 */
 	atu.index = 0;
-	atu.type = PCIE_ATU_TYPE_CFG0;
+	atu.type = PCIE_TLP_TYPE_CFG0_RDWR;
 	atu.parent_bus_addr = pp->cfg0_base + SZ_1M;
 	/* 1MiB is to cover 1 (bus) * 32 (devices) * 8 (functions) */
 	atu.size = SZ_1M;
@@ -450,7 +450,7 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
 
 	/* Configure remaining buses in type 1 iATU configuration */
 	atu.index = 1;
-	atu.type = PCIE_ATU_TYPE_CFG1;
+	atu.type = PCIE_TLP_TYPE_CFG1_RDWR;
 	atu.parent_bus_addr = pp->cfg0_base + SZ_2M;
 	atu.size = (SZ_1M * bus_range_max) - SZ_2M;
 	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
@@ -745,9 +745,9 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
 
 	if (pci_is_root_bus(bus->parent))
-		type = PCIE_ATU_TYPE_CFG0;
+		type = PCIE_TLP_TYPE_CFG0_RDWR;
 	else
-		type = PCIE_ATU_TYPE_CFG1;
+		type = PCIE_TLP_TYPE_CFG1_RDWR;
 
 	atu.type = type;
 	atu.parent_bus_addr = pp->cfg0_base - pci->parent_bus_offset;
@@ -774,7 +774,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 
 	if (pp->cfg0_io_shared) {
-		atu.type = PCIE_ATU_TYPE_IO;
+		atu.type = PCIE_TLP_TYPE_IO_RDWR;
 		atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
@@ -800,7 +800,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 
 	if (pp->cfg0_io_shared) {
-		atu.type = PCIE_ATU_TYPE_IO;
+		atu.type = PCIE_TLP_TYPE_IO_RDWR;
 		atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
@@ -908,7 +908,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
-		atu.type = PCIE_ATU_TYPE_MEM;
+		atu.type = PCIE_TLP_TYPE_MEM_RDWR;
 		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
 		atu.pci_addr = entry->res->start - entry->offset;
 
@@ -951,7 +951,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	if (pp->io_size) {
 		if (ob_iatu_index < pci->num_ob_windows) {
 			atu.index = ob_iatu_index;
-			atu.type = PCIE_ATU_TYPE_IO;
+			atu.type = PCIE_TLP_TYPE_IO_RDWR;
 			atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
 			atu.pci_addr = pp->io_bus_addr;
 			atu.size = pp->io_size;
@@ -1013,7 +1013,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 			window_size = MIN(pci->region_limit + 1, res_size);
 			ret = dw_pcie_prog_inbound_atu(pci, ib_iatu_index,
-						       PCIE_ATU_TYPE_MEM, res_start,
+						       PCIE_TLP_TYPE_MEM_RDWR, res_start,
 						       res_start - entry->offset, window_size);
 			if (ret) {
 				dev_err(pci->dev, "Failed to set DMA range %pr\n",
@@ -1194,7 +1194,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 
 	atu.code = PCIE_MSG_CODE_PME_TURN_OFF;
 	atu.routing = PCIE_MSG_TYPE_R_BC;
-	atu.type = PCIE_ATU_TYPE_MSG;
+	atu.type = PCIE_TLP_TYPE_MSG;
 	atu.size = resource_size(pci->pp.msg_res);
 	atu.index = pci->pp.msg_atu_index;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c11cf61b8319..813f4baa7c62 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -568,7 +568,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
 	val = PCIE_ATU_ENABLE | atu->ctrl2;
-	if (atu->type == PCIE_ATU_TYPE_MSG) {
+	if (atu->type == PCIE_TLP_TYPE_MSG) {
 		/* The data-less messages only for now */
 		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
 	}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 3e69ef60165b..d8d83156fb9d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -170,11 +170,6 @@
 #define PCIE_ATU_VIEWPORT_SIZE		0x2C
 #define PCIE_ATU_REGION_CTRL1		0x000
 #define PCIE_ATU_INCREASE_REGION_SIZE	BIT(13)
-#define PCIE_ATU_TYPE_MEM		0x0
-#define PCIE_ATU_TYPE_IO		0x2
-#define PCIE_ATU_TYPE_CFG0		0x4
-#define PCIE_ATU_TYPE_CFG1		0x5
-#define PCIE_ATU_TYPE_MSG		0x10
 #define PCIE_ATU_TD			BIT(8)
 #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
 #define PCIE_ATU_REGION_CTRL2		0x004
diff --git a/drivers/pci/controller/dwc/pcie-tegra194-acpi.c b/drivers/pci/controller/dwc/pcie-tegra194-acpi.c
index 55f61914a986..2d737b49ea8f 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194-acpi.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194-acpi.c
@@ -86,11 +86,11 @@ static void __iomem *tegra194_map_bus(struct pci_bus *bus,
 
 	if (bus->parent->number == cfg->busr.start) {
 		if (PCI_SLOT(devfn) == 0)
-			type = PCIE_ATU_TYPE_CFG0;
+			type = PCIE_TLP_TYPE_CFG0_RDWR;
 		else
 			return NULL;
 	} else {
-		type = PCIE_ATU_TYPE_CFG1;
+		type = PCIE_TLP_TYPE_CFG1_RDWR;
 	}
 
 	program_outbound_atu(pcie_ecam, 0, type, cfg->res.start, busdev,
-- 
2.34.1

