Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FD532AAB5;
	Sat, 30 May 2026 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155383; cv=none; b=BQ1RGxin6i6Gp0vzB17C5GI2LlX5GXApS7oYakNj0vun2n516wlyVD4fCrixx/rNU5wtiP8/MTgUNdB36dF+ht+Hn80VsLw0lPCkD0i6CqMDSNNLEjq6nhatv6EZTMySAnd4Z4z3i2qr77tDRRb3q04tX5CFxdsPMmYtpAkJiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155383; c=relaxed/simple;
	bh=CYQKlMS4vwJEVcoNDL4H9KtJy4p/r0VknULP3APC4go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UzsJC60ekEB6MH56EFL1kJNvBdnLtY+XdJJsz5l4RA876y55prrUpAKaguqmX2Y7C/sXsuVEolIQ/5IPfq1h+tbqa+EZslKsRTv5BP9XFA38GKX6QPImtXr97K9rk8JQOXyTrWZ3EzRzwFTwCe+r2dagAFyPT67jzv9l0ZsniP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=le3EBQBl; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="le3EBQBl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Di
	vrsgUAlYu1c4Ug4K0z9/9Rqe9VK3xx/y1rw22Gnx8=; b=le3EBQBlT1SY1/VUFY
	qjBR1Yo8F8gJZieTuRsR30DdK9PsSXljr5uQJBFwMCCl20AG+qS9i7tN4Q3Iw3FD
	AE0xDIB75i4whcOpQaf7WRyTiof8V79hfo69IuFd7soEJcvtINNJcLjx0ioH9lku
	co7ReVYm+gY13lug+NWbqGlo4=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnfA+4AhtqjqjeAQ--.36562S4;
	Sat, 30 May 2026 23:31:07 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s-vadapalli@ti.com,
	a-garg7@ti.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 02/16] PCI: dwc: Use cached PCIe capability offset in core
Date: Sat, 30 May 2026 23:30:47 +0800
Message-Id: <20260530153101.695580-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260530153101.695580-1-18255117159@163.com>
References: <20260530153101.695580-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnfA+4AhtqjqjeAQ--.36562S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr1xCFWfZw4UCFW3tr4kXrb_yoW7AF47pa
	y3XF1FyF18AF45ZFnI9a95Zr13tF9xAFW7Ca92gr1SvFy2yFW7Ka10yry3trn7KFsFvryY
	9w18trW5Cw15JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMmhFUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBsQs2obArt5rwAA3i

Modify the DWC core functions to use the cached pcie_cap offset instead
of calling dw_pcie_find_capability() each time.

In the DWC core, dw_pcie_find_capability() is called at several locations:
- dw_pcie_ep_init_non_sticky_registers()
- dw_pcie_wait_for_link()
- dw_pcie_link_set_max_speed()
- dw_pcie_link_get_max_link_width()
- dw_pcie_link_set_max_link_width()

The cached offset is initialized after hardware is ready:
- In host mode: dw_pcie_host_init() calls pp->ops->host_init() (enables
  clocks/resets), then dw_pcie_get_pcie_cap() caches the offset.
- In endpoint mode: dw_pcie_ep_init() calls ep->ops->pre_init() (enables
  hardware), then dw_pcie_get_pcie_cap() caches the offset.

dw_pcie_ep_init_non_sticky_registers() is called after pre_init, so it can
use dw_pcie_get_pcie_cap() safely. The other functions run after probe,
so pci->pcie_cap is already valid and can be used directly.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c  |  4 +++-
 .../pci/controller/dwc/pcie-designware-host.c    |  2 ++
 drivers/pci/controller/dwc/pcie-designware.c     | 16 ++++++----------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index a396b58d6746..11b4fa6d129c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1246,7 +1246,7 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 	 * to all other functions as well.
 	 */
 	if (funcs > 1) {
-		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		offset = dw_pcie_get_pcie_cap(pci);
 		func0_lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 		func0_lnkcap = FIELD_GET(PCI_EXP_LNKCAP_MLW |
 					 PCI_EXP_LNKCAP_SLS, func0_lnkcap);
@@ -1524,6 +1524,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ep->ops->pre_init)
 		ep->ops->pre_init(ep);
 
+	dw_pcie_get_pcie_cap(pci);
+
 	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
 			       ep->page_size);
 	if (ret < 0) {
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index cffb34f6f3a9..b8175138e47a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -593,6 +593,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_free_ecam;
 	}
 
+	dw_pcie_get_pcie_cap(pci);
+
 	if (pci_msi_enabled()) {
 		pp->use_imsi_rx = !(pp->ops->msi_init ||
 				     of_property_present(np, "msi-parent") ||
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 37d2715e38eb..810e920c1d8b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -765,7 +765,7 @@ const char *dw_pcie_ltssm_status_string(enum dw_pcie_ltssm ltssm)
  */
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
-	u32 offset, val, ltssm;
+	u32 val, ltssm;
 	int retries;
 
 	/* Check if the link is up or not */
@@ -811,8 +811,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 	if (pci->max_link_speed > 2)
 		msleep(PCIE_RESET_CONFIG_WAIT_MS);
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
+	val = dw_pcie_readw_dbi(pci, pci->pcie_cap + PCI_EXP_LNKSTA);
 
 	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
 		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
@@ -848,7 +847,7 @@ EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
 static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 {
 	u32 cap, ctrl2, link_speed;
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = pci->pcie_cap;
 
 	cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 
@@ -894,8 +893,7 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 
 int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
 {
-	u8 cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	u32 lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+	u32 lnkcap = dw_pcie_readl_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP);
 
 	return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
 }
@@ -903,7 +901,6 @@ int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
 static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 {
 	u32 lnkcap, lwsc, plc;
-	u8 cap;
 
 	if (!num_lanes)
 		return;
@@ -940,10 +937,9 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
 
-	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+	lnkcap = dw_pcie_readl_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP);
 	FIELD_MODIFY(PCI_EXP_LNKCAP_MLW, &lnkcap, num_lanes);
-	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
+	dw_pcie_writel_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP, lnkcap);
 }
 
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
-- 
2.34.1

