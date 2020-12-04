Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E06C433FE
	for <linux-pci@archiver.kernel.org>; Fri,  4 Dec 2020 16:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F43F22B4E
	for <linux-pci@archiver.kernel.org>; Fri,  4 Dec 2020 16:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgLDQ70 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Dec 2020 11:59:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:59512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728583AbgLDQ70 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 11:59:26 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Alex Dewar <alex.dewar90@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: dwc: exynos: add back MSI dependency
Date:   Fri,  4 Dec 2020 17:58:34 +0100
Message-Id: <20201204165841.3845589-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

While the exynos driver does not always need MSI, the generic
deisgnware host code it uses fails to build without it:

WARNING: unmet direct dependencies detected for PCIE_DW_HOST
  Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
  Selected by [y]:
  - PCI_EXYNOS [=y] && PCI [=y] && (ARCH_EXYNOS [=n] || COMPILE_TEST [=y])
drivers/pci/controller/dwc/pcie-designware-host.c:247:19: error: implicit declaration of function 'pci_msi_create_irq_domain' [-Werror,-Wimplicit-function-declaration]
        pp->msi_domain = pci_msi_create_irq_domain(fwnode,
                         ^

Add back the dependency that all other designware controllers have.

Fixes: f0a6743028f9 ("PCI: dwc: exynos: Rework the driver to support Exynos5433 variant")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 020101b58155..e403bb2eeb4c 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -85,6 +85,7 @@ config PCIE_DW_PLAT_EP
 config PCI_EXYNOS
 	tristate "Samsung Exynos PCIe controller"
 	depends on ARCH_EXYNOS || COMPILE_TEST
+	depends on PCI && PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
 	  Enables support for the PCIe controller in the Samsung Exynos SoCs
-- 
2.27.0

