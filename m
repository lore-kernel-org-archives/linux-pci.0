Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6B0C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 17:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7AA218A6
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 17:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfAXRsH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:48:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:51320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728408AbfAXRrt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 12:47:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31866B0D9;
        Thu, 24 Jan 2019 17:47:45 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/7] MIPS: SGI-IP27: get rid of volatile and hubreg_t
Date:   Thu, 24 Jan 2019 18:47:22 +0100
Message-Id: <20190124174728.28812-2-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190124174728.28812-1-tbogendoerfer@suse.de>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace hub register access with __raw_readq/__raw_writeq and get
rid of hubreg_t completely. Also remove no longer (probably never)
used defines

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/include/asm/sn/addrs.h | 63 +++-------------------------------------
 arch/mips/include/asm/sn/arch.h  |  2 --
 arch/mips/sgi-ip27/ip27-hubio.c  |  2 +-
 arch/mips/sgi-ip27/ip27-init.c   |  2 +-
 arch/mips/sgi-ip27/ip27-irq.c    |  4 +--
 arch/mips/sgi-ip27/ip27-memory.c |  6 ++--
 arch/mips/sgi-ip27/ip27-nmi.c    |  2 +-
 7 files changed, 12 insertions(+), 69 deletions(-)

diff --git a/arch/mips/include/asm/sn/addrs.h b/arch/mips/include/asm/sn/addrs.h
index 66814f8ba8e8..3eb81e30a568 100644
--- a/arch/mips/include/asm/sn/addrs.h
+++ b/arch/mips/include/asm/sn/addrs.h
@@ -27,16 +27,11 @@
 
 #ifndef __ASSEMBLY__
 
-#define PS_UINT_CAST		(unsigned long)
 #define UINT64_CAST		(unsigned long)
 
-#define HUBREG_CAST		(volatile hubreg_t *)
-
 #else /* __ASSEMBLY__ */
 
-#define PS_UINT_CAST
 #define UINT64_CAST
-#define HUBREG_CAST
 
 #endif /* __ASSEMBLY__ */
 
@@ -256,42 +251,22 @@
  *	Otherwise, the recommended approach is to use *_HUB_L() and *_HUB_S().
  *	They're always safe.
  */
-#define LOCAL_HUB_ADDR(_x)	(HUBREG_CAST (IALIAS_BASE + (_x)))
-#define REMOTE_HUB_ADDR(_n, _x) (HUBREG_CAST (NODE_SWIN_BASE(_n, 1) +	\
-					      0x800000 + (_x)))
-#ifdef CONFIG_SGI_IP27
-#define REMOTE_HUB_PI_ADDR(_n, _sn, _x) (HUBREG_CAST (NODE_SWIN_BASE(_n, 1) +	\
-					      0x800000 + (_x)))
-#endif /* CONFIG_SGI_IP27 */
+#define LOCAL_HUB_ADDR(_x)	(IALIAS_BASE + (_x))
+#define REMOTE_HUB_ADDR(_n, _x) ((NODE_SWIN_BASE(_n, 1) + 0x800000 + (_x)))
 
 #ifndef __ASSEMBLY__
 
-#define HUB_L(_a)			*(_a)
-#define HUB_S(_a, _d)			*(_a) = (_d)
+#define HUB_L(_a)			__raw_readq((u64 *)(_a))
+#define HUB_S(_a, _d)			__raw_writeq((_d), (u64 *)(_a))
 
 #define LOCAL_HUB_L(_r)			HUB_L(LOCAL_HUB_ADDR(_r))
 #define LOCAL_HUB_S(_r, _d)		HUB_S(LOCAL_HUB_ADDR(_r), (_d))
 #define REMOTE_HUB_L(_n, _r)		HUB_L(REMOTE_HUB_ADDR((_n), (_r)))
 #define REMOTE_HUB_S(_n, _r, _d)	HUB_S(REMOTE_HUB_ADDR((_n), (_r)), (_d))
-#define REMOTE_HUB_PI_L(_n, _sn, _r)	HUB_L(REMOTE_HUB_PI_ADDR((_n), (_sn), (_r)))
-#define REMOTE_HUB_PI_S(_n, _sn, _r, _d) HUB_S(REMOTE_HUB_PI_ADDR((_n), (_sn), (_r)), (_d))
 
 #endif /* !__ASSEMBLY__ */
 
 /*
- * The following macros are used to get to a hub/bridge register, given
- * the base of the register space.
- */
-#define HUB_REG_PTR(_base, _off)	\
-	(HUBREG_CAST((__psunsigned_t)(_base) + (__psunsigned_t)(_off)))
-
-#define HUB_REG_PTR_L(_base, _off)	\
-	HUB_L(HUB_REG_PTR((_base), (_off)))
-
-#define HUB_REG_PTR_S(_base, _off, _data)	\
-	HUB_S(HUB_REG_PTR((_base), (_off)), (_data))
-
-/*
  * Software structure locations -- permanently fixed
  *    See diagram in kldir.h
  */
@@ -387,44 +362,14 @@
 
 #define SYMMON_STK_END(nasid)	(SYMMON_STK_ADDR(nasid, 0) + KLD_SYMMON_STK(nasid)->size)
 
-/* loading symmon 4k below UNIX. the arcs loader needs the topaddr for a
- * relocatable program
- */
-#define UNIX_DEBUG_LOADADDR	0x300000
-#define SYMMON_LOADADDR(nasid)						\
-	TO_NODE(nasid, PHYS_TO_K0(UNIX_DEBUG_LOADADDR - 0x1000))
-
-#define FREEMEM_OFFSET(nasid)	KLD_FREEMEM(nasid)->offset
-#define FREEMEM_ADDR(nasid)	SYMMON_STK_END(nasid)
-/*
- * XXX
- * Fix this. FREEMEM_ADDR should be aware of if symmon is loaded.
- * Also, it should take into account what prom thinks to be a safe
- * address
-	PHYS_TO_K0(NODE_OFFSET(nasid) + FREEMEM_OFFSET(nasid))
- */
-#define FREEMEM_SIZE(nasid)	KLD_FREEMEM(nasid)->size
-
-#define PI_ERROR_OFFSET(nasid)	KLD_PI_ERROR(nasid)->offset
-#define PI_ERROR_ADDR(nasid)						\
-	TO_NODE_UNCAC((nasid), PI_ERROR_OFFSET(nasid))
-#define PI_ERROR_SIZE(nasid)	KLD_PI_ERROR(nasid)->size
-
 #define NODE_OFFSET_TO_K0(_nasid, _off)					\
 	PHYS_TO_K0((NODE_OFFSET(_nasid) + (_off)) | CAC_BASE)
 #define NODE_OFFSET_TO_K1(_nasid, _off)					\
 	TO_UNCAC((NODE_OFFSET(_nasid) + (_off)) | UNCAC_BASE)
-#define K0_TO_NODE_OFFSET(_k0addr)					\
-	((__psunsigned_t)(_k0addr) & NODE_ADDRSPACE_MASK)
 
 #define KERN_VARS_ADDR(nasid)	KLD_KERN_VARS(nasid)->pointer
 #define KERN_VARS_SIZE(nasid)	KLD_KERN_VARS(nasid)->size
 
-#define KERN_XP_ADDR(nasid)	KLD_KERN_XP(nasid)->pointer
-#define KERN_XP_SIZE(nasid)	KLD_KERN_XP(nasid)->size
-
-#define GPDA_ADDR(nasid)	TO_NODE_CAC(nasid, GPDA_OFFSET)
-
 #endif /* !__ASSEMBLY__ */
 
 
diff --git a/arch/mips/include/asm/sn/arch.h b/arch/mips/include/asm/sn/arch.h
index 471e6870d876..3f1fb1454749 100644
--- a/arch/mips/include/asm/sn/arch.h
+++ b/arch/mips/include/asm/sn/arch.h
@@ -17,8 +17,6 @@
 #include <asm/sn/sn0/arch.h>
 #endif
 
-typedef u64	hubreg_t;
-
 #define cputonasid(cpu)		(sn_cpu_info[(cpu)].p_nasid)
 #define cputoslice(cpu)		(sn_cpu_info[(cpu)].p_slice)
 #define makespnum(_nasid, _slice)					\
diff --git a/arch/mips/sgi-ip27/ip27-hubio.c b/arch/mips/sgi-ip27/ip27-hubio.c
index 2abe016a0ffc..9b4fd7773423 100644
--- a/arch/mips/sgi-ip27/ip27-hubio.c
+++ b/arch/mips/sgi-ip27/ip27-hubio.c
@@ -135,7 +135,7 @@ static void hub_setup_prb(nasid_t nasid, int prbnum, int credits)
  **/
 static void hub_set_piomode(nasid_t nasid)
 {
-	hubreg_t ii_iowa;
+	u64 ii_iowa;
 	hubii_wcr_t ii_wcr;
 	unsigned i;
 
diff --git a/arch/mips/sgi-ip27/ip27-init.c b/arch/mips/sgi-ip27/ip27-init.c
index e501c43c02db..83399e578b61 100644
--- a/arch/mips/sgi-ip27/ip27-init.c
+++ b/arch/mips/sgi-ip27/ip27-init.c
@@ -177,7 +177,7 @@ extern void ip27_reboot_setup(void);
 
 void __init plat_mem_setup(void)
 {
-	hubreg_t p, e, n_mode;
+	u64 p, e, n_mode;
 	nasid_t nid;
 
 	ip27_reboot_setup();
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 0dde6164a06f..f37155ef7ed9 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -85,7 +85,7 @@ static int ms1bit(unsigned long x)
 static void ip27_do_irq_mask0(void)
 {
 	int irq, swlevel;
-	hubreg_t pend0, mask0;
+	u64 pend0, mask0;
 	cpuid_t cpu = smp_processor_id();
 	int pi_int_mask0 =
 		(cputoslice(cpu) == 0) ?  PI_INT_MASK0_A : PI_INT_MASK0_B;
@@ -132,7 +132,7 @@ static void ip27_do_irq_mask0(void)
 static void ip27_do_irq_mask1(void)
 {
 	int irq, swlevel;
-	hubreg_t pend1, mask1;
+	u64 pend1, mask1;
 	cpuid_t cpu = smp_processor_id();
 	int pi_int_mask1 = (cputoslice(cpu) == 0) ?  PI_INT_MASK1_A : PI_INT_MASK1_B;
 	struct slice_data *si = cpu_data[cpu].data;
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 813d13f92957..87ef4181934e 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -44,7 +44,7 @@ static int is_fine_dirmode(void)
 	return ((LOCAL_HUB_L(NI_STATUS_REV_ID) & NSRI_REGIONSIZE_MASK) >> NSRI_REGIONSIZE_SHFT) & REGIONSIZE_FINE;
 }
 
-static hubreg_t get_region(cnodeid_t cnode)
+static u64 get_region(cnodeid_t cnode)
 {
 	if (fine_mode)
 		return COMPACT_TO_NASID_NODEID(cnode) >> NASID_TO_FINEREG_SHFT;
@@ -52,9 +52,9 @@ static hubreg_t get_region(cnodeid_t cnode)
 		return COMPACT_TO_NASID_NODEID(cnode) >> NASID_TO_COARSEREG_SHFT;
 }
 
-static hubreg_t region_mask;
+static u64 region_mask;
 
-static void gen_region_mask(hubreg_t *region_mask)
+static void gen_region_mask(u64 *region_mask)
 {
 	cnodeid_t cnode;
 
diff --git a/arch/mips/sgi-ip27/ip27-nmi.c b/arch/mips/sgi-ip27/ip27-nmi.c
index 8ac2bfa35fb6..8cb3a5d6d7d1 100644
--- a/arch/mips/sgi-ip27/ip27-nmi.c
+++ b/arch/mips/sgi-ip27/ip27-nmi.c
@@ -130,7 +130,7 @@ void nmi_cpu_eframe_save(nasid_t nasid, int slice)
 
 void nmi_dump_hub_irq(nasid_t nasid, int slice)
 {
-	hubreg_t mask0, mask1, pend0, pend1;
+	u64 mask0, mask1, pend0, pend1;
 
 	if (slice == 0) {				/* Slice A */
 		mask0 = REMOTE_HUB_L(nasid, PI_INT_MASK0_A);
-- 
2.13.7

