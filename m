Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392ABC43613
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 13:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF392173C
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 13:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ncentric-com.20150623.gappssmtp.com header.i=@ncentric-com.20150623.gappssmtp.com header.b="jenRUwhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfAGNp5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:45:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36058 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfAGNp5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jan 2019 08:45:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so930850edb.3
        for <linux-pci@vger.kernel.org>; Mon, 07 Jan 2019 05:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b2DAOrsaqCpd7/c8SqsFrjOiq3UmHX0O+L9w4u3BsTM=;
        b=jenRUwhyHvUWELIvIH+8BYorQ0IClHpOHqijBtjNPwjd5zYHPLoxKBuyGMbWIXUuA+
         YDH+9xih6RaHmuPbHGYPQDqXvJLbCyo+Jruc8QGAW11FfjEcwfPeC28bhCgKDuQZtDuD
         lAnQwB1DcB4fs5ts/UB9RXYYQnb3liquKTJj4NTQOXVJChg8T4Cgk5GdUzKxwZmSRz4G
         8UzjOQ4exCXjo/bcCvK4rNAetCfLx/xDE1e5ldO69DqU0iJDCm3oj5LQT0DXkeGRcnvB
         Cc+SVqXwcLgkPq5gJKq2pbF1gcPb5eOwS+TyQScfS12yOuhzgMNSwXRawygQO/Ktq45w
         o4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b2DAOrsaqCpd7/c8SqsFrjOiq3UmHX0O+L9w4u3BsTM=;
        b=fz7CFt2k1pao2z9OvCvSYDx2Tfp+T1amXrTgqEh9+WBl7UT5R9Njs0XKgRMbLamCee
         ZEZmT28kADQtdkeXnShARPp4R4ZJO7CQXSFP2bRN8oQergMfxfHSIEccJeChUhCbBYnK
         JsbPqUV/REQj7MhDixpq3MeldX2psAHpCAwWKeENBCvCIevuyRbBgjZ3yyc/a3k12E0W
         QjC55xQbKhWpp2xTOCgj2a8kfP1GGQTraDrIAvW9Zccoh40KlXVOsAJtdJn0ERK5/K2r
         l1ibzOD8t81NuGMDarQovM4tUAHQ8zW5fshsVj5GrAgBI97kKm3+RstZMJM6GFpo/INy
         TtAQ==
X-Gm-Message-State: AJcUuke8L4L68cxvBybm9YKnYK1fphUswEVGXXUtsn20RkuLnaGozfKQ
        bT/7VKfkklKsZkptYTkvMOAlduhaYpU=
X-Google-Smtp-Source: ALg8bN6G5eKBh+PZUJ6qp7Q7aqCNOoPkrOuvt4eUW7pAr0qgzvCo5/nNidyT0WQ/OjRF1KxI+fq2fg==
X-Received: by 2002:a17:906:938e:: with SMTP id l14-v6mr11121227ejx.246.1546868755214;
        Mon, 07 Jan 2019 05:45:55 -0800 (PST)
Received: from kvdp-BRIX.cmb.citymesh.com ([91.179.126.85])
        by smtp.gmail.com with ESMTPSA id n18-v6sm14017427ejy.17.2019.01.07.05.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 05:45:54 -0800 (PST)
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-pci@vger.kernel.org,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Olof Johansson <olof@lixom.net>,
        Robin Leblon <robin.leblon@ncentric.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tim Harvey <tharvey@gateworks.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/2] arm: cns3xxx: use actual size reads for PCIe
Date:   Mon,  7 Jan 2019 14:45:10 +0100
Message-Id: <20190107134510.32494-2-koen.vandeputte@ncentric.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
References: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
reimplemented cns3xxx_pci_read_config() using pci_generic_config_read32(),
which preserved the property of only doing 32-bit reads.

It also replaced cns3xxx_pci_write_config() with pci_generic_config_write(),
so it changed writes from always being 32 bits to being the actual size,
which works just fine.

Due to:
- The documentation does not mention that only 32 bit access is allowed.
- Writes are already executed using the actual size
- Extensive testing shows that 8b, 16b and 32b reads work as intended

It makes perfectly sense to also swap 32 bit reading in favor of actual size.

Fixes: 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Krzysztof Halasa <khalasa@piap.pl>
CC: Olof Johansson <olof@lixom.net>
CC: Robin Leblon <robin.leblon@ncentric.com>
CC: Rob Herring <robh@kernel.org>
CC: Russell King <linux@armlinux.org.uk>
CC: Tim Harvey <tharvey@gateworks.com>
CC: stable@vger.kernel.org # v4.0+
---
 arch/arm/mach-cns3xxx/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 5e11ad3164e0..95a11d5b3587 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -93,7 +93,7 @@ static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	u32 mask = (0x1ull << (size * 8)) - 1;
 	int shift = (where % 4) * 8;
 
-	ret = pci_generic_config_read32(bus, devfn, where, size, val);
+	ret = pci_generic_config_read(bus, devfn, where, size, val);
 
 	if (ret == PCIBIOS_SUCCESSFUL && !bus->number && !devfn &&
 	    (where & 0xffc) == PCI_CLASS_REVISION)
-- 
2.17.1

