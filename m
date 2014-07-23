Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44233 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbaGWRkg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jul 2014 13:40:36 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Shawn Guo <shawn.guo@freescale.com>, kernel@pengutronix.de
Subject: [PATCH 1/3] MAINTAINERS: add myself as co-maintainer for i.MX6 PCI driver
Date: Wed, 23 Jul 2014 19:40:15 +0200
Message-Id: <1406137217-11294-2-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1406137217-11294-1-git-send-email-l.stach@pengutronix.de>
References: <1406137217-11294-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
I've talked privately to Richard about this and he's
in favor, but still should give an public ACK.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 134483f206e4..54c23c4fcbb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6775,6 +6775,7 @@ F:	arch/x86/kernel/quirks.c
 PCI DRIVER FOR IMX6
 M:	Richard Zhu <r65037@freescale.com>
 M:	Shawn Guo <shawn.guo@linaro.org>
+M:	Lucas Stach <l.stach@pengutronix.de>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.0.1

