Received: from mail-m9320.xmail.ntesmail.com (mail-m9320.xmail.ntesmail.com [103.126.93.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A05E30DECB
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.93.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790222838; cv=none; b=s9ZrEbTdXgd5o1wvM5a7D90+xhgr+owqbutllEEtKLe4z4W03L2HH13oTcrUUbG9I8Zk0ED6kjiKkSPvLja3V0P2MtmssocZkxy6mDGaXvD6DnM57toX/49gO2VraB5sjUYRY69PXbxfn2gG9+WlH4BiUeeJ2g+eAUFIx0+0S4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790222838; c=relaxed/simple;
	bh=7C6Zl/eGVFp2Pt/7MsWoc1VEMPOrqOWTFq3zKlxiuyY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=T4XUEPRKjAblx0NW1G/mCCM1Jc9yP6l+gfXA+BSFTzUsiT3PRTTmndTJ+i6zj6NmDg30H34FARroIrzAj07KwflTPz37msYXULJCcWev2zDxhkcMykKDEmsoH+54YiAZZ6k+78EuIP/X/tRm2YR4785bT45bNHCBj7l+9UgRgTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TySLePJ4; arc=none smtp.client-ip=103.126.93.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TySLePJ4"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ef7608d3;
	Thu, 24 Sep 2026 12:07:02 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4] PCI: dw-rockchip: Move the INTx irq setup to probe
Date: Thu, 24 Sep 2026 12:06:33 +0800
Message-Id: <1790222793-77182-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa0d1986b4103a4kunm47a76791511db9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUpMHVYYSExISUpIH0
	8ZTkNWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZS1
	VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=TySLePJ4TBsUOmjkCwrWL/AmdlED8OjDRBuyktROf3gwRtahYHW1/12B//f76/6UHsYs2CeQHFSJNdMlXreYMeD9Fpxg715gSqDmVmul1woUxYzcB5m321nv8zn/ZiBPniSA0kZW4FlSdvSKEXtFFlGsJ6L+HiisvthcpX3OmWE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=HN0pp24pZmSGqLJQAT9kmJas1gg8aX6HKbdeTQypF68=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Since commit b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port()
and use for link down"), .reset_root_port() re-runs the host ops .init()
callback to reprogram the Root Complex after a controller reset. That
works for the register programming, but .init() is not re-entrant: it
also creates the INTx irq domain and installs the chained INTx handler.
Every root port reset therefore ends up with a second irq domain
registered for the same fwnode: the previous one is leaked, as it is
never removed, and worse, the INTx virqs of the downstream PCI devices
were allocated in the previous irq domain and are never re-mapped, while
the chained handler now looks up virqs in the new, empty domain. After a
link down recovery, INTx interrupts are silently lost.

Fix it by moving the of_irq_get_byname() lookup, the INTx irq domain
creation and the chained handler installation out of .init() and into
rockchip_pcie_configure_rc(), just before dw_pcie_host_init(). The
lookup has to happen before the host is initialized, because
dw_pcie_host_init() enumerates the bus and probes the downstream
devices, and pci_assign_irq() maps their INTx interrupts at that point:
if the domain does not exist yet, the mapping fails and the devices end
up without a usable INTx. This also mirrors how the qcom driver requests
its global IRQ, and leaves .init() with nothing but idempotent register
programming, so both .reset_root_port() and dw_pcie_resume_noirq() can
safely re-run it. Re-running of_irq_get_byname() on every resume is also
gone.

Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and use for link down")
Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4:
- drop the code comment (Niklas)
- create the INTx irq domain before dw_pcie_host_init() instead of
  after it. dw_pcie_host_init() enumerates the bus and probes the
  downstream devices, and their INTx interrupts get mapped at that
  point, so registering the domain afterwards left every downstream
  device without a usable INTx (flagged by the Sashiko review).
- this also removes the failing steps behind dw_pcie_host_init(), so
  there is no error path left that would return with the root bus
  registered and the rockchip structure about to be freed (flagged by
  the Sashiko review).

Changes in v3:
- split devm-managed part into a seperate patch

Changes in v2:
- Moved the of_irq_get_byname() lookup, the INTx irq domain creation
  and the chained handler installation out of the host ops .init()
  callback into rockchip_pcie_configure_rc(), right after
  dw_pcie_host_init(), as suggested by Niklas Cassel. This supersedes
  v1 patch 1/2, as .init() no longer creates the irq domain, and
  removes the rockchip_pcie_host_hw_init() helper from v1.
- Made the INTx irq domain devm-managed with
  devm_irq_domain_instantiate() and uninstall the chained handler
  through a devres action, addressing the probe failure leak and
  use-after-free flagged by the Sashiko review.

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 1497686..bd86e32c 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -422,23 +422,9 @@ static void rockchip_pcie_stop_link(struct dw_pcie *pci)
 static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
-	struct device *dev = rockchip->pci.dev;
-	int irq, ret;
-
-	irq = of_irq_get_byname(dev->of_node, "legacy");
-	if (irq < 0)
-		return irq;
 
 	pci->dbi_base2 = pci->dbi_base + PCIE_TYPE0_HDR_DBI2_OFFSET;
 
-	ret = rockchip_pcie_init_irq_domain(rockchip);
-	if (ret < 0)
-		dev_err(dev, "failed to init irq domain\n");
-
-	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
-					 rockchip);
-
 	rockchip_pcie_configure_l1ss(pci);
 	rockchip_pcie_enable_l0s(pci);
 	pp->bridge->reset_root_port = rockchip_pcie_rc_reset_root_port;
@@ -731,6 +717,19 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
 				 PCIE_CLIENT_GENERAL_CON);
 
+	irq = of_irq_get_byname(dev->of_node, "legacy");
+	if (irq < 0)
+		return irq;
+
+	ret = rockchip_pcie_init_irq_domain(rockchip);
+	if (ret < 0) {
+		dev_err(dev, "failed to init irq domain\n");
+		return ret;
+	}
+
+	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
+					 rockchip);
+
 	pp = &rockchip->pci.pp;
 	pp->ops = &rockchip_pcie_host_ops;
 
-- 
2.7.4

