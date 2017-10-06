Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60838 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752120AbdJFN33 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Oct 2017 09:29:29 -0400
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        gabriele.paoloni@huawei.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com
Subject: [RFCv2 PATCH 19/36] arm64: mm: Pin down ASIDs for sharing contexts with devices
Date: Fri,  6 Oct 2017 14:31:46 +0100
Message-Id: <20171006133203.22803-20-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In order to enable address space sharing with the IOMMU, we introduce
functions mm_context_get and mm_context_put, that pin down a context and
ensure that its ASID won't be modified willy-nilly after a rollover.

Pinning is necessary because, once a device is using an ASID, it needs a
valid and unique one at all times, whether the associated task is running
or not.

Without pinning, we would need to notify the IOMMU when we're about to use
a new ASID for a task. Things would get messy when a new task is assigned
a shared ASID. Consider the following scenario:

1. Task t1 is running on CPUx with shared ASID (1, 1)
2. Task t2 is scheduled on CPUx, gets ASID (1, 2)
3. Task tn is scheduled on CPUy, a rollover occurs, tn gets ASID (2, 1)
   We would now have to immediately generate a new ASID for t1, notify
   the IOMMU, and finally enable task tn. We are holding the lock during
   all that time, since we can't afford having another CPU trigger a
   rollover.

It gets needlessly complicated, and all we wanted to do was schedule poor
task tn, that has no business with the IOMMU. By letting the IOMMU pin
tasks when needed, we avoid stalling the slow path, and let the pinning
fail when we're out of potential ASIDs.

After a rollover, we assume that there is at least one more ASID than
number of CPUs. So we can use (NR_ASIDS - NR_CPUS - 1) as a hard limit for
the number of ASIDs we can afford to share with the IOMMU.

Since multiple IOMMUs could pin the same context, we need to keep track of
the number of references. Add a refcount value in mm_context_t for this
purpose.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 arch/arm64/include/asm/mmu.h         |  1 +
 arch/arm64/include/asm/mmu_context.h | 11 ++++-
 arch/arm64/mm/context.c              | 80 +++++++++++++++++++++++++++++++++++-
 3 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 0d34bf0a89c7..3e687fc49825 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -20,6 +20,7 @@
 
 typedef struct {
 	atomic64_t	id;
+	unsigned long	refcount;
 	void		*vdso;
 	unsigned long	flags;
 } mm_context_t;
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 3257895a9b5e..52c2f8e04a18 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -154,7 +154,13 @@ static inline void cpu_replace_ttbr1(pgd_t *pgd)
 #define destroy_context(mm)		do { } while(0)
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
 
-#define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); 0; })
+static inline int
+init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	atomic64_set(&mm->context.id, 0);
+	mm->context.refcount = 0;
+	return 0;
+}
 
 /*
  * This is called when "tsk" is about to enter lazy TLB mode.
@@ -226,6 +232,9 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 void verify_cpu_asid_bits(void);
 
+unsigned long mm_context_get(struct mm_struct *mm);
+void mm_context_put(struct mm_struct *mm);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* !__ASM_MMU_CONTEXT_H */
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index ab9f5f0fb2c7..a15c90083a57 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -37,6 +37,10 @@ static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
 static cpumask_t tlb_flush_pending;
 
+static unsigned long max_pinned_asids;
+static unsigned long nr_pinned_asids;
+static unsigned long *pinned_asid_map;
+
 #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
 #define ASID_FIRST_VERSION	(1UL << asid_bits)
 #define NUM_USER_ASIDS		ASID_FIRST_VERSION
@@ -92,7 +96,7 @@ static void flush_context(unsigned int cpu)
 	u64 asid;
 
 	/* Update the list of reserved ASIDs and the ASID bitmap. */
-	bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
+	bitmap_copy(asid_map, pinned_asid_map, NUM_USER_ASIDS);
 
 	set_reserved_asid_bits();
 
@@ -154,6 +158,10 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 	if (asid != 0) {
 		u64 newasid = generation | (asid & ~ASID_MASK);
 
+		/* That ASID is pinned for us, we're good to go. */
+		if (mm->context.refcount)
+			return newasid;
+
 		/*
 		 * If our current ASID was active during a rollover, we
 		 * can continue to use it and this was just a false alarm.
@@ -235,6 +243,63 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 		cpu_switch_mm(mm->pgd, mm);
 }
 
+unsigned long mm_context_get(struct mm_struct *mm)
+{
+	unsigned long flags;
+	u64 asid;
+
+	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+
+	asid = atomic64_read(&mm->context.id);
+
+	if (mm->context.refcount) {
+		mm->context.refcount++;
+		asid &= ~ASID_MASK;
+		goto out_unlock;
+	}
+
+	if (nr_pinned_asids >= max_pinned_asids) {
+		asid = 0;
+		goto out_unlock;
+	}
+
+	if (((asid ^ atomic64_read(&asid_generation)) >> asid_bits)) {
+		/*
+		 * We went through one or more rollover since that ASID was
+		 * used. Ensure that it is still valid, or generate a new one.
+		 * The cpu argument isn't used by new_context.
+		 */
+		asid = new_context(mm, 0);
+		atomic64_set(&mm->context.id, asid);
+	}
+
+	asid &= ~ASID_MASK;
+
+	nr_pinned_asids++;
+	__set_bit(asid, pinned_asid_map);
+	mm->context.refcount++;
+
+out_unlock:
+	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+
+	return asid;
+}
+
+void mm_context_put(struct mm_struct *mm)
+{
+	unsigned long flags;
+	u64 asid = atomic64_read(&mm->context.id) & ~ASID_MASK;
+
+	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+
+	if (--mm->context.refcount == 0) {
+		__clear_bit(asid, pinned_asid_map);
+		nr_pinned_asids--;
+	}
+
+	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+}
+
 static int asids_init(void)
 {
 	asid_bits = get_cpu_asid_bits();
@@ -252,6 +317,19 @@ static int asids_init(void)
 
 	set_reserved_asid_bits();
 
+	pinned_asid_map = kzalloc(BITS_TO_LONGS(NUM_USER_ASIDS)
+				  * sizeof(*pinned_asid_map), GFP_KERNEL);
+	if (!pinned_asid_map)
+		panic("Failed to allocate pinned bitmap\n");
+
+	/*
+	 * We assume that an ASID is always available after a rollback. This
+	 * means that even if all CPUs have a reserved ASID, there still is at
+	 * least one slot available in the asid_bitmap.
+	 */
+	max_pinned_asids = NUM_USER_ASIDS - num_possible_cpus() - 2;
+	nr_pinned_asids = 0;
+
 	pr_info("ASID allocator initialised with %lu entries\n", NUM_USER_ASIDS);
 	return 0;
 }
-- 
2.13.3
