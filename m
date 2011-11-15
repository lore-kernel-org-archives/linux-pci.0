Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtv-iport-4.cisco.com ([173.36.130.15]:62368 "EHLO
	mtv-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432Ab1KOVkP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2011 16:40:15 -0500
Date: Tue, 15 Nov 2011 13:40:11 -0800
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
From: Aaron Fabbri <aafabbri@cisco.com>
To: Scott Wood <scottwood@freescale.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	<chrisw@sous-sol.org>, <aik@au1.ibm.com>, <pmac@au1.ibm.com>,
	<joerg.roedel@amd.com>, <agraf@suse.de>, <benve@cisco.com>,
	<B08248@freescale.com>, <B07421@freescale.com>, <avi@redhat.com>,
	<konrad.wilk@oracle.com>, <kvm@vger.kernel.org>,
	<qemu-devel@nongnu.org>, <iommu@lists.linux-foundation.org>,
	<linux-pci@vger.kernel.org>
Message-ID: <CAE81C3B.12A00%aafabbri@cisco.com>
In-Reply-To: <4EC2C71A.9020609@freescale.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>




On 11/15/11 12:10 PM, "Scott Wood" <scottwood@freescale.com> wrote:

> On 11/15/2011 12:34 AM, David Gibson wrote:
<snip> 
>>> +static int allow_unsafe_intrs;
>>> +module_param(allow_unsafe_intrs, int, 0);
>>> +MODULE_PARM_DESC(allow_unsafe_intrs,
>>> +        "Allow use of IOMMUs which do not support interrupt remapping");
>> 
>> This should not be a global option, but part of the AMD/Intel IOMMU
>> specific code.  In general it's a question of how strict the IOMMU
>> driver is about isolation when it determines what the groups are, and
>> only the IOMMU driver can know what the possibilities are for its
>> class of hardware.
> 
> It's also a concern that is specific to MSIs.  In any case, I'm not sure
> that the ability to cause a spurious IRQ is bad enough to warrant
> disabling the entire subsystem by default on certain hardware.

I think the issue is more that the ability to create fake MSI interrupts can
lead to bigger exploits.

Originally we didn't have this parameter. It was added it to reflect the
fact that MSI's triggered by guests are dangerous without the isolation that
interrupt remapping provides.

That is, it *should* be inconvenient to run without interrupt mapping HW
support.

-Aaron

> Probably best to just print a warning on module init if there are any
> known isolation holes, and let the admin decide whom (if anyone) to let
> use this.  If the hole is bad enough that it must be confirmed, it
> should require at most a sysfs poke.
> 
> -Scott
> 

