Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: rt@linuxtronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 20/20] x86/pci/amd-bus: Convert to hotplug state machine
Date: Thu, 17 Nov 2016 19:35:41 +0100
Message-Id: <20161117183541.8588-21-bigeasy@linutronix.de>
In-Reply-To: <20161117183541.8588-1-bigeasy@linutronix.de>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

The smp_call_function_single() is dropped because the ONLINE callback is
invoked on the target CPU since commit 1cf4f629d9d2 ("cpu/hotplug: Move
online calls to hotplugged cpu"). smp_call_function_single() invokes the
invoked function with interrupts disabled, but this calling convention is
not preserved as the MSR is not modified by anything else than this code.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/pci/amd_bus.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index c20d2cc7ef64..ae387e5ee6f7 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -327,35 +327,18 @@ static int __init early_root_info_init(void)
=20
 #define ENABLE_CF8_EXT_CFG      (1ULL << 46)
=20
-static void enable_pci_io_ecs(void *unused)
+static int amd_bus_cpu_online(unsigned int cpu)
 {
 	u64 reg;
+
 	rdmsrl(MSR_AMD64_NB_CFG, reg);
 	if (!(reg & ENABLE_CF8_EXT_CFG)) {
 		reg |=3D ENABLE_CF8_EXT_CFG;
 		wrmsrl(MSR_AMD64_NB_CFG, reg);
 	}
+	return 0;
 }
=20
-static int amd_cpu_notify(struct notifier_block *self, unsigned long actio=
n,
-			  void *hcpu)
-{
-	int cpu =3D (long)hcpu;
-	switch (action) {
-	case CPU_ONLINE:
-	case CPU_ONLINE_FROZEN:
-		smp_call_function_single(cpu, enable_pci_io_ecs, NULL, 0);
-		break;
-	default:
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block amd_cpu_notifier =3D {
-	.notifier_call	=3D amd_cpu_notify,
-};
-
 static void __init pci_enable_pci_io_ecs(void)
 {
 #ifdef CONFIG_AMD_NB
@@ -385,7 +368,7 @@ static void __init pci_enable_pci_io_ecs(void)
=20
 static int __init pci_io_ecs_init(void)
 {
-	int cpu;
+	int ret;
=20
 	/* assume all cpus from fam10h have IO ECS */
 	if (boot_cpu_data.x86 < 0x10)
@@ -395,12 +378,9 @@ static int __init pci_io_ecs_init(void)
 	if (early_pci_allowed())
 		pci_enable_pci_io_ecs();
=20
-	cpu_notifier_register_begin();
-	for_each_online_cpu(cpu)
-		amd_cpu_notify(&amd_cpu_notifier, (unsigned long)CPU_ONLINE,
-			       (void *)(long)cpu);
-	__register_cpu_notifier(&amd_cpu_notifier);
-	cpu_notifier_register_done();
+	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "pci/amd_bus:online",
+				amd_bus_cpu_online, NULL);
+	WARN_ON(ret < 0);
=20
 	pci_probe |=3D PCI_HAS_IO_ECS;
=20
--=20
2.10.2
