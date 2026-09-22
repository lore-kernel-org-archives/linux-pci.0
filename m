Received: from mail-m3298.qiye.163.com (mail-m3298.qiye.163.com [220.197.32.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981CE39CD16
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 02:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044958; cv=none; b=ZM1dgqCVQQ6fnsKcUi9eYUIWVT77LGw8Oc5cSTV4sHFTr+IeO4LRXbaa1274rAzFDKsB4qkVpGTww0nUInsTih/3PzgyyWc4HGD9Ie0N+cGTumbi9zrLZ8H/TGSWlD7oBWviTVQ3UD0IjI5wQKuzKyLGgk0mKuNW2BJz6kjVlII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044958; c=relaxed/simple;
	bh=16YnnriyJ/kOgPJXvJdgxtcAFdz0j9bU7ZQmjucwtyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=K530/LdTbfFtNZeCK3LFNsfMgW4qtnlBUPvW17Zhzqzj1/PHwjIHimzUgLgSWt7A/ZZyFEbpQ+mV40gwstTtplSen+hZneGRqqeSCMZC8KnHvGh6fkb9rwM5TYMX46AfaDvnIFTmVDEPUDMnkWtx9HzbwAZhxJqKjo3/3lSIPog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FMn7tWTR; arc=none smtp.client-ip=220.197.32.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FMn7tWTR"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ea70feac;
	Tue, 22 Sep 2026 10:37:17 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 1/3] PCI: dw-rockchip: Move the INTx irq setup to probe
Date: Tue, 22 Sep 2026 10:37:00 +0800
Message-Id: <1790044622-164744-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
References: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0c6f988a103a4kunm27853d20398d42
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGRhKT1YZSx1JTxpCH0
	MfSExWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FMn7tWTRdfgPQSSGSZuXQRHruNnb0qRgExH513sG/+O6Y8pS119SGLE2ZjeMu6/iI0mftG/wf7rg8lIrJu6QtFgPKGSihE+8TIhJFuM9M2dXvM3al0bTYI6fDvGGrwlYs0HjtxNWEAKVdO5AS2zrNHtriLYUXRfiVYNCgXgIJJA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=n00Z4Jr5yae9rvhO7FKpm87YcHpUZxS8llu8J3/udT8=;
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
rockchip_pcie_configure_rc(), right after dw_pcie_host_init(). This
mirrors how the qcom driver requests its global IRQ, and leaves .init()
with nothing but idempotent register programming, so both
.reset_root_port() and dw_pcie_resume_noirq() can safely re-run it.
Re-running of_irq_get_byname() on every resume is also gone.

rockchip_pcie_configure_rc() can abort probe, so propagate the irq
domain creation error instead of only logging it as .init() used to do.

Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and use for link down")
Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

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

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 32 +++++++++++++++------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 1497686..8788a10 100644
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
@@ -740,6 +726,24 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 		return ret;
 	}
 
+	/*
+	 * This is done here instead of in the host ops .init() callback,
+	 * which is also re-run by .reset_root_port(), so that the INTx irq
+	 * domain is only created once, at probe time.
+	 */
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
 	/* unmask hot reset/link-down reset */
 	val = FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
-- 
2.7.4

