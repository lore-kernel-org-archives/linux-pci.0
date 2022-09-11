Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648ABC6FA8A
	for <linux-pci@archiver.kernel.org>; Sun, 11 Sep 2022 11:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiIKLXY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 11 Sep 2022 07:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiIKLXH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 07:23:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54117E01B;
        Sun, 11 Sep 2022 04:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E37B860E9A;
        Sun, 11 Sep 2022 11:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA5DC4347C;
        Sun, 11 Sep 2022 11:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662895314;
        bh=qCITB3pvSrb+ckkDzWx+69C+5fXYFGqHOoPkeSYiQSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wx7TrtNZrD1ZWIkeAwgTzOhqd6u+XVtm1m7WWlIKCV5pdpZX7CeiEb+wwL3POe2zs
         fdSoKNlika2uoFjZg1eV9+THAayroTU5RAl7pR2Sa0NQdIl2fjcWV2esjQdBtwJj3v
         90xmNh5PWIfug2dZ97GvFtft8Y5nmjc2r0qglVSXyRO3ObJNhMB9ZlVQE3tynMf1UD
         2d1FSHvKxi7K1Ql6/ZJxsE5N/N0vMAUoKtZT7vQSLy7Q4dEzL050+xxPRRJz0j5apt
         iukVZFgWwsX/wlaRxJMhZuQXXI6L7K1zWqGTcJ8xKGT44R+qUx9HQi7/9R+L9PpyZl
         rh3UYlt+zABmg==
Received: by pali.im (Postfix)
        id ED4BEABB; Sun, 11 Sep 2022 13:21:51 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH 2/3] PCI: ftpci100: Use PCI_CONF1_ADDRESS() macro
Date:   Sun, 11 Sep 2022 13:20:23 +0200
Message-Id: <20220911112024.14304-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220911112024.14304-1-pali@kernel.org>
References: <20220911112024.14304-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify pci-ftpci100.c driver code and use new PCI_CONF1_ADDRESS() macro
for accessing PCI config space.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-ftpci100.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 88980a44461d..86f6ab165850 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -27,6 +27,7 @@
 #include <linux/bitops.h>
 #include <linux/irq.h>
 #include <linux/clk.h>
+#include <linux/pci-conf1.h>
 
 #include "../pci.h"
 
@@ -103,13 +104,6 @@
 #define FARADAY_PCI_DMA_MEM2_BASE	0x00000000
 #define FARADAY_PCI_DMA_MEM3_BASE	0x00000000
 
-/* Defines for PCI configuration command register */
-#define PCI_CONF_ENABLE		BIT(31)
-#define PCI_CONF_WHERE(r)	((r) & 0xFC)
-#define PCI_CONF_BUS(b)		(((b) & 0xFF) << 16)
-#define PCI_CONF_DEVICE(d)	(((d) & 0x1F) << 11)
-#define PCI_CONF_FUNCTION(f)	(((f) & 0x07) << 8)
-
 /**
  * struct faraday_pci_variant - encodes IP block differences
  * @cascaded_irq: this host has cascaded IRQs from an interrupt controller
@@ -190,11 +184,8 @@ static int faraday_raw_pci_read_config(struct faraday_pci *p, int bus_number,
 				       unsigned int fn, int config, int size,
 				       u32 *value)
 {
-	writel(PCI_CONF_BUS(bus_number) |
-			PCI_CONF_DEVICE(PCI_SLOT(fn)) |
-			PCI_CONF_FUNCTION(PCI_FUNC(fn)) |
-			PCI_CONF_WHERE(config) |
-			PCI_CONF_ENABLE,
+	writel(PCI_CONF1_ADDRESS(bus_number, PCI_SLOT(fn),
+				 PCI_FUNC(fn), config),
 			p->base + FTPCI_CONFIG);
 
 	*value = readl(p->base + FTPCI_DATA);
@@ -225,11 +216,8 @@ static int faraday_raw_pci_write_config(struct faraday_pci *p, int bus_number,
 {
 	int ret = PCIBIOS_SUCCESSFUL;
 
-	writel(PCI_CONF_BUS(bus_number) |
-			PCI_CONF_DEVICE(PCI_SLOT(fn)) |
-			PCI_CONF_FUNCTION(PCI_FUNC(fn)) |
-			PCI_CONF_WHERE(config) |
-			PCI_CONF_ENABLE,
+	writel(PCI_CONF1_ADDRESS(bus_number, PCI_SLOT(fn),
+				 PCI_FUNC(fn), config),
 			p->base + FTPCI_CONFIG);
 
 	switch (size) {
-- 
2.20.1

