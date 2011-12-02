Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:5033
	"EHLO AM1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932066Ab1LBSV1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2011 13:21:27 -0500
Message-ID: <4ED9171B.8060500@freescale.com>
Date: Fri, 2 Dec 2011 12:21:15 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Stuart Yoder <b08248@gmail.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	Alexey Kardashevskiy <aik@au1.ibm.com>, <aafabbri@cisco.com>,
	<kvm@vger.kernel.org>, <pmac@au1.ibm.com>, <qemu-devel@nongnu.org>,
	<joerg.roedel@amd.com>, <konrad.wilk@oracle.com>, <agraf@suse.de>,
	<dwg@au1.ibm.com>, <chrisw@sous-sol.org>, <B08248@freescale.com>,
	<iommu@lists.linux-foundation.org>, <avi@redhat.com>,
	<linux-pci@vger.kernel.org>, <B07421@freescale.com>,
	<benve@cisco.com>
Subject: Re: [Qemu-devel] [RFC PATCH] vfio: VFIO Driver core framework
References: <20111103195452.21259.93021.stgit@bling.home> <4ED43AD9.5090509@au1.ibm.com> <4ED43CFE.8040009@au1.ibm.com> <1322538856.19120.126.camel@bling.home> <1322594768.19120.194.camel@bling.home> <CALRxmdDEGwA787gEgC3d_yU99TqOZOtWeDJ9N-QCQ3gxV8yyMw@mail.gmail.com> <1322610273.19120.209.camel@bling.home> <CALRxmdBaguEZD8CnogHv+mSPuLx9et1CGRAa8oO_182Pjjp6-Q@mail.gmail.com> <1322672293.19120.232.camel@bling.home> <CALRxmdAjeyyM3Ta+DCTxtdc_J69fnVko_9hzmjcLUCe8SskNnQ@mail.gmail.com> <1322774717.26545.118.camel@bling.home> <CALRxmdDZjFGjdrEC5e1ANGV+PYd5Mz7j3zeaKNiEUwLdNzmiEA@mail.gmail.com>
In-Reply-To: <CALRxmdDZjFGjdrEC5e1ANGV+PYd5Mz7j3zeaKNiEUwLdNzmiEA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/02/2011 08:40 AM, Stuart Yoder wrote:
> On Thu, Dec 1, 2011 at 3:25 PM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
>> On Thu, 2011-12-01 at 14:58 -0600, Stuart Yoder wrote:
>>> One other mechanism we need as well is the ability to
>>> enable/disable a domain.
>>>
>>> For example-- suppose a device is assigned to a VM, the
>>> device is in use when the VM is abruptly terminated.  The
>>> VM terminate would shut off DMA at the IOMMU, but now
>>> the device is in an indeterminate state.   Some devices
>>> have no simple reset bit and getting the device back into
>>> a sane state could be complicated-- something the hypervisor
>>> doesn't want to do.
>>>
>>> So now KVM restarts the VM, vfio init happens for the device
>>> and  the IOMMU for that device is re-configured,
>>> etc, but we really can't re-enable DMA until the guest OS tells us
>>> (via an hcall) that it is ready.   The guest needs to get the
>>> assigned device in a sane state before DMA is enabled.
>>
>> Giant red flag.  We need to paravirtualize the guest?  Not on x86.
> 
> It's the reality we have to deal with, but doing this would obviously
> only apply to platforms that need it.

By "x86" I assume you mean "PCI" and thus a bus-master enable flag that
you rely on the guest not setting until the device has been reset or
otherwise quiesced from any previous activity, in the absence of
function-level reset.

We don't have such a thing on our non-PCI devices.

>> Some
>> devices are better for assignment than others.  PCI devices are moving
>> towards supporting standard reset mechanisms.
>>
>>> Does this warrant a new domain enable/disable API, or should
>>> we make this part of the setup API we are discussing
>>> here?
>>
>> What's wrong with simply not adding any DMA mapping entries until you
>> think your guest is ready?  Isn't that effectively the same thing?
>> Unmap ~= disable.  If the IOMMU API had a mechanism to toggle the iommu
>> domain on and off, I wouldn't be opposed to adding an ioctl to do it,
>> but it really seems like just a shortcut vs map/unmap.  Thanks,
> 
> Yes, we could do something like that I guess.

It would mean that we don't see any errors relating to impossible map
requests until after the guest is running and decides to enable DMA.
Depending on how PAMU table allocation is handled, it could introduce a
risk of failing even later when a guest reboots and we need to
temporarily disable DMA (e.g. if another vfio user consumes the same
table space for another group in the meantime).

It would add latency to failovers -- some customers have somewhat tight
requirements there.

-Scott

