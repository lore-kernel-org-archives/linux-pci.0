Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5317D9B0.1080502@amd.com>
Date: Wed, 5 Mar 2014 20:13:04 -0600
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>,
	<kim.naru@amd.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 0/3] amd/pci: Add AMD hostbridge supports for newer AMD
 systems
References: <1394053603-3724-1-git-send-email-suravee.suthikulpanit@amd.com> <CAErSpo4MMJh9b0aivwGSbxCMVw24He1+Vo_LH0R0E+fYM5aThg@mail.gmail.com>
In-Reply-To: <CAErSpo4MMJh9b0aivwGSbxCMVw24He1+Vo_LH0R0E+fYM5aThg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/5/2014 3:24 PM, Bjorn Helgaas wrote:
> [+cc linux-acpi]
>
> On Wed, Mar 5, 2014 at 2:06 PM,  <suravee.suthikulpanit@amd.com> wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> The current code only supports upto AMD hostbridge for family11h.
>> This causes PCI numa_node information to be reported incorrectly
>> for newer family with multi sockets.
>
> Where is the incorrect reporting?  In ACPI tables?  Is this patch a
> way to cover up firmware defects in the ACPI description?  Or is this
> for machines without ACPI (it seems unlikely that machines with new
> AMD processors would not have ACPI)?

This is incorrectly reported in the sysfs for each PCI device (e.g. 
/devices/pci0000:50/0000:50:00.2/numa_node). Without the patch, they 
return -1.

In file arch/x86/pci/acpi.c, in function pci_acpi_scan_root(), it is 
queries the node information as following:

#ifdef CONFIG_ACPI_NUMA
	pxm = acpi_get_pxm(device->handle);
	if (pxm >= 0)
		node = pxm_to_node(pxm);
	if (node != -1)
		set_mp_bus_to_node(busnum, node);
	else
#endif
		node = get_mp_bus_to_node(busnum);

In this case, I see that the acpi_get_pxm() returns -1.  Therefore, it 
falls back to using the node information in mp_bus_to_node[].  So, 
without this patch, it would also returning -1.

Also, the spec mentioned that the _PXM is optional, so I am not sure if 
this is a firmware bug.

Suravee

>
> The whole point of ACPI is that we shouldn't need to update the kernel
> for new hardware, so if there's a firmware bug, it should be fixed, or
> if the ACPI spec isn't powerful enough, it should be extended.
>
>> This patch set introduces the logic to discover AMD hostbridges.
>>
>> Note:
>>      * Patch 1 and 2 are functional changes.
>>      * Patch 3 is code clean up/restructuring
>>
>> Suravee Suthikulpanit (3):
>>    amd/pci: Add supports for generic AMD hostbridges
>>    amd/pci: Support additional MMIO ranges capabilities
>>    amd/pci: Miscellaneous code clean up for early_fillup_mp_bus_info
>>
>>   arch/x86/pci/amd_bus.c |  376 ++++++++++++++++++++++++++++++++----------------
>>   1 file changed, 251 insertions(+), 125 deletions(-)
>>
>> --
>> 1.7.10.4
>>
>>
>


