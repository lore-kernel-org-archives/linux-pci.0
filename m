Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43256 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeAWPqB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jan 2018 10:46:01 -0500
Received: by mail-pf0-f195.google.com with SMTP id y26so605726pfi.10
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2018 07:46:01 -0800 (PST)
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        project-aspen-dev@linaro.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 1/2] PCI: histb: fix error path of histb_pcie_host_enable()
Date: Tue, 23 Jan 2018 23:45:36 +0800
Message-Id: <1516722337-1533-2-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1516722337-1533-1-git-send-email-shawn.guo@linaro.org>
References: <1516722337-1533-1-git-send-email-shawn.guo@linaro.org>
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
index 33b01b734d7d..6395394be5b4 100644
--- a/drivers/pci/dwc/pcie-histb.c
+++ b/drivers/pci/dwc/pcie-histb.c
@@ -279,13 +279,12 @@ static int histb_pcie_host_enable(struct pcie_port *pp)
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
