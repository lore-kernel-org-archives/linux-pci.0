Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3077 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758269Ab2HJPBy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Aug 2012 11:01:54 -0400
Message-ID: <5025225E.6000008@redhat.com>
Date: Fri, 10 Aug 2012 11:01:50 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Prarit Bhargava <prarit@redhat.com>, linux-pci@vger.kernel.org,
	Myron Stowe <mstowe@redhat.com>
Subject: Re: [PATCH] pci, rename subordinate bus to secondary bus
References: <1343998156-1037-1-git-send-email-prarit@redhat.com> <CAErSpo6sFdQSObsRLdyNPcrqhONMcjbjcbAR0xyGa-z0Pex-iQ@mail.gmail.com>
In-Reply-To: <CAErSpo6sFdQSObsRLdyNPcrqhONMcjbjcbAR0xyGa-z0Pex-iQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/03/2012 12:17 PM, Bjorn Helgaas wrote:
> On Fri, Aug 3, 2012 at 6:49 AM, Prarit Bhargava<prarit@redhat.com>  wrote:
>> The PCI-to-PCI Bridge Architecture Specification defines a secondary
>> interface (commonly known as a secondary bus) as "The PCI interface of the
>> bridge that is connected to the PCI bus farthest from the CPU is referred
>> to as the secondary PCI interface."
>>
>> The term subordinate bus number is used to define "the bus number of the
>> highest numbered PCI bus segment which is behind (or subordinate to) the
>> bridge".
>>
>> The current code tree mixes up these terms such that pci_dev->subordinate
>> is really the secondary interface.  This gets confusing as other areas
>> of the code use proper terminology for subordinate and secondary.
>>
>> This is a cleanup that renames pci_dev->subordinate to pci_dev->secondary,
>> and cleans up some comments referring to the secondary and subordinate
>> busses.
>
> I think this or something similar might be worthwhile eventually, but
> I'm not sure we're quite ready yet.  I hesitate because this feels
> like one small piece of PCI namespace cleanup, and I think it would be
> good to settle on a plan for a more extensive reorganization that we
> could do all at once.  I don't think it's obvious yet what that would
> look like.  This might be one part, collecting P2P bridge-related
> things into one place (they're currently scattered around pci_dev and
> pci_bus), giving busn_res a better name might be another,  etc.
>
+1.
pci-dev could stand a good cleaning up, so if we're going to churn
pci-dev users/consumers, we ought to roll this into a larger cleanup.
Maybe we can hash some of this out at PCI mini-summit.

> Also, I think this specific change would affect all architectures, and
> this patch only fixes x86.
>
yup.

> When we're ready to do this, I wonder if it could be done completely
> mechanically by Coccinelle?  If it could, that would be a nice way of
> encapsulating the effort so the patch doesn't bit-rot.
>
oh; /me looks up Coccinelle ...

>>   arch/x86/pci/fixup.c                      |    3 ++-
>>   arch/x86/pci/sta2x11-fixup.c              |    4 ++--
>>   drivers/acpi/pci_bind.c                   |   12 ++++++------
>>   drivers/acpi/pci_root.c                   |    4 ++--
>>   drivers/acpi/pci_slot.c                   |    6 +++---
>>   drivers/infiniband/hw/mthca/mthca_reset.c |    2 +-
>>   drivers/iommu/dmar.c                      |    6 +++---
>>   drivers/iommu/intel-iommu.c               |   18 +++++++++---------
>>   drivers/net/ethernet/broadcom/tg3.c       |   16 ++++++++--------
>>   drivers/pci/bus.c                         |   14 +++++++-------
>>   drivers/pci/hotplug-pci.c                 |    2 +-
>>   drivers/pci/hotplug/acpiphp_glue.c        |   26 +++++++++++++-------------
>>   drivers/pci/hotplug/cpcihp_generic.c      |    2 +-
>>   drivers/pci/hotplug/cpcihp_zt5550.c       |    2 +-
>>   drivers/pci/hotplug/cpqphp_core.c         |    2 +-
>>   drivers/pci/hotplug/cpqphp_pci.c          |    2 +-
>>   drivers/pci/hotplug/ibmphp_core.c         |    2 +-
>>   drivers/pci/hotplug/pciehp_core.c         |    6 +++---
>>   drivers/pci/hotplug/pciehp_ctrl.c         |    6 +++---
>>   drivers/pci/hotplug/pciehp_hpc.c          |    4 ++--
>>   drivers/pci/hotplug/pciehp_pci.c          |    4 ++--
>>   drivers/pci/hotplug/pcihp_slot.c          |    6 +++---
>>   drivers/pci/hotplug/rpadlpar_core.c       |    4 ++--
>>   drivers/pci/hotplug/sgi_hotplug.c         |   14 +++++++-------
>>   drivers/pci/hotplug/shpchp_core.c         |    6 +++---
>>   drivers/pci/hotplug/shpchp_ctrl.c         |    4 ++--
>>   drivers/pci/hotplug/shpchp_hpc.c          |    4 ++--
>>   drivers/pci/hotplug/shpchp_pci.c          |    4 ++--
>>   drivers/pci/hotplug/shpchp_sysfs.c        |    2 +-
>>   drivers/pci/pci-acpi.c                    |    4 ++--
>>   drivers/pci/pci-sysfs.c                   |   16 ++++++++--------
>>   drivers/pci/pci.c                         |   10 +++++-----
>>   drivers/pci/pci.h                         |    2 +-
>>   drivers/pci/pcie/aer/aerdrv.c             |    4 ++--
>>   drivers/pci/pcie/aer/aerdrv_core.c        |   11 ++++++-----
>>   drivers/pci/pcie/aspm.c                   |   18 +++++++++---------
>>   drivers/pci/pcie/pme.c                    |    8 ++++----
>>   drivers/pci/pcie/portdrv_pci.c            |    6 +++---
>>   drivers/pci/probe.c                       |    4 ++--
>>   drivers/pci/quirks.c                      |   27 ++++++++++++---------------
>>   drivers/pci/remove.c                      |   22 +++++++++++-----------
>>   drivers/pci/setup-bus.c                   |   26 +++++++++++++-------------
>>   drivers/pcmcia/cardbus.c                  |    6 +++---
>>   drivers/pcmcia/yenta_socket.c             |   22 +++++++++++++---------
>>   drivers/platform/x86/eeepc-laptop.c       |    2 +-
>>   include/linux/pci.h                       |    2 +-
>>   46 files changed, 190 insertions(+), 187 deletions(-)
