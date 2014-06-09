Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, x86@kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch V4 31/42] x86, irq, mpparse: use common irqdomain map interface to program IOAPIC pins
Date: Mon,  9 Jun 2014 16:20:00 +0800
Message-Id: <1402302011-23642-32-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1402302011-23642-1-git-send-email-jiang.liu@linux.intel.com>
References: <1402302011-23642-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Refine mpparse to use common irqdomain map interface to program IOAPIC pins,
so we can unify the callsite to progam IOAPIC pins.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/mpparse.c |    4 +++-
 arch/x86/pci/irq.c        |    2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 13c8e1f864fc..faf503aa3b70 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -113,7 +113,9 @@ static void __init MP_bus_info(struct mpc_bus *m)
 		pr_warn("Unknown bustype %s - ignoring\n", str);
 }
 
-static struct irq_domain_ops mp_ioapic_irqdomain_ops;
+static struct irq_domain_ops mp_ioapic_irqdomain_ops = {
+	.map = mp_irqdomain_map,
+};
 
 static void __init MP_ioapic_info(struct mpc_ioapic *m)
 {
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 84112f55dd7a..e4200e5e775e 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1227,8 +1227,6 @@ static int pirq_enable_irq(struct pci_dev *dev)
 			}
 			dev = temp_dev;
 			if (irq >= 0) {
-				io_apic_set_pci_routing(&dev->dev, irq,
-							 &irq_attr);
 				dev->irq = irq;
 				dev_info(&dev->dev, "PCI->APIC IRQ transform: "
 					 "INT %c -> IRQ %d\n", 'A' + pin - 1, irq);
-- 
1.7.10.4

