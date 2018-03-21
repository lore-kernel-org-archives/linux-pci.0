Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54296 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752064AbeCUOnR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Mar 2018 10:43:17 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Fengguang Wu <fengguang.wu@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v2 05/10] PCI: faraday: struct faraday_pci_variant can be static
Date: Wed, 21 Mar 2018 14:42:49 +0000
Message-Id: <20180321144254.7406-6-lorenzo.pieralisi@arm.com>
In-Reply-To: <20180321144254.7406-1-lorenzo.pieralisi@arm.com>
References: <20180321144254.7406-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fengguang Wu <fengguang.wu@intel.com>

This was generated from 0-day builder.

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
[lorenzo.pieralisi@arm.com: reworked/split patch]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/host/pci-ftpci100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index b9617d1c1d48..5008fd87956a 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -586,11 +586,11 @@ static int faraday_pci_probe(struct platform_device *pdev)
  * We encode bridge variants here, we have at least two so it doesn't
  * hurt to have infrastructure to encompass future variants as well.
  */
-const struct faraday_pci_variant faraday_regular = {
+static const struct faraday_pci_variant faraday_regular = {
 	.cascaded_irq = true,
 };
 
-const struct faraday_pci_variant faraday_dual = {
+static const struct faraday_pci_variant faraday_dual = {
 	.cascaded_irq = false,
 };
 
-- 
2.15.0
