Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:43872 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbbCJXOv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2015 19:14:51 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: bhelgaas@google.com, mingo@redhat.com, tglx@linutronix.de,
	hpa@zytor.com, pure.logic@nexus-software.ie, jgross@suse.com,
	luto@amacapital.net, andy.shevchenko@gmail.com,
	thomas.petazzoni@free-electrons.com, JBeulich@suse.com, bp@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	x86@kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [RFC v1 1/2] x86: kconfig: simplify enabling [IO]APIC for PCI_MSI
Date: Tue, 10 Mar 2015 16:14:34 -0700
Message-Id: <1426029275-9594-2-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426029275-9594-1-git-send-email-mcgrof@do-not-panic.com>
References: <1426029275-9594-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Commit 38a1dfda by Bryan O'Donoghue fixed a build issue
when PCI_MSI support is enabled on non-SMP X86_32 systems,
this was done by introducing a new Kconfig entry,
X86_UP_APIC_MSI, with the only purpose of selecting
X86_UP_APIC under certain conditions. The real goal
in the end though is to enable X86_LOCAL_APIC and
X86_IO_APIC. We already have enough APIC related Kconfig
entries and adding more only confuses things, we can
remove X86_UP_APIC_MSI by just passing on to PCI_MSI
what it needs.

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
 Documentation/PCI/MSI-HOWTO.txt | 5 +----
 arch/x86/Kconfig                | 6 +-----
 drivers/pci/Kconfig             | 2 ++
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
index 0d920d5..7306d2c 100644
--- a/Documentation/PCI/MSI-HOWTO.txt
+++ b/Documentation/PCI/MSI-HOWTO.txt
@@ -71,10 +71,7 @@ will simply fail and the device will continue to use pin-based interrupts.
 4.1 Include kernel support for MSIs
 
 To support MSI or MSI-X, the kernel must be built with the CONFIG_PCI_MSI
-option enabled.  This option is only available on some architectures,
-and it may depend on some other options also being set.  For example,
-on x86, you must also enable X86_UP_APIC or SMP in order to see the
-CONFIG_PCI_MSI option.
+option enabled.  This option is only available on some architectures.
 
 4.2 Using MSI
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d038475..0ecdeb1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -902,10 +902,6 @@ config X86_UP_APIC
 	  performance counters), and the NMI watchdog which detects hard
 	  lockups.
 
-config X86_UP_APIC_MSI
-	def_bool y
-	select X86_UP_APIC if X86_32 && !SMP && !X86_32_NON_STANDARD && PCI_MSI
-
 config X86_UP_IOAPIC
 	bool "IO-APIC support on uniprocessors"
 	depends on X86_UP_APIC
@@ -924,7 +920,7 @@ config X86_LOCAL_APIC
 	select GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
 
 config X86_IO_APIC
-	def_bool X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_IOAPIC
+	def_bool X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_IOAPIC || PCI_MSI
 	depends on X86_LOCAL_APIC
 	select IRQ_DOMAIN
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 7a8f1c5..01370c0 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -5,6 +5,8 @@ config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
 	depends on PCI
 	select GENERIC_MSI_IRQ
+	select X86_LOCAL_APIC if X86_32 && !SMP && !X86_32_NON_STANDARD
+	select X86_IO_APIC if X86_32 && !SMP && !X86_32_NON_STANDARD
 	help
 	   This allows device drivers to enable MSI (Message Signaled
 	   Interrupts).  Message Signaled Interrupts enable a device to
-- 
2.3.2.209.gd67f9d5.dirty

