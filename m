Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:42816
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755685AbcJZQ7E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 12:59:04 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <bhelgaas@google.com>
CC: <l.stach@pengutronix.de>, <hongxing.zhu@nxp.com>,
        <linux-pci@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 2/3] MAINTAINERS: PCI: imx6: Use Richard Zhu's NXP email
Date: Wed, 26 Oct 2016 14:27:23 -0200
Message-ID: <1477499244-10640-2-git-send-email-fabio.estevam@nxp.com>
In-Reply-To: <1477499244-10640-1-git-send-email-fabio.estevam@nxp.com>
References: <1477499244-10640-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

FSL emails may become invalid soon, so switch to the NXP one.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8544cd6..cf828f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9257,7 +9257,7 @@ S:	Maintained
 F:	drivers/pci/host/*layerscape*
 
 PCI DRIVER FOR IMX6
-M:	Richard Zhu <Richard.Zhu@freescale.com>
+M:	Richard Zhu <hongxing.zhu@nxp.com>
 M:	Lucas Stach <l.stach@pengutronix.de>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.7.4

