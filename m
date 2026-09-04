Received: from mail-m49245.qiye.163.com (mail-m49245.qiye.163.com [45.254.49.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4423A561
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485036; cv=none; b=BM/a/JYLQ5PTwjWUnLJoUCwC3mQ91kB3Nk6CRyIh99gM/LJJ5faIDQ2MWFkl7US6w3hX5gI/F+OSAcuP7YyRhrh9TGShYdF02ruYTcORedv/H+vsjJtlpN7B/XeFLxGRtrOWFSbPIDvthMzivfPxKFdNMqouTKR7Of4mgTl0pHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485036; c=relaxed/simple;
	bh=4+fiNVWiXrygOGTgjI4G44w6QNbBwd0sdNFjmgMtDd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EssYexGHCNrEJAJ+n6Ea14OMAQw7y9wdqxDvisKvNTqtVR+7fr7jbQaAjU7kGls4p/RT+QYduyw463wMwNZOcCKw1TBBsFdEzxxMDFdGXGj+KGyuAMyE3RLy+RjQR5zks61UpUHd1RLFNExBE3XsxyEjdk1crsct6TjvnCQmhDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=CjyWZIcO; arc=none smtp.client-ip=45.254.49.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="CjyWZIcO"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c7b37555;
	Fri, 4 Sep 2026 09:18:40 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/2] PCI: dw-rockchip: Mask the INTx IRQ while the controller clocks are gated
Date: Fri,  4 Sep 2026 09:18:29 +0800
Message-Id: <1788484709-139123-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1788484709-139123-1-git-send-email-shawn.lin@rock-chips.com>
References: <1788484709-139123-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa069ff18d903a4kunm9a952c5910a963
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGU4YS1ZPSh1OQklIGB
	gfSkpWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=CjyWZIcO4P0O+KMoCYVHOjIFK/sRQA/YshWpgWBymIzNJ4vy6qS3a36k9NklC3mvD9lecRmTjzlUIpsK9hS+M7cr7QEEiSPEqZehYj/mSSV3YoiuD3N3PAfteGYl5aKStO0GCNRxwwrJRY4tYkOjAk16wR6oP91QS0d7+ysYB0k=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=8YeVgybQaFGVaqWo90XwrRYov5wETp15PRnOneuUQPM=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

.reset_root_port() gates the controller clocks and PHY before
re-initializing the hardware. Devices on the bus may keep their INTx
line asserted across this window, so the chained INTx handler can run
and read the APB registers of the unclocked controller, raising a
synchronous external abort.

Mask the INTx IRQ before turning the clocks off and re-enable it once
the clocks are running again. On the error paths the clocks stay
gated, so the IRQ is deliberately left masked there.

Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and use for link down")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- keep the INTx IRQ masked while .reset_root_port()
  gates the controller clocks, responding to the Sashiko review
  finding about accessing the unclocked APB bus.

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index ecf0d7e..aee5ca8 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -434,7 +434,6 @@ static void rockchip_pcie_stop_link(struct dw_pcie *pci)
 static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 
 	pci->dbi_base2 = pci->dbi_base + PCIE_TYPE0_HDR_DBI2_OFFSET;
 
@@ -925,6 +924,16 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 	u32 val;
 	int ret;
 
+	/*
+	 * Devices may keep their INTx line asserted across the reset. Mask
+	 * the INTx IRQ so that the chained handler does not touch the
+	 * unclocked APB bus, which would raise a synchronous external abort.
+	 * The IRQ is re-enabled once the clocks are restored, and is
+	 * deliberately left masked on the error paths where the controller
+	 * remains unclocked.
+	 */
+	disable_irq(rockchip->intx_irq);
+
 	dw_pcie_stop_link(pci);
 	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
 	rockchip_pcie_phy_deinit(rockchip);
@@ -975,6 +984,7 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 
 	/* Ignore errors, the link may come up later */
 	dw_pcie_wait_for_link(pci);
+	enable_irq(rockchip->intx_irq);
 	dev_dbg(dev, "Root Port reset completed\n");
 	return ret;
 
-- 
2.7.4

