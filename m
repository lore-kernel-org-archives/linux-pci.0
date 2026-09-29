Received: from mail-m12772.qiye.163.com (mail-m12772.qiye.163.com [115.236.127.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B8050B43B
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677483; cv=none; b=REj+o/JbsAz8+jYvNgBkFGWyMvoOhxkoAoyH7R9nDgopMBcHCUCXhyPLH6Ng+QVnDkGdwF8EA60XAME0WKqdbiabNjd/DrPJo/BR+KXm8IoiVgve7dbo0Dmc4rdBNoBIDldwRv/X72UwOkloERyXDv9NhnSxv4azbN216IFBywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677483; c=relaxed/simple;
	bh=v+of8rN2Rvp9uljefemw21IvHcJizV8S2uM+sN44GGI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EfYtnFVaOuZzWqqzP5429mfiZ8C9xem/zIff1CIuSARik/ofQJWgsT39Y7kQTq/3EJDbEJLaX1GIidAw+6A/d/Db9TGpobs+QQwCMc2TdtXZyZpi4GYJ+LSmAYAOoViq0tj/TrXbKFQ/yHJ6l4bPl8LIkAxvmxEFfOKY7zcKNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FPEEZ7Zg; arc=none smtp.client-ip=115.236.127.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FPEEZ7Zg"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f768de6d;
	Tue, 29 Sep 2026 14:55:12 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: dw-rockchip: Enable INTx affinity support
Date: Tue, 29 Sep 2026 14:54:58 +0800
Message-Id: <1790664898-207928-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa0ebf22c3303a4kunm1b4a75ea81b7dc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGkxDQ1ZDHh0YHxkeSU
	NOHh1WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSUJDQ0xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=FPEEZ7ZgsC/LbXuk08N790+AGkezJzI4aL94BObdSzcdHzsGhTB7XpDirPA6pC9ioeyaALvNYGnAX3WLzizAATC8cUhbiPR/sSqS+tujObAbYPRxb8eAlTh11ffl4FwyECdH9HG/G5uMLTPMAN9+S2m3beAON0cPMyMLXskqkAE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=/cZOLmf/WtiucRoMtKUvb7+Grkz4rDeltc4jZcDpcmc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Leverage the interrupt redirection infrastructure to enable CPU
affinity support for the legacy INTx interrupts. The INTx virqs are
demultiplexed by the chained handler of the "legacy" interrupt, whose
affinity cannot be changed, so affinity control for the INTx virqs is
achieved by redirecting the handler to run in IRQ work context on the
target CPU.

Mask the INTx source in .irq_pre_redirect() before the handler is
redirected: the legacy interrupt is level triggered, so an unmasked
line would keep re-firing the chained interrupt until the redirected
handler runs.

Same approach as the DesignWare core, commit eaf290c404f7c39f2 ("PCI:
dwc: Enable MSI affinity support").

Test was done on RK3588 EVB1 board with an NVMe with pci=nomsi
parameter. The /proc/interrupts columns are trimmed for brevity.

  # cat /proc/interrupts | grep INTx
  51:  137 0 0 0 0 0 0 0 INTx 0 Edge PCIe PME, nvme0q0, nvme0q1
  # echo 10 > /proc/irq/51/smp_affinity
  # dd if=/dev/nvme0n1p1 of=/dev/null bs=1M count=200
  200+0 records in
  200+0 records out
  209715200 bytes (210 MB, 200 MiB) copied, 0.182021 s, 1.2 GB/s
  # cat /proc/interrupts | grep INTx
  51:  137 0 0 0 946 0 0 0 INTx 0 Edge PCIe PME, nvme0q0, nvme0q1

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 1497686..af66142 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -149,7 +149,7 @@ static void rockchip_pcie_intx_handler(struct irq_desc *desc)
 	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_LEGACY);
 
 	for_each_set_bit(hwirq, &reg, 4)
-		generic_handle_domain_irq(rockchip->irq_domain, hwirq);
+		generic_handle_demux_domain_irq(rockchip->irq_domain, hwirq);
 
 	chained_irq_exit(chip, desc);
 }
@@ -173,6 +173,16 @@ static struct irq_chip rockchip_intx_irq_chip = {
 	.irq_mask		= rockchip_intx_mask,
 	.irq_unmask		= rockchip_intx_unmask,
 	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
+#ifdef CONFIG_SMP
+	/*
+	 * The legacy interrupt is level triggered. Mask the INTx source in
+	 * the parent's context before the handler is redirected, so that
+	 * the unmasked level line does not keep re-firing the chained
+	 * interrupt until the redirected handler runs.
+	 */
+	.irq_pre_redirect	= rockchip_intx_mask,
+	.irq_set_affinity	= irq_chip_redirect_set_affinity,
+#endif
 };
 
 static int rockchip_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
-- 
2.7.4

