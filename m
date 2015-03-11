Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:44073 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbbCKXRA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2015 19:17:00 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: rientjes@google.com, bhelgaas@google.com, mingo@redhat.com,
	tglx@linutronix.de, hpa@zytor.com, pure.logic@nexus-software.ie,
	jgross@suse.com, luto@amacapital.net, andy.shevchenko@gmail.com,
	thomas.petazzoni@free-electrons.com, JBeulich@suse.com, bp@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	x86@kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v1 2/2] x86: kconfig: remove X86_UP_APIC
Date: Wed, 11 Mar 2015 16:10:22 -0700
Message-Id: <1426115422-1823-3-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426115422-1823-1-git-send-email-mcgrof@do-not-panic.com>
References: <1426115422-1823-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

X86_UP_APIC is used for two reasons on 32-bit systems:

1) set a series of dependencies under which we would like
   to express we want X86_LOCAL_APIC enabled
2) under the above conditions if PCI_MSI is enabled always
   force X86_LOCAL_APIC to be enabled
3) Let users opt in or out of X86_LOCAL_APIC if PCI_MSI is
   not enabled

We don't really need a Kconfig entry to address 1) for 2) and 3)
as X86_LOCAL_APIC already has the dependencies which we wish to
match. Instead since 2) is desirable we can just select
X86_LOCAL_APIC on PCI_MSI and it will be enabled when the
dependencies are met. The only thing we loose with this then
is letting users elect to enable or not X86_LOCAL_APIC on
UP 32-bit systems but since:

a) enabling X86_LOCAL_APIC will in no way slow down your kernel
b) enabling X86_LOCAL_APIC only increases your kernel
   by 19264 bytes (19 KiB)
c) x86 is not in a state of flux

We can compromise here and just always enable X86_LOCAL_APIC
when PCI_MSI is enabled.

Using:

(a hacked up patch to enable X86_LOCAL_APIC any time)

export ARCH=i386
make allnoconfig
--> Enabling or disabling X86_LOCAL_APIC
make localyesconfig

With X86_LOCAL_APIC:
mcgrof@ergon ~/linux-next (git::master)$ du -b arch/x86/boot/bzImage
508496  arch/x86/boot/bzImage

With X86_LOCAL_APIC:
mcgrof@ergon ~/linux-next (git::master)$ du -b arch/x86/boot/bzImage
489232  arch/x86/boot/bzImage

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
 arch/x86/Kconfig    | 17 +----------------
 drivers/pci/Kconfig |  2 ++
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b17a8ea..37d3e6e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -895,24 +895,9 @@ config UP_LATE_INIT
        def_bool y
        depends on !SMP && X86_LOCAL_APIC
 
-config X86_UP_APIC
-	bool "Local APIC support on uniprocessors" if !PCI_MSI
-	default PCI_MSI
-	depends on X86_32 && !SMP && !X86_32_NON_STANDARD
-	select X86_IO_APIC
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
 config X86_LOCAL_APIC
 	def_bool y
-	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
+	depends on X86_64 || SMP || X86_32_NON_STANDARD || PCI_MSI
 	select GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
 
 config X86_IO_APIC
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 7a8f1c5..fa9739e 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -5,6 +5,8 @@ config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
 	depends on PCI
 	select GENERIC_MSI_IRQ
+	select X86_LOCAL_APIC
+	select X86_IO_APIC
 	help
 	   This allows device drivers to enable MSI (Message Signaled
 	   Interrupts).  Message Signaled Interrupts enable a device to
-- 
2.3.2.209.gd67f9d5.dirty

