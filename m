Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37035 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeISLO5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2018 07:14:57 -0400
From: Nathan Chancellor <natechancellor@gmail.com>
To: Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] PCI: kirin: Fix section mismatch warning
Date: Tue, 18 Sep 2018 22:38:29 -0700
Message-Id: <20180919053829.4858-1-natechancellor@gmail.com>
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
the function kirin_pcie_probe() to the function
.init.text:kirin_add_pcie_port()
The function kirin_pcie_probe() references
the function __init kirin_add_pcie_port().
This is often because kirin_pcie_probe lacks a __init
annotation or the annotation of kirin_add_pcie_port is wrong.

Remove '__init' from kirin_add_pcie_port so there is no mismatch.

Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 5352e0c3be82..9b599296205d 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -467,8 +467,8 @@ static int kirin_pcie_add_msi(struct dw_pcie *pci,
 	return 0;
 }
 
-static int __init kirin_add_pcie_port(struct dw_pcie *pci,
-				      struct platform_device *pdev)
+static int kirin_add_pcie_port(struct dw_pcie *pci,
+			       struct platform_device *pdev)
 {
 	int ret;
 
-- 
2.19.0
