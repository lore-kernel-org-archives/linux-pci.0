Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B91C43612
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 13:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B2C2173C
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 13:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ncentric-com.20150623.gappssmtp.com header.i=@ncentric-com.20150623.gappssmtp.com header.b="X3zuFDeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfAGNp4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:45:56 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40067 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfAGNp4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jan 2019 08:45:56 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so911291edr.7
        for <linux-pci@vger.kernel.org>; Mon, 07 Jan 2019 05:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=H/7doH88Idi5Mj1ZDeX/jUMyy4ALq/yqhRpTL/yV0ko=;
        b=X3zuFDeWy+8epsUMtjXM9hyLwipEBvOZq9Yv7HdvSQ8JaFkuqWw0XtMMk/sqscOvc8
         fUdl8WnNSeC74T+J1wGDth2G7WEBglanCYsJCly2uKJyctNTuJQpyQwS2XituqayDEX8
         XFfQJv+HqdUBXfI4wO7YZjaAwYjlh+owvmMa/nRgD+0L754LBIg+2AzjY4UfB+JJg06k
         QvvgZ42stTXp3hl7t0OWUfYUWDDYxHmzn8dyyva5wl1SOG2bhLaEwU1QHDiEJ8dBc05m
         LpgvFk+SH+20RpSoWtjz4iYPnOV7/b3BqcCVghJKrtPM4hme+KHrF1OP+dRVyoCn36ef
         jv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H/7doH88Idi5Mj1ZDeX/jUMyy4ALq/yqhRpTL/yV0ko=;
        b=XZjst6h11I+eILx6UmNOEycZpg4GKrtRAwe6ME50XZS5mNPcDfMVifVA0GdomjVoQ2
         6sftZwbPbPEq0eWoZKRQ1O7OS3JdVMzC+K2XAg9kMeGzuVIMGYtfYDINS+V6oCBTk1UJ
         +TIOhn9pCCq6FAkmM/UgyF/LpjFg8Y4xaE/2CFTaEy2LIyDNdmLMc7vHKvoR3+nPWIYB
         tPYdj6jM/IDsIv2zPFLLM2fFiEV88126dwbkCYZGRs9p+r3xm+c5rsSoGPvZEGAMDGga
         q5PmWmJWJnU/8EvU1qYeyXMGb6QIBRW5VMnGqGPD0CNpPu+LpyStyHHOkdtD+Nx2+EIW
         eELQ==
X-Gm-Message-State: AA+aEWb9CZ8BlwjczbtNPxcZvmKfq2BTKLwREM2ewWjuhDQVP1d/FELX
        k5iAubeZ6gmQHwTjac4Qnzf7aw==
X-Google-Smtp-Source: AFSGD/W6sdmsvnX/mA+E2rLxIhpNqS/0Tjf68WiZjIhzptzxG32xwbWNXXyNmcZu6bR4as/hM2KB4A==
X-Received: by 2002:aa7:dc51:: with SMTP id g17mr54978919edu.115.1546868754215;
        Mon, 07 Jan 2019 05:45:54 -0800 (PST)
Received: from kvdp-BRIX.cmb.citymesh.com ([91.179.126.85])
        by smtp.gmail.com with ESMTPSA id n18-v6sm14017427ejy.17.2019.01.07.05.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 05:45:53 -0800 (PST)
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-pci@vger.kernel.org,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>,
        Robin Leblon <robin.leblon@ncentric.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] arm: cns3xxx: fix writing to wrong PCI registers after alignment
Date:   Mon,  7 Jan 2019 14:45:09 +0100
Message-Id: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Originally, cns3xxx used it's own functions for mapping, reading and writing registers.

Commit 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
removed the internal PCI config write function in favor of the generic one:

cns3xxx_pci_write_config() --> pci_generic_config_write()

cns3xxx_pci_write_config() expected aligned addresses, being produced by cns3xxx_pci_map_bus()
while the generic one pci_generic_config_write() actually expects the real address
as both the function and hardware are capable of byte-aligned writes.

This currently leads to pci_generic_config_write() writing
to the wrong registers on some ocasions.

First issue seen due to this:

- driver ath9k gets loaded
- The driver wants to write value 0xA8 to register PCI_LATENCY_TIMER, located at 0x0D
- cns3xxx_pci_map_bus() aligns the address to 0x0C
- pci_generic_config_write() effectively writes 0xA8 into register 0x0C (CACHE_LINE_SIZE)

This seems to cause some slight instability when certain PCI devices are used.

Another issue example caused by this this is the PCI bus numbering,
where the primary bus is higher than the secondary, which is impossible.

Before:

00:00.0 PCI bridge: Cavium, Inc. Device 3400 (rev 01) (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0, IRQ 255
    Bus: primary=02, secondary=01, subordinate=ff, sec-latency=0

After fix:

00:00.0 PCI bridge: Cavium, Inc. Device 3400 (rev 01) (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0, IRQ 255
    Bus: primary=00, secondary=01, subordinate=02, sec-latency=0

And very likely some more ..

Fix all by omitting the alignment being done in the mapping function.

Fixes: 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
Acked-by: Krzysztof Halasa <khalasa@piap.pl>
Acked-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Olof Johansson <olof@lixom.net>
CC: Robin Leblon <robin.leblon@ncentric.com>
CC: Rob Herring <robh@kernel.org>
CC: Russell King <linux@armlinux.org.uk>
CC: stable@vger.kernel.org # v4.0+
---
 arch/arm/mach-cns3xxx/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


V2:
--> resend to be in sync with new second patch
--> added acked-by's based on patch comments

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 318394ed5c7a..5e11ad3164e0 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -83,7 +83,7 @@ static void __iomem *cns3xxx_pci_map_bus(struct pci_bus *bus,
 	} else /* remote PCI bus */
 		base = cnspci->cfg1_regs + ((busno & 0xf) << 20);
 
-	return base + (where & 0xffc) + (devfn << 12);
+	return base + where + (devfn << 12);
 }
 
 static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
-- 
2.17.1

