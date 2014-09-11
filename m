Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Grant Likely <grant.likely@linaro.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [RFC Part1 v1 14/18] x86, irq: Make MSI and HT_IRQ indepenent of X86_IO_APIC
Date: Thu, 11 Sep 2014 16:25:01 +0800
Message-Id: <1410423905-26239-15-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1410423905-26239-1-git-send-email-jiang.liu@linux.intel.com>
References: <1410423905-26239-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we have splitted functions to support MSI and HT_IRQ into vector.c,
and they have no dependency on IOAPIC any more. So change Kconfig files
to make MSI and HT_IRQ independent of X86_IO_APIC.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/Kconfig    |    4 ++--
 drivers/pci/Kconfig |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e0fc1e721ae2..7d0ca80d628f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -839,8 +839,8 @@ config X86_LOCAL_APIC
 	select GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
 
 config X86_IO_APIC
-	def_bool y
-	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_IOAPIC || PCI_MSI
+	def_bool X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_IOAPIC
+	depends on X86_LOCAL_APIC
 	select IRQ_DOMAIN
 
 config X86_REROUTE_FOR_BROKEN_BOOT_IRQS
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 39866d18004e..b9db0f2ce11f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -61,7 +61,7 @@ config XEN_PCIDEV_FRONTEND
 config HT_IRQ
 	bool "Interrupts on hypertransport devices"
 	default y
-	depends on PCI && X86_LOCAL_APIC && X86_IO_APIC
+	depends on PCI && X86_LOCAL_APIC
 	help
 	   This allows native hypertransport devices to use interrupts.
 
-- 
1.7.10.4

