Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Rui Wang <rui.y.wang@intel.com>
To: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
	bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rui.y.wang@intel.com
Subject: [PATCH V2 2/3] x86/ioapic: Fix wrong pointers in ioapic_setup_resources()
Date: Wed,  8 Jun 2016 14:59:52 +0800
Message-Id: <1465369193-4816-3-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <1465369193-4816-1-git-send-email-rui.y.wang@intel.com>
References: <1465369193-4816-1-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On a 4-socket brickland, hot-removing one ioapic is fine. Hot-removing
the 2nd one causes panic in mp_unregister_ioapic() while calling
release_resource(). It is because the iomem_res pointer has already been
released when removing the first ioapic.

Fix it by assigning the correct pointers to ioapics[i].iomem_res in
ioapic_setup_resources().

To explain the use of &res[num] here: res is assigned to ioapic_resources,
and later in ioapic_insert_resources() we do

	struct resource *r = ioapic_resources;
        for_each_ioapic(i) {
                insert_resource(&iomem_resource, r);
                r++;
        }

Here r is treated as an arry of struct resource, and the r++ ensures that
each element of the array is inserted separately. Thus we should call
release_resouce() on each element at &res[num].

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
---
 arch/x86/kernel/apic/io_apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 84e33ff..446702e 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2588,8 +2588,8 @@ static struct resource * __init ioapic_setup_resources(void)
 		res[num].flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 		snprintf(mem, IOAPIC_RESOURCE_NAME_SIZE, "IOAPIC %u", i);
 		mem += IOAPIC_RESOURCE_NAME_SIZE;
+		ioapics[i].iomem_res = &res[num];
 		num++;
-		ioapics[i].iomem_res = res;
 	}
 
 	ioapic_resources = res;
-- 
1.8.3.1

