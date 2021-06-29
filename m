Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDED0C11F66
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jun 2021 13:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA91461DC2
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jun 2021 13:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhF2NXR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jun 2021 09:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhF2NXR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 09:23:17 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3B3C061766
        for <linux-pci@vger.kernel.org>; Tue, 29 Jun 2021 06:20:49 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:7d95:f75f:5ece:4663])
        by baptiste.telenet-ops.be with bizsmtp
        id P1Ln2500K4F6zkK011LnBE; Tue, 29 Jun 2021 15:20:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lyDfS-004tf1-Qy; Tue, 29 Jun 2021 15:20:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lyDfS-009rsQ-94; Tue, 29 Jun 2021 15:20:46 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PCI: PCI_IXP4XX should depend on ARCH_IXP4XX
Date:   Tue, 29 Jun 2021 15:20:45 +0200
Message-Id: <6a88e55fe58fc280f4ff1ca83c154e4895b6dcbf.1624972789.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Intel IXP4xx PCI controller is only present on Intel IXP4xx
XScale-based network processor SoCs.  Hence add a dependency on
ARCH_IXP4XX, to prevent asking the user about this driver when
configuring a kernel without support for the XScale processor family.

Fixes: f7821b4934584824 ("PCI: ixp4xx: Add a new driver for IXP4xx")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pci/controller/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 5e1e3796efa4e327..326f7d13024f9037 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -40,6 +40,7 @@ config PCI_FTPCI100
 config PCI_IXP4XX
 	bool "Intel IXP4xx PCI controller"
 	depends on ARM && OF
+	depends on ARCH_IXP4XX || COMPILE_TEST
 	default ARCH_IXP4XX
 	help
 	  Say Y here if you want support for the PCI host controller found
-- 
2.25.1

