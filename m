Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D6C04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 08:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D0C20851
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 08:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVDkAa47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D0C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbeLCIVs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:21:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34522 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeLCIVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Dec 2018 03:21:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so6348436wmd.1;
        Mon, 03 Dec 2018 00:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FNun3UGNN/f1ATchkSmY6dXPmR4XVkmmp1eN8wjnK28=;
        b=nVDkAa47+jZFTV/Eu4aOo9Usfzbpqm1zU/51YCrs+A3WkpB3drh9X6GO6jIF8oMUUL
         WAaD4vHO7dF+088B98V8c/65pj1F+Lmz8f6vSua6e2hrwVA97JZkoGE5B6AZmuugc2zx
         D9zk+oDkQ16D563C3TtocgjQgUsw438zoT9bi3prBD1/yPD0k2MPbugPoUe+JCEEKVHU
         4IqDsK433S0Kb4Zf2TLRpWg1tGbTPSu9RET0aKZlkpi9/cbE7rcAVQ7tWU0uk7ZLL7V7
         EvOjTrB229DkJ1PX1CFJf/xxIFQyLGUFNknTyl1fm8IkoaL8jJYLEbKEZeY9r8KClorC
         LVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=FNun3UGNN/f1ATchkSmY6dXPmR4XVkmmp1eN8wjnK28=;
        b=mDzVkTTP3kJkZwJVeNfT7e3nlLq/0G/ZLB6kdFhTUApx2gHXpVeLxzHzvhUjghyxlG
         TDBh+Ln1EqCPQKO4ke3lNqZ/Gi1OVsmOHECE0pcztQyMFoPH/PZ15v2RHYmQuYd3DKXV
         +MggRSE0hPNrVEJnIM5c6ofl209LLb8cQK7x7pfiUEGfmBKQmxW8yG2ET/MShPUJYKLd
         vYB8Iz4V54kpDj4r0siJX5qV5LwOIWBPQt3MbhxO6lNzGN9AgpJjUUZHIl4x39szOVNc
         T7SSp5fTklP+TD9L7BdfrCEbNrL9GbPcJFYbv7lRvlBlk7EppAjnDU8Mh/n6zXpWvNgj
         ogcA==
X-Gm-Message-State: AA+aEWbb6PAJOi5TIWp2m0BVLt8PgrWPEVZl/MOoEBy6DDrbz9bWyIKS
        Fp0LpcoRFrMkr4c+l15mjZzGpfx4
X-Google-Smtp-Source: AFSGD/Xd13urvLDd86/fh7CHzCIhbAUnImFvxQopfNp6c/2gwyVD3EeAv6HnI5AeL6JIukseXTyO+g==
X-Received: by 2002:a1c:7011:: with SMTP id l17mr7068696wmc.34.1543825303050;
        Mon, 03 Dec 2018 00:21:43 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p6sm10535264wrx.50.2018.12.03.00.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 00:21:42 -0800 (PST)
Date:   Mon, 3 Dec 2018 09:21:40 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/pci: Remove dead code DBG() macro
Message-ID: <20181203082140.GA15318@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From 22b71f970f18f5f38161be028ab7ce7cd1f769f7 Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@kernel.org>
Date: Mon, 3 Dec 2018 09:15:40 +0100
Subject: [PATCH] x86/pci: Remove the dead-code DBG() macro

While reading arch/x86/include/asm/pci_x86.h I noticed that we have ancient
residuals of debugging code, which is never actually enabled via any regular
Kconfig mechanism:

 #undef DEBUG

 #ifdef DEBUG
 #define DBG(fmt, ...) printk(fmt, ##__VA_ARGS__)
 #else
 #define DBG(fmt, ...)                          \
 do {                                           \
       if (0)                                  \
               printk(fmt, ##__VA_ARGS__);     \
 } while (0)
 #endif

Remove this and the call sites. These messages might have been
super interesting decades ago when the PCI code was first
bootstrapped, but we have better mechanisms meanwhile, and code
readability is king ... ;-)

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pci_x86.h | 12 ------------
 arch/x86/pci/direct.c          |  1 -
 arch/x86/pci/i386.c            |  2 --
 arch/x86/pci/irq.c             | 29 +++--------------------------
 arch/x86/pci/legacy.c          |  3 +--
 arch/x86/pci/pcbios.c          |  9 ++-------
 6 files changed, 6 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 959d618dbb17..3f8d9c75b9ee 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -7,18 +7,6 @@
 
 #include <linux/ioport.h>
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(fmt, ...) printk(fmt, ##__VA_ARGS__)
-#else
-#define DBG(fmt, ...)				\
-do {						\
-	if (0)					\
-		printk(fmt, ##__VA_ARGS__);	\
-} while (0)
-#endif
-
 #define PCI_PROBE_BIOS		0x0001
 #define PCI_PROBE_CONF1		0x0002
 #define PCI_PROBE_CONF2		0x0004
diff --git a/arch/x86/pci/direct.c b/arch/x86/pci/direct.c
index a51074c55982..68a115629568 100644
--- a/arch/x86/pci/direct.c
+++ b/arch/x86/pci/direct.c
@@ -216,7 +216,6 @@ static int __init pci_sanity_check(const struct pci_raw_ops *o)
 			return 1;
 	}
 
-	DBG(KERN_WARNING "PCI: Sanity check failed\n");
 	return 0;
 }
 
diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 8cd66152cdb0..5c2b31315750 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -389,8 +389,6 @@ void __init pcibios_resource_survey(void)
 {
 	struct pci_bus *bus;
 
-	DBG("PCI: Allocating resources\n");
-
 	list_for_each_entry(bus, &pci_root_buses, node)
 		pcibios_allocate_bus_resources(bus);
 
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 52e55108404e..1286f138e281 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -77,11 +77,8 @@ static inline struct irq_routing_table *pirq_check_routing_table(u8 *addr)
 	sum = 0;
 	for (i = 0; i < rt->size; i++)
 		sum += addr[i];
-	if (!sum) {
-		DBG(KERN_DEBUG "PCI: Interrupt Routing Table found at 0x%p\n",
-			rt);
+	if (!sum)
 		return rt;
-	}
 	return NULL;
 }
 
@@ -126,15 +123,6 @@ static void __init pirq_peer_trick(void)
 	memset(busmap, 0, sizeof(busmap));
 	for (i = 0; i < (rt->size - sizeof(struct irq_routing_table)) / sizeof(struct irq_info); i++) {
 		e = &rt->slots[i];
-#ifdef DEBUG
-		{
-			int j;
-			DBG(KERN_DEBUG "%02x:%02x slot=%02x", e->bus, e->devfn/8, e->slot);
-			for (j = 0; j < 4; j++)
-				DBG(" %d:%02x/%04x", j, e->irq[j].link, e->irq[j].bitmap);
-			DBG("\n");
-		}
-#endif
 		busmap[e->bus] = 1;
 	}
 	for (i = 1; i < 256; i++) {
@@ -163,10 +151,8 @@ void elcr_set_level_irq(unsigned int irq)
 	elcr_irq_mask |= (1 << irq);
 	printk(KERN_DEBUG "PCI: setting IRQ %u as level-triggered\n", irq);
 	val = inb(port);
-	if (!(val & mask)) {
-		DBG(KERN_DEBUG " -> edge");
+	if (!(val & mask))
 		outb(val | mask, port);
-	}
 }
 
 /*
@@ -836,16 +822,10 @@ static void __init pirq_find_router(struct irq_router *r)
 	r->get = NULL;
 	r->set = NULL;
 
-	DBG(KERN_DEBUG "PCI: Attempting to find IRQ router for [%04x:%04x]\n",
-	    rt->rtr_vendor, rt->rtr_device);
-
 	pirq_router_dev = pci_get_domain_bus_and_slot(0, rt->rtr_bus,
 						      rt->rtr_devfn);
-	if (!pirq_router_dev) {
-		DBG(KERN_DEBUG "PCI: Interrupt router not found at "
-			"%02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
+	if (!pirq_router_dev)
 		return;
-	}
 
 	for (h = pirq_routers; h->vendor; h++) {
 		/* First look for a router match */
@@ -1028,7 +1008,6 @@ void __init pcibios_fixup_irqs(void)
 	struct pci_dev *dev = NULL;
 	u8 pin;
 
-	DBG(KERN_DEBUG "PCI: IRQ fixup\n");
 	for_each_pci_dev(dev) {
 		/*
 		 * If the BIOS has set an out of range IRQ number, just
@@ -1119,8 +1098,6 @@ static const struct dmi_system_id pciirq_dmi_table[] __initconst = {
 
 void __init pcibios_irq_init(void)
 {
-	DBG(KERN_DEBUG "PCI: IRQ init\n");
-
 	if (raw_pci_ops == NULL)
 		return;
 
diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c
index dfbe6ac38830..045089b34400 100644
--- a/arch/x86/pci/legacy.c
+++ b/arch/x86/pci/legacy.c
@@ -17,7 +17,6 @@ static void pcibios_fixup_peer_bridges(void)
 
 	if (pcibios_last_bus <= 0 || pcibios_last_bus > 0xff)
 		return;
-	DBG("PCI: Peer bridge fixup\n");
 
 	for (n=0; n <= pcibios_last_bus; n++)
 		pcibios_scan_specific_bus(n);
@@ -45,7 +44,7 @@ void pcibios_scan_specific_bus(int busn)
 	for (devfn = 0; devfn < 256; devfn += stride) {
 		if (!raw_pci_read(0, busn, devfn, PCI_VENDOR_ID, 2, &l) &&
 		    l != 0x0000 && l != 0xffff) {
-			DBG("Found device at %02x:%02x [%04x]\n", busn, devfn, l);
+
 			pr_info("PCI: Discovered peer bus %02x\n", busn);
 			pcibios_scan_root(busn);
 			return;
diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
index 9c97d814125e..a6fc43aa668c 100644
--- a/arch/x86/pci/pcbios.c
+++ b/arch/x86/pci/pcbios.c
@@ -160,8 +160,6 @@ static int __init check_pcibios(void)
 		minor_ver = ebx & 0xff;
 		if (pcibios_last_bus < 0)
 			pcibios_last_bus = ecx & 0xff;
-		DBG("PCI: BIOS probe returned s=%02x hw=%02x ver=%02x.%02x l=%02x\n",
-			status, hw_mech, major_ver, minor_ver, pcibios_last_bus);
 		if (status || signature != PCI_SIGNATURE) {
 			printk (KERN_ERR "PCI: BIOS BUG #%x[%08x] found\n",
 				status, signature);
@@ -320,15 +318,13 @@ static const struct pci_raw_ops *__init pci_find_bios(void)
 				check->fields.revision, check);
 			continue;
 		}
-		DBG("PCI: BIOS32 Service Directory structure at 0x%p\n", check);
 		if (check->fields.entry >= 0x100000) {
 			printk("PCI: BIOS32 entry (0x%p) in high memory, "
 					"cannot use.\n", check);
 			return NULL;
 		} else {
 			unsigned long bios32_entry = check->fields.entry;
-			DBG("PCI: BIOS32 Service Directory entry at 0x%lx\n",
-					bios32_entry);
+
 			bios32_indirect.address = bios32_entry + PAGE_OFFSET;
 			set_bios_x();
 			if (check_pcibios())
@@ -366,7 +362,6 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
 	opt.size = PAGE_SIZE;
 	opt.segment = __KERNEL_DS;
 
-	DBG("PCI: Fetching IRQ routing table... ");
 	__asm__("push %%es\n\t"
 		"push %%ds\n\t"
 		"pop  %%es\n\t"
@@ -384,7 +379,7 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
 		  "S" (&pci_indirect),
 		  "m" (opt)
 		: "memory");
-	DBG("OK  ret=%d, size=%d, map=%x\n", ret, opt.size, map);
+
 	if (ret & 0xff00)
 		printk(KERN_ERR "PCI: Error %02x when fetching IRQ routing table.\n", (ret >> 8) & 0xff);
 	else if (opt.size) {
