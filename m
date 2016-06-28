Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:57129 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbcF1Ggl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2016 02:36:41 -0400
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 16/19] pci: PCI_HOST_GENERIC enable for SH
Date: Tue, 28 Jun 2016 15:36:32 +0900
Message-Id: <1467095795-5082-17-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp>
References: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index df60505..83184eb 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -83,7 +83,7 @@ config PCI_HOST_COMMON
 
 config PCI_HOST_GENERIC
 	bool "Generic PCI host controller"
-	depends on (ARM || ARM64) && OF
+	depends on (ARM || ARM64 || SUPERH) && OF
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want to support a simple generic PCI host
-- 
2.7.0

