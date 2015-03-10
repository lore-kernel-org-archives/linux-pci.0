Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:41036 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbCJXO4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2015 19:14:56 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: bhelgaas@google.com, mingo@redhat.com, tglx@linutronix.de,
	hpa@zytor.com, pure.logic@nexus-software.ie, jgross@suse.com,
	luto@amacapital.net, andy.shevchenko@gmail.com,
	thomas.petazzoni@free-electrons.com, JBeulich@suse.com, bp@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	x86@kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [RFC v1 2/2] x86: kconfig: remove UP [IO]APIC options
Date: Tue, 10 Mar 2015 16:14:35 -0700
Message-Id: <1426029275-9594-3-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426029275-9594-1-git-send-email-mcgrof@do-not-panic.com>
References: <1426029275-9594-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

These were here mostly to help as wrappers for PCI_MSI
under certain UP 32-bit build scenarios, now that PCI_MSI
properly selects what it needs and when it needs it these
Kconfig options are now only enabling users reduce the size
of 32-bit kernels optionally. Since 32-bit kernels are not
in a huge state of flux and since there is no penalty for
adding APIC support other than a bit of size moving forward
we simply expect folks to enable APIC options on 32-bit systems
when a system needs it, as with PCI_MSI. This lets us remove
clutter from the x86 Kconfig file.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: linux-pci@vger.kernel.org
Cc: x86@kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 arch/x86/Kconfig | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0ecdeb1..bfd4d66 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -889,38 +889,13 @@ config UP_LATE_INIT
        def_bool y
        depends on !SMP && X86_LOCAL_APIC
 
-config X86_UP_APIC
-	bool "Local APIC support on uniprocessors"
-	depends on X86_32 && !SMP && !X86_32_NON_STANDARD
-	---help---
-	  A local APIC (Advanced Programmable Interrupt Controller) is an
-	  integrated interrupt controller in the CPU. If you have a single-CPU
-	  system which has a processor with a local APIC, you can say Y here to
-	  enable and use it. If you say Y here even though your machine doesn't
-	  have a local APIC, then the kernel will still run with no slowdown at
-	  all. The local APIC supports CPU-generated self-interrupts (timer,
-	  performance counters), and the NMI watchdog which detects hard
-	  lockups.
-
-config X86_UP_IOAPIC
-	bool "IO-APIC support on uniprocessors"
-	depends on X86_UP_APIC
-	---help---
-	  An IO-APIC (I/O Advanced Programmable Interrupt Controller) is an
-	  SMP-capable replacement for PC-style interrupt controllers. Most
-	  SMP systems and many recent uniprocessor systems have one.
-
-	  If you have a single-CPU system with an IO-APIC, you can say Y here
-	  to use it. If you say Y here even though your machine doesn't have
-	  an IO-APIC, then the kernel will still run with no slowdown at all.
-
 config X86_LOCAL_APIC
 	def_bool y
-	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
+	depends on X86_64 || SMP || X86_32_NON_STANDARD || PCI_MSI
 	select GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
 
 config X86_IO_APIC
-	def_bool X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_IOAPIC || PCI_MSI
+	def_bool X86_64 || SMP || X86_32_NON_STANDARD || PCI_MSI
 	depends on X86_LOCAL_APIC
 	select IRQ_DOMAIN
 
-- 
2.3.2.209.gd67f9d5.dirty

