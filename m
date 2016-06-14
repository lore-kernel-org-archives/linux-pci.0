Return-Path: <jayachandran.c@broadcom.com>
Return-Path: <jayachandran.c@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20160611172457.GK16462@localhost>
References: <linux-pci@vger.kernel.org> <1462700001-30086-2-git-send-email-jchandra@broadcom.com>
 <20160611172457.GK16462@localhost>
From: Jayachandran C <jchandra@broadcom.com>
Date: Tue, 14 Jun 2016 21:40:36 +0530
Message-ID: <CAKc_7PXfydUJspWdgj6YT_VhFhHcjaK_PDTH+-dRYofW=4sQ3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: Handle Broadcom Vulcan DMA alias calculation quirk
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
	Linux PCI <linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	Robin Murphy <robin.murphy@arm.com>, marc.zyngier@arm.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

[Adding ARM GIC and SMMU maintainers]

On Sat, Jun 11, 2016 at 10:54 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sun, May 08, 2016 at 03:03:21PM +0530, Jayachandran C wrote:
>> The Broadcom Vulcan PCI topology is slightly unusual, for a multi-node
>> system, it looks like:
>>
>>  [bus 0]
>>      |
>>      +--[node 0 PCI bridge 0.0.0]
>>      |           |
>>      |        [bus 1]
>>      |           +---[SoC PCI devices 1.4.x, 1.5.x] ........
>>      |           +---[Glue bridges    1.a.x, 1.b.x]         \
>>      |                    |                        .....{node 0 GIC ITS}
>>      |                    |                       /
>>      |                    +----[SoC PCIe controller root ports]
>>      |                                |         \...... {SMMUv3 0..3}
>>      |                                |
>>      |                                +---- [external PCI devices]
>>      +- [node 1 PCI bridge 0.0.1]
>>      |           |
>>      |        [bus n - similar to bus 1 above]
>>      ...
>>
>> The for_each_dma_alias call for external PCI devices should not go
>> beyond the PCIe controllers where the SMMU and ITS is associated, going
>> further above to the glue bridges or the node bridges will find aliases
>> which are not valid. For internal devices, the association is at the
>> node level bridge and the alias search should not go further.
>
> I like the line of reasoning that we should not iterate higher in the
> hierarchy than where the translation hardware is attached.  That seems
> like a reasonable thing in general, not just for this hardware.
>
> Is there some generic way to learn where the translation hardware is
> attached?  If there is, we could make pci_for_each_dma_alias() use
> that information, and maybe we could solve the problem for other
> systems as well as for Vulcan.

There was discussion on using the return value of the callback function
to stop the alias search when we reach the bridge to which the IOMMU
or MSI controller is attached[1]. There was an iommu patch proposed to
handle this for the device tree case[2], It is possible that we can do
something similar for MSI and extend it to work when ACPI IORT is
used as well.

I will spend some time to see if this can be done.

JC.
[1] http://www.spinics.net/lists/linux-pci/msg51093.html
[2] http://www.spinics.net/lists/arm-kernel/msg508266.html
