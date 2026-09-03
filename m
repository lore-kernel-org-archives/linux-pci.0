Received: from mail-m1973196.qiye.163.com (mail-m1973196.qiye.163.com [220.197.31.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17B83264DD
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788403819; cv=none; b=oB9FeOybhmiFSX/XxIAKm7FHp+Eq5O4uYlh8sR5qVGjfUfp2M+7FZ6I7otbMoxIk7qgSlMC9GAfsvwsAXWQovTGsllF8dAARXCh74kseht5JOUaLUhAQqjBq1GYeQsPQ8aY37nuYoh3JRZOKYAOXEgEqHn3Oudjn9Qq7UpoO6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788403819; c=relaxed/simple;
	bh=NgNl2uql9tO4i+CyDBB7L1xsVBc64OxMh+Vjb9ebH10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pTZpoKIbkG8adK5if/j0iY4wBHcsVvZJ+/eOOIlDgpMpnYnG0kzXlOkAzX4Eb+hTnGOv3ZStV36KMgcBWqfqqOlMuKeRmgWTYSujgIIkqHYBKTdk11vwk2oA++6Q3ZnyVWp0ahwTuCU/X88nhVkJW8eBlaupln0iNfk8oP0aKxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=PfxfnNer; arc=none smtp.client-ip=220.197.31.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="PfxfnNer"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c5849824;
	Thu, 3 Sep 2026 10:44:54 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Peter Geis <pgwipeout@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] PCI: dw-rockchip: Do not recreate the INTx irq domain on root port reset
Date: Thu,  3 Sep 2026 10:44:37 +0800
Message-Id: <1788403477-71491-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com>
References: <1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa06527aeed03a4kunm355d5a8763ee6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQ0hLS1YdHxhPGkJOT0
	lPQ0JWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PfxfnNerxX97Q4CGupDFknJwpsP1ug8EbRC+gfJaoH5rrM+u0dC+d58RRm59QkKx/urD540Nh7FNIlVJBCNopEWWL4w/dKp7s4EV/VMjTsJRLwaCOwj/bbxQ+jOTUWuHgFbzEY+upPHHyEgMYzncn/LXByV+VUvJiBN8p8TJeVc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=FzU+8PGJgfCvydkiA6ltBY+b8mcOBv3eiLjMbqLbEis=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

.reset_root_port() re-runs the host ops .init() callback to reprogram
the Root Complex after the controller reset. However, .init() also
creates a new INTx irq domain on every root port reset, so that:

  - the previous irq domain is leaked, as it is never removed, and two
    irq domains end up registered for the same fwnode;

  - the INTx virqs of the downstream PCI devices were allocated in the
    previous irq domain and are never re-mapped, while the chained
    handler now looks up virqs in the new, empty domain. Hence, after a
    link down recovery, INTx interrupts are silently lost.

Split the (re)programming of the Root Complex registers out of .init()
into rockchip_pcie_host_hw_init() and call that from .reset_root_port()
instead. The INTx irq domain and the chained handler are now only set up
once, at probe time, which keeps the already mapped virqs valid across
root port resets.

Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and use for link down")
Cc: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 37 +++++++++++++++++----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 50824c8..ff92394 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -418,6 +418,27 @@ static void rockchip_pcie_stop_link(struct dw_pcie *pci)
 	rockchip_pcie_ltssm_trace(rockchip, false);
 }
 
+/*
+ * (Re)program the Root Complex registers that are cleared by the controller
+ * reset. Called from .init() at probe time and from .reset_root_port().
+ * The INTx irq domain must not be touched here, as downstream devices hold
+ * virqs mapped in it.
+ */
+static void rockchip_pcie_host_hw_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	pci->dbi_base2 = pci->dbi_base + PCIE_TYPE0_HDR_DBI2_OFFSET;
+
+	rockchip_pcie_configure_l1ss(pci);
+	rockchip_pcie_enable_l0s(pci);
+	pp->bridge->reset_root_port = rockchip_pcie_rc_reset_root_port;
+
+	/* Disable Root Ports BAR0 and BAR1 as they report bogus size */
+	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, 0x0);
+	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_1, 0x0);
+}
+
 static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -429,8 +450,6 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	if (irq < 0)
 		return irq;
 
-	pci->dbi_base2 = pci->dbi_base + PCIE_TYPE0_HDR_DBI2_OFFSET;
-
 	ret = rockchip_pcie_init_irq_domain(rockchip);
 	if (ret < 0) {
 		dev_err(dev, "failed to init irq domain\n");
@@ -440,13 +459,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
 					 rockchip);
 
-	rockchip_pcie_configure_l1ss(pci);
-	rockchip_pcie_enable_l0s(pci);
-	pp->bridge->reset_root_port = rockchip_pcie_rc_reset_root_port;
-
-	/* Disable Root Ports BAR0 and BAR1 as they report bogus size */
-	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, 0x0);
-	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_1, 0x0);
+	rockchip_pcie_host_hw_init(pp);
 
 	return 0;
 }
@@ -920,11 +933,7 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 	if (ret)
 		goto deinit_phy;
 
-	ret = pp->ops->init(pp);
-	if (ret) {
-		dev_err(dev, "Host init failed: %d\n", ret);
-		goto deinit_clk;
-	}
+	rockchip_pcie_host_hw_init(pp);
 
 	/* LTSSM enable control mode */
 	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
-- 
2.7.4

