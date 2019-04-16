Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839A7C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 21:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5350620684
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 21:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="R3ttiMwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfDPVme (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:42:34 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:33242 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfDPVme (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 17:42:34 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4B8CFD06
        for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2019 21:42:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rthpKnhxa_U7 for <linux-pci@vger.kernel.org>;
        Tue, 16 Apr 2019 16:42:32 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 1BF80D1E
        for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2019 16:42:32 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id j8so633221ita.5
        for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2019 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PFTfONvAiiu67aPzQLdoY/PU1MIG5Y6/UArerLbs+JA=;
        b=R3ttiMwNTVSi4jeuQ5nZlMf3pgiDhx33vC4XrUIXFwounQPH/amvqOUXnFpmaIzJp/
         A9Xqn0HAahQDdFllFd2IdXYo1lXC30agT7b53dF0HnZLDIQv4d1ORUgluhVe/RnIsJmd
         /th4NOe65F6s0Ct4CTtGn0t4dBo0R3+5W9cdOEP/TBNFq+hNQQTW6s2aAiXFft9UA4DY
         OskJNfkWuzAGtVFQ8zZiiVj3+5jkQOZjviFoARXje/yJfYJ9OCXkK/v8BIPfyYhM2mHp
         Mew7NdAIcaXOb9ImvIGx53CM2sCO0jXVEDtiCxP4FpSboc676lz4daNum8pcE1TTrUBl
         D7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PFTfONvAiiu67aPzQLdoY/PU1MIG5Y6/UArerLbs+JA=;
        b=D2LfCQxii1n6Vhv3LKkiWoGB8j489yYUEhlP8+yFIFbPXxqmP+m8rWQ3fPhifUKdlm
         nv13ZHK8vE4jMtLCDB8MrJK6UXAVhO4Ky6AMJPLw2F5sdKVSsq+iUsvkwPpff/cdQ49u
         Il3yGDyczADqJKxFbm7g+KaP2CHJAuWlhGv1ctzxI9WJgdPoykQuYY1RikQAMgwFVzJa
         Bp3Bwyh+sgl7CZkgQn9z6fSB6LMpWxcNNk/qWEQUDi5Y5/2sZCG5gYXvjeCt/YGxxH3X
         hnNascZmJ01KsJr+3CEA2zJ80+l5JGhrXdCTdViFjieDs8qm+1NbZwTRcDLkn/Trp2Et
         ReOQ==
X-Gm-Message-State: APjAAAXheZiS3wC36dJkdFksr81wNqe84zzJ5hLdx4inpZF1/FUnwsKy
        eEsGXlOUx6x9/C7nULVq8grVjlg5tiF8HuMHZBCl8d6YQzs4P5rD7ZL/hitmOoj16SXor9W71Z/
        cbRK48ekQMdEAWJiPvsqAj7mx
X-Received: by 2002:a24:4746:: with SMTP id t67mr30799275itb.123.1555450951770;
        Tue, 16 Apr 2019 14:42:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzM20y35jywx3tWO3WkicyMumuCPB6EW7gPvM+gdPz11vWA0rvlrJS6fDVbzRUsv49eHtY36g==
X-Received: by 2002:a24:4746:: with SMTP id t67mr30799263itb.123.1555450951614;
        Tue, 16 Apr 2019 14:42:31 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id m137sm330086itb.27.2019.04.16.14.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 14:42:30 -0700 (PDT)
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
Subject: [PATCH v3] x86/PCI: fix a memory leak bug
Date:   Tue, 16 Apr 2019 16:42:11 -0500
Message-Id: <1555450931-7728-1-git-send-email-wang6495@umn.edu>
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

