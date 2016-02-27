Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0130.outbound.protection.outlook.com ([157.56.111.130]:36979
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755533AbcB0Efs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Feb 2016 23:35:48 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Hadden Hoppert <haddenh@microsoft.com>
Subject: RE: [PATCH 5/5] hv: Track allocations of children of hv_vmbus in
 private resource tree
Date: Sat, 27 Feb 2016 04:35:43 +0000
Message-ID: <DM2PR0301MB1232C09D27BA3E229D81B023ABB80@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1456349042-16275-1-git-send-email-jakeo@microsoft.com>
 <1456349042-16275-6-git-send-email-jakeo@microsoft.com>
 <BY2PR0301MB16542F997FB348465274DC4BA0B80@BY2PR0301MB1654.namprd03.prod.outlook.com>
In-Reply-To: <BY2PR0301MB16542F997FB348465274DC4BA0B80@BY2PR0301MB1654.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: KY Srinivasan
> Sent: Friday, February 26, 2016 5:09 PM
> To: Jake Oshins <jakeo@microsoft.com>; linux-pci@vger.kernel.org;
> gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> vkuznets@redhat.com; Haiyang Zhang <haiyangz@microsoft.com>; Hadden
> Hoppert <haddenh@microsoft.com>
> Cc: Jake Oshins <jakeo@microsoft.com>
> Subject: RE: [PATCH 5/5] hv: Track allocations of children of hv_vmbus in
> private resource tree
> 
> > -----Original Message-----
> > From: jakeo@microsoft.com [mailto:jakeo@microsoft.com]
> > Sent: Wednesday, February 24, 2016 1:24 PM
> > To: linux-pci@vger.kernel.org; gregkh@linuxfoundation.org; KY Srinivasan
> > <kys@microsoft.com>; linux-kernel@vger.kernel.org;
> > devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> > vkuznets@redhat.com; Haiyang Zhang <haiyangz@microsoft.com>;
> Hadden
> > Hoppert <haddenh@microsoft.com>
> > Cc: Jake Oshins <jakeo@microsoft.com>
> > Subject: [PATCH 5/5] hv: Track allocations of children of hv_vmbus in
> private
> > resource tree
> >
> > From: Jake Oshins <jakeo@microsoft.com>
> >
> > This patch changes vmbus_allocate_mmio() and vmbus_free_mmio() so
> > that when child paravirtual devices allocate memory-mapped I/O
> > space, they allocate it privately from a resource tree pointed
> > at by hyperv_mmio and also by the public resource tree
> > iomem_resource.  This allows the region to be marked as "busy"
> > in the private tree, but a "bridge window" in the public tree,
> > guaranteeing that no two bridge windows will overlap each other
> > but while also allowing the PCI device children of the bridge
> > windows to overlap that window.
> >
> > One might conclude that this belongs in the pnp layer, rather
> > than in this driver.  Rafael Wysocki, the maintainter of the
> > pnp layer, has previously asked that we not modify the pnp layer
> > as it is considered deprecated.  This patch is thus essentially
> > a workaround.
> >
> > Signed-off-by: Jake Oshins <jakeo@microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index b090548..2a7eb3f 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1169,7 +1169,7 @@ int vmbus_allocate_mmio(struct resource
> **new,
> > struct hv_device *device_obj,
> >  			resource_size_t size, resource_size_t align,
> >  			bool fb_overlap_ok)
> >  {
> > -	struct resource *iter;
> > +	struct resource *iter, *shadow;
> >  	resource_size_t range_min, range_max, start, local_min, local_max;
> >  	const char *dev_n = dev_name(&device_obj->device);
> >  	u32 fb_end = screen_info.lfb_base + (screen_info.lfb_size << 1);
> > @@ -1211,12 +1211,22 @@ int vmbus_allocate_mmio(struct resource
> > **new, struct hv_device *device_obj,
> >
> >  			start = (local_min + align - 1) & ~(align - 1);
> >  			for (; start + size - 1 <= local_max; start += align) {
> > +				shadow = __request_region(iter, start,
> > +							  size,
> > +							  NULL,
> > +							  IORESOURCE_BUSY);
> > +				if (!shadow)
> > +					continue;
> > +
> >  				*new =
> > request_mem_region_exclusive(start, size,
> >  								    dev_n);
> >  				if (*new) {
> > +					shadow->name = (char*)*new;
> 
> Why are you not correctly setting the name field in the shadow structure?
> 
> Regards,
> 
> K. Y

Nothing looks at the name fields in the shadow resource tree.  So it seemed like that pointer could point to anything.  I figured by making it point to the resource claim from the iomem_resource that might be useful in debugging someday.  If you'd rather see something different here, it doesn't make much difference to me.

Thanks for the review,
Jake Oshins
