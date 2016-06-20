Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/3] vmd: Use lock save/restore in interrupt enable path
Date: Mon, 20 Jun 2016 09:39:51 -0600
Message-Id: <1466437193-17043-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1466437193-17043-1-git-send-email-jonathan.derrick@intel.com>
References: <1466437193-17043-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Enabling interrupts may result in an interrupt raised and serviced while
VMD holds a lock, resulting in contention with the spin lock held while
enabling interrupts.

The solution is to disable preemption and save/restore the state during
interrupt enable and disable.

Fixes lockdep:

[   52.340274] ======================================================
[   52.347381] [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
[   52.355129] 4.6.0-2016-06-16-lockdep+ #47 Tainted: G            E
[   52.362334] ------------------------------------------------------
[   52.369443] kworker/0:1/447 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[   52.377245]  (list_lock){+.+...}, at: [<ffffffffa04eb8fc>] vmd_irq_enable+0x3c/0x70 [vmd]
[   52.386736]
[   52.386736] and this task is already holding:
[   52.393427]  (&irq_desc_lock_class){-.-...}, at: [<ffffffff810e1ff6>] __setup_irq+0xa6/0x610
[   52.403204] which would create a new lock dependency:
[   52.409004]  (&irq_desc_lock_class){-.-...} -> (list_lock){+.+...}
[   52.416265]
[   52.416265] but this new dependency connects a HARDIRQ-irq-safe lock:
[   52.425328]  (&irq_desc_lock_class){-.-...}
... which became HARDIRQ-irq-safe at:
[   52.434084]   [<ffffffff810c9f21>] __lock_acquire+0x981/0xe00
[   52.440702]   [<ffffffff810cb039>] lock_acquire+0x119/0x220
[   52.447109]   [<ffffffff8167294d>] _raw_spin_lock+0x3d/0x80
[   52.453519]   [<ffffffff810e36d4>] handle_level_irq+0x24/0x110
[   52.460232]   [<ffffffff8101f20a>] handle_irq+0x1a/0x30
[   52.466248]   [<ffffffff81675fc1>] do_IRQ+0x61/0x120
[   52.471966]   [<ffffffff8167404c>] ret_from_intr+0x0/0x20
[   52.478180]   [<ffffffff81672e30>] _raw_spin_unlock_irqrestore+0x40/0x60
[   52.485893]   [<ffffffff810e21ee>] __setup_irq+0x29e/0x610
[   52.492210]   [<ffffffff810e25a1>] setup_irq+0x41/0x90
[   52.498133]   [<ffffffff81f5777f>] setup_default_timer_irq+0x1e/0x20
[   52.505450]   [<ffffffff81f57798>] hpet_time_init+0x17/0x19
[   52.511870]   [<ffffffff81f5775a>] x86_late_time_init+0xa/0x11
[   52.518587]   [<ffffffff81f51e9b>] start_kernel+0x382/0x436
[   52.525006]   [<ffffffff81f51308>] x86_64_start_reservations+0x2a/0x2c
[   52.532548]   [<ffffffff81f51445>] x86_64_start_kernel+0x13b/0x14a
[   52.539669]
[   52.539669] to a HARDIRQ-irq-unsafe lock:
[   52.545955]  (list_lock){+.+...}
... which became HARDIRQ-irq-unsafe at:
[   52.553801] ...  [<ffffffff810c9d8e>] __lock_acquire+0x7ee/0xe00
[   52.560732]   [<ffffffff810cb039>] lock_acquire+0x119/0x220
[   52.567147]   [<ffffffff8167294d>] _raw_spin_lock+0x3d/0x80
[   52.573556]   [<ffffffffa04eba42>] vmd_msi_init+0x72/0x150 [vmd]
[   52.580465]   [<ffffffff810e8597>] msi_domain_alloc+0xb7/0x140
[   52.587182]   [<ffffffff810e6b10>] irq_domain_alloc_irqs_recursive+0x40/0xa0
[   52.595295]   [<ffffffff810e6cea>] __irq_domain_alloc_irqs+0x14a/0x330
[   52.602815]   [<ffffffff810e8a8c>] msi_domain_alloc_irqs+0x8c/0x1d0
[   52.616372]   [<ffffffff813ca4e3>] pci_msi_setup_msi_irqs+0x43/0x70
[   52.629967]   [<ffffffff813cada1>] pci_enable_msi_range+0x131/0x280
[   52.643533]   [<ffffffff813bf5e0>] pcie_port_device_register+0x320/0x4e0
[   52.657800]   [<ffffffff813bf9a4>] pcie_portdrv_probe+0x34/0x60
[   52.670985]   [<ffffffff813b0e85>] local_pci_probe+0x45/0xa0
[   52.683782]   [<ffffffff813b226b>] pci_device_probe+0xdb/0x130
[   52.696720]   [<ffffffff8149e3cc>] driver_probe_device+0x22c/0x440
[   52.710053]   [<ffffffff8149e774>] __device_attach_driver+0x94/0x110
[   52.723578]   [<ffffffff8149bfad>] bus_for_each_drv+0x5d/0x90
[   52.736258]   [<ffffffff8149e030>] __device_attach+0xc0/0x140
[   52.748793]   [<ffffffff8149e0c0>] device_attach+0x10/0x20
[   52.760936]   [<ffffffff813a77f7>] pci_bus_add_device+0x47/0x90
[   52.773563]   [<ffffffff813a7879>] pci_bus_add_devices+0x39/0x70
[   52.786176]   [<ffffffff813aaba7>] pci_rescan_bus+0x27/0x30
[   52.798099]   [<ffffffffa04ec1af>] vmd_probe+0x68f/0x76c [vmd]
[   52.810302]   [<ffffffff813b0e85>] local_pci_probe+0x45/0xa0
[   52.822584]   [<ffffffff81088064>] work_for_cpu_fn+0x14/0x20
[   52.834688]   [<ffffffff8108c244>] process_one_work+0x1f4/0x740
[   52.846834]   [<ffffffff8108c9c6>] worker_thread+0x236/0x4f0
[   52.858896]   [<ffffffff810935c2>] kthread+0xf2/0x110
[   52.869910]   [<ffffffff816738f2>] ret_from_fork+0x22/0x50
[   52.881391]
[   52.881391] other info that might help us debug this:
[   52.881391]
[   52.906283]  Possible interrupt unsafe locking scenario:
[   52.906283]
[   52.924922]        CPU0                    CPU1
[   52.935372]        ----                    ----
[   52.945702]   lock(list_lock);
[   52.954329]                                local_irq_disable();
[   52.966240]                                lock(&irq_desc_lock_class);
[   52.978859]                                lock(list_lock);
[   52.990325]   <Interrupt>
[   52.998369]     lock(&irq_desc_lock_class);
[   53.008269]
[   53.008269]  *** DEADLOCK ***

Acked-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/vmd.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index 2c82b19..bd81393 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -119,10 +119,11 @@ static void vmd_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 static void vmd_irq_enable(struct irq_data *data)
 {
 	struct vmd_irq *vmdirq = data->chip_data;
+	unsigned long flags;
 
-	raw_spin_lock(&list_lock);
+	raw_spin_lock_irqsave(&list_lock, flags);
 	list_add_tail_rcu(&vmdirq->node, &vmdirq->irq->irq_list);
-	raw_spin_unlock(&list_lock);
+	raw_spin_unlock_irqrestore(&list_lock, flags);
 
 	data->chip->irq_unmask(data);
 }
@@ -130,13 +131,14 @@ static void vmd_irq_enable(struct irq_data *data)
 static void vmd_irq_disable(struct irq_data *data)
 {
 	struct vmd_irq *vmdirq = data->chip_data;
+	unsigned long flags;
 
 	data->chip->irq_mask(data);
 
-	raw_spin_lock(&list_lock);
+	raw_spin_lock_irqsave(&list_lock, flags);
 	list_del_rcu(&vmdirq->node);
 	INIT_LIST_HEAD_RCU(&vmdirq->node);
-	raw_spin_unlock(&list_lock);
+	raw_spin_unlock_irqrestore(&list_lock, flags);
 }
 
 /*
@@ -170,13 +172,14 @@ static irq_hw_number_t vmd_get_hwirq(struct msi_domain_info *info,
 static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd)
 {
 	int i, best = 0;
+	unsigned long flags;
 
-	raw_spin_lock(&list_lock);
+	raw_spin_lock_irqsave(&list_lock, flags);
 	for (i = 1; i < vmd->msix_count; i++)
 		if (vmd->irqs[i].count < vmd->irqs[best].count)
 			best = i;
 	vmd->irqs[best].count++;
-	raw_spin_unlock(&list_lock);
+	raw_spin_unlock_irqrestore(&list_lock, flags);
 
 	return &vmd->irqs[best];
 }
@@ -204,11 +207,12 @@ static void vmd_msi_free(struct irq_domain *domain,
 			struct msi_domain_info *info, unsigned int virq)
 {
 	struct vmd_irq *vmdirq = irq_get_chip_data(virq);
+	unsigned long flags;
 
 	/* XXX: Potential optimization to rebalance */
-	raw_spin_lock(&list_lock);
+	raw_spin_lock_irqsave(&list_lock, flags);
 	vmdirq->irq->count--;
-	raw_spin_unlock(&list_lock);
+	raw_spin_unlock_irqrestore(&list_lock, flags);
 
 	kfree_rcu(vmdirq, rcu);
 }
-- 
1.8.3.1
