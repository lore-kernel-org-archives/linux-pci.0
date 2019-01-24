Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895BBC282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 17:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62809218A6
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 17:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfAXRrs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:47:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:51310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728196AbfAXRrs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 12:47:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 315DCB0D7;
        Thu, 24 Jan 2019 17:47:45 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/7] MIPS: SGI-IP27: use pr_info/pr_emerg and pr_cont to fix output
Date:   Thu, 24 Jan 2019 18:47:24 +0100
Message-Id: <20190124174728.28812-4-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190124174728.28812-1-tbogendoerfer@suse.de>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Topology and NMI output needs pr_cont() to look the way it was in the
old days of printk.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/sgi-ip27/ip27-memory.c | 28 +++++++++---------
 arch/mips/sgi-ip27/ip27-nmi.c    | 62 ++++++++++++++++++++--------------------
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 87ef4181934e..fb077a947575 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -154,11 +154,11 @@ static int __init compute_node_distance(nasid_t nasid_a, nasid_t nasid_b)
 	}
 
 	if (router_a == NULL) {
-		printk("node_distance: router_a NULL\n");
+		pr_info("node_distance: router_a NULL\n");
 		return -1;
 	}
 	if (router_b == NULL) {
-		printk("node_distance: router_b NULL\n");
+		pr_info("node_distance: router_b NULL\n");
 		return -1;
 	}
 
@@ -203,17 +203,17 @@ static void __init dump_topology(void)
 	klrou_t *router;
 	cnodeid_t row, col;
 
-	printk("************** Topology ********************\n");
+	pr_info("************** Topology ********************\n");
 
-	printk("    ");
+	pr_info("    ");
 	for_each_online_node(col)
-		printk("%02d ", col);
-	printk("\n");
+		pr_cont("%02d ", col);
+	pr_cont("\n");
 	for_each_online_node(row) {
-		printk("%02d  ", row);
+		pr_info("%02d  ", row);
 		for_each_online_node(col)
-			printk("%2d ", node_distance(row, col));
-		printk("\n");
+			pr_cont("%2d ", node_distance(row, col));
+		pr_cont("\n");
 	}
 
 	for_each_online_node(cnode) {
@@ -230,7 +230,7 @@ static void __init dump_topology(void)
 		do {
 			if (brd->brd_flags & DUPLICATE_BOARD)
 				continue;
-			printk("Router %d:", router_num);
+			pr_cont("Router %d:", router_num);
 			router_num++;
 
 			router = (klrou_t *)NODE_OFFSET_TO_K0(NASID_GET(brd), brd->brd_compts[0]);
@@ -244,11 +244,11 @@ static void __init dump_topology(void)
 					router->rou_port[port].port_offset);
 
 				if (dest_brd->brd_type == KLTYPE_IP27)
-					printk(" %d", dest_brd->brd_nasid);
+					pr_cont(" %d", dest_brd->brd_nasid);
 				if (dest_brd->brd_type == KLTYPE_ROUTER)
-					printk(" r");
+					pr_cont(" r");
 			}
-			printk("\n");
+			pr_cont("\n");
 
 		} while ( (brd = find_lboard_class(KLCF_NEXT(brd), KLTYPE_ROUTER)) );
 	}
@@ -373,7 +373,7 @@ static void __init szmem(void)
 
 			if ((nodebytes >> PAGE_SHIFT) * (sizeof(struct page)) >
 						(slot0sz << PAGE_SHIFT)) {
-				printk("Ignoring slot %d onwards on node %d\n",
+				pr_info("Ignoring slot %d onwards on node %d\n",
 								slot, node);
 				slot = MAX_MEM_SLOTS;
 				continue;
diff --git a/arch/mips/sgi-ip27/ip27-nmi.c b/arch/mips/sgi-ip27/ip27-nmi.c
index 8cb3a5d6d7d1..3aae388561d9 100644
--- a/arch/mips/sgi-ip27/ip27-nmi.c
+++ b/arch/mips/sgi-ip27/ip27-nmi.c
@@ -62,70 +62,70 @@ void nmi_cpu_eframe_save(nasid_t nasid, int slice)
 		(TO_UNCAC(TO_NODE(nasid, IP27_NMI_KREGS_OFFSET)) +
 		slice * IP27_NMI_KREGS_CPU_SIZE);
 
-	printk("NMI nasid %d: slice %d\n", nasid, slice);
+	pr_emerg("NMI nasid %d: slice %d\n", nasid, slice);
 
 	/*
 	 * Saved main processor registers
 	 */
 	for (i = 0; i < 32; ) {
 		if ((i % 4) == 0)
-			printk("$%2d   :", i);
-		printk(" %016lx", nr->gpr[i]);
+			pr_emerg("$%2d   :", i);
+		pr_cont(" %016lx", nr->gpr[i]);
 
 		i++;
 		if ((i % 4) == 0)
-			printk("\n");
+			pr_cont("\n");
 	}
 
-	printk("Hi    : (value lost)\n");
-	printk("Lo    : (value lost)\n");
+	pr_emerg("Hi    : (value lost)\n");
+	pr_emerg("Lo    : (value lost)\n");
 
 	/*
 	 * Saved cp0 registers
 	 */
-	printk("epc   : %016lx %pS\n", nr->epc, (void *) nr->epc);
-	printk("%s\n", print_tainted());
-	printk("ErrEPC: %016lx %pS\n", nr->error_epc, (void *) nr->error_epc);
-	printk("ra    : %016lx %pS\n", nr->gpr[31], (void *) nr->gpr[31]);
-	printk("Status: %08lx	      ", nr->sr);
+	pr_emerg("epc   : %016lx %pS\n", nr->epc, (void *)nr->epc);
+	pr_emerg("%s\n", print_tainted());
+	pr_emerg("ErrEPC: %016lx %pS\n", nr->error_epc, (void *)nr->error_epc);
+	pr_emerg("ra    : %016lx %pS\n", nr->gpr[31], (void *)nr->gpr[31]);
+	pr_emerg("Status: %08lx	      ", nr->sr);
 
 	if (nr->sr & ST0_KX)
-		printk("KX ");
+		pr_cont("KX ");
 	if (nr->sr & ST0_SX)
-		printk("SX	");
+		pr_cont("SX ");
 	if (nr->sr & ST0_UX)
-		printk("UX ");
+		pr_cont("UX ");
 
 	switch (nr->sr & ST0_KSU) {
 	case KSU_USER:
-		printk("USER ");
+		pr_cont("USER ");
 		break;
 	case KSU_SUPERVISOR:
-		printk("SUPERVISOR ");
+		pr_cont("SUPERVISOR ");
 		break;
 	case KSU_KERNEL:
-		printk("KERNEL ");
+		pr_cont("KERNEL ");
 		break;
 	default:
-		printk("BAD_MODE ");
+		pr_cont("BAD_MODE ");
 		break;
 	}
 
 	if (nr->sr & ST0_ERL)
-		printk("ERL ");
+		pr_cont("ERL ");
 	if (nr->sr & ST0_EXL)
-		printk("EXL ");
+		pr_cont("EXL ");
 	if (nr->sr & ST0_IE)
-		printk("IE ");
-	printk("\n");
+		pr_cont("IE ");
+	pr_cont("\n");
 
-	printk("Cause : %08lx\n", nr->cause);
-	printk("PrId  : %08x\n", read_c0_prid());
-	printk("BadVA : %016lx\n", nr->badva);
-	printk("CErr  : %016lx\n", nr->cache_err);
-	printk("NMI_SR: %016lx\n", nr->nmi_sr);
+	pr_emerg("Cause : %08lx\n", nr->cause);
+	pr_emerg("PrId  : %08x\n", read_c0_prid());
+	pr_emerg("BadVA : %016lx\n", nr->badva);
+	pr_emerg("CErr  : %016lx\n", nr->cache_err);
+	pr_emerg("NMI_SR: %016lx\n", nr->nmi_sr);
 
-	printk("\n");
+	pr_emerg("\n");
 }
 
 void nmi_dump_hub_irq(nasid_t nasid, int slice)
@@ -143,9 +143,9 @@ void nmi_dump_hub_irq(nasid_t nasid, int slice)
 	pend0 = REMOTE_HUB_L(nasid, PI_INT_PEND0);
 	pend1 = REMOTE_HUB_L(nasid, PI_INT_PEND1);
 
-	printk("PI_INT_MASK0: %16Lx PI_INT_MASK1: %16Lx\n", mask0, mask1);
-	printk("PI_INT_PEND0: %16Lx PI_INT_PEND1: %16Lx\n", pend0, pend1);
-	printk("\n\n");
+	pr_emerg("PI_INT_MASK0: %16llx PI_INT_MASK1: %16llx\n", mask0, mask1);
+	pr_emerg("PI_INT_PEND0: %16llx PI_INT_PEND1: %16llx\n", pend0, pend1);
+	pr_emerg("\n\n");
 }
 
 /*
-- 
2.13.7

