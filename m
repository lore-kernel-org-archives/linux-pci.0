Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:35468 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753284AbdF2PfJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2017 11:35:09 -0400
Received: by mail-io0-f177.google.com with SMTP id h134so9175796iof.2
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2017 08:35:08 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] PCI: dwc: qcom: limit TPL size to 2K to fix hw issue
Date: Thu, 29 Jun 2017 17:34:55 +0200
Message-Id: <20170629153455.11995-1-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch limits TPL size to 2K from default 4K size as a workaround
for a HW bug in v0 version of pcie IP. When using default TPL size of 4K
the internal buffer gets corrupted due to this HW bug.

This bug was originally noticed during ssh session between APQ8064
based board and PC. Network packets got corrupted randomly and
terminated the ssh session due to this bug.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/pci/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 5bf23d432fdb..28ba5192a21d 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -51,6 +51,12 @@
 #define PCIE20_ELBI_SYS_CTRL			0x04
 #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
 
+#define PCIE20_AXI_MSTR_RESP_COMP_CTRL0		0x818
+#define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
+#define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_4K	0x5
+#define PCIE20_AXI_MSTR_RESP_COMP_CTRL1		0x81c
+#define CFG_BRIDGE_SB_INIT			BIT(0)
+
 #define PCIE20_CAP				0x70
 
 #define PERST_DELAY_US				1000
@@ -357,6 +363,13 @@ static int qcom_pcie_init_v0(struct qcom_pcie *pcie)
 	/* wait for clock acquisition */
 	usleep_range(1000, 1500);
 
+
+	/* Set the Max TLP size to 2K, instead of using default of 4K */
+	writel(CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K,
+	       pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL0);
+	writel(CFG_BRIDGE_SB_INIT,
+	       pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL1);
+
 	return 0;
 
 err_deassert_ahb:
-- 
2.11.0
