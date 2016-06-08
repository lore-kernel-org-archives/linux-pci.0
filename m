Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Rui Wang <rui.y.wang@intel.com>
To: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
	bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rui.y.wang@intel.com
Subject: [PATCH V2 3/3] x86/ioapic: Simplify ioapic_setup_resources()
Date: Wed,  8 Jun 2016 14:59:53 +0800
Message-Id: <1465369193-4816-4-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <1465369193-4816-1-git-send-email-rui.y.wang@intel.com>
References: <1465369193-4816-1-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Optimize the function by removing the variable 'num'.

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
---
 arch/x86/kernel/apic/io_apic.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 446702e..e587295 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2567,29 +2567,25 @@ static struct resource * __init ioapic_setup_resources(void)
 	unsigned long n;
 	struct resource *res;
 	char *mem;
-	int i, num = 0;
+	int i;
 
-	for_each_ioapic(i)
-		num++;
-	if (num == 0)
+	if (nr_ioapics == 0)
 		return NULL;
 
 	n = IOAPIC_RESOURCE_NAME_SIZE + sizeof(struct resource);
-	n *= num;
+	n *= nr_ioapics;
 
 	mem = alloc_bootmem(n);
 	res = (void *)mem;
 
-	mem += sizeof(struct resource) * num;
+	mem += sizeof(struct resource) * nr_ioapics;
 
-	num = 0;
 	for_each_ioapic(i) {
-		res[num].name = mem;
-		res[num].flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		res[i].name = mem;
+		res[i].flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 		snprintf(mem, IOAPIC_RESOURCE_NAME_SIZE, "IOAPIC %u", i);
 		mem += IOAPIC_RESOURCE_NAME_SIZE;
-		ioapics[i].iomem_res = &res[num];
-		num++;
+		ioapics[i].iomem_res = &res[i];
 	}
 
 	ioapic_resources = res;
-- 
1.8.3.1

