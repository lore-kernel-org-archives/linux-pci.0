Return-Path: <SRS0=IOiO=DI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C309C4727E
	for <linux-pci@archiver.kernel.org>; Thu,  1 Oct 2020 07:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFADC21531
	for <linux-pci@archiver.kernel.org>; Thu,  1 Oct 2020 07:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgJAHoL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 1 Oct 2020 03:44:11 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:35424 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgJAHoK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 03:44:10 -0400
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 543CE3A8E0A;
        Thu,  1 Oct 2020 07:43:11 +0000 (UTC)
Received: from localhost (lfbn-tou-1-420-199.w86-206.abo.wanadoo.fr [86.206.245.199])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id BBC7624000A;
        Thu,  1 Oct 2020 07:42:48 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 1/2] PCI: dwc: armada-8k driver needs OF support
Date:   Thu,  1 Oct 2020 09:42:43 +0200
Message-Id: <20201001074244.349443-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes the following build warning when CONFIG_OF is disabled:

drivers/pci/controller/dwc/pcie-armada8k.c:344:34: warning: ‘armada8k_pcie_of_match’ defined but not used [-Wunused-const-variable=]
  344 | static const struct of_device_id armada8k_pcie_of_match[] = {
      |                                  ^~~~~~~~~~~~~~~~~~~~~~

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 044a3761c44f..96994b715f26 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -176,7 +176,7 @@ config PCIE_QCOM
 
 config PCIE_ARMADA_8K
 	bool "Marvell Armada-8K PCIe controller"
-	depends on ARCH_MVEBU || COMPILE_TEST
+	depends on OF && (ARCH_MVEBU || COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
-- 
2.26.2

