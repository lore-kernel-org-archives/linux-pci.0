Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] PCI: iproc: enable arm64 support for iProc PCIe
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1437021563-29139-1-git-send-email-rjui@broadcom.com>
 <1437021563-29139-2-git-send-email-rjui@broadcom.com>
 <20150721203018.GH21967@google.com> <55AEB094.1090601@broadcom.com>
 <20150721220259.GK21967@google.com>
CC: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <55AEDD3E.6060808@broadcom.com>
Date: Tue, 21 Jul 2015 17:01:02 -0700
MIME-Version: 1.0
In-Reply-To: <20150721220259.GK21967@google.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 7/21/2015 3:02 PM, Bjorn Helgaas wrote:
> On Tue, Jul 21, 2015 at 01:50:28PM -0700, Ray Jui wrote:
>>
>>
>> On 7/21/2015 1:30 PM, Bjorn Helgaas wrote:
>>> On Wed, Jul 15, 2015 at 09:39:20PM -0700, Ray Jui wrote:
>>>> This patch enables arm64 support to the iProc PCIe driver
>>>
>>> This needs a little more explanation: ARM has a common struct pci_sys_data
>>> but ARM64 does not,
>>
>> Correct, and according to Arnd, there's already work in process of
>> removing the need for pci_sys_data on arm32. Before that is done, we
>> need this in the driver for it to work on both arm32 and arm64.
>>
>> and ARM needs pci_fixup_irqs() but ARM64 does not (why
>>> not?),
>>
>> under arch/arm64/kernel/pci.c:
>>
>>  41 /*
>>  42  * Try to assign the IRQ number from DT when adding a new device
>>  43  */
>>  44 int pcibios_add_device(struct pci_dev *dev)
>>  45 {
>>  46         dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>>  47
>>  48         return 0;
>>  49 }
>>
>> interrupt is automatically parsed and mapped when adding a new device
>> for arm64.
>>
>> ARM uses the common pci_sys_data for the PCI sysdata while ARM64
>>> uses a driver-specific sysdata, etc.
>>
>> Correct. pci_sys_data for arm32 will eventually be removed, so all arm32
>> based PCie host should only need to carry driver specific sysdata.
> 
> That all makes sense.  I'm just looking for a condensed version of it in
> the changelog because it takes some digging to figure it out, and in a
> couple months even the implicit context of "somebody's working to combine
> arm32 and arm64" will be gone.  So we need a changelog that motivates this
> patch as it is.
> 

Okay I will re-submit a new patch with a commit message that explains
the change in more details.

Thanks,

Ray
