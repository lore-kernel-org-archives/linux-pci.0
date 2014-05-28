Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:41701 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbaE1JvH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 May 2014 05:51:07 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so10743188pad.32
        for <linux-pci@vger.kernel.org>; Wed, 28 May 2014 02:51:07 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-pci@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, jg1.han@samsung.com,
	bhelgaas@google.com, sachin.kamat@linaro.org
Subject: [PATCH 1/1] PCI: exynos: Fix section mismatch warning
Date: Wed, 28 May 2014 15:18:45 +0530
Message-Id: <1401270525-27139-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

add_pcie_port is called from probe which is annotated with __init.
add_pcie_port calls dw_pcie_host_init which is also annotated with
__init. Thus it makes sense to annotate add_pcie_port with __init
to avoid the following section mismatch warning:

WARNING: drivers/pci/built-in.o(.text.unlikely+0xf8): Section mismatch in reference from the function add_pcie_port() to the function .init.text:dw_pcie_host_init()
   The function add_pcie_port() references
   the function __init dw_pcie_host_init().
   This is often because add_pcie_port lacks a __init
   annotation or the annotation of dw_pcie_host_init is wrong.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/pci/host/pci-exynos.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 3de6bfbbe8e9..3c1ff89829ec 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -511,7 +511,8 @@ static struct pcie_host_ops exynos_pcie_host_ops = {
 	.host_init = exynos_pcie_host_init,
 };
 
-static int add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
+static int __init add_pcie_port(struct pcie_port *pp,
+				struct platform_device *pdev)
 {
 	int ret;
 
-- 
1.7.9.5

