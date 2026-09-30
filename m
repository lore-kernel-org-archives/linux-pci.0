Received: from mail-m32113.qiye.163.com (mail-m32113.qiye.163.com [220.197.32.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A86D331202
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735881; cv=none; b=tSWENDYYFvLHYNVk6/qo4ZEyHnOQUJVh+CuYZp6Hq9nAh1mvua1vvcnxPthSd1ZsFNCBwVlAGnL142AXwvK4r/aLaSugxPGPerG+Q3h6WU7Ou7kL4bxKe3prrBW51M3Cmz+YJcKuWjQu6Ar5pgCH2qvmjGW1vSaZ1bI14c1S5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735881; c=relaxed/simple;
	bh=mC+FiKjACMLUlGwV3IQU284KW2oNlYrmzudxokWj3Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tGCqrR4t653Ib7JiotY4+KxrEC0xKsOgos8kANjD87kjMpF1DN2ztIX26Bnykdj7+xEUmglIWVRVbBeE/ij81DlV9d1WKboBo+fQzh08fggB5mnCuf+09/WjFbJyE0jq7JCYb144jGK1K6GwYDSx9q906X9h8do0vOOBJ5WpEzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=dmfKU8dw; arc=none smtp.client-ip=220.197.32.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="dmfKU8dw"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f91c9014;
	Wed, 30 Sep 2026 10:22:30 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] PCI: dwc: Rename dw_pcie_allocate_domains to dw_pcie_allocate_msi_domains
Date: Wed, 30 Sep 2026 10:22:09 +0800
Message-Id: <1790734930-217000-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1790734930-217000-1-git-send-email-shawn.lin@rock-chips.com>
References: <1790734930-217000-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0f01ee04003a4kunmb069125d8a7dcb
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQ0NITVZOGkpOSkhOGU
	hCTBhWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dmfKU8dw/IFPr0aF9RkY5CV9+s3anMN1gsDzSH8gw8JaitLteP8qP/7qTMBnTknBFyWyMS/RWrqBVjDX5XL91yMvMBLPPdsM1bJZUXd7hq1r+FqPeEgTvs6aOnEQ08kFl01/RLO2YlxYs2FuPpfTiNbmEu6NdUsbB/htj4uPzFo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=q30D34cPtR8t+1aYqul7p1W56a4Ns6B3dFH8nzXuaK0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Rename dw_pcie_allocate_domains() to dw_pcie_allocate_msi_domains() so that
the name says what it allocates and cannot be mistaken for a generic domain
allocator.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/pci/controller/dwc/pci-keystone.c         | 2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.h      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index b8e3032..c35f3f4 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -309,7 +309,7 @@ static int ks_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
 
 	pp->msi_irq_chip = &ks_pcie_msi_irq_chip;
-	return dw_pcie_allocate_domains(pp);
+	return dw_pcie_allocate_msi_domains(pp);
 }
 
 static void ks_pcie_handle_intx_irq(struct keystone_pcie *ks_pcie,
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f5a38e6..7fb165c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -207,7 +207,7 @@ static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
 	.free	= dw_pcie_irq_domain_free,
 };
 
-int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
+int dw_pcie_allocate_msi_domains(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct irq_domain_info info = {
@@ -225,7 +225,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(dw_pcie_allocate_domains);
+EXPORT_SYMBOL_GPL(dw_pcie_allocate_msi_domains);
 
 void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 {
@@ -342,7 +342,7 @@ int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 
 	pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
 
-	ret = dw_pcie_allocate_domains(pp);
+	ret = dw_pcie_allocate_msi_domains(pp);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a53ac27..22e8f95 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -869,7 +869,7 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp);
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
 int dw_pcie_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
-int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
+int dw_pcie_allocate_msi_domains(struct dw_pcie_rp *pp);
 void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 				       int where);
 #else
@@ -910,7 +910,7 @@ static inline void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 {
 }
 
-static inline int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
+static inline int dw_pcie_allocate_msi_domains(struct dw_pcie_rp *pp)
 {
 	return 0;
 }
-- 
2.7.4

