Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58133 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436AbbGPTOT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Jul 2015 15:14:19 -0400
Message-ID: <55A80262.2010401@ti.com>
Date: Thu, 16 Jul 2015 15:13:38 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v1] ARM: pci: add call to pcie_bus_configure_settings()
References: <1401297293-3950-1-git-send-email-m-karicheri2@ti.com> <20150516140230.GF31666@google.com>
In-Reply-To: <20150516140230.GF31666@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/16/2015 10:02 AM, Bjorn Helgaas wrote:
> On Wed, May 28, 2014 at 01:14:53PM -0400, Murali Karicheri wrote:
>> Call pcie_bus_configure_settings on ARM, like for other platforms.
>> pcie_bus_configure_settings makes sure the MPS across the bus is
>> uniform and provides the ability to tune the MRSS and MPS to higher
>> performance values. This is particularly important for embedded where
>> there is no firmware to program these PCI-E settings for the OS.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>
>> CC: Russell King <linux@arm.linux.org.uk>
>> CC: Bjorn Helgaas <bhelgaas@google.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>   - Fixed comments against initial version
>>   arch/arm/kernel/bios32.c |   12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
>> index 16d43cd..17a26c1 100644
>> --- a/arch/arm/kernel/bios32.c
>> +++ b/arch/arm/kernel/bios32.c
>> @@ -545,6 +545,18 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
>>   		 */
>>   		pci_bus_add_devices(bus);
>>   	}
>> +
>> +	list_for_each_entry(sys, &head, node) {
>> +		struct pci_bus *bus = sys->bus;
>> +
>> +		/* Configure PCI Express settings */
>> +		if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
>> +			struct pci_bus *child;
>> +
>> +			list_for_each_entry(child, &bus->children, node)
>> +				pcie_bus_configure_settings(child);
>
> This patch (8b5742ad156d ("ARM/PCI: Call pcie_bus_configure_settings() to
> set MPS")) has been upstream since v3.16-rc1, but I think we goofed.
>
> The MPS configuration should be done *before* pci_bus_add_devices().  After
> pci_bus_add_devices(), drivers may be bound to devices, and the PCI core
> shouldn't touch device configuration while a driver owns the device.
>
> Looking at the code, it seems like it would have been simpler to do this in
> the existing loop:
>
>    list_for_each_entry(sys, &head, node) {
>      struct pci_bus *bus = sys->bus;
>
>      if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
>        pci_bus_size_bridges(bus);
>        pci_bus_assign_resources(bus);
>        list_for_each_entry(child, &bus->children, node)
>          pcie_bus_configure_settings(child);
>      }
>
>      pci_bus_add_devices(bus);
>    }
>
> so maybe there's some reason I'm not aware of for not doing it that way?

Bjorn,

This one has escaped my radar and I found it recently while I was 
searching for something else. I can't recall why this was not done this 
way. However I have tried the below code on Keystone and it works fine.

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index fcbbbb1..17efde7 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -520,7 +520,8 @@ void pci_common_init_dev(struct device *parent, 
struct hw_pci *hw)
         list_for_each_entry(sys, &head, node) {
                 struct pci_bus *bus = sys->bus;

-               if (!pci_has_flag(PCI_PROBE_ONLY)) {
+               if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
+                       struct pci_bus *child;
                         /*
                          * Size the bridge windows.
                          */
@@ -530,25 +531,15 @@ void pci_common_init_dev(struct device *parent, 
struct hw_pci *hw)
                          * Assign resources.
                          */
                         pci_bus_assign_resources(bus);
-               }

+                       list_for_each_entry(child, &bus->children, node)
+                               pcie_bus_configure_settings(child);
+               }
                 /*
                  * Tell drivers about devices found.
                  */
                 pci_bus_add_devices(bus);
         }
-
-       list_for_each_entry(sys, &head, node) {
-               struct pci_bus *bus = sys->bus;
-
-               /* Configure PCI Express settings */
-               if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
-                       struct pci_bus *child;
-
-                       list_for_each_entry(child, &bus->children, node)
-                               pcie_bus_configure_settings(child);
-               }
-       }
  }

The SATA comes up fine and ahci is able to override the mrrs value as 
shown by the log below.

[    1.581526] ahci 0001:01:00.0: limiting MRRS to 256
[    1.586521] ahci 0001:01:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 
0x3 impl SATA mode
[    1.594604] ahci 0001:01:00.0: flags: 64bit ncq sntf led only pmp fbs 
pio slum part sxs
[    1.603772] scsi host0: ahci
[    1.606976] scsi host1: ahci
[

If you are fine, I can send a patch for this. Please confirm.

Murali

>
>> +		}
>> +	}
>>   }
>>
>>   #ifndef CONFIG_PCI_HOST_ITE8152
>> --
>> 1.7.9.5
>>


-- 
Murali Karicheri
Linux Kernel, Keystone
