Received: from mail-m1973173.qiye.163.com (mail-m1973173.qiye.163.com [220.197.31.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9101C376A19
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759544; cv=none; b=ugbHo1Pt1Kx19UCIdk240lDntdMCFznzMYtg1Mr9/ATUaxaCcfeFIMMgOipod4WQZ8gHkHb1cuUMwRZlrTwImlHbrLun1Jwx4ObYKbmGiWL0ykUWLbhJjaAU+UIq5kxMl9I9BYSVSiZvt2AikJGaBbQc7tnOidOf85jQc8yfSTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759544; c=relaxed/simple;
	bh=pbma0XKBt5bf/IQpR4kuyiKEc1l7p9m7JfWVxPoHs2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JyHODJBV+TWjQqRztHEJX1QgM3vxoVEuNKkSr/0x9p1XNV0pC95LWGs+Zu1aG18tV69xOsJTpmGGnMkoOLfcgqELiw0WKCJikmiU/Sj8x4m01vnO0Ly8oYvy4GHDL/eFAnmqavZNMzj+k+B3+fXKBKRV/kld7IqJuj7fET8MRng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=j1IYodZj; arc=none smtp.client-ip=220.197.31.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="j1IYodZj"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f91c9030;
	Wed, 30 Sep 2026 10:22:34 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 2/2] PCI: dwc: Rename pp->irq_domain to pp->msi_irq_domain
Date: Wed, 30 Sep 2026 10:22:10 +0800
Message-Id: <1790734930-217000-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1790734930-217000-1-git-send-email-shawn.lin@rock-chips.com>
References: <1790734930-217000-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0f01ef0c803a4kunmb069125d8a7e03
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQhpMHlYZTE8fTEhMTB
	8aTk9WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=j1IYodZjp38jyRoQ/FR/G471Qwh8jOTtAr6ijgT91CGYo35nGTh3pE/6l/U5lfLEZzuTccFdbv4ojrgs90AVpGo8PYeUeQBuWS4Tro5yNjOOX2Dgt1IsXeiiLsF78gFeQrJLh+jbPt85z3chQYmVyNsH9oHlv4PIR2+gV5tsRDA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=aBTWoHrRjP/xPXukeVQhnjTf1B9cu0kbpxuBuPnUcQ0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pp->irq_domain is exclusively the MSI parent irq domain: it is created
by dw_pcie_allocate_msi_domains() with msi_create_parent_irq_domain()
and is only used to resolve the MSI child virqs in dw_handle_msi_irq()
and in the keystone and dra7xx MSI handlers. The name gives no hint
about that, in the same way dw_pcie_allocate_domains() did not say that
it was only about MSI.

Rename it to pp->msi_irq_domain, matching the previous rename.

Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/controller/dwc/pci-dra7xx.c           | 2 +-
 drivers/pci/controller/dwc/pci-keystone.c         | 2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++----
 drivers/pci/controller/dwc/pcie-designware.h      | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 3460a83..0d56fd5 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -213,7 +213,7 @@ static int dra7xx_pcie_handle_msi(struct dw_pcie_rp *pp, int index)
 
 	pos = find_first_bit(&val, MAX_MSI_IRQS_PER_CTRL);
 	while (pos != MAX_MSI_IRQS_PER_CTRL) {
-		generic_handle_domain_irq(pp->irq_domain,
+		generic_handle_domain_irq(pp->msi_irq_domain,
 					  (index * MAX_MSI_IRQS_PER_CTRL) + pos);
 		pos++;
 		pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL, pos);
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index c35f3f4..388a97c 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -633,7 +633,7 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 
 		vector = offset + (pos << 3);
 		dev_dbg(dev, "irq: bit %d, vector %d\n", pos, vector);
-		generic_handle_domain_irq(pp->irq_domain, vector);
+		generic_handle_domain_irq(pp->msi_irq_domain, vector);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7fb165c..0bf9a59 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -82,7 +82,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
 			continue;
 
 		for_each_set_bit(pos, &status, MAX_MSI_IRQS_PER_CTRL)
-			generic_handle_demux_domain_irq(pp->irq_domain, irq_off + pos);
+			generic_handle_demux_domain_irq(pp->msi_irq_domain, irq_off + pos);
 	}
 }
 
@@ -217,8 +217,8 @@ int dw_pcie_allocate_msi_domains(struct dw_pcie_rp *pp)
 		.host_data	= pp,
 	};
 
-	pp->irq_domain = msi_create_parent_irq_domain(&info, &dw_pcie_msi_parent_ops);
-	if (!pp->irq_domain) {
+	pp->msi_irq_domain = msi_create_parent_irq_domain(&info, &dw_pcie_msi_parent_ops);
+	if (!pp->msi_irq_domain) {
 		dev_err(pci->dev, "Failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
@@ -236,7 +236,7 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
 	}
 
-	irq_domain_remove(pp->irq_domain);
+	irq_domain_remove(pp->msi_irq_domain);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_free_msi);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 22e8f95..f2fdc29 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -454,7 +454,7 @@ struct dw_pcie_rp {
 	int			irq;
 	const struct dw_pcie_host_ops *ops;
 	int			msi_irq[MAX_MSI_CTRLS];
-	struct irq_domain	*irq_domain;
+	struct irq_domain	*msi_irq_domain;
 	dma_addr_t		msi_data;
 	struct irq_chip		*msi_irq_chip;
 	u32			num_vectors;
-- 
2.7.4

