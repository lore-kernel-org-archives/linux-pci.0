Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33276 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163289AbeCBBMh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2018 20:12:37 -0500
Received: by mail-pl0-f66.google.com with SMTP id c11-v6so4720888plo.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Mar 2018 17:12:37 -0800 (PST)
From: Shawn Guo <shawn.guo@linaro.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 1/2] PCI: histb: Fix error path of histb_pcie_host_enable()
Date: Fri,  2 Mar 2018 09:12:00 +0800
Message-Id: <1519953121-28218-2-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1519953121-28218-1-git-send-email-shawn.guo@linaro.org>
References: <1519953121-28218-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If clk_prepare_enable() call fails on a particular clock, we should not
call clk_disable_unprepare() on this clock, but on the clocks that
succeed from clk_prepare_enable() previously.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pci/dwc/pcie-histb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/dwc/pcie-histb.c b/drivers/pci/dwc/pcie-histb.c
index 70b5c0b108bf..17ed604f5741 100644
--- a/drivers/pci/dwc/pcie-histb.c
+++ b/drivers/pci/dwc/pcie-histb.c
@@ -276,13 +276,12 @@ static int histb_pcie_host_enable(struct pcie_port *pp)
 	return 0;
 
 err_aux_clk:
-	clk_disable_unprepare(hipcie->aux_clk);
-err_pipe_clk:
 	clk_disable_unprepare(hipcie->pipe_clk);
-err_sys_clk:
+err_pipe_clk:
 	clk_disable_unprepare(hipcie->sys_clk);
-err_bus_clk:
+err_sys_clk:
 	clk_disable_unprepare(hipcie->bus_clk);
+err_bus_clk:
 
 	return ret;
 }
-- 
1.9.1
