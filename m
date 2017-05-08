Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57775 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751872AbdEHGMy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 May 2017 02:12:54 -0400
From: Juergen Gross <jgross@suse.com>
To: stable@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Anthony Liguori <aliguori@amazon.com>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [stable-4.11: PATCH] xen: revert commits 72a9b186292 and da72ff5bfcb0
Date: Mon,  8 May 2017 08:12:47 +0200
Message-Id: <20170508061247.19339-1-jgross@suse.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Revert commit 72a9b186292 ("xen: Remove event channel notification
through Xen PCI platform device") as the original analysis was wrong
that all the removed code isn't in use any more. As commit da72ff5bfcb0
("partially revert xen: Remove event channel notification through Xen
PCI platform device") reverted already some parts of it revert this
commit, too.

It is still necessary for old Xen versions (< 4.0) and for being able
to run the Linux kernel as dom0 in a nested Xen environment.

This is a backport of upstream commit 84d582d236dc1f9085e741affc72e9ba061a67c2

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Julien Grall <julien.grall@arm.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: xen-devel@lists.xenproject.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: Anthony Liguori <aliguori@amazon.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
Please apply to stable-4.11.y
---
 arch/x86/include/asm/xen/events.h | 11 +++++++++++
 arch/x86/pci/xen.c                |  2 +-
 arch/x86/xen/enlighten.c          | 16 +++++++++++-----
 arch/x86/xen/smp.c                |  2 ++
 arch/x86/xen/time.c               |  5 +++++
 drivers/xen/events/events_base.c  | 26 +++++++++++++++++---------
 drivers/xen/platform-pci.c        | 13 +++----------
 7 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/xen/events.h b/arch/x86/include/asm/xen/events.h
index 608a79d5a466..e6911caf5bbf 100644
--- a/arch/x86/include/asm/xen/events.h
+++ b/arch/x86/include/asm/xen/events.h
@@ -20,4 +20,15 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
 /* No need for a barrier -- XCHG is a barrier on x86. */
 #define xchg_xen_ulong(ptr, val) xchg((ptr), (val))
 
+extern int xen_have_vector_callback;
+
+/*
+ * Events delivered via platform PCI interrupts are always
+ * routed to vcpu 0 and hence cannot be rebound.
+ */
+static inline bool xen_support_evtchn_rebind(void)
+{
+	return (!xen_hvm_domain() || xen_have_vector_callback);
+}
+
 #endif /* _ASM_X86_XEN_EVENTS_H */
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 292ab0364a89..c4b3646bd04c 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -447,7 +447,7 @@ void __init xen_msi_init(void)
 
 int __init pci_xen_hvm_init(void)
 {
-	if (!xen_feature(XENFEAT_hvm_pirqs))
+	if (!xen_have_vector_callback || !xen_feature(XENFEAT_hvm_pirqs))
 		return 0;
 
 #ifdef CONFIG_ACPI
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index ec1d5c46e58f..29b239025b57 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -138,6 +138,8 @@ struct shared_info xen_dummy_shared_info;
 void *xen_initial_gdt;
 
 RESERVE_BRK(shared_info_page_brk, PAGE_SIZE);
+__read_mostly int xen_have_vector_callback;
+EXPORT_SYMBOL_GPL(xen_have_vector_callback);
 
 static int xen_cpu_up_prepare(unsigned int cpu);
 static int xen_cpu_up_online(unsigned int cpu);
@@ -1861,7 +1863,9 @@ static int xen_cpu_up_prepare(unsigned int cpu)
 		xen_vcpu_setup(cpu);
 	}
 
-	if (xen_pv_domain() || xen_feature(XENFEAT_hvm_safe_pvclock))
+	if (xen_pv_domain() ||
+	    (xen_have_vector_callback &&
+	     xen_feature(XENFEAT_hvm_safe_pvclock)))
 		xen_setup_timer(cpu);
 
 	rc = xen_smp_intr_init(cpu);
@@ -1877,7 +1881,9 @@ static int xen_cpu_dead(unsigned int cpu)
 {
 	xen_smp_intr_free(cpu);
 
-	if (xen_pv_domain() || xen_feature(XENFEAT_hvm_safe_pvclock))
+	if (xen_pv_domain() ||
+	    (xen_have_vector_callback &&
+	     xen_feature(XENFEAT_hvm_safe_pvclock)))
 		xen_teardown_timer(cpu);
 
 	return 0;
@@ -1916,8 +1922,8 @@ static void __init xen_hvm_guest_init(void)
 
 	xen_panic_handler_init();
 
-	BUG_ON(!xen_feature(XENFEAT_hvm_callback_vector));
-
+	if (xen_feature(XENFEAT_hvm_callback_vector))
+		xen_have_vector_callback = 1;
 	xen_hvm_smp_init();
 	WARN_ON(xen_cpuhp_setup());
 	xen_unplug_emulated_devices();
@@ -1958,7 +1964,7 @@ bool xen_hvm_need_lapic(void)
 		return false;
 	if (!xen_hvm_domain())
 		return false;
-	if (xen_feature(XENFEAT_hvm_pirqs))
+	if (xen_feature(XENFEAT_hvm_pirqs) && xen_have_vector_callback)
 		return false;
 	return true;
 }
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 7ff2f1bfb7ec..4e6b65baf8e2 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -742,6 +742,8 @@ static void __init xen_hvm_smp_prepare_cpus(unsigned int max_cpus)
 
 void __init xen_hvm_smp_init(void)
 {
+	if (!xen_have_vector_callback)
+		return;
 	smp_ops.smp_prepare_cpus = xen_hvm_smp_prepare_cpus;
 	smp_ops.smp_send_reschedule = xen_smp_send_reschedule;
 	smp_ops.cpu_die = xen_cpu_die;
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 1e69956d7852..4535627cf532 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -432,6 +432,11 @@ static void xen_hvm_setup_cpu_clockevents(void)
 
 void __init xen_hvm_init_time_ops(void)
 {
+	/* vector callback is needed otherwise we cannot receive interrupts
+	 * on cpu > 0 and at this point we don't know how many cpus are
+	 * available */
+	if (!xen_have_vector_callback)
+		return;
 	if (!xen_feature(XENFEAT_hvm_safe_pvclock)) {
 		printk(KERN_INFO "Xen doesn't support pvclock on HVM,"
 				"disable pv timer\n");
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 6a53577772c9..42807ce11c42 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1312,6 +1312,9 @@ static int rebind_irq_to_cpu(unsigned irq, unsigned tcpu)
 	if (!VALID_EVTCHN(evtchn))
 		return -1;
 
+	if (!xen_support_evtchn_rebind())
+		return -1;
+
 	/* Send future instances of this interrupt to other vcpu. */
 	bind_vcpu.port = evtchn;
 	bind_vcpu.vcpu = xen_vcpu_nr(tcpu);
@@ -1645,15 +1648,20 @@ void xen_callback_vector(void)
 {
 	int rc;
 	uint64_t callback_via;
-
-	callback_via = HVM_CALLBACK_VECTOR(HYPERVISOR_CALLBACK_VECTOR);
-	rc = xen_set_callback_via(callback_via);
-	BUG_ON(rc);
-	pr_info("Xen HVM callback vector for event delivery is enabled\n");
-	/* in the restore case the vector has already been allocated */
-	if (!test_bit(HYPERVISOR_CALLBACK_VECTOR, used_vectors))
-		alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR,
-				xen_hvm_callback_vector);
+	if (xen_have_vector_callback) {
+		callback_via = HVM_CALLBACK_VECTOR(HYPERVISOR_CALLBACK_VECTOR);
+		rc = xen_set_callback_via(callback_via);
+		if (rc) {
+			pr_err("Request for Xen HVM callback vector failed\n");
+			xen_have_vector_callback = 0;
+			return;
+		}
+		pr_info("Xen HVM callback vector for event delivery is enabled\n");
+		/* in the restore case the vector has already been allocated */
+		if (!test_bit(HYPERVISOR_CALLBACK_VECTOR, used_vectors))
+			alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR,
+					xen_hvm_callback_vector);
+	}
 }
 #else
 void xen_callback_vector(void) {}
diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index 2a165cc8a43c..1c4deac9b0f8 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -67,7 +67,7 @@ static uint64_t get_callback_via(struct pci_dev *pdev)
 	pin = pdev->pin;
 
 	/* We don't know the GSI. Specify the PCI INTx line instead. */
-	return ((uint64_t)0x01 << HVM_CALLBACK_VIA_TYPE_SHIFT) | /* PCI INTx identifier */
+	return ((uint64_t)0x01 << 56) | /* PCI INTx identifier */
 		((uint64_t)pci_domain_nr(pdev->bus) << 32) |
 		((uint64_t)pdev->bus->number << 16) |
 		((uint64_t)(pdev->devfn & 0xff) << 8) |
@@ -90,7 +90,7 @@ static int xen_allocate_irq(struct pci_dev *pdev)
 static int platform_pci_resume(struct pci_dev *pdev)
 {
 	int err;
-	if (!xen_pv_domain())
+	if (xen_have_vector_callback)
 		return 0;
 	err = xen_set_callback_via(callback_via);
 	if (err) {
@@ -138,14 +138,7 @@ static int platform_pci_probe(struct pci_dev *pdev,
 	platform_mmio = mmio_addr;
 	platform_mmiolen = mmio_len;
 
-	/* 
-	 * Xen HVM guests always use the vector callback mechanism.
-	 * L1 Dom0 in a nested Xen environment is a PV guest inside in an
-	 * HVM environment. It needs the platform-pci driver to get
-	 * notifications from L0 Xen, but it cannot use the vector callback
-	 * as it is not exported by L1 Xen.
-	 */
-	if (xen_pv_domain()) {
+	if (!xen_have_vector_callback) {
 		ret = xen_allocate_irq(pdev);
 		if (ret) {
 			dev_warn(&pdev->dev, "request_irq failed err=%d\n", ret);
-- 
2.12.0
