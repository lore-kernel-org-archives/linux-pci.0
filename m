Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [PATCH V8 7/9] acpi: Add generic MCFG table handling
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-8-git-send-email-tn@semihalf.com>
 <20160608015631.GE4759@localhost> <57580DCA.7000703@semihalf.com>
 <20160608131709.GB16764@localhost>
Cc: arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
 rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com,
 okaya@codeaurora.org, jchandra@broadcom.com,
 robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com,
 ddaney@caviumnetworks.com, wangyijing@huawei.com,
 Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org,
 dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com,
 cov@codeaurora.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <57582133.8060402@semihalf.com>
Date: Wed, 8 Jun 2016 15:44:19 +0200
MIME-Version: 1.0
In-Reply-To: <20160608131709.GB16764@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 08.06.2016 15:17, Bjorn Helgaas wrote:
> On Wed, Jun 08, 2016 at 02:21:30PM +0200, Tomasz Nowicki wrote:
>> On 08.06.2016 03:56, Bjorn Helgaas wrote:
>>> On Mon, May 30, 2016 at 05:14:20PM +0200, Tomasz Nowicki wrote:
>>>> In order to handle PCI config space regions properly in ACPI, new MCFG
>>>> interface is defined which does sanity checks on MCFG table and keeps its
>>>> root pointer. The user is able to lookup MCFG regions based on
>>>> host bridge root structure and domain:bus_start:bus_end touple.
>>>> Use pci_mmcfg_late_init old prototype to avoid another function name.
>
>>>> +	/* found matching entry, bus range check */
>>>> +	if (entry->end_bus_number != bus_res->end) {
>>>> +		resource_size_t bus_end = min_t(resource_size_t,
>>>> +					entry->end_bus_number, bus_res->end);
>>>> +		pr_warn("%04x:%pR bus end mismatch, using %02lx\n",
>>>> +			root->segment, bus_res, (unsigned long)bus_end);
>>>> +		bus_res->end = bus_end;
>>>> +	}
>>
>> What about bus end mismatch case? Should we trim the host bridge bus
>> range or expect MCFG entry covers that range? Sometimes we get
>> _BBN-0xFF bus range, not from _CRS.
>
> Lack of a bus range in _CRS is a firmware defect.  There's a comment
> about this in acpi_pci_root_add().  On x86, we probably had to live
> with firmware in the field that had this defect.  I think we should
> expect all ARM64 systems to provide a bus number range in _CRS, and
> fail the attach if it's not there.
>
> I don't think we should warn about an MCFG entry that covers more than
> the _CRS bus range.  On x86, it's common to have something like:
>
>    ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
>    ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-ff])
>
> with a single MCFG entry that covers [bus 00-ff].  That seems
> reasonable and I don't think it's worth warning about it.
>
> If the MCFG entry doesn't cover all of a _CRS bus range, we should
> just fail so we can find and fix broken firmware.

Make sense to me.

>
>>>> +/* Interface called by ACPI - parse and save MCFG table */
>>>
>>> I think we save a *pointer* to the MCFG table, not the table itself.
>>
>> Right, the comment is broken.
>>
>>> And acpi_table_parse() calls early_acpi_os_unmap_memory() immediately
>>> after it calls pci_mcfg_parse(), so I'm doubtful that the pointer
>>> remains valid.
>>
>> At this stage early_acpi_os_unmap_memory() is doing nothing since
>> acpi_early_init() set acpi_gbl_permanent_mmap to 1 way before. The
>> pointer is fine then.
>
> Hmmm...  I see your argument, but this is a problem waiting to happen.
> We should not depend on the internal implementation of
> early_acpi_os_unmap_memory().  The pattern of:
>
>    y = x;
>    unmap(x);
>    z = *y;
>
> is just broken and we shouldn't expect readers to recognize that "oh,
> unmap() isn't really unmapping anything in this special case, so this
> looks wrong but is really fine."
>

Right, so we are back to MCFG cache.

Thanks,
Tomasz
