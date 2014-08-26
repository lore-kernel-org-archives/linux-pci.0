Return-Path: <linux-acpi-owner@vger.kernel.org>
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
	Grant Likely <grant.likely@linaro.org>, x86@kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Prarit Bhargava <prarit@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [Bugfix] x86, irq: Fix bug in setting IOAPIC pin attributes
Date: Tue, 26 Aug 2014 16:45:01 +0800
Message-Id: <1409042706-11958-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <20140822124145.GF1660@lahna.fi.intel.com>
References: <20140822124145.GF1660@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On startup, IOAPIC driver preallocates IRQ descriptors and programs
IOAPIC pins with default level and polarity attributes for all legacy
IRQs. Later legacy IRQ users may fail to set IOAPIC pin attributes
if the requested attributes conflicts with the default IOAPIC pin
attributes. So change mp_irqdomain_map() to allow the first legacy IRQ
user to reprogram IOAPIC pin with different attributes.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/apic/io_apic.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 29290f554e79..66c2700c9f83 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3896,7 +3896,15 @@ int mp_irqdomain_map(struct irq_domain *domain, unsigned int virq,
 			info->polarity = 1;
 		}
 		info->node = NUMA_NO_NODE;
-		info->set = 1;
+
+		/*
+		 * setup_IO_APIC_irqs() programs all legacy IRQs with default
+		 * trigger and polarity attirbutes. Don't set the flag for that
+		 * case so the first legacy IRQ user could reprogram the pin
+		 * with real trigger and polarity attributes.
+		 */
+		if (virq >= nr_legacy_irqs() || info->count)
+			info->set = 1;
 	}
 	set_io_apic_irq_attr(&attr, ioapic, hwirq, info->trigger,
 			     info->polarity);
-- 
1.7.10.4

