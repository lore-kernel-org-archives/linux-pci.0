Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33307 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935721AbdEXM2J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2017 08:28:09 -0400
Received: by mail-wr0-f194.google.com with SMTP id w50so9610129wrc.0
        for <linux-pci@vger.kernel.org>; Wed, 24 May 2017 05:28:08 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pci@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] pci: host: FTPCI100: Add dependency on ARCH_GEMINI
Date: Wed, 24 May 2017 13:28:02 +0100
Message-Id: <20170524122802.29493-1-pbrobinson@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add dependency on ARCH_GEMINI and compile test

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 7f47cd5e10a5..7810acbf9ad2 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -30,7 +30,7 @@ config PCIE_XILINX_NWL
 config PCI_FTPCI100
 	bool "Faraday Technology FTPCI100 PCI controller"
 	depends on OF
-	depends on ARM
+	depends on ARM && (ARCH_GEMINI || COMPILE_TEST)
 	default ARCH_GEMINI
 
 config PCI_TEGRA
-- 
2.13.0
