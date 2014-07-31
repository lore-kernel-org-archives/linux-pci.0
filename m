Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49816 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaGaSQZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jul 2014 14:16:25 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-pci@vger.kernel.org
Cc: Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <Shawn.Guo@freescale.com>, kernel@pengutronix.de
Subject: [PATCH 1/2] MAINTAINERS: add myself as co-maintainer for i.MX6 PCI driver
Date: Thu, 31 Jul 2014 20:16:04 +0200
Message-Id: <1406830565-23450-2-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1406830565-23450-1-git-send-email-l.stach@pengutronix.de>
References: <1406830565-23450-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Also drop Shawn Guo per his request.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Shawn Guo <shawn.guo@freescale.com>
Acked-by: Richard Zhu <r65037@freescale.com>
Acked-by: Jingoo Han <jg1.han@samsung.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f35d07d284b6..cd4224d0a029 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6774,7 +6774,7 @@ F:	arch/x86/kernel/quirks.c
 
 PCI DRIVER FOR IMX6
 M:	Richard Zhu <r65037@freescale.com>
-M:	Shawn Guo <shawn.guo@freescale.com>
+M:	Lucas Stach <l.stach@pengutronix.de>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.0.1

