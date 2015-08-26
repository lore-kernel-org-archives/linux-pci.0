Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37608 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbbHZIuH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Aug 2015 04:50:07 -0400
Received: by widdq5 with SMTP id dq5so8319162wid.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2015 01:50:06 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	thierry.reding@gmail.com, linux-tegra@vger.kernel.org
Cc: swarren@wwwdotorg.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH resend] PCI: tegra: use __pgprot() around static pgprot_t initializer
Date: Wed, 26 Aug 2015 10:49:34 +0200
Message-Id: <1440578974-26527-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In order to comply with the rules that apply when STRICT_MM_TYPECHECKS
is defined, wrap the initializer for a pgprot_t in __pgprot().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/pci/host/pci-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 10c05718dbfd..0d3e6cb0c459 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -382,8 +382,8 @@ static unsigned long tegra_pcie_conf_offset(unsigned int devfn, int where)
 static struct tegra_pcie_bus *tegra_pcie_bus_alloc(struct tegra_pcie *pcie,
 						   unsigned int busnr)
 {
-	pgprot_t prot = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY | L_PTE_XN |
-			L_PTE_MT_DEV_SHARED | L_PTE_SHARED;
+	pgprot_t prot = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				 L_PTE_XN | L_PTE_MT_DEV_SHARED | L_PTE_SHARED);
 	phys_addr_t cs = pcie->cs->start;
 	struct tegra_pcie_bus *bus;
 	unsigned int i;
-- 
1.9.1

