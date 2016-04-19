Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:38122 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbcDSLPW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 07:15:22 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Tue, 19 Apr 2016 21:15:19 +1000
Subject: Re: [RFC v6 06/10] PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
To: David Laight <David.Laight@ACULAB.COM>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <1460977120-29367-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4A45A8@AcuExch.aculab.com>
Cc: "alistair@popple.id.au" <alistair@popple.id.au>,
	"nikunj@linux.vnet.ibm.com" <nikunj@linux.vnet.ibm.com>,
	"zhong@linux.vnet.ibm.com" <zhong@linux.vnet.ibm.com>,
	"eric.auger@linaro.org" <eric.auger@linaro.org>,
	"aik@ozlabs.ru" <aik@ozlabs.ru>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"gwshan@linux.vnet.ibm.com" <gwshan@linux.vnet.ibm.com>,
	"warrier@linux.vnet.ibm.com" <warrier@linux.vnet.ibm.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"paulus@samba.org" <paulus@samba.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <571612F2.1080502@linux.vnet.ibm.com>
Date: Tue, 19 Apr 2016 19:13:54 +0800
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4A45A8@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/4/18 19:30, David Laight wrote:
> From: Yongji Xie
>> Sent: 18 April 2016 11:59
>> We introduce a new pci_bus_flags, PCI_BUS_FLAGS_MSI_REMAP
>> which indicates all devices on the bus are protected by the
>> hardware which supports IRQ remapping(intel naming).
>>
>> This flag will be used to know whether it's safe to expose
>> MSI-X tables of PCI BARs to userspace. Because the capability
>> of IRQ remapping can guarantee the PCI device cannot trigger
>> MSIs that correspond to interrupt IDs of other devices.
> I'm worried that this entire series is going to break drivers
> for existing hardware.
>
> I understand some of the reasoning for 'vm pass through' configurations,
> but there will be PCIe devices out there that have the MSI-X tables
> in the same BAR as other device registers.
> If you are lucky nothing else is in the same 4k area, but I wouldn't
> assume it.

Thanks for your comments. But I didn't get your point here.
Why will exposing MSI-X table to userspace break the driver
for hardware which have the MSI-X tables in the same BAR as
other device registers? Could you give me more details?

The reason why we want to mmap MSI-X table is that there
may be some other critical device registers in the same page
as the MSI-X table. We prefer to handle the mmio access to
these registers in guest rather than in QEMU. So we would
like to see there is something else in the same 4k/64k area.

> In any case, if the hardware can't police the card's master transfers
> there is nothing to stop a different bus master block on the card
> from raising MSI-X interrupts - they are just a PCIe write.
> So all you are doing is raising the bar slightly and giving a very false
> sense of security.

Do you mean we can request a DMA to the target address
area that raises MSI-X interrupts? But for PPC64 with IODA
bridge, this invalid PCIe write will be prevented on PHB before
raising MSI-X interrupt. And I think the capability of interrupt
remapping or ITS can also do the same thing. If hardware didn't
support this, we would not expose MSI-X table in my patch.

Thanks,
Yongji

