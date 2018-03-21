Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752064AbeCUOnP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Mar 2018 10:43:15 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Fengguang Wu <fengguang.wu@intel.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [PATCH v2 04/10] PCI: kirin: struct kirin_pcie_driver can be static
Date: Wed, 21 Mar 2018 14:42:48 +0000
Message-Id: <20180321144254.7406-5-lorenzo.pieralisi@arm.com>
In-Reply-To: <20180321144254.7406-1-lorenzo.pieralisi@arm.com>
References: <20180321144254.7406-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fengguang Wu <fengguang.wu@intel.com>

This was generated from 0-day builder.

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
[robh: add commit msg]
Signed-off-by: Rob Herring <robh@kernel.org>
[lorenzo.pieralisi@arm.com: reworked the commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/dwc/pcie-kirin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
index dcc8cedf6e17..a6b88c7f6e3e 100644
--- a/drivers/pci/dwc/pcie-kirin.c
+++ b/drivers/pci/dwc/pcie-kirin.c
@@ -504,7 +504,7 @@ static const struct of_device_id kirin_pcie_match[] = {
 	{},
 };
 
-struct platform_driver kirin_pcie_driver = {
+static struct platform_driver kirin_pcie_driver = {
 	.probe			= kirin_pcie_probe,
 	.driver			= {
 		.name			= "kirin-pcie",
-- 
2.15.0
