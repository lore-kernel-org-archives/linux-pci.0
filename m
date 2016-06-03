Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <201606030228.u532PSG8045852@mx0a-001b2d01.pphosted.com>
Subject: Re: [RESEND PATCH v2 0/6] vfio-pci: Add support for mmapping MSI-X
 table
To: Alex Williamson <alex.williamson@redhat.com>
References: <1464847803-22756-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160602071132.273c64c7@ul30vt.home>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org, bhelgaas@google.com,
	aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
	mpe@ellerman.id.au, joro@8bytes.org, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	eric.auger@linaro.org, will.deacon@arm.com,
	gwshan@linux.vnet.ibm.com, alistair@popple.id.au,
	ruscur@russell.cc, kevin.tian@intel.com, David.Laight@ACULAB.COM
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Fri, 3 Jun 2016 10:28:21 +0800
MIME-Version: 1.0
In-Reply-To: <20160602071132.273c64c7@ul30vt.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Alex

On 2016/6/2 21:11, Alex Williamson wrote:

> AFAICT, you posted this *3* days ago, has something changed here or is
> this just expedited nagging for review?  This also depends on a
> non-upstream series and crosses multiple functional areas, all of which
> make it difficult for maintainers to actually do anything with this
> series.  Thanks,
>
> Alex

I resend this series because I found the message-id of the previous email
is changed unexpectedly. The cover letter is not in the same thread as other
patches.  It would be a little hard for people to review.

Thanks,
Yongji

> On Thu,  2 Jun 2016 14:09:57 +0800
> Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:
>
>> Current vfio-pci implementation disallows to mmap the page
>> containing MSI-X table in case that users can write directly
>> to MSI-X table and generate an incorrect MSIs.
>>
>> However, this will cause some performance issue when there
>> are some critical device registers in the same page as the
>> MSI-X table. We have to handle the mmio access to these
>> registers in QEMU emulation rather than in guest.
>>
>> To solve this issue, this series allows to expose MSI-X table
>> to userspace when hardware enables the capability of interrupt
>> remapping which can ensure that a given PCI device can only
>> shoot the MSIs assigned for it. And we introduce a new bus_flags
>> PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side
>> for different archs.
>>
>> The patch 3 are based on the proposed patchset[1].
>>
>> Changelog v2:
>> - Make the commit log more clear
>> - Replace pci_bus_check_msi_remapping() with pci_bus_msi_isolated()
>>    so that we could clearly know what the function does
>> - Set PCI_BUS_FLAGS_MSI_REMAP in pci_create_root_bus() instead
>>    of iommu_bus_notifier()
>> - Reserve VFIO_REGION_INFO_FLAG_CAPS when we allow to mmap MSI-X
>>    table so that we can know whether we allow to mmap MSI-X table
>>    in QEMU
>>
>> [1] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1138820.html
>>
>> Yongji Xie (6):
>>    PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
>>    PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller enables IRQ remapping
>>    PCI: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have capability of IRQ remapping
>>    iommu: Set PCI_BUS_FLAGS_MSI_REMAP on iommu driver initialization
>>    pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
>>    vfio-pci: Allow to expose MSI-X table to userspace if interrupt remapping is enabled
>>
>>   arch/powerpc/platforms/powernv/pci-ioda.c |    8 ++++++++
>>   drivers/iommu/iommu.c                     |    8 ++++++++
>>   drivers/pci/msi.c                         |   15 +++++++++++++++
>>   drivers/pci/probe.c                       |    7 +++++++
>>   drivers/vfio/pci/vfio_pci.c               |   17 ++++++++++++++---
>>   drivers/vfio/pci/vfio_pci_rdwr.c          |    3 ++-
>>   include/linux/msi.h                       |    5 ++++-
>>   include/linux/pci.h                       |    1 +
>>   8 files changed, 59 insertions(+), 5 deletions(-)
>>
