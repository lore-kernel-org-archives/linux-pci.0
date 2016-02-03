Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0105.outbound.protection.outlook.com ([157.56.110.105]:48539
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965675AbcBCWWr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2016 17:22:47 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH RESEND 3/3] PCI: hv: New paravirtual PCI front-end for
 Hyper-V VMs
Date: Wed, 3 Feb 2016 22:22:44 +0000
Message-ID: <DM2PR0301MB1232CA7B094EC389000BB733ABD00@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1454434903-1680-1-git-send-email-jakeo@microsoft.com>
 <1454434903-1680-4-git-send-email-jakeo@microsoft.com>
 <20160203212904.GF10879@localhost>
In-Reply-To: <20160203212904.GF10879@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Wednesday, February 3, 2016 1:29 PM
> To: Jake Oshins <jakeo@microsoft.com>
> Cc: gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; Haiyang Zhang
> <haiyangz@microsoft.com>; marc.zyngier@arm.com;
> bhelgaas@google.com; linux-pci@vger.kernel.org
> Subject: Re: [PATCH RESEND 3/3] PCI: hv: New paravirtual PCI front-end for
> Hyper-V VMs
> 
> Hi Jake,
> 
> On Tue, Feb 02, 2016 at 05:41:43PM +0000, jakeo@microsoft.com wrote:
> > From: Jake Oshins <jakeo@microsoft.com>
> >
> > This patch introduces a new driver which exposes a root PCI bus whenever
> a
> > PCI Express device is passed through to a guest VM under Hyper-V. The
> > device can be single- or multi-function. The interrupts for the devices
> > are managed by an IRQ domain, implemented within the driver.

[lots of stuff snipped out]

> > +/**
> > + * hv_pci_free_bridge_windows() - Release memory regions for the
> > + * bus
> > + * @hbus:	Root PCI bus, as understood by this driver
> > + */
> > +static void hv_pci_free_bridge_windows(struct hv_pcibus_device *hbus)
> > +{
> > +	if (hbus->low_mmio_space && hbus->low_mmio_res) {
> > +		hbus->low_mmio_res->flags |= IORESOURCE_BUSY;
> 
> Drivers should not normally set or clear IORESOURCE_BUSY themselves.
> 
> > +		release_mem_region(hbus->low_mmio_res->start,
> > +				   resource_size(hbus->low_mmio_res));
> 
> Usually there's a request_mem_region() to correspond with a
> release_mem_region(), and that takes care of IORESOURCE_BUSY.
> 
> What's unique about this driver, and can you make it less unique?
> 

Thanks for the detailed review.  I'll make all the changes that you're suggesting and resend.

As for the comment above, and all the others related to IORESOURCE_BUSY, this amounts to making the resource claim look like a bridge window, so that callers of request_mem_region() in the drivers for the child devices actually can succeed.  There's no function in the kernel today that amounts to "request_mem_region_for_bridge_window()" or at least none that I understood.  The current plug and play code in Linux is pretty hard coded for various bus types, i.e. ACPI and PCI.  I took a tack at one point where I tried to offer changes to it, so that it understood the concept of "grandchild of ACPI or PCI" which is what would make this code simpler.  Rafael Wysocki basically told me that the pnp layer is deprecated and that new changes to it wouldn't be entertained, and that I should find some way of using what exists.  This was the result.  If you have another suggestion, I'm happy to try it.  In any case, I'll explain what's happening more thoroughly in comments.

Thanks,
Jake Oshins

