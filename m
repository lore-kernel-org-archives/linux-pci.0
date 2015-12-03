Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0104.outbound.protection.outlook.com ([207.46.100.104]:43776
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752109AbbLCRAs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2015 12:00:48 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: Jiang Liu <jiang.liu@linux.intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@redhat.com" <tglx@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v6 4/7] PCI: Add fwnode_handle to pci_sysdata
Date: Thu, 3 Dec 2015 17:00:46 +0000
Message-ID: <DM2PR0301MB12322F99B83FD888BE12E3ADAB0D0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1446499996-1350-1-git-send-email-jakeo@microsoft.com>
 <1446499996-1350-5-git-send-email-jakeo@microsoft.com>
 <565FE6E6.8000700@linux.intel.com>
In-Reply-To: <565FE6E6.8000700@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Jiang Liu [mailto:jiang.liu@linux.intel.com]
> Sent: Wednesday, December 2, 2015 10:53 PM
> To: Jake Oshins <jakeo@microsoft.com>; gregkh@linuxfoundation.org; KY
> Srinivasan <kys@microsoft.com>; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> vkuznets@redhat.com; tglx@redhat.com; Haiyang Zhang
> <haiyangz@microsoft.com>; marc.zyngier@arm.com;
> bhelgaas@google.com; linux-pci@vger.kernel.org
> Subject: Re: [PATCH v6 4/7] PCI: Add fwnode_handle to pci_sysdata
> 
> On 2015/11/3 5:33, jakeo@microsoft.com wrote:
> > From: Jake Oshins <jakeo@microsoft.com>

> >
> > +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> > +static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
> > +{
> > +	struct pci_sysdata *sd = bus->sysdata;
> > +	return sd->fwnode;
> > +}
> > +
> > +#define pci_root_bus_fwnode	_pci_root_bus_fwnode
> > +#endif
> > +
> >  /* Can be used to override the logic in pci_scan_bus for skipping
> >     already-configured bus numbers - to be used for buggy BIOSes
> >     or architectures with incomplete PCI setup by the loader */
> > diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
> > index f24bc51..3fde985 100644
> > --- a/include/asm-generic/pci.h
> > +++ b/include/asm-generic/pci.h
> > @@ -21,4 +21,8 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev
> *dev, int channel)
> >  #define PCI_DMA_BUS_IS_PHYS	(1)
> >  #endif
> >
> > +#ifndef pci_root_bus_fwnode
> > +#define pci_root_bus_fwnode(bus)	((void)(bus),NULL)
> > +#endif
> Hi Jakeo,
> 	For x86, all PCI devices share the same MSI controller. But I'm
> not sure whether it may have per-bus/per-device MSI controllers on other
> archs. If there may be multiple MSI controllers serving PCI devices
> under the same PCI root, it would be better to use some thing like
> pci_get_msi_fwnode(bus) or similar.
> Thanks,
> Gerry
> 

Certainly other architectures have per-bus MSI controllers, though usually it's per root complex.  In case you're not familiar with PCI Express terms (and I apologize for this if you are) a root complex is one instance of PCI Express, where traffic is defined between every part of it.  If your traffic leaves PCI Express and goes onto some processor-specific bus, it has left the root complex.  The root complex is usually modeled as a root PCI bus, a set of root port, and a set of legacy and/or embedded endpoints, which amounts to saying that some PCI/E devices are built into the root complex and not connected with links.

I don't have a use case at the moment for anything other than an MSI controller for a root complex.  If you'd like me to change this so that it more naturally extends to a situation where you'd want to use it for a specific bus, I can do that.  Please let me know.

And thanks again for your review.

-- Jake Oshins
 

