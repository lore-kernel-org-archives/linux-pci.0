Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0084.outbound.protection.outlook.com ([104.47.40.84]:43434
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932290AbcJZQnf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 12:43:35 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <bhelgaas@google.com>
CC: <l.stach@pengutronix.de>, <hongxing.zhu@nxp.com>,
        <linux-pci@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 3/3] MAINTAINERS: PCI: imx6: Add devicetree binding file
Date: Wed, 26 Oct 2016 14:27:24 -0200
Message-ID: <1477499244-10640-3-git-send-email-fabio.estevam@nxp.com>
In-Reply-To: <1477499244-10640-1-git-send-email-fabio.estevam@nxp.com>
References: <1477499244-10640-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add an entry for the devicetree binding file, so that when
people run ./scripts/get_maintainer.pl the PCI imx6 maintainers could
also be listed.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf828f4..d61aead 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9262,6 +9262,7 @@ M:	Lucas Stach <l.stach@pengutronix.de>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
 F:	drivers/pci/host/*imx6*
 
 PCI DRIVER FOR TI KEYSTONE
-- 
2.7.4

