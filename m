Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:37843 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbbCKXOs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2015 19:14:48 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: rientjes@google.com, bhelgaas@google.com, mingo@redhat.com,
	tglx@linutronix.de, hpa@zytor.com, pure.logic@nexus-software.ie,
	jgross@suse.com, luto@amacapital.net, andy.shevchenko@gmail.com,
	thomas.petazzoni@free-electrons.com, JBeulich@suse.com, bp@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	x86@kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v1 1/2] x86: kconfig: remove X86_UP_IOAPIC
Date: Wed, 11 Mar 2015 16:10:21 -0700
Message-Id: <1426115422-1823-2-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426115422-1823-1-git-send-email-mcgrof@do-not-panic.com>
References: <1426115422-1823-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

X86_UP_IOAPIC is a way so that 32-bit UP systems can enable
X86_IOAPIC. X86_UP_IOAPIC is only as a visible user option if
you are on a 32-bit system but have X86_UP_APIC enabled. X86_UP_APIC
will be enabled by force if you have PCI_MSI on 32-bit systems
now, X86_UP_APIC will now only be user selectable if you didn't
have PCI_MSI enabled and are also not on a X86_32_NON_STANDARD
system. Bryan's original patch (refactored commit log in commit
38a1dfda) [0] describes that Intel CE, Intel MID and Intel Quark
are all 32-bit uniprocessor systems with IO-APICs, the code change
however only *re-enabled* UP_IOAPIC as an *option* when PCI_MSI
was enabled, but given that:

1) enabling X86_IOAPIC is the real end goal here
2) enabling X86_IOAPIC only increases the kernel only by 12064 bytes (~12 KiB)
3) enabling X86_IOAPIC will in no way slow down your kernel

Let's make a compromise for 32-bit systems and always enable X86_IOAPIC
when X86_UP_IOAPIC is enabled as 32-bit systems are not in a state
of flux and the price for the size is small with no performance impact.

Using:

export ARCH=i386
make allnoconfig
--> Enabling PCI_MSI
make localyesconfig

With X86_IO_APIC:
mcgrof@ergon ~/linux-next (git::master)$ du -b arch/x86/boot/bzImage
734608  arch/x86/boot/bzImage

Without X86_IO_APIC:
mcgrof@ergon ~/linux-next (git::master)$ du -b arch/x86/boot/bzImage
722544  arch/x86/boot/bzImage

[0] https://lkml.org/lkml/2015/1/22/718

Cc: David Rientjes <rientjes@google.com>
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
 arch/x86/Kconfig | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 110f6ae..b17a8ea 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -899,6 +899,7 @@ config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !PCI_MSI
 	default PCI_MSI
 	depends on X86_32 && !SMP && !X86_32_NON_STANDARD
+	select X86_IO_APIC
 	---help---
 	  A local APIC (Advanced Programmable Interrupt Controller) is an
 	  integrated interrupt controller in the CPU. If you have a single-CPU
@@ -909,18 +910,6 @@ config X86_UP_APIC
 	  performance counters), and the NMI watchdog which detects hard
 	  lockups.
 
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
 	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
@@ -928,7 +917,7 @@ config X86_LOCAL_APIC
 
 config X86_IO_APIC
 	def_bool y
-	depends on X86_LOCAL_APIC || X86_UP_IOAPIC
+	depends on X86_LOCAL_APIC
 	select IRQ_DOMAIN
 
 config X86_REROUTE_FOR_BROKEN_BOOT_IRQS
-- 
2.3.2.209.gd67f9d5.dirty

