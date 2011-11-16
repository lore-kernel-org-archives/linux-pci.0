Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12160 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962Ab1KPXfA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Nov 2011 18:35:00 -0500
Message-ID: <1321486477.26410.38.camel@bling.home>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: Scott Wood <scottwood@freescale.com>
Cc: Aaron Fabbri <aafabbri@cisco.com>, chrisw@sous-sol.org,
	aik@au1.ibm.com, pmac@au1.ibm.com, joerg.roedel@amd.com,
	agraf@suse.de, benve@cisco.com, B08248@freescale.com,
	B07421@freescale.com, avi@redhat.com, konrad.wilk@oracle.com,
	kvm@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Date: Wed, 16 Nov 2011 16:34:37 -0700
In-Reply-To: <4EC2E7E7.6010203@freescale.com>
References: <CAE81C3B.12A00%aafabbri@cisco.com>
	 <4EC2E7E7.6010203@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2011-11-15 at 16:29 -0600, Scott Wood wrote:
> On 11/15/2011 03:40 PM, Aaron Fabbri wrote:
> > 
> > 
> > 
> > On 11/15/11 12:10 PM, "Scott Wood" <scottwood@freescale.com> wrote:
> > 
> >> On 11/15/2011 12:34 AM, David Gibson wrote:
> > <snip> 
> >>>> +static int allow_unsafe_intrs;
> >>>> +module_param(allow_unsafe_intrs, int, 0);
> >>>> +MODULE_PARM_DESC(allow_unsafe_intrs,
> >>>> +        "Allow use of IOMMUs which do not support interrupt remapping");
> >>>
> >>> This should not be a global option, but part of the AMD/Intel IOMMU
> >>> specific code.  In general it's a question of how strict the IOMMU
> >>> driver is about isolation when it determines what the groups are, and
> >>> only the IOMMU driver can know what the possibilities are for its
> >>> class of hardware.
> >>
> >> It's also a concern that is specific to MSIs.  In any case, I'm not sure
> >> that the ability to cause a spurious IRQ is bad enough to warrant
> >> disabling the entire subsystem by default on certain hardware.
> > 
> > I think the issue is more that the ability to create fake MSI interrupts can
> > lead to bigger exploits.
> > 
> > Originally we didn't have this parameter. It was added it to reflect the
> > fact that MSI's triggered by guests are dangerous without the isolation that
> > interrupt remapping provides.
> > 
> > That is, it *should* be inconvenient to run without interrupt mapping HW
> > support.
> 
> A sysfs knob is sufficient inconvenience.  It should only affect whether
> you can use MSIs, and the relevant issue shouldn't be "has interrupt
> remapping" but "is there a hole".
> 
> Some systems might address the issue in ways other than IOMMU-level MSI
> translation.  Our interrupt controller provides enough separate 4K pages
> for MSI interrupt delivery for each PCIe IOMMU group to get its own (we
> currently only have 3, one per root complex) -- no special IOMMU feature
> required.
> 
> It doesn't help that the semantics of IOMMU_CAP_INTR_REMAP are
> undefined.  I shouldn't have to know how x86 IOMMUs work when
> implementing a driver for different hardware, just to know what the
> generic code is expecting.
> 
> As David suggests, if you want to do this it should be the x86 IOMMU
> driver that has a knob that controls how it forms groups in the absence
> of this support.

That is a possibility, we could push it down to the iommu driver which
could simply lump everything into a single groupid when interrupt
remapping is not supported.  Or more directly, when there is an exposure
that devices can trigger random MSIs in the host.  Then we wouldn't need
an option to override this in vfio, you'd just be stuck not being able
to use any devices if you can't bind everything to vfio.  That also
eliminates the possibility of flipping it on dynamically since we can't
handle groupids changing.  Then we'd need an iommu=group_unsafe_msi flag
to enable it.  Ok?  Thanks,

Alex

