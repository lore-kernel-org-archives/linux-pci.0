Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50502 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbbASKRh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jan 2015 05:17:37 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] MAINTAINERS: fix Richard Zhu's mail address
Date: Mon, 19 Jan 2015 11:17:31 +0100
Message-Id: <1421662651-22962-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The old cryptic address bounces, fix it by using a properly
working one.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fa385321245..b0a01320c755 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7239,7 +7239,7 @@ S:	Maintained
 F:	drivers/pci/host/*layerscape*
 
 PCI DRIVER FOR IMX6
-M:	Richard Zhu <r65037@freescale.com>
+M:	Richard Zhu <Richard.Zhu@freescale.com>
 M:	Lucas Stach <l.stach@pengutronix.de>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.1.4

