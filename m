Return-Path: <yu.c.chen@intel.com>
Return-Path: <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC] PCI: Workaround to enable poweroff on Mac Pro 11
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1464604404-11257-1-git-send-email-yu.c.chen@intel.com>
 <20160530213305.GA21322@localhost>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Yinghai Lu <yinghai@kernel.org>
From: Chen Yu <yu.c.chen@intel.com>
Message-ID: <574D03F9.6050201@intel.com>
Date: Tue, 31 May 2016 11:24:41 +0800
MIME-Version: 1.0
In-Reply-To: <20160530213305.GA21322@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2016年05月31日 05:33, Bjorn Helgaas wrote:
> On Mon, May 30, 2016 at 06:33:24PM +0800, Chen Yu wrote:
>> Currently there are many people reported that they can not
>> do a poweroff nor a suspend to memory on their Mac Pro 11.
>> After some investigations it was found that, once the PCI bridge
>> 0000:00:1c.0 reassigns its mm windows([mem 0x7fa00000-0x7fbfffff]
>> and [mem 0x7fc00000-0x7fdfffff 64bit pref]), the region of ACPI
>> io resource 0x1804 becomes unaccessible immediately, where the
>> ACPI Sleep register is located, as a result neither poweroff(S5)
>> nor suspend to memory(S3) works.
>>
>> I don't know why setting the base/limit of PCI bridge mem resource
>> would affect another io resource region, so this quirk just simply
>> bypass the assignment of these mm resources on 0000:00:1c.0, by
>> resetting the resource flag to 0 before updating the base/limit registers.
>> This patch also introduces a new pci fixup phase before the actual bridge
>> resource assignment.
> Split the new fixup phase into a separate patch.
>
> I'm doubtful about this because we don't understand the root cause.
Yes, I don't know the root cause neither, so I send this patch to ask for
help, maybe we should  also invite Apple people in..
>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=103211
>> Tested-by: Cedric Le Goater <clg@kaod.org>
>> Tested-by: pkozlov <pkozlov.vrn@gmail.com>
>> Tested-by: Zach Norman <zach@nor.mn>
>> Tested-by: Pablo Catalina <pablo.catalina@gmail.com>
>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>> ---
>>   drivers/pci/quirks.c              | 25 +++++++++++++++++++++++++
>>   drivers/pci/setup-bus.c           |  2 ++
>>   include/asm-generic/vmlinux.lds.h |  3 +++
>>   include/linux/pci.h               |  4 ++++
>>   scripts/mod/modpost.c             |  1 +
>>   5 files changed, 35 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index ee72ebe..e347047 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3370,6 +3370,8 @@ extern struct pci_fixup __start_pci_fixups_header[];
>>   extern struct pci_fixup __end_pci_fixups_header[];
>>   extern struct pci_fixup __start_pci_fixups_final[];
>>   extern struct pci_fixup __end_pci_fixups_final[];
>> +extern struct pci_fixup __start_pci_fixups_assign[];
>> +extern struct pci_fixup __end_pci_fixups_assign[];
>>   extern struct pci_fixup __start_pci_fixups_enable[];
>>   extern struct pci_fixup __end_pci_fixups_enable[];
>>   extern struct pci_fixup __start_pci_fixups_resume[];
>> @@ -3405,6 +3407,11 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
>>   		end = __end_pci_fixups_final;
>>   		break;
>>   
>> +	case pci_fixup_assign:
>> +		start = __start_pci_fixups_assign;
>> +		end = __end_pci_fixups_assign;
>> +		break;
>> +
>>   	case pci_fixup_enable:
>>   		start = __start_pci_fixups_enable;
>>   		end = __end_pci_fixups_enable;
>> @@ -4419,3 +4426,21 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
>>   	}
>>   }
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
>> +
>> +/*
>> + * On Mac Pro 11, the allocation of pci bridge memory resource
>> + * broke ACPI Sleep Type register region.
>> + */
>> +static void quirk_mac_disable_mmio_bar(struct pci_dev *dev)
>> +{
>> +	struct resource *b_res;
>> +
>> +	dev_info(&dev->dev, "[Quirk] Disable mmio on Mac Pro 11\n");
>> +	if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
>> +		return;
> Why test for PCI_CLASS_BRIDGE_PCI?  If you do need to test, why is the
> test after the dev_info()?
This checking is not needed, since we only invoke 
pci_fixup_device(pci_fixup_assign)
for bridges. I can remove it.
>
>> +	b_res = &dev->resource[PCI_BRIDGE_RESOURCES];
>> +	b_res[1].flags = 0;
>> +	b_res[2].flags = 0;
> You're changing the resource flags but not the hardware itself.  I
> assume the window is still enabled and still claims address space, so
> we don't want to throw away the information about it, because then we
> don't know whether downstream devices can work, and we can't safely
> assign resources to peers.
If I understand correctly, according to the boot logs, the pci bridge
in question has not declaimed any valid device/bridge resource
(both io and mem) during  probe(because base=0xfff>limit=0x0),
so I think it has not hardware resource setting at that time(at least
in BIOS)
until it reaches pcibios_assign_resources and it has to allocate a
minimal io/mem resource, then it tries to  assign them to
[mem 0x7fa00000 - 0x7fbfffff]
[mem 0x7fc00000-0x7fdfffff 64bit pref]
[io 0x2000-0x2fff],
so if we reset the flag to zero for these mem resource, the pci bridge
  will not assign any pci mem windows for it
(in this way
find_free_bus_resource(bus, mask | IORESOURCE_PREFETCH, type)
will not return any free resource, thus bypass the assignment)

According to the boot log at 
https://bugzilla.kernel.org/attachment.cgi?id=210141
,  we can see there is no bridge windows assign for 0000:00:1c.0 during 
early probe:

[    0.807893] pci 0000:00:1c.0: [8086:8c10] type 01 class 0x060400
[    0.807949] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.831281] pci 0000:00:1c.0: PCI bridge to [bus 02]

and then in pcibios_assign_resources, 0000:00:1c.0 tries to allocate minimal
resource window and then update related base/limit registers:

[    0.865342] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to 
[bus 02] add_size 1000
[    0.865343] pci 0000:00:1c.0: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 
100000
[    0.865344] pci 0000:00:1c.0: bridge window [mem 
0x00100000-0x000fffff] to [bus 02] add_size 200000 add_align 100000

>
>> +}
>> +DECLARE_PCI_FIXUP_ASSIGN(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_mac_disable_mmio_bar);
> Is this device *only* used on the Mac Pro 11?  http://pci-ids.ucs.cz
> says "8 Series/C220 Series Chipset Family PCI Express Root Port #1",
> which sounds pretty generic.
Maybe not only used for Mac Pro 11, so should it be a dmi match+pci quirk?

thanks,
Yu
