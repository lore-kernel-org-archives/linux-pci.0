Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AB0C04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 08:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC7020851
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 08:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgXmLfZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC7020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbeLCItx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:49:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41195 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLCItx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Dec 2018 03:49:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so11175423wrs.8;
        Mon, 03 Dec 2018 00:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VOEh866ZbANo3Ge5n4GDOewNeDwEmttJjoNgAq7uD50=;
        b=GgXmLfZ6SHxjM+zhaUo9mUB2y1RBXQ9arvSR/g0fECPwbaBhfd0MvjwTbqhsOTubs0
         VIfYuOrlA/39RcfhmNcEsel+RnUyXSHmu/4eKdXgyGTXRrW3oJXZg5iCVMtpnD0uPXZ5
         9xMyg+J6m6LoDCyZ+tSBytWvY20hrbDUkAjshrJ/hC9niScu9flL1Q+mWdEjHqsKaMkR
         NwEsQp5yUtxl+YsiP3/hamXrR0DhfWZP9x+Uj4XMjNbRBONKUlQ1hS9sCOluFmsPYHjz
         SvuwFaa/24jjk9lJSnu6cJQnWCCQDTExhlWcs2jLJlFA2mq+xRZTUvNNEoAoF98D/Vn9
         FxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VOEh866ZbANo3Ge5n4GDOewNeDwEmttJjoNgAq7uD50=;
        b=U2VUJh0vROeE6YQ/q6ywqwl/oCaowYiqNjqFRvPp9iPXXktMsm5G81mmatanZj9OqT
         l+T1CkrGJ87zd2Z6KMtUXNMCw0UR2x9zrYe2eEJmu8MrBse9ZysJPD1HL4F1XwsrLAq6
         /8YBbCU5jjAfbF+oGzHGlof6Ulyd4vCbYZ9VYVu6kiRs3PUM996ew9xEOApUMHOH9C29
         5k1mUD10qtVAOP6WuJRF1ZCKYblbFijTgooU3ATeKoZAMGdNl8qzLQ2MXklItbVwSJ03
         4fwqErWrD6el123dGfyQm90j0trKrRVBURoJ2ToThQemhOemUdTvZBUfLSpM3z+MWiEc
         shWQ==
X-Gm-Message-State: AA+aEWbguf/Lx7OpGicuT1lKp3VTI6m/y1ATd2Yb5F1uf/5uuQyKnJSP
        i47LCv20OhBbI4ZRHRvXcNA=
X-Google-Smtp-Source: AFSGD/V/bFNMLrYoXGG3QKGEo1CfsXD80lBSMKtXFqRWQ1J6WLAZQbJTB6zNYF9pdGIyFVROGUhfwQ==
X-Received: by 2002:adf:fe8f:: with SMTP id l15mr12573387wrr.313.1543826986302;
        Mon, 03 Dec 2018 00:49:46 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m4sm8524516wrw.67.2018.12.03.00.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 00:49:45 -0800 (PST)
Date:   Mon, 3 Dec 2018 09:49:43 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/pci: Clean up the asm/pci_x86.h header a bit
Message-ID: <20181203084943.GA56168@gmail.com>
References: <20181203082140.GA15318@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203082140.GA15318@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> From 22b71f970f18f5f38161be028ab7ce7cd1f769f7 Mon Sep 17 00:00:00 2001
> From: Ingo Molnar <mingo@kernel.org>
> Date: Mon, 3 Dec 2018 09:15:40 +0100
> Subject: [PATCH] x86/pci: Remove the dead-code DBG() macro
> 
> While reading arch/x86/include/asm/pci_x86.h I noticed that we have ancient
> residuals of debugging code, which is never actually enabled via any regular
> Kconfig mechanism:

I also noticed that the PCI_CHECK_ENABLE_AMD_MMCONF line added eons ago 
looked weird, so did a quick cleanup pass of the header.

Thanks,

	Ingo

================>
From: Ingo Molnar <mingo@kernel.org>
Date: Mon, 3 Dec 2018 09:42:40 +0100
Subject: [PATCH] x86/pci: Clean up the asm/pci_x86.h header a bit

- The addition of PCI_CHECK_ENABLE_AMD_MMCONF broke the tabulation of the
  enumeration - fix the tabulation and also extend it with zeroes to make
  it clearer how the bits relate, and to make it easier to check that
  there's no accidental overlap.

- Remove unnecessary and out of date comments referring to file names that
  do not exist with that name anymore.

- Fix non-standard comment lines.

- Add 'extern' to global scope variables/functions that don't have it.

- Fix typo.

- Tabulate 'struct pci_mmcfg_region', similarly to the other structure
  definitions in this header.

- Move the x86_default_pci_* definitions closer to their usage site
  in arch/x86/kernel/x86_init.c, they are not used anywhere else,
  so it's unnecessary to include it in 30+ .c files.

No change to functionality intended.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pci_x86.h | 101 +++++++++++++++--------------------------
 arch/x86/kernel/x86_init.c     |  14 ++++++
 2 files changed, 51 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 3f8d9c75b9ee..3448f24282c7 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -7,26 +7,26 @@
 
 #include <linux/ioport.h>
 
-#define PCI_PROBE_BIOS		0x0001
-#define PCI_PROBE_CONF1		0x0002
-#define PCI_PROBE_CONF2		0x0004
-#define PCI_PROBE_MMCONF	0x0008
-#define PCI_PROBE_MASK		0x000f
-#define PCI_PROBE_NOEARLY	0x0010
-
-#define PCI_NO_CHECKS		0x0400
-#define PCI_USE_PIRQ_MASK	0x0800
-#define PCI_ASSIGN_ROMS		0x1000
-#define PCI_BIOS_IRQ_SCAN	0x2000
-#define PCI_ASSIGN_ALL_BUSSES	0x4000
-#define PCI_CAN_SKIP_ISA_ALIGN	0x8000
-#define PCI_USE__CRS		0x10000
-#define PCI_CHECK_ENABLE_AMD_MMCONF	0x20000
-#define PCI_HAS_IO_ECS		0x40000
-#define PCI_NOASSIGN_ROMS	0x80000
-#define PCI_ROOT_NO_CRS		0x100000
-#define PCI_NOASSIGN_BARS	0x200000
-#define PCI_BIG_ROOT_WINDOW	0x400000
+#define PCI_PROBE_BIOS			0x000001
+#define PCI_PROBE_CONF1			0x000002
+#define PCI_PROBE_CONF2			0x000004
+#define PCI_PROBE_MMCONF		0x000008
+#define PCI_PROBE_MASK			0x00000f
+#define PCI_PROBE_NOEARLY		0x000010
+
+#define PCI_NO_CHECKS			0x000400
+#define PCI_USE_PIRQ_MASK		0x000800
+#define PCI_ASSIGN_ROMS			0x001000
+#define PCI_BIOS_IRQ_SCAN		0x002000
+#define PCI_ASSIGN_ALL_BUSSES		0x004000
+#define PCI_CAN_SKIP_ISA_ALIGN		0x008000
+#define PCI_USE__CRS			0x010000
+#define PCI_CHECK_ENABLE_AMD_MMCONF	0x020000
+#define PCI_HAS_IO_ECS			0x040000
+#define PCI_NOASSIGN_ROMS		0x080000
+#define PCI_ROOT_NO_CRS			0x100000
+#define PCI_NOASSIGN_BARS		0x200000
+#define PCI_BIG_ROOT_WINDOW		0x400000
 
 extern unsigned int pci_probe;
 extern unsigned long pirq_table_addr;
@@ -38,28 +38,19 @@ enum pci_bf_sort_state {
 	pci_dmi_bf,
 };
 
-/* pci-i386.c */
-
-void pcibios_resource_survey(void);
-void pcibios_set_cache_line_size(void);
-
-/* pci-pc.c */
-
+extern void pcibios_resource_survey(void);
+extern void pcibios_set_cache_line_size(void);
 extern int pcibios_last_bus;
 extern struct pci_ops pci_root_ops;
-
-void pcibios_scan_specific_bus(int busn);
-
-/* pci-irq.c */
+extern void pcibios_scan_specific_bus(int busn);
 
 struct irq_info {
 	u8 bus, devfn;			/* Bus, device and function */
 	struct {
-		u8 link;		/* IRQ line ID, chipset dependent,
-					   0 = not routed */
+		u8 link;		/* IRQ line ID, chipset dependent, 0 = not routed */
 		u16 bitmap;		/* Available IRQs */
-	} __attribute__((packed)) irq[4];
-	u8 slot;			/* Slot number, 0=onboard */
+	} __packed irq[4];
+	u8 slot;			/* Slot number, 0 = onboard */
 	u8 rfu;
 } __attribute__((packed));
 
@@ -68,10 +59,8 @@ struct irq_routing_table {
 	u16 version;			/* PIRQ_VERSION */
 	u16 size;			/* Table size in bytes */
 	u8 rtr_bus, rtr_devfn;		/* Where the interrupt router lies */
-	u16 exclusive_irqs;		/* IRQs devoted exclusively to
-					   PCI usage */
-	u16 rtr_vendor, rtr_device;	/* Vendor and device ID of
-					   interrupt router */
+	u16 exclusive_irqs;		/* IRQs devoted exclusively to PCI usage */
+	u16 rtr_vendor, rtr_device;	/* Vendor and device ID of interrupt router */
 	u32 miniport_data;		/* Crap */
 	u8 rfu[11];
 	u8 checksum;			/* Modulo 256 checksum must give 0 */
@@ -108,27 +97,25 @@ extern void pci_pcbios_init(void);
 extern void __init dmi_check_pciprobe(void);
 extern void __init dmi_check_skip_isa_align(void);
 
-/* some common used subsys_initcalls */
+/* some commonly used subsys_initcalls */
 extern int __init pci_acpi_init(void);
 extern void __init pcibios_irq_init(void);
 extern int __init pcibios_init(void);
 extern int pci_legacy_init(void);
 extern void pcibios_fixup_irqs(void);
 
-/* pci-mmconfig.c */
-
 /* "PCI MMCONFIG %04x [bus %02x-%02x]" */
 #define PCI_MMCFG_RESOURCE_NAME_LEN (22 + 4 + 2 + 2)
 
 struct pci_mmcfg_region {
-	struct list_head list;
-	struct resource res;
-	u64 address;
-	char __iomem *virt;
-	u16 segment;
-	u8 start_bus;
-	u8 end_bus;
-	char name[PCI_MMCFG_RESOURCE_NAME_LEN];
+	struct list_head	list;
+	struct resource		res;
+	u64			address;
+	char __iomem		*virt;
+	u16			segment;
+	u8			start_bus;
+	u8			end_bus;
+	char			name[PCI_MMCFG_RESOURCE_NAME_LEN];
 };
 
 extern int __init pci_mmcfg_arch_init(void);
@@ -188,17 +175,3 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
 {
 	asm volatile("movl %%eax,(%1)" : : "a" (val), "r" (pos) : "memory");
 }
-
-#ifdef CONFIG_PCI
-# ifdef CONFIG_ACPI
-#  define x86_default_pci_init		pci_acpi_init
-# else
-#  define x86_default_pci_init		pci_legacy_init
-# endif
-# define x86_default_pci_init_irq	pcibios_irq_init
-# define x86_default_pci_fixup_irqs	pcibios_fixup_irqs
-#else
-# define x86_default_pci_init		NULL
-# define x86_default_pci_init_irq	NULL
-# define x86_default_pci_fixup_irqs	NULL
-#endif
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 50a2b492fdd6..95f64345c416 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -32,6 +32,20 @@ static void iommu_shutdown_noop(void) { }
 static bool __init bool_x86_init_noop(void) { return false; }
 static void x86_op_int_noop(int cpu) { }
 
+#ifdef CONFIG_PCI
+# ifdef CONFIG_ACPI
+#  define x86_default_pci_init		pci_acpi_init
+# else
+#  define x86_default_pci_init		pci_legacy_init
+# endif
+# define x86_default_pci_init_irq	pcibios_irq_init
+# define x86_default_pci_fixup_irqs	pcibios_fixup_irqs
+#else
+# define x86_default_pci_init		NULL
+# define x86_default_pci_init_irq	NULL
+# define x86_default_pci_fixup_irqs	NULL
+#endif
+
 /*
  * The platform setup functions are preset with the default functions
  * for standard PC hardware.
