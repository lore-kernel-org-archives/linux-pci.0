Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7565C436356;
	Mon, 20 Jul 2026 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560117; cv=none; b=M1Ot/p+50bxQzKdp7RXx+9spx8cICVkm34hz8z5/JzZA1CfIwGBRDCFN2wWqM41KgKqKMFPhwIeVXnSugRgF0QlMf0dtji0O9hHcz/6IBb/oZJG+G1YFgSMKBV0xx7Kkt9QvnKP644Y1I/xfi6pdMId688G0+JbwMH2LsieudbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560117; c=relaxed/simple;
	bh=WYuhx25G9sjPOhTLSdw4bLr2ImKawi5tUo5DLE+nRxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UOthfud6Abs6qqSxUNzFB4vuq+Chc82FlwH3h64v3lJ7JxOg4vHArqT5dYulwsue2oqUPejJcUXZ/x37hzW4FuUDrfH8PIIV+4gz/+MzeTsorhox9dldtmu5XNdl71eQuQpQ0oO9wrd/UEAO2Mi5bOaw1DxuWOszjTk6jY+pEUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=glyoB2ln; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="glyoB2ln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/S
	B7jvifzYR7GkBWCB3qlrfMX4gh0Gr4R+CcLe5/I0k=; b=glyoB2lnLVd7f+Nq+d
	vlaSVI90dgg0bU5S3wjAW14RUXKb5ea59uEsW5HnTbRHRxrROTXY9B7Iaria71Fs
	GuEJQXXsGS1jzxxr2n6Hhf+w7ptJ1tR/Y+an0rm1j2HlGhoF2ZECc4i6mdm4FVSn
	o+Hd0tMxyv64sOsyyHunjBcAQ=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX+mO9OV5q8LEOKg--.8910S4;
	Mon, 20 Jul 2026 23:07:45 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 02/16] PCI: dwc: Use cached PCIe capability offset in core
Date: Mon, 20 Jul 2026 23:06:05 +0800
Message-Id: <20260720150619.24733-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720150619.24733-1-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX+mO9OV5q8LEOKg--.8910S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr1xCFWfZw4UCFW3tr4kXrb_yoW7WFy5pa
	y3XFyFyF18Ar45ZFsI9as5XF13tFnxArWUCa9agr1SvFy7AFW2qa10yry3trn7KFsFvryY
	9w18trW3Cwn8JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zidHUfUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwGwVGpeOcEAMgAA3Y

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
- In endpoint mode: the core no longer caches automatically. Instead,
  drivers must call dw_pcie_get_pcie_cap() after hardware is enabled
  (e.g., after PERST# deassert). dw_pcie_ep_init_non_sticky_registers()
  is called after that point, so it can safely use pci->pcie_cap.

dw_pcie_ep_init_non_sticky_registers() now assumes pci->pcie_cap is
valid. if not, it prints a warning and skips the operation. The other
functions run after probe, so pci->pcie_cap is already valid and can
be used directly.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c |  2 ++
 drivers/pci/controller/dwc/pcie-designware.c      | 15 ++++++---------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7d2794945704..14228be8bbce 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1246,7 +1246,7 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 	 * to all other functions as well.
 	 */
 	if (funcs > 1) {
-		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		offset = pci->pcie_cap;
 		func0_lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 		func0_lnkcap = FIELD_GET(PCI_EXP_LNKCAP_MLW |
 					 PCI_EXP_LNKCAP_SLS, func0_lnkcap);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 06722259d2e3..fee800ac56d4 100644
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
index ec4722ed9303..810729b91892 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -766,7 +766,7 @@ const char *dw_pcie_ltssm_status_string(enum dw_pcie_ltssm ltssm)
  */
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
-	u32 offset, val, ltssm;
+	u32 val, ltssm;
 	int retries;
 
 	/* Check if the link is up or not */
@@ -806,8 +806,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 
 	pci_host_common_link_train_delay(pci->max_link_speed);
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
+	val = dw_pcie_readw_dbi(pci, pci->pcie_cap + PCI_EXP_LNKSTA);
 
 	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
 		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
@@ -843,7 +842,7 @@ EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
 static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 {
 	u32 cap, ctrl2, link_speed;
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = pci->pcie_cap;
 
 	cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 
@@ -890,7 +889,7 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
 {
 	u8 cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	u32 lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+	u32 lnkcap = dw_pcie_readl_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP);
 
 	return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
 }
@@ -898,7 +897,6 @@ int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
 static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 {
 	u32 lnkcap, lwsc, plc;
-	u8 cap;
 
 	if (!num_lanes)
 		return;
@@ -935,10 +933,9 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
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

