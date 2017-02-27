Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: 
Subject: [RFC PATCH 11/30] arm64: mm: Pin down ASIDs for sharing contexts with
 devices
Date: Mon, 27 Feb 2017 19:54:22 +0000
Message-Id: <20170227195441.5170-12-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Harv Abdulhamid <harba@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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
index 47619411f0ff..e18a6dfcf745 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -18,6 +18,7 @@
 
 typedef struct {
 	atomic64_t	id;
+	unsigned long	refcount;
 	void		*vdso;
 	unsigned long	flags;
 } mm_context_t;
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 1ef40d82cfd3..ce4216e09e13 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -152,7 +152,13 @@ static inline void cpu_replace_ttbr1(pgd_t *pgd)
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
@@ -224,6 +230,9 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 void verify_cpu_asid_bits(void);
 
+unsigned long mm_context_get(struct mm_struct *mm);
+void mm_context_put(struct mm_struct *mm);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* !__ASM_MMU_CONTEXT_H */
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 68634c630cdd..b8ddd46bedb6 100644
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
 
@@ -157,6 +161,10 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 	if (asid != 0) {
 		u64 newasid = generation | (asid & ~ASID_MASK);
 
+		/* That ASID is pinned for us, we're good to go. */
+		if (mm->context.refcount)
+			return newasid;
+
 		/*
 		 * If our current ASID was active during a rollover, we
 		 * can continue to use it and this was just a false alarm.
@@ -238,6 +246,63 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
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
@@ -255,6 +320,19 @@ static int asids_init(void)
 
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
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
