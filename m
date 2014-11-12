Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:60119 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202AbaKLD2T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 22:28:19 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEW002WLPN64200@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 12 Nov 2014 12:28:18 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>,
	'Mohit Kumar' <mohit.kumar@st.com>,
	'Viresh Kumar' <viresh.kumar@linaro.org>,
	'Pratyush Anand' <pratyush.anand@st.com>
Subject: [PATCH] PCI: spear: Remove unnecessary OOM message
Date: Wed, 12 Nov 2014 12:29:02 +0900
Message-id: <002d01cffe28$ce2f5870$6a8e0950$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message. This patch
fixes the following checkpatch warning.

  WARNING: Possible unnecessary 'out of memory' message

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pcie-spear13xx.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 85f594e..4647b62 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -308,10 +308,8 @@ static int __init spear13xx_pcie_probe(struct platform_device *pdev)
 	int ret;
 
 	spear13xx_pcie = devm_kzalloc(dev, sizeof(*spear13xx_pcie), GFP_KERNEL);
-	if (!spear13xx_pcie) {
-		dev_err(dev, "no memory for SPEAr13xx pcie\n");
+	if (!spear13xx_pcie)
 		return -ENOMEM;
-	}
 
 	spear13xx_pcie->phy = devm_phy_get(dev, "pcie-phy");
 	if (IS_ERR(spear13xx_pcie->phy)) {
-- 
1.7.9.5


