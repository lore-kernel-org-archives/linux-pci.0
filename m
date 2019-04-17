Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0A5C282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 14:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C012177B
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 14:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="fnSP/znF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732288AbfDQOTE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:19:04 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:57646 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731745AbfDQOTE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Apr 2019 10:19:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 95AD8BF5
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2019 14:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tioPUOB5tiWa for <linux-pci@vger.kernel.org>;
        Wed, 17 Apr 2019 09:19:02 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 5F31593D
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2019 09:19:02 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id i188so2657419iti.4
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2019 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uojC63LlRZMao2Xj4ZjGaAJ2xtzmNGWu+Lgx37e3mxc=;
        b=fnSP/znF9HoI91HHaFKybcEPhsXHBY1++8r6g6Hv1Ul7W/0bqN3+aJfRkmri/3PYfx
         HN56IjoL+zIa7IOyXmh2wZLkI4b49CaBwgNF+8Xhimo32S3D3/9BYK+2GKJh4lAZ6P5A
         +zjJu2I0rutSN5Kr/YVW4NG4Z8wkjcFTZ8FxfpwshRusI0411TFSMM2V+x9igc0DKbjn
         5yXYxkhKsWU48xNF9vGy+eedNIrHzdtNFv7keE4MYzhJ0nzCKB+xzPOoSr1nxMQY3C29
         ofSdxgvXzwebXSYIYNJ+9YV6tVp2+JqBkWnOB2o9zRjVuSfpcXdSdp5NoZE1ArU/oKAL
         uJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uojC63LlRZMao2Xj4ZjGaAJ2xtzmNGWu+Lgx37e3mxc=;
        b=PmHB3D9A6+HkUypXxsrwNpFCnUml+f3yBfCdZjOe8TtmoJGqgtBSZxqtQ9TKQalSne
         v+QTq2jKmd4LWBQA8eFHnKW+gnyScAMgk9gKJZWzc3qbzAcIjDASp8ffR2EqWLQ4Q7GT
         ntbyfOsaHJJ1bMsCapBRGsQTfrYAJ+68WIvKKviYriHiZRuU/ULGiNBi2IGBOIDAhaJK
         hQBGRhba+/vYVy1bBdgLcK8MtqClr5y8l2ej1OSv/xv8HkwkqTnmMp5iLcTkOdvRQMD4
         Brd1ryHH1MzpuzIYEhlzOVVcY2rUmyUURTKIHAORfpNpuk/36HgSAAH4d43el/FfCJvy
         Sguw==
X-Gm-Message-State: APjAAAXqLylbxDrvmrM6/i1GsNofrbybvYBwpz3K5ckYTsXKRlIdDBnH
        hxK7Xc2Xv5iHm7mJtKXnCa0lVN7KXDuUtTqVOmwM//U63cslWcQe7EvgKgOzyiM35dGhKTTwIg0
        /Hjjix9Yur7PaI1LgnTz2EHO/
X-Received: by 2002:a5d:8d88:: with SMTP id b8mr47103247ioj.58.1555510742094;
        Wed, 17 Apr 2019 07:19:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqybQYs6+blBBfUmDGt2jd85HaE+WxEAm3OWFoBDjr4F3rKrnG4xxjhtiFsnt75OJKqYWuLrFA==
X-Received: by 2002:a5d:8d88:: with SMTP id b8mr47103238ioj.58.1555510741947;
        Wed, 17 Apr 2019 07:19:01 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id g126sm1317062itg.36.2019.04.17.07.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 07:19:01 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v4] x86/PCI: fix a memory leak bug
Date:   Wed, 17 Apr 2019 09:18:50 -0500
Message-Id: <1555510730-9060-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In pcibios_irq_init(), the PCI IRQ routing table 'pirq_table' is firstly
found through pirq_find_routing_table(). If the table is not found and
'CONFIG_PCI_BIOS' is defined, the table is then allocated in
pcibios_get_irq_routing_table() using kmalloc(). In the following
execution, if the I/O APIC is used, this table is actually not used.
However, in that case, the allocated table is not freed, which is a memory
leak bug.

To fix this issue, free the allocated table if it is not used.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/pci/irq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 52e5510..d3a73f9 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1119,6 +1119,8 @@ static const struct dmi_system_id pciirq_dmi_table[] __initconst = {
 
 void __init pcibios_irq_init(void)
 {
+	struct irq_routing_table *rtable = NULL;
+
 	DBG(KERN_DEBUG "PCI: IRQ init\n");
 
 	if (raw_pci_ops == NULL)
@@ -1129,8 +1131,10 @@ void __init pcibios_irq_init(void)
 	pirq_table = pirq_find_routing_table();
 
 #ifdef CONFIG_PCI_BIOS
-	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN))
+	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN)) {
 		pirq_table = pcibios_get_irq_routing_table();
+		rtable = pirq_table;
+	}
 #endif
 	if (pirq_table) {
 		pirq_peer_trick();
@@ -1145,8 +1149,10 @@ void __init pcibios_irq_init(void)
 		 * If we're using the I/O APIC, avoid using the PCI IRQ
 		 * routing table
 		 */
-		if (io_apic_assign_pci_irqs)
+		if (io_apic_assign_pci_irqs) {
+			kfree(rtable);
 			pirq_table = NULL;
+		}
 	}
 
 	x86_init.pci.fixup_irqs();
-- 
2.7.4

