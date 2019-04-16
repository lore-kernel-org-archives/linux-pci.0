Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F9DC10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 14:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17765223B5
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 14:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="pH4l246J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfDPOCB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:02:01 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:52500 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfDPOCB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 10:02:01 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id BC126AEE
        for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2019 14:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FK7Hj8DASzmK for <linux-pci@vger.kernel.org>;
        Tue, 16 Apr 2019 09:01:59 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 83C6D86
        for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2019 09:01:59 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id w11so16759147iom.20
        for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2019 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iwjMijP3+qu6tm9Ocaym7EnWSSoP8/7s8H9M+zp/o04=;
        b=pH4l246JQa7gqqHTnkvh/2qqqxnoKjbpdrSf7IcXCYV5RfBTK2/o/oB32m/e7Mhamb
         RKzevpkRs+mKB11gq4VNFtfQNiteam507U6Q3vYPveE0301V5O4w79/fAWaXtEODsMcO
         5G3s1FFyhWFoB9jz5w0iRBuGdL0JRT1kWxT4J8Tou53UmCR48Yj3bIjepRbmd6BuH0J6
         QChDp0cYmzKyXeBOXk2magzcfnXeJIssCtUVgcMouF3iNUQgfqgTOM/bdg+uVqrkpUAy
         dM3avtUc2iOWAhO2gm7nvmvmak+LG7gKt20kGd5qjxDynZsDorvoXg57dFzSNh8A4o2T
         nyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iwjMijP3+qu6tm9Ocaym7EnWSSoP8/7s8H9M+zp/o04=;
        b=uiJ4aNGouUup5QrNb1WFSNnq85yWRZS8vNFDV/OhrXUflNoIgn9AtrLTzmOz6V94gC
         76Kl0tILafZUl8XIV2d0ns0PkNZhvAgufzAsmff8+kEqYYyza7TG132Oa2J+DrYMsMss
         02hSR1+oWvf0a0maR+o3hMpZYp/qubMtzMpI2tBNogtRbHoNU8M+M/Jvgnood6Aq9gAD
         tWBJhYvVfYDDuUoIHVfKoCdyTjubelJElPOl1wsyenK2VlOVG2bfEPt0hiIG5N5JsMJe
         0+66i73avV4iOnzDvIMLlNpiXMQYVJ+aefXzEoBWaN4UvKZde7tLqDyLQ1nRPNahkm1e
         htVA==
X-Gm-Message-State: APjAAAXihSZQfTUfPYP8AG0kTxOpjUDmAGcXWtguX4UkKgJ6/u6458g4
        3GKmROOvtbA4NoapRLaC1670/duotY2AM5FSdWZE0K9oi6NVBEP639XxyADT+YnGCRAFChLk5ix
        WgQ49BPLuc8CcYAeIc1ZAFsDX
X-Received: by 2002:a24:d643:: with SMTP id o64mr29154510itg.148.1555423318397;
        Tue, 16 Apr 2019 07:01:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzuYxaJBOuetMqAT1zQQQN2fVktQuApd+U6kCX1zxVT/gLExusOiL5Rk0VleOFmxdlfUFooOA==
X-Received: by 2002:a24:d643:: with SMTP id o64mr29154491itg.148.1555423318246;
        Tue, 16 Apr 2019 07:01:58 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id m6sm19496152ioj.36.2019.04.16.07.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 07:01:57 -0700 (PDT)
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
Subject: [PATCH v2] x86/PCI: fix a memory leak bug
Date:   Tue, 16 Apr 2019 09:01:38 -0500
Message-Id: <1555423298-6677-1-git-send-email-wang6495@umn.edu>
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
However, in that case, the allocated table is not freed, which can lead to
a memory leak bug.

To fix this issue, this patch frees the allocated table if it is not used.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
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

