Return-Path: <linux-arch-owner@vger.kernel.org>
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 27/52] x86, pci,
 amd-bus: Fix CPU hotplug callback registration
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org,
	rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de,
	akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com,
	ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	srivatsa.bhat@linux.vnet.ibm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-pci@vger.kernel.org,
	"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Fri, 14 Feb 2014 13:25:11 +0530
Message-ID: <20140214075511.22701.15084.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Subsystems that want to register CPU hotplug callbacks, as well as perform
initialization for the CPUs that are already online, often do it as shown
below:

	get_online_cpus();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	register_cpu_notifier(&foobar_cpu_notifier);

	put_online_cpus();

This is wrong, since it is prone to ABBA deadlocks involving the
cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
with CPU hotplug operations).

Instead, the correct and race-free way of performing the callback
registration is:

	cpu_notifier_register_begin();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	/* Note the use of the double underscored version of the API */
	__register_cpu_notifier(&foobar_cpu_notifier);

	cpu_notifier_register_done();


Fix the amd-bus code in x86 by using this latter form of callback
registration.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/pci/amd_bus.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index a48be98..f05cbf0 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -380,10 +380,13 @@ static int __init pci_io_ecs_init(void)
 	if (early_pci_allowed())
 		pci_enable_pci_io_ecs();
 
-	register_cpu_notifier(&amd_cpu_notifier);
+	cpu_notifier_register_begin();
 	for_each_online_cpu(cpu)
 		amd_cpu_notify(&amd_cpu_notifier, (unsigned long)CPU_ONLINE,
 			       (void *)(long)cpu);
+	__register_cpu_notifier(&amd_cpu_notifier);
+	cpu_notifier_register_done();
+
 	pci_probe |= PCI_HAS_IO_ECS;
 
 	return 0;

