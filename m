Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rui Wang <rui.y.wang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
        linux-pci@vger.kernel.org, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, bhelgaas@google.com,
        Ingo Molnar <mingo@kernel.org>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.4 26/74] x86/ioapic: Fix incorrect pointers in ioapic_setup_resources()
Date: Mon, 29 Jan 2018 13:56:31 +0100
Message-Id: <20180129123848.802267981@linuxfoundation.org>
In-Reply-To: <20180129123847.507563674@linuxfoundation.org>
References: <20180129123847.507563674@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rui Wang <rui.y.wang@intel.com>

commit 9d98bcec731756b8688b59ec998707924d716d7b upstream.

On a 4-socket Brickland system, hot-removing one ioapic is fine.
Hot-removing the 2nd one causes panic in mp_unregister_ioapic()
while calling release_resource().

It is because the iomem_res pointer has already been released
when removing the first ioapic.

To explain the use of &res[num] here: res is assigned to ioapic_resources,
and later in ioapic_insert_resources() we do:

	struct resource *r = ioapic_resources;

        for_each_ioapic(i) {
                insert_resource(&iomem_resource, r);
                r++;
        }

Here 'r' is treated as an arry of 'struct resource', and the r++ ensures
that each element of the array is inserted separately. Thus we should call
release_resouce() on each element at &res[num].

Fix it by assigning the correct pointers to ioapics[i].iomem_res in
ioapic_setup_resources().

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: tony.luck@intel.com
Cc: linux-pci@vger.kernel.org
Cc: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org
Cc: bhelgaas@google.com
Link: http://lkml.kernel.org/r/1465369193-4816-3-git-send-email-rui.y.wang@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/apic/io_apic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2592,8 +2592,8 @@ static struct resource * __init ioapic_s
 		res[num].flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 		snprintf(mem, IOAPIC_RESOURCE_NAME_SIZE, "IOAPIC %u", i);
 		mem += IOAPIC_RESOURCE_NAME_SIZE;
+		ioapics[i].iomem_res = &res[num];
 		num++;
-		ioapics[i].iomem_res = res;
 	}
 
 	ioapic_resources = res;


