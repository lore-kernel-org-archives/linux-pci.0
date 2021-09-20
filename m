Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9C3C433F5
	for <linux-pci@archiver.kernel.org>; Mon, 20 Sep 2021 09:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D65660FED
	for <linux-pci@archiver.kernel.org>; Mon, 20 Sep 2021 09:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhITJ7B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 20 Sep 2021 05:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhITJ7A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Sep 2021 05:59:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CFBC60F6D;
        Mon, 20 Sep 2021 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632131854;
        bh=S1TgMzumtgJoMruZRuNxmPEZg1rvV96gDTGUyuMF9+0=;
        h=From:To:Cc:Subject:Date:From;
        b=kEnf6lYcxfvOC0bnBT4VNdOoN91CeIMWuGmVkrxNlk3e3bISWBUGQYDghYjXuD9gr
         oZ88zgZuqdBWNJDEQmYdhQQPCUBVOFDPt9JMBjz3/BfdIHG22J71JoWO6Txs376ZHo
         EtzXM3YyurTIFzeTUxpIwK6ZEeZB95GS8+ltTcDJRSaPRA8SWNH7m0yxI3x+5JQInI
         X6ybRkLCBAbakqtvOfMFquNpaJabj+RwKBHntlNNXVqKw5s4nLrnK8M8Xp/vZ8svlm
         Bc6XaUTN9u8LeufKmlA5VcBWCjxA8qG2GxQOZ+YEs0xtosRc/eC+ulgCPdt1ptXtyU
         nReFCC3BfA61A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: rcar: add COMMON_CLK dependency
Date:   Mon, 20 Sep 2021 11:57:10 +0200
Message-Id: <20210920095730.1216692-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The __clk_is_enabled() interface is only available when building for
platforms using CONFIG_COMMON_CLK:

arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in function `rcar_pcie_aarch32_abort_handler':
pcie-rcar-host.c:(.text+0x8fc): undefined reference to `__clk_is_enabled'

Add the necessary dependency to the COMPILE_TEST path.

Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 326f7d13024f..53e3648fe872 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -65,7 +65,7 @@ config PCI_RCAR_GEN2
 
 config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe host controller"
-	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on ARCH_RENESAS || (COMMON_CLK && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in host
-- 
2.29.2

