Return-Path: <SRS0=1awV=MZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA44C6787C
	for <linux-pci@archiver.kernel.org>; Sat, 13 Oct 2018 00:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F298E21480
	for <linux-pci@archiver.kernel.org>; Sat, 13 Oct 2018 00:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmYc7Wya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F298E21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeJMI0X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Oct 2018 04:26:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40254 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeJMI0X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Oct 2018 04:26:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id s5-v6so6976031pfj.7;
        Fri, 12 Oct 2018 17:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+rQhsJQbQUL7ExRr7DE8fPI8d4Z8EwKvAeWUvzAs9A4=;
        b=TmYc7WyamW4GgykUyyigNA1WeUGtu+jzSL+hGSJop2DdvkXOjBq0JNnk4GvnpphnD7
         bu7DwavRqeXh1tEb7Pij4fH88dlZdVgI3IW8rz4YrDJ9+5w4OFhf1gxhtP7tuxI0mfM7
         umqwc4XASe3+hjmf7yxkWBIfZ/0VRCXpLeUCGBQdxhDjEgDbzvfefNraFCndJQGJvSoN
         E83H0sjCQUqkEa2tDWiK+6j1UOEpiyAtZmXMTC0tinRin1uDLoUefcF+uvQU5nlfk3w2
         JzpefTyJN276KwMlaZ+7BjZQ2g2+wwB1GHcNjB3RL0fOreJhh21dcx/AelYZzDAGHkEt
         cZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+rQhsJQbQUL7ExRr7DE8fPI8d4Z8EwKvAeWUvzAs9A4=;
        b=dtbRuo2Ufm7b9vZ9YQKKy2hyrrvtjom/87RbH1pIPzTl9wLAKZ7Cb14YxZkSlDwhol
         VCOsL8sXtJRosHd1VTPI4PYmoSdxzAxQstNjGpxvFGlORszGhzOVZgvqR1T5Q9gQsV3A
         mzlAgakFuwMjTr/8ZjweMrfhXAGNC3PjHVqxixvLlkJM1Kf5fqZj2aeNvERkKCnbRRAV
         zbHsvgkenySnyetwsngVKiy07I48j/HEnhz5mlQVFZx5b7nEXla/VO0GBZa5Zc40pg7f
         8tFMuJ6e5/GCdXkMb3cMzVowhJkcaoAgs/KBMnZ3xTUT/HrgKE8u8La46MWyed0aETjF
         cTxw==
X-Gm-Message-State: ABuFfohvDG89YMmrWxaSsyr3PyppFDnt/DrZ2OhMKXi8xtlSKzGqQHDs
        08VDqO2CByaPuBGHgHuzWYsdoeBG2Uqo3g==
X-Google-Smtp-Source: ACcGV60qsofhhKlSDV0yARQTfrTssB9XLdKd6V3ZgcPMwJiLAIb2FEtwjhrC373S3YjZS+SLtUhY6g==
X-Received: by 2002:a62:4bd2:: with SMTP id d79-v6mr8246315pfj.38.1539391883114;
        Fri, 12 Oct 2018 17:51:23 -0700 (PDT)
Received: from localhost.localdomain ([218.108.98.82])
        by smtp.gmail.com with ESMTPSA id b62-v6sm6773107pfa.159.2018.10.12.17.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 17:51:22 -0700 (PDT)
From:   changbin.du@gmail.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Du Changbin <changbin.du@gmail.com>
Subject: [PATCH] PCI: make pci_size() return real size
Date:   Sat, 13 Oct 2018 08:49:19 +0800
Message-Id: <20181013004919.3202-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Du Changbin <changbin.du@gmail.com>

Currently, the pci_size() function actually return 'size-1'.
Make it return real size to avoid confusing.

Signed-off-by: Du Changbin <changbin.du@gmail.com>
---
 drivers/pci/probe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 201f9e5ff55c..8ff2b1413865 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -121,13 +121,13 @@ static u64 pci_size(u64 base, u64 maxbase, u64 mask)
 	 * Get the lowest of them to find the decode size, and from that
 	 * the extent.
 	 */
-	size = (size & ~(size-1)) - 1;
+	size = size & ~(size-1);
 
 	/*
 	 * base == maxbase can be valid only if the BAR has already been
 	 * programmed with all 1s.
 	 */
-	if (base == maxbase && ((base | size) & mask) != mask)
+	if (base == maxbase && ((base | (size - 1)) & mask) != mask)
 		return 0;
 
 	return size;
@@ -278,7 +278,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			/* Above 32-bit boundary; try to reallocate */
 			res->flags |= IORESOURCE_UNSET;
 			res->start = 0;
-			res->end = sz64;
+			res->end = sz64 - 1;
 			pci_info(dev, "reg 0x%x: can't handle BAR above 4GB (bus address %#010llx)\n",
 				 pos, (unsigned long long)l64);
 			goto out;
@@ -286,7 +286,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	}
 
 	region.start = l64;
-	region.end = l64 + sz64;
+	region.end = l64 + sz64 - 1;
 
 	pcibios_bus_to_resource(dev->bus, res, &region);
 	pcibios_resource_to_bus(dev->bus, &inverted_region, res);
-- 
2.17.1

