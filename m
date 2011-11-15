Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:8934 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749Ab1KOWaE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2011 17:30:04 -0500
Message-ID: <4EC2E7E7.6010203@freescale.com>
Date: Tue, 15 Nov 2011 16:29:59 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Aaron Fabbri <aafabbri@cisco.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	<chrisw@sous-sol.org>, <aik@au1.ibm.com>, <pmac@au1.ibm.com>,
	<joerg.roedel@amd.com>, <agraf@suse.de>, <benve@cisco.com>,
	<B08248@freescale.com>, <B07421@freescale.com>, <avi@redhat.com>,
	<konrad.wilk@oracle.com>, <kvm@vger.kernel.org>,
	<qemu-devel@nongnu.org>, <iommu@lists.linux-foundation.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
References: <CAE81C3B.12A00%aafabbri@cisco.com>
In-Reply-To: <CAE81C3B.12A00%aafabbri@cisco.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/15/2011 03:40 PM, Aaron Fabbri wrote:
> 
> 
> 
> On 11/15/11 12:10 PM, "Scott Wood" <scottwood@freescale.com> wrote:
> 
>> On 11/15/2011 12:34 AM, David Gibson wrote:
> <snip> 
>>>> +static int allow_unsafe_intrs;
>>>> +module_param(allow_unsafe_intrs, int, 0);
>>>> +MODULE_PARM_DESC(allow_unsafe_intrs,
>>>> +        "Allow use of IOMMUs which do not support interrupt remapping");
>>>
>>> This should not be a global option, but part of the AMD/Intel IOMMU
>>> specific code.  In general it's a question of how strict the IOMMU
>>> driver is about isolation when it determines what the groups are, and
>>> only the IOMMU driver can know what the possibilities are for its
>>> class of hardware.
>>
>> It's also a concern that is specific to MSIs.  In any case, I'm not sure
>> that the ability to cause a spurious IRQ is bad enough to warrant
>> disabling the entire subsystem by default on certain hardware.
> 
> I think the issue is more that the ability to create fake MSI interrupts can
> lead to bigger exploits.
> 
> Originally we didn't have this parameter. It was added it to reflect the
> fact that MSI's triggered by guests are dangerous without the isolation that
> interrupt remapping provides.
> 
> That is, it *should* be inconvenient to run without interrupt mapping HW
> support.

A sysfs knob is sufficient inconvenience.  It should only affect whether
you can use MSIs, and the relevant issue shouldn't be "has interrupt
remapping" but "is there a hole".

Some systems might address the issue in ways other than IOMMU-level MSI
translation.  Our interrupt controller provides enough separate 4K pages
for MSI interrupt delivery for each PCIe IOMMU group to get its own (we
currently only have 3, one per root complex) -- no special IOMMU feature
required.

It doesn't help that the semantics of IOMMU_CAP_INTR_REMAP are
undefined.  I shouldn't have to know how x86 IOMMUs work when
implementing a driver for different hardware, just to know what the
generic code is expecting.

As David suggests, if you want to do this it should be the x86 IOMMU
driver that has a knob that controls how it forms groups in the absence
of this support.

-Scott

