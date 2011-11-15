Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-am1.bigfish.com ([213.199.180.138]:3154 "EHLO
	AM1EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752763Ab1KOUKJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2011 15:10:09 -0500
Message-ID: <4EC2C71A.9020609@freescale.com>
Date: Tue, 15 Nov 2011 14:10:02 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>,
	<chrisw@sous-sol.org>, <aik@au1.ibm.com>, <pmac@au1.ibm.com>,
	<joerg.roedel@amd.com>, <agraf@suse.de>, <benve@cisco.com>,
	<aafabbri@cisco.com>, <B08248@freescale.com>,
	<B07421@freescale.com>, <avi@redhat.com>, <konrad.wilk@oracle.com>,
	<kvm@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
References: <20111103195452.21259.93021.stgit@bling.home> <20111115063431.GA4921@truffala.fritz.box>
In-Reply-To: <20111115063431.GA4921@truffala.fritz.box>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/15/2011 12:34 AM, David Gibson wrote:
> I think we need to pin exactly what "MAP_ANY" means down better.  Now,
> VFIO is pretty much a lost cause if you can't map any normal process
> memory page into the IOMMU, so I think the only thing that is really
> covered is IOVAs.  But saying "can map any IOVA" is not clear, because
> if you can't map it, it's not a (valid) IOVA.  Better to say that
> IOVAs can be any 64-bit value, which I think is what you really mean
> here.

It also means that there are no restrictions on what the IOVA can be
within that range (other than page alignment), which isn't true on our
IOMMU.

We'll also need a way to communicate the desired geometry of the overall
IOMMU table (for this group) to the kernel, which determines what the
restrictions will be (we can't determine it automatically until we know
what all the translation requests will be, and even then it's awkward).

> On Thu, Nov 03, 2011 at 02:12:24PM -0600, Alex Williamson wrote:
>> +When a level triggered interrupt is signaled, the interrupt is masked
>> +on the host.  This prevents an unresponsive userspace driver from
>> +continuing to interrupt the host system.  After servicing the interrupt,
>> +UNMASK_IRQ is used to allow the interrupt to retrigger.  Note that level
>> +triggered interrupts implicitly have a count of 1 per index.
> 
> This is a silly restriction.  Even PCI devices can have up to 4 LSIs
> on a function in theory, though no-one ever does.  Embedded devices
> can and do have multiple level interrupts.

Those interrupts would each have their own index.  This is necessary for
level-triggered interrupts since they'll need to be individually
identifiable to VFIO_DEVICE_UNMASK_IRQ -- doesn't seem worth adding
another parameter to UNMASK.

>> +#ifdef CONFIG_COMPAT
>> +static long vfio_iommu_compat_ioctl(struct file *filep,
>> +				    unsigned int cmd, unsigned long arg)
>> +{
>> +	arg = (unsigned long)compat_ptr(arg);
>> +	return vfio_iommu_unl_ioctl(filep, cmd, arg);
> 
> Um, this only works if the structures are exactly compatible between
> 32-bit and 64-bit ABIs.  I don't think that is always true.

These are new structs, we can make it true.

>> +static int allow_unsafe_intrs;
>> +module_param(allow_unsafe_intrs, int, 0);
>> +MODULE_PARM_DESC(allow_unsafe_intrs,
>> +        "Allow use of IOMMUs which do not support interrupt remapping");
> 
> This should not be a global option, but part of the AMD/Intel IOMMU
> specific code.  In general it's a question of how strict the IOMMU
> driver is about isolation when it determines what the groups are, and
> only the IOMMU driver can know what the possibilities are for its
> class of hardware.

It's also a concern that is specific to MSIs.  In any case, I'm not sure
that the ability to cause a spurious IRQ is bad enough to warrant
disabling the entire subsystem by default on certain hardware.

Probably best to just print a warning on module init if there are any
known isolation holes, and let the admin decide whom (if anyone) to let
use this.  If the hole is bad enough that it must be confirmed, it
should require at most a sysfs poke.

-Scott

