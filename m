Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF8DC282C8
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 17:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FFD218AF
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 17:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfAXRrs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:47:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:51358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728565AbfAXRrr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 12:47:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36A64B0DD;
        Thu, 24 Jan 2019 17:47:45 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/7] MIPS: SGI-IP27: clean up bridge access and header files
Date:   Thu, 24 Jan 2019 18:47:23 +0100
Message-Id: <20190124174728.28812-3-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190124174728.28812-1-tbogendoerfer@suse.de>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduced bridge_read/bridge_write/bridge_set/bridge_clr for accessing
bridge register and get rid of volatile declarations. Also removed
all typedefs from arch/mips/include/asm/pci/bridge.h and cleaned up
language in arch/mips/pci/ops-bridge.c

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/include/asm/pci/bridge.h   | 217 +++++++++++++++++------------------
 arch/mips/include/asm/sn/sn0/addrs.h |   5 -
 arch/mips/pci/ops-bridge.c           |  68 ++++-------
 arch/mips/pci/pci-ip27.c             |  31 +++--
 arch/mips/sgi-ip27/ip27-irq-pci.c    |  24 ++--
 5 files changed, 153 insertions(+), 192 deletions(-)

diff --git a/arch/mips/include/asm/pci/bridge.h b/arch/mips/include/asm/pci/bridge.h
index 3206245d1ed6..6155618ce45b 100644
--- a/arch/mips/include/asm/pci/bridge.h
+++ b/arch/mips/include/asm/pci/bridge.h
@@ -44,19 +44,37 @@
  */
 
 #ifndef __ASSEMBLY__
+/* Address translation entry for mapped pci32 accesses */
+union bridge_ate {
+	u64	ent;
+	struct ate_s {
+		u64	rmf:16;
+		u64	addr:36;
+		u64	targ:4;
+		u64	reserved:3;
+		u64	barrier:1;
+		u64	prefetch:1;
+		u64	precise:1;
+		u64	coherent:1;
+		u64	valid:1;
+	} field;
+};
 
-/*
- * All accesses to bridge hardware registers must be done
- * using 32-bit loads and stores.
- */
-typedef u32	bridgereg_t;
+#define ATE_V		0x01
+#define ATE_CO		0x02
+#define ATE_PREC	0x04
+#define ATE_PREF	0x08
+#define ATE_BAR		0x10
 
-typedef u64	bridge_ate_t;
+#define ATE_PFNSHIFT		12
+#define ATE_TIDSHIFT		8
+#define ATE_RMFSHIFT		48
 
-/* pointers to bridge ATEs
- * are always "pointer to volatile"
- */
-typedef volatile bridge_ate_t  *bridge_ate_p;
+#define mkate(xaddr, xid, attr) (((xaddr) & 0x0000fffffffff000ULL) | \
+				 ((xid)<<ATE_TIDSHIFT) | \
+				 (attr))
+
+#define BRIDGE_INTERNAL_ATES	128
 
 /*
  * It is generally preferred that hardware registers on the bridge
@@ -65,7 +83,7 @@ typedef volatile bridge_ate_t  *bridge_ate_p;
  * Generated from Bridge spec dated 04oct95
  */
 
-typedef volatile struct bridge_s {
+struct bridge_regs {
 	/* Local Registers			       0x000000-0x00FFFF */
 
 	/* standard widget configuration	       0x000000-0x000057 */
@@ -86,105 +104,105 @@ typedef volatile struct bridge_s {
 #define b_wid_tflush			b_widget.w_tflush
 
 	/* bridge-specific widget configuration 0x000058-0x00007F */
-	bridgereg_t	    _pad_000058;
-	bridgereg_t	    b_wid_aux_err;		/* 0x00005C */
-	bridgereg_t	    _pad_000060;
-	bridgereg_t	    b_wid_resp_upper;		/* 0x000064 */
-	bridgereg_t	    _pad_000068;
-	bridgereg_t	    b_wid_resp_lower;		/* 0x00006C */
-	bridgereg_t	    _pad_000070;
-	bridgereg_t	    b_wid_tst_pin_ctrl;		/* 0x000074 */
-	bridgereg_t	_pad_000078[2];
+	u32	_pad_000058;
+	u32	b_wid_aux_err;		/* 0x00005C */
+	u32	_pad_000060;
+	u32	b_wid_resp_upper;		/* 0x000064 */
+	u32	_pad_000068;
+	u32	b_wid_resp_lower;		/* 0x00006C */
+	u32	_pad_000070;
+	u32	 b_wid_tst_pin_ctrl;		/* 0x000074 */
+	u32	_pad_000078[2];
 
 	/* PMU & Map 0x000080-0x00008F */
-	bridgereg_t	_pad_000080;
-	bridgereg_t	b_dir_map;			/* 0x000084 */
-	bridgereg_t	_pad_000088[2];
+	u32	_pad_000080;
+	u32	b_dir_map;			/* 0x000084 */
+	u32	_pad_000088[2];
 
 	/* SSRAM 0x000090-0x00009F */
-	bridgereg_t	_pad_000090;
-	bridgereg_t	b_ram_perr;			/* 0x000094 */
-	bridgereg_t	_pad_000098[2];
+	u32	_pad_000090;
+	u32	b_ram_perr;			/* 0x000094 */
+	u32	_pad_000098[2];
 
 	/* Arbitration 0x0000A0-0x0000AF */
-	bridgereg_t	_pad_0000A0;
-	bridgereg_t	b_arb;				/* 0x0000A4 */
-	bridgereg_t	_pad_0000A8[2];
+	u32	_pad_0000A0;
+	u32	b_arb;				/* 0x0000A4 */
+	u32	_pad_0000A8[2];
 
 	/* Number In A Can 0x0000B0-0x0000BF */
-	bridgereg_t	_pad_0000B0;
-	bridgereg_t	b_nic;				/* 0x0000B4 */
-	bridgereg_t	_pad_0000B8[2];
+	u32	_pad_0000B0;
+	u32	b_nic;				/* 0x0000B4 */
+	u32	_pad_0000B8[2];
 
 	/* PCI/GIO 0x0000C0-0x0000FF */
-	bridgereg_t	_pad_0000C0;
-	bridgereg_t	b_bus_timeout;			/* 0x0000C4 */
+	u32	_pad_0000C0;
+	u32	b_bus_timeout;			/* 0x0000C4 */
 #define b_pci_bus_timeout b_bus_timeout
 
-	bridgereg_t	_pad_0000C8;
-	bridgereg_t	b_pci_cfg;			/* 0x0000CC */
-	bridgereg_t	_pad_0000D0;
-	bridgereg_t	b_pci_err_upper;		/* 0x0000D4 */
-	bridgereg_t	_pad_0000D8;
-	bridgereg_t	b_pci_err_lower;		/* 0x0000DC */
-	bridgereg_t	_pad_0000E0[8];
+	u32	_pad_0000C8;
+	u32	b_pci_cfg;			/* 0x0000CC */
+	u32	_pad_0000D0;
+	u32	b_pci_err_upper;		/* 0x0000D4 */
+	u32	_pad_0000D8;
+	u32	b_pci_err_lower;		/* 0x0000DC */
+	u32	_pad_0000E0[8];
 #define b_gio_err_lower b_pci_err_lower
 #define b_gio_err_upper b_pci_err_upper
 
 	/* Interrupt 0x000100-0x0001FF */
-	bridgereg_t	_pad_000100;
-	bridgereg_t	b_int_status;			/* 0x000104 */
-	bridgereg_t	_pad_000108;
-	bridgereg_t	b_int_enable;			/* 0x00010C */
-	bridgereg_t	_pad_000110;
-	bridgereg_t	b_int_rst_stat;			/* 0x000114 */
-	bridgereg_t	_pad_000118;
-	bridgereg_t	b_int_mode;			/* 0x00011C */
-	bridgereg_t	_pad_000120;
-	bridgereg_t	b_int_device;			/* 0x000124 */
-	bridgereg_t	_pad_000128;
-	bridgereg_t	b_int_host_err;			/* 0x00012C */
+	u32	_pad_000100;
+	u32	b_int_status;			/* 0x000104 */
+	u32	_pad_000108;
+	u32	b_int_enable;			/* 0x00010C */
+	u32	_pad_000110;
+	u32	b_int_rst_stat;			/* 0x000114 */
+	u32	_pad_000118;
+	u32	b_int_mode;			/* 0x00011C */
+	u32	_pad_000120;
+	u32	b_int_device;			/* 0x000124 */
+	u32	_pad_000128;
+	u32	b_int_host_err;			/* 0x00012C */
 
 	struct {
-		bridgereg_t	__pad;			/* 0x0001{30,,,68} */
-		bridgereg_t	addr;			/* 0x0001{34,,,6C} */
+		u32	__pad;			/* 0x0001{30,,,68} */
+		u32	addr;			/* 0x0001{34,,,6C} */
 	} b_int_addr[8];				/* 0x000130 */
 
-	bridgereg_t	_pad_000170[36];
+	u32	_pad_000170[36];
 
 	/* Device 0x000200-0x0003FF */
 	struct {
-		bridgereg_t	__pad;			/* 0x0002{00,,,38} */
-		bridgereg_t	reg;			/* 0x0002{04,,,3C} */
+		u32	__pad;			/* 0x0002{00,,,38} */
+		u32	reg;			/* 0x0002{04,,,3C} */
 	} b_device[8];					/* 0x000200 */
 
 	struct {
-		bridgereg_t	__pad;			/* 0x0002{40,,,78} */
-		bridgereg_t	reg;			/* 0x0002{44,,,7C} */
+		u32	__pad;			/* 0x0002{40,,,78} */
+		u32	reg;			/* 0x0002{44,,,7C} */
 	} b_wr_req_buf[8];				/* 0x000240 */
 
 	struct {
-		bridgereg_t	__pad;			/* 0x0002{80,,,88} */
-		bridgereg_t	reg;			/* 0x0002{84,,,8C} */
+		u32	__pad;			/* 0x0002{80,,,88} */
+		u32	reg;			/* 0x0002{84,,,8C} */
 	} b_rrb_map[2];					/* 0x000280 */
 #define b_even_resp	b_rrb_map[0].reg		/* 0x000284 */
 #define b_odd_resp	b_rrb_map[1].reg		/* 0x00028C */
 
-	bridgereg_t	_pad_000290;
-	bridgereg_t	b_resp_status;			/* 0x000294 */
-	bridgereg_t	_pad_000298;
-	bridgereg_t	b_resp_clear;			/* 0x00029C */
+	u32	_pad_000290;
+	u32	b_resp_status;			/* 0x000294 */
+	u32	_pad_000298;
+	u32	b_resp_clear;			/* 0x00029C */
 
-	bridgereg_t	_pad_0002A0[24];
+	u32	_pad_0002A0[24];
 
 	char		_pad_000300[0x10000 - 0x000300];
 
 	/* Internal Address Translation Entry RAM 0x010000-0x0103FF */
 	union {
-		bridge_ate_t	wr;			/* write-only */
+		u64	wr;			/* write-only */
 		struct {
-			bridgereg_t	_p_pad;
-			bridgereg_t	rd;		/* read-only */
+			u32	_p_pad;
+			u32	rd;		/* read-only */
 		}			hi;
 	}			    b_int_ate_ram[128];
 
@@ -192,8 +210,8 @@ typedef volatile struct bridge_s {
 
 	/* Internal Address Translation Entry RAM LOW 0x011000-0x0113FF */
 	struct {
-		bridgereg_t	_p_pad;
-		bridgereg_t	rd;		/* read-only */
+		u32	_p_pad;
+		u32	rd;		/* read-only */
 	} b_int_ate_ram_lo[128];
 
 	char	_pad_011400[0x20000 - 0x011400];
@@ -212,7 +230,7 @@ typedef volatile struct bridge_s {
 		} f[8];
 	} b_type0_cfg_dev[8];					/* 0x020000 */
 
-    /* PCI Type 1 Configuration Space 0x028000-0x028FFF */
+	/* PCI Type 1 Configuration Space 0x028000-0x028FFF */
 	union {				/* make all access sizes available. */
 		u8	c[0x1000 / 1];
 		u16	s[0x1000 / 2];
@@ -233,7 +251,7 @@ typedef volatile struct bridge_s {
 	u8	_pad_030007[0x04fff8];			/* 0x030008-0x07FFFF */
 
 	/* External Address Translation Entry RAM 0x080000-0x0FFFFF */
-	bridge_ate_t	b_ext_ate_ram[0x10000];
+	union bridge_ate	b_ext_ate_ram[0x10000];
 
 	/* Reserved 0x100000-0x1FFFFF */
 	char	_pad_100000[0x200000-0x100000];
@@ -259,13 +277,13 @@ typedef volatile struct bridge_s {
 		u32	l[0x400000 / 4];	/* read-only */
 		u64	d[0x400000 / 8];	/* read-only */
 	} b_external_flash;			/* 0xC00000 */
-} bridge_t;
+};
 
 /*
  * Field formats for Error Command Word and Auxiliary Error Command Word
  * of bridge.
  */
-typedef struct bridge_err_cmdword_s {
+struct bridge_err_cmdword {
 	union {
 		u32		cmd_word;
 		struct {
@@ -282,7 +300,7 @@ typedef struct bridge_err_cmdword_s {
 				rsvd:8;
 		} berr_st;
 	} berr_un;
-} bridge_err_cmdword_t;
+};
 
 #define berr_field	berr_un.berr_st
 #endif /* !__ASSEMBLY__ */
@@ -290,7 +308,7 @@ typedef struct bridge_err_cmdword_s {
 /*
  * The values of these macros can and should be crosschecked
  * regularly against the offsets of the like-named fields
- * within the "bridge_t" structure above.
+ * within the bridge_regs structure above.
  */
 
 /* Byte offset macros for Bridge internal registers */
@@ -797,46 +815,12 @@ typedef struct bridge_err_cmdword_s {
 #define PCI64_ATTR_RMF_MASK	0x00ff000000000000
 #define PCI64_ATTR_RMF_SHFT	48
 
-#ifndef __ASSEMBLY__
-/* Address translation entry for mapped pci32 accesses */
-typedef union ate_u {
-	u64	ent;
-	struct ate_s {
-		u64	rmf:16;
-		u64	addr:36;
-		u64	targ:4;
-		u64	reserved:3;
-		u64	barrier:1;
-		u64	prefetch:1;
-		u64	precise:1;
-		u64	coherent:1;
-		u64	valid:1;
-	} field;
-} ate_t;
-#endif /* !__ASSEMBLY__ */
-
-#define ATE_V		0x01
-#define ATE_CO		0x02
-#define ATE_PREC	0x04
-#define ATE_PREF	0x08
-#define ATE_BAR		0x10
-
-#define ATE_PFNSHIFT		12
-#define ATE_TIDSHIFT		8
-#define ATE_RMFSHIFT		48
-
-#define mkate(xaddr, xid, attr) ((xaddr) & 0x0000fffffffff000ULL) | \
-				((xid)<<ATE_TIDSHIFT) | \
-				(attr)
-
-#define BRIDGE_INTERNAL_ATES	128
-
 struct bridge_controller {
 	struct pci_controller	pc;
 	struct resource		mem;
 	struct resource		io;
 	struct resource		busn;
-	bridge_t		*base;
+	struct bridge_regs	*base;
 	nasid_t			nasid;
 	unsigned int		widget_id;
 	unsigned int		irq_cpu;
@@ -847,6 +831,13 @@ struct bridge_controller {
 #define BRIDGE_CONTROLLER(bus) \
 	((struct bridge_controller *)((bus)->sysdata))
 
+#define bridge_read(bc, reg)		__raw_readl(&bc->base->reg)
+#define bridge_write(bc, reg, val)	__raw_writel(val, &bc->base->reg)
+#define bridge_set(bc, reg, val)	\
+	__raw_writel(__raw_readl(&bc->base->reg) | (val), &bc->base->reg)
+#define bridge_clr(bc, reg, val)	\
+	__raw_writel(__raw_readl(&bc->base->reg) & ~(val), &bc->base->reg)
+
 extern void register_bridge_irq(unsigned int irq);
 extern int request_bridge_irq(struct bridge_controller *bc);
 
diff --git a/arch/mips/include/asm/sn/sn0/addrs.h b/arch/mips/include/asm/sn/sn0/addrs.h
index 6b53070f400f..f13df84edfdd 100644
--- a/arch/mips/include/asm/sn/sn0/addrs.h
+++ b/arch/mips/include/asm/sn/sn0/addrs.h
@@ -134,11 +134,6 @@
 
 #define CALIAS_BASE		CAC_BASE
 
-
-
-#define BRIDGE_REG_PTR(_base, _off)	((volatile bridgereg_t *) \
-	((__psunsigned_t)(_base) + (__psunsigned_t)(_off)))
-
 #define SN0_WIDGET_BASE(_nasid, _wid)	(NODE_SWIN_BASE((_nasid), (_wid)))
 
 /* Turn on sable logging for the processors whose bits are set. */
diff --git a/arch/mips/pci/ops-bridge.c b/arch/mips/pci/ops-bridge.c
index a1d2c4ae0d1b..df95b0da08f2 100644
--- a/arch/mips/pci/ops-bridge.c
+++ b/arch/mips/pci/ops-bridge.c
@@ -44,7 +44,7 @@ static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
 				 int where, int size, u32 * value)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
-	bridge_t *bridge = bc->base;
+	struct bridge_regs *bridge = bc->base;
 	int slot = PCI_SLOT(devfn);
 	int fn = PCI_FUNC(devfn);
 	volatile void *addr;
@@ -56,11 +56,11 @@ static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
+	 * IOC3 is broken beyond belief ...  Don't even give the
 	 * generic PCI code a chance to look at it for real ...
 	 */
 	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
-		goto oh_my_gawd;
+		goto is_ioc3;
 
 	addr = &bridge->b_type0_cfg_dev[slot].f[fn].c[where ^ (4 - size)];
 
@@ -73,21 +73,16 @@ static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
 
 	return res ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
 
-oh_my_gawd:
+is_ioc3:
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
-	 * generic PCI code a chance to look at the wrong register.
+	 * IOC3 special handling
 	 */
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48)) {
 		*value = emulate_ioc3_cfg(where, size);
 		return PCIBIOS_SUCCESSFUL;
 	}
 
-	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
-	 * anything but 32-bit words ...
-	 */
 	addr = &bridge->b_type0_cfg_dev[slot].f[fn].l[where >> 2];
 
 	if (get_dbe(cf, (u32 *) addr))
@@ -104,7 +99,7 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
 				 int where, int size, u32 * value)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
-	bridge_t *bridge = bc->base;
+	struct bridge_regs *bridge = bc->base;
 	int busno = bus->number;
 	int slot = PCI_SLOT(devfn);
 	int fn = PCI_FUNC(devfn);
@@ -112,19 +107,19 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
 	u32 cf, shift, mask;
 	int res;
 
-	bridge->b_pci_cfg = (busno << 16) | (slot << 11);
+	bridge_write(bc, b_pci_cfg, (busno << 16) | (slot << 11));
 	addr = &bridge->b_type1_cfg.c[(fn << 8) | PCI_VENDOR_ID];
 	if (get_dbe(cf, (u32 *) addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
+	 * IOC3 is broken beyond belief ...  Don't even give the
 	 * generic PCI code a chance to look at it for real ...
 	 */
 	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
-		goto oh_my_gawd;
+		goto is_ioc3;
 
-	bridge->b_pci_cfg = (busno << 16) | (slot << 11);
+	bridge_write(bc, b_pci_cfg, (busno << 16) | (slot << 11));
 	addr = &bridge->b_type1_cfg.c[(fn << 8) | (where ^ (4 - size))];
 
 	if (size == 1)
@@ -136,22 +131,17 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
 
 	return res ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
 
-oh_my_gawd:
+is_ioc3:
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
-	 * generic PCI code a chance to look at the wrong register.
+	 * IOC3 special handling
 	 */
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48)) {
 		*value = emulate_ioc3_cfg(where, size);
 		return PCIBIOS_SUCCESSFUL;
 	}
 
-	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
-	 * anything but 32-bit words ...
-	 */
-	bridge->b_pci_cfg = (busno << 16) | (slot << 11);
+	bridge_write(bc, b_pci_cfg, (busno << 16) | (slot << 11));
 	addr = &bridge->b_type1_cfg.c[(fn << 8) | where];
 
 	if (get_dbe(cf, (u32 *) addr))
@@ -177,7 +167,7 @@ static int pci_conf0_write_config(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 value)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
-	bridge_t *bridge = bc->base;
+	struct bridge_regs *bridge = bc->base;
 	int slot = PCI_SLOT(devfn);
 	int fn = PCI_FUNC(devfn);
 	volatile void *addr;
@@ -189,11 +179,11 @@ static int pci_conf0_write_config(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
+	 * IOC3 is broken beyond belief ...  Don't even give the
 	 * generic PCI code a chance to look at it for real ...
 	 */
 	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
-		goto oh_my_gawd;
+		goto is_ioc3;
 
 	addr = &bridge->b_type0_cfg_dev[slot].f[fn].c[where ^ (4 - size)];
 
@@ -210,19 +200,14 @@ static int pci_conf0_write_config(struct pci_bus *bus, unsigned int devfn,
 
 	return PCIBIOS_SUCCESSFUL;
 
-oh_my_gawd:
+is_ioc3:
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
-	 * generic PCI code a chance to touch the wrong register.
+	 * IOC3 special handling
 	 */
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48))
 		return PCIBIOS_SUCCESSFUL;
 
-	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
-	 * anything but 32-bit words ...
-	 */
 	addr = &bridge->b_type0_cfg_dev[slot].f[fn].l[where >> 2];
 
 	if (get_dbe(cf, (u32 *) addr))
@@ -243,7 +228,7 @@ static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 value)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
-	bridge_t *bridge = bc->base;
+	struct bridge_regs *bridge = bc->base;
 	int slot = PCI_SLOT(devfn);
 	int fn = PCI_FUNC(devfn);
 	int busno = bus->number;
@@ -251,17 +236,17 @@ static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
 	u32 cf, shift, mask, smask;
 	int res;
 
-	bridge->b_pci_cfg = (busno << 16) | (slot << 11);
+	bridge_write(bc, b_pci_cfg, (busno << 16) | (slot << 11));
 	addr = &bridge->b_type1_cfg.c[(fn << 8) | PCI_VENDOR_ID];
 	if (get_dbe(cf, (u32 *) addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
+	 * IOC3 is broken beyond belief ...  Don't even give the
 	 * generic PCI code a chance to look at it for real ...
 	 */
 	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
-		goto oh_my_gawd;
+		goto is_ioc3;
 
 	addr = &bridge->b_type1_cfg.c[(fn << 8) | (where ^ (4 - size))];
 
@@ -278,19 +263,14 @@ static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
 
 	return PCIBIOS_SUCCESSFUL;
 
-oh_my_gawd:
+is_ioc3:
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
-	 * generic PCI code a chance to touch the wrong register.
+	 * IOC3 special handling
 	 */
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48))
 		return PCIBIOS_SUCCESSFUL;
 
-	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
-	 * anything but 32-bit words ...
-	 */
 	addr = &bridge->b_type0_cfg_dev[slot].f[fn].l[where >> 2];
 
 	if (get_dbe(cf, (u32 *) addr))
diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index c94a66070a60..7cf50290a6d9 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -47,7 +47,6 @@ int bridge_probe(nasid_t nasid, int widget_id, int masterwid)
 	unsigned long offset = NODE_OFFSET(nasid);
 	struct bridge_controller *bc;
 	static int num_bridges = 0;
-	bridge_t *bridge;
 	int slot;
 
 	pci_set_flags(PCI_PROBE_ONLY);
@@ -87,45 +86,43 @@ int bridge_probe(nasid_t nasid, int widget_id, int masterwid)
 	/*
 	 * point to this bridge
 	 */
-	bridge = (bridge_t *) RAW_NODE_SWIN_BASE(nasid, widget_id);
+	bc->base = (struct bridge_regs *)RAW_NODE_SWIN_BASE(nasid, widget_id);
 
 	/*
 	 * Clear all pending interrupts.
 	 */
-	bridge->b_int_rst_stat = BRIDGE_IRR_ALL_CLR;
+	bridge_write(bc, b_int_rst_stat, BRIDGE_IRR_ALL_CLR);
 
 	/*
 	 * Until otherwise set up, assume all interrupts are from slot 0
 	 */
-	bridge->b_int_device = 0x0;
+	bridge_write(bc, b_int_device, 0x0);
 
 	/*
 	 * swap pio's to pci mem and io space (big windows)
 	 */
-	bridge->b_wid_control |= BRIDGE_CTRL_IO_SWAP |
-				 BRIDGE_CTRL_MEM_SWAP;
+	bridge_set(bc, b_wid_control, BRIDGE_CTRL_IO_SWAP |
+				      BRIDGE_CTRL_MEM_SWAP);
 #ifdef CONFIG_PAGE_SIZE_4KB
-	bridge->b_wid_control &= ~BRIDGE_CTRL_PAGE_SIZE;
+	bridge_clr(bc, b_wid_control, BRIDGE_CTRL_PAGE_SIZE);
 #else /* 16kB or larger */
-	bridge->b_wid_control |= BRIDGE_CTRL_PAGE_SIZE;
+	bridge_set(bc, b_wid_control, BRIDGE_CTRL_PAGE_SIZE);
 #endif
 
 	/*
 	 * Hmm...  IRIX sets additional bits in the address which
 	 * are documented as reserved in the bridge docs.
 	 */
-	bridge->b_wid_int_upper = 0x8000 | (masterwid << 16);
-	bridge->b_wid_int_lower = 0x01800090;	/* PI_INT_PEND_MOD off*/
-	bridge->b_dir_map = (masterwid << 20);	/* DMA */
-	bridge->b_int_enable = 0;
+	bridge_write(bc, b_wid_int_upper, 0x8000 | (masterwid << 16));
+	bridge_write(bc, b_wid_int_lower, 0x01800090); /* PI_INT_PEND_MOD off*/
+	bridge_write(bc, b_dir_map, (masterwid << 20));	/* DMA */
+	bridge_write(bc, b_int_enable, 0);
 
 	for (slot = 0; slot < 8; slot ++) {
-		bridge->b_device[slot].reg |= BRIDGE_DEV_SWAP_DIR;
+		bridge_set(bc, b_device[slot].reg, BRIDGE_DEV_SWAP_DIR);
 		bc->pci_int[slot] = -1;
 	}
-	bridge->b_wid_tflush;	  /* wait until Bridge PIO complete */
-
-	bc->base = bridge;
+	bridge_read(bc, b_wid_tflush);	  /* wait until Bridge PIO complete */
 
 	register_pci_controller(&bc->pc);
 
@@ -206,7 +203,7 @@ phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
 static inline void pci_disable_swapping(struct pci_dev *dev)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(dev->bus);
-	bridge_t *bridge = bc->base;
+	struct bridge_regs *bridge = bc->base;
 	int slot = PCI_SLOT(dev->devfn);
 
 	/* Turn off byte swapping */
diff --git a/arch/mips/sgi-ip27/ip27-irq-pci.c b/arch/mips/sgi-ip27/ip27-irq-pci.c
index cd449e90b917..a00a23b32a2a 100644
--- a/arch/mips/sgi-ip27/ip27-irq-pci.c
+++ b/arch/mips/sgi-ip27/ip27-irq-pci.c
@@ -136,14 +136,12 @@ static int intr_disconnect_level(int cpu, int bit)
 static unsigned int startup_bridge_irq(struct irq_data *d)
 {
 	struct bridge_controller *bc;
-	bridgereg_t device;
-	bridge_t *bridge;
 	int pin, swlevel;
 	cpuid_t cpu;
+	u64 device;
 
 	pin = SLOT_FROM_PCI_IRQ(d->irq);
 	bc = IRQ_TO_BRIDGE(d->irq);
-	bridge = bc->base;
 
 	pr_debug("bridge_startup(): irq= 0x%x  pin=%d\n", d->irq, pin);
 	/*
@@ -151,9 +149,10 @@ static unsigned int startup_bridge_irq(struct irq_data *d)
 	 * of INT_PEND0 are taken
 	 */
 	swlevel = find_level(&cpu, d->irq);
-	bridge->b_int_addr[pin].addr = (0x20000 | swlevel | (bc->nasid << 8));
-	bridge->b_int_enable |= (1 << pin);
-	bridge->b_int_enable |= 0x7ffffe00;	/* more stuff in int_enable */
+	bridge_write(bc, b_int_addr[pin].addr,
+		     (0x20000 | swlevel | (bc->nasid << 8)));
+	bridge_set(bc, b_int_enable, (1 << pin));
+	bridge_set(bc, b_int_enable, 0x7ffffe00); /* more stuff in int_enable */
 
 	/*
 	 * Enable sending of an interrupt clear packt to the hub on a high to
@@ -162,18 +161,18 @@ static unsigned int startup_bridge_irq(struct irq_data *d)
 	 * IRIX sets additional bits in the address which are documented as
 	 * reserved in the bridge docs.
 	 */
-	bridge->b_int_mode |= (1UL << pin);
+	bridge_set(bc, b_int_mode, (1UL << pin));
 
 	/*
 	 * We assume the bridge to have a 1:1 mapping between devices
 	 * (slots) and intr pins.
 	 */
-	device = bridge->b_int_device;
+	device = bridge_read(bc, b_int_device);
 	device &= ~(7 << (pin*3));
 	device |= (pin << (pin*3));
-	bridge->b_int_device = device;
+	bridge_write(bc, b_int_device, device);
 
-	bridge->b_wid_tflush;
+	bridge_read(bc, b_wid_tflush);
 
 	intr_connect_level(cpu, swlevel);
 
@@ -184,7 +183,6 @@ static unsigned int startup_bridge_irq(struct irq_data *d)
 static void shutdown_bridge_irq(struct irq_data *d)
 {
 	struct bridge_controller *bc = IRQ_TO_BRIDGE(d->irq);
-	bridge_t *bridge = bc->base;
 	int pin, swlevel;
 	cpuid_t cpu;
 
@@ -198,8 +196,8 @@ static void shutdown_bridge_irq(struct irq_data *d)
 	swlevel = find_level(&cpu, d->irq);
 	intr_disconnect_level(cpu, swlevel);
 
-	bridge->b_int_enable &= ~(1 << pin);
-	bridge->b_wid_tflush;
+	bridge_clr(bc, b_int_enable, (1 << pin));
+	bridge_read(bc, b_wid_tflush);
 }
 
 static inline void enable_bridge_irq(struct irq_data *d)
-- 
2.13.7

