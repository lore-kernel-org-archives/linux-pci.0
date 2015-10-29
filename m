Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
To: Sinan Kaya <okaya@codeaurora.org>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <5631180D.2000902@codeaurora.org> <563131B0.9060305@codeaurora.org>
 <563233EE.1090907@codeaurora.org>
Cc: jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <563248DB.9020900@semihalf.com>
Date: Thu, 29 Oct 2015 17:27:07 +0100
MIME-Version: 1.0
In-Reply-To: <563233EE.1090907@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 29.10.2015 15:57, Sinan Kaya wrote:
>
>
> On 10/28/2015 4:36 PM, Sinan Kaya wrote:
>> 2. The second problem is about the PCIe resources.
>>
>> pci_0000:01:00.0:_can't_enable_device:_BAR_0_[mem_0x80100100000-0x80100101fff_64bit]_not_claimed
>>
>>
>> pci 0000:01:00.0: Can't enable PCI device, BIOS handoff failed.
>> pci 0000:00:00.0: BAR 14: assigned [mem 0x80100100000-0x801003fffff]
>> pci 0000:00:00.0: BAR 13: no space for [io  size 0x1000]
>> pci 0000:00:00.0: BAR 13: failed to assign [io  size 0x1000]
>> pci 0000:00:00.0: BAR 13: no space for [io  size 0x1000]
>> pci 0000:00:00.0: BAR 13: failed to assign [io  size 0x1000]
>> pci 0000:01:00.0: BAR 0: assigned [mem 0x80100100000-0x80100101fff 64bit]
>>
>> For some reason, the kernel is unable to assign resources.
>>
>> I appreciate any pointers you might give.
>
> Tomasz,
> I debugged this part of the problem yesterday night.
>
> I have one set up with 4.2 kernel and Mark Salter's original ACPI PCIE
> patch. His patchwork works fine with our ACPI table.
>
> This is what IO resource looks like in our table. PCI IO is supported
> using the ACPI translation attribute on ARM systems.
>
> QWORDIO(            // produced resource
>      ResourceProducer,    // bit 0 of general flags is 0
>      MinFixed,        // Range is fixed
>      MaxFixed,        // Range is fixed
>      PosDecode,
>      EntireRange,
>      0x0000,            // Granularity
>      0x1000,            // Min,
>      0xFFFF,            // Max
>      0x8FFFFFEF000,        // Translation
>      0xF000,            // Range Length
>      ,, PI00
>   )
>
> It looks like you are missing the translation support for the IO
> aperture and Mark Salter's patch has this support.
>
> Yours is missing in pci_acpi_root_prepare_resources function here.
> Mark's patch uses the offset argument to reorganize the resource.
>
>
> +            resource_size_t length = res->end - res->start;
> +
> +            err = pci_register_io_range(res->start, length);
> +            if (err) {
> +                resource_list_destroy_entry(entry);
> +                continue;
> +            }
> +
> +            port = pci_address_to_pio(res->start);
> +            if (port == (unsigned long)-1) {
> +                resource_list_destroy_entry(entry);
> +                continue;
> +            }
> +
> +            res->start = port;
> +            res->end = res->start + length - 1;
> +
> +            if (pci_remap_iospace(res, res->start) < 0)
> +                resource_list_destroy_entry(entry);
>
>

Thanks for the heads up, working on it.

Regards,
Tomasz


