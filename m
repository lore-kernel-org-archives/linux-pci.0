Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A360BC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714242075B
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="V9nQ2s4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfDOO4W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:56:22 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:50728 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbfDOO4V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 10:56:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 12AF6CD7
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2019 14:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XwlRWeCWj-tU for <linux-pci@vger.kernel.org>;
        Mon, 15 Apr 2019 09:56:19 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id C8BB2D0F
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2019 09:56:03 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id e126so14138971ioa.8
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2019 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OVfJ2iOS0oUQifj2xXtFvPtDE+Eag0qBqDFOQ3KG+Ek=;
        b=V9nQ2s4VSxnEmO050wxtdc0l7cLsNcGgJ0MhWXm/QdX5vWwRYNxg2GTq9q6VbmMdec
         x3pmUeywriHgPtA0mlxrPmfoJhfuaIiPwABHiHD/hPEQH5wLrCPIhbDr2czJRXHiGDNO
         zN3tSEom8038DOpOXQeGcHSAQNksqo19VO9FzPvPKx3tZXAedHa9wgYccq+0h248JqlD
         WP/UtUPbfi9UwkcLotvaOj8sM3OHJeelmfdSqIn2LOd1MzupOcBhVJ4gwUJZTGZJZ9jS
         fLXoWIFhX00BJ0zr7mI07OJf3ansghuofju8h4elk1xuCNHGRJS0pWZSALbmyRa3vRhN
         WIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OVfJ2iOS0oUQifj2xXtFvPtDE+Eag0qBqDFOQ3KG+Ek=;
        b=pA5pnR2O0OeeEHlH1I3EABYNNrSyY1AcZLg7EZrldFrvNSCXeQn127j63/5Z4l5arb
         NChhpbKol7UlRf1Ppj/8K5sLAPiqaxF5qox1dpT9mQWhi7aJierE/vAvtksGJritByjT
         aa7vDTguatbSpCW8xY0MR0jPq6KVwTQDaGN0nHPDTzyLrF3bt+29PwiV06z3TrKgmtgW
         Ixq95N4e56B7tpfxF9s2AezMUQRrvFFq16pQJqWQ64XJxJhmfVtrPwGkkZSLtmhzJx1m
         cuYyNM4nzrjA61E2BkuNwbfbiVI7zb2JagYgyJaRgDIuNF8MlOxGefDoKHTR6v/g+L8f
         YhWA==
X-Gm-Message-State: APjAAAWI2C9mSklC7ETkDP75q2iPGoPfeI7adXVuui8r2vPUqSwYFprL
        SzqfD9V83tmzYwXzH7K1lWIsozw7qMPHOT/aAdiqBKzveNwPwIPmV2qqsPkpEVV3bft2dWGJLA6
        61Gv3RerP2nhYu0nZPXx3sU1M
X-Received: by 2002:a24:9414:: with SMTP id j20mr11773541ite.91.1555340163517;
        Mon, 15 Apr 2019 07:56:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzHzWqXSoZP/hL9mCHhoNlnbWK0cmDZS6VZ46LK80hgIWsrpqvg1kq2KxnzvdQSHt7vk8rlFA==
X-Received: by 2002:a24:9414:: with SMTP id j20mr11773526ite.91.1555340163359;
        Mon, 15 Apr 2019 07:56:03 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id a16sm8085709itc.36.2019.04.15.07.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 07:56:02 -0700 (PDT)
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
Subject: [PATCH] x86/PCI: fix a memory leak bug
Date:   Mon, 15 Apr 2019 09:54:18 -0500
Message-Id: <1555340058-3065-1-git-send-email-wang6495@umn.edu>
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
index 52e5510..d9bcb96 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1119,6 +1119,8 @@ static const struct dmi_system_id pciirq_dmi_table[] __initconst = {
 
 void __init pcibios_irq_init(void)
 {
+	struct irq_routing_table *itable = NULL;
+
 	DBG(KERN_DEBUG "PCI: IRQ init\n");
 
 	if (raw_pci_ops == NULL)
@@ -1129,8 +1131,10 @@ void __init pcibios_irq_init(void)
 	pirq_table = pirq_find_routing_table();
 
 #ifdef CONFIG_PCI_BIOS
-	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN))
+	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN)) {
 		pirq_table = pcibios_get_irq_routing_table();
+		itable = pirq_table;
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
+			kfree(itable);
 			pirq_table = NULL;
+		}
 	}
 
 	x86_init.pci.fixup_irqs();
-- 
2.7.4

