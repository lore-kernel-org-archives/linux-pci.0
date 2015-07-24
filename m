Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout3.freenet.de ([195.4.92.93]:36049 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030AbbGXSEY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 24 Jul 2015 14:04:24 -0400
Subject: Re: Since Linux 4.1: A lot of AMD-Vi IO_PAGE_FAULTs
To: Bjorn Helgaas <bhelgaas@google.com>
References: <55AE5F84.5020204@01019freenet.de>
 <1437492886.1391.847.camel@redhat.com> <20150721155635.GE10969@8bytes.org>
 <55AE7147.7070902@maya.org> <20150721163517.GG10969@8bytes.org>
 <55B1BDA3.3030507@maya.org>
 <CAErSpo666MBxpDe+uPvfVc7LPJsJQsVTusBhHygtwbou5GGj1w@mail.gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
From: Andreas Hartmann <andihartmann@freenet.de>
Message-ID: <55B27CEB.6010007@maya.org>
Date: Fri, 24 Jul 2015 19:59:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAErSpo666MBxpDe+uPvfVc7LPJsJQsVTusBhHygtwbou5GGj1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

New information: During testing, I now realized that Linux 4.0.9 shows
the same problem ... . I'm now testing 3.19.4.


Regards,
Andreas


On 07/24/2015 at 06:15 PM, Bjorn Helgaas wrote:
> [+cc Tejun, linux-ide]
> 
> On Thu, Jul 23, 2015 at 11:22 PM, Andreas Hartmann
> <andihartmann@freenet.de> wrote:
>> On Tue, Jul 21, 2015 at 06:35PM +0200, Joerg Roedel wrote:
>>> On Tue, Jul 21, 2015 at 06:20:23PM +0200, Andreas Hartmann wrote:
>>>> [   48.193901] <6>[fglrx] Firegl kernel thread PID: 1840
>>>> [   48.193985] <6>[fglrx] Firegl kernel thread PID: 1841
>>>> [   48.194063] <6>[fglrx] Firegl kernel thread PID: 1842
>>>> [   48.194172] <6>[fglrx] IRQ 28 Enabled
>>>> [   48.261580] <6>[fglrx] Reserved FB block: Shared offset:0, size:1000000
>>>> [   48.261586] <6>[fglrx] Reserved FB block: Unshared offset:f7b4000, size:4000
>>>> [   48.261587] <6>[fglrx] Reserved FB block: Unshared offset:f7b8000, size:548000
>>>> [   48.261588] <6>[fglrx] Reserved FB block: Unshared offset:3fff3000, size:d000
>>>
>>> From a first glance it doesn't look like an IOMMU driver issue, because
>>> the addresses where the faults happen are not from the AMD IOMMU driver.
>>>
>>> And you have proprietary closed-source drivers loaded, can you reproduce
>>> the issue without fglrx?
>>
>> Yes. I attached this one.
>>
>> Meanwhile I tested with 4.0.9, too. I wasn't able to reproduce the
>> problem with this kernel even after lots of reboots (the problem w/ 4.1
>> usually comes up during boot process (but not only - it can be seen
>> after boot process, too)).
>>
>> The problem always is, that there are errors w/ one of the sata discs
>> and at the same time, IO_PAGE_FAULT errors are rising as described before:
>>
>> [  152.533708] ata3.00: failed command: READ FPDMA QUEUED
>> [  152.538102] ata3.00: failed command: READ FPDMA QUEUED
>> [  152.539862] ata3.00: failed command: READ FPDMA QUEUED
>> [  152.541778] ata3.00: failed command: WRITE FPDMA QUEUED
>> [  152.543861] ata3.00: failed command: WRITE FPDMA QUEUED
>>
>> [ 5818.068050] ata2.00: failed command: WRITE FPDMA QUEUED
>> [ 5818.068059] ata2.00: failed command: WRITE FPDMA QUEUED
>>
>> I compared dmesg from 4.1 w/ 4.0 and I realized the following *missing*
>> entries in 4.1:
>>
>> [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
>> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
>> [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
>> [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
>> [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] enabled)
>> [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] enabled)
>> [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
>> [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
>>
>>
>> What does this mean? Is there missing some part of the acpi initialization?
>>
>>
>> Thanks for any hint as Linux 4.1 is completely unusable here with these
>> errors.
> 
> This looks more like an AHCI problem than an IOMMU or PCI problem.
> Seems like the device has the wrong idea about where its DMA buffers
> are.  Maybe something scribbled on its command list?
> 
> From your attachments:
> 
> # lspci -vvs 00:11.0
> 00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI]
> SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40) (prog-if 01 [AHCI
> 1.0])
> 
> pci 0000:00:11.0: [1002:4391] type 00 class 0x010601
> ahci 0000:00:11.0: version 3.0
> ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
> ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part
> AMD-Vi: Event logged [IO_PAGE_FAULT device=00:11.0 domain=0x0008
> address=0x40eba32100618000 flags=0x0010]
> AMD-Vi: Event logged [IO_PAGE_FAULT device=00:11.0 domain=0x0008
> address=0x40eba32100618040 flags=0x0010]
> AMD-Vi: Event logged [IO_PAGE_FAULT device=00:11.0 domain=0x0008
> address=0x0000000000000000 flags=0x0000]
> AMD-Vi: Event logged [IO_PAGE_FAULT device=00:11.0 domain=0x0008
> address=0x00000000000000c0 flags=0x0000]
> AMD-Vi: Event logged [IO_PAGE_FAULT device=00:11.0 domain=0x0008
> address=0x0000000000000040 flags=0x0000]
> AMD-Vi: Event logged [IO_PAGE_FAULT device=00:11.0 domain=0x0008
> address=0x00000000000001c0 flags=0x0000]
> 

