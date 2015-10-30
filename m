Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0143.outbound.protection.outlook.com ([157.56.110.143]:40571
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932874AbbJ3QBt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2015 12:01:49 -0400
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
Subject: RE: [PATCH v4 4/7] PCI: Add fwnode_handle to pci_sysdata
Date: Fri, 30 Oct 2015 16:01:41 +0000
Message-ID: <DM2PR0301MB1232657EA30A824BB0C0984DAB2F0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1446162376-43419-1-git-send-email-jakeo@microsoft.com>
 <1446162376-43419-5-git-send-email-jakeo@microsoft.com>
 <5632CDF5.1000402@linux.intel.com>
In-Reply-To: <5632CDF5.1000402@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Jiang Liu [mailto:jiang.liu@linux.intel.com]
> Sent: Thursday, October 29, 2015 6:55 PM
> To: Jake Oshins <jakeo@microsoft.com>; gregkh@linuxfoundation.org; KY
> Srinivasan <kys@microsoft.com>; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> vkuznets@redhat.com; tglx@redhat.com; Haiyang Zhang
> <haiyangz@microsoft.com>; marc.zyngier@arm.com;
> bhelgaas@google.com; linux-pci@vger.kernel.org
> Subject: Re: [PATCH v4 4/7] PCI: Add fwnode_handle to pci_sysdata
> 


> >
> > +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> > +static inline void *pci_fwnode(struct pci_bus *bus)
> > +{
> > +	struct pci_sysdata *sd = bus->sysdata;
> > +	return sd->fwnode;
> > +}
> > +#endif
> Hi Jakeo,
> 	I would be better that if the function name indicates
> that we are getting PCI host bridge(root bus) firmware node.
> And you also need some magic here to avoid breaking compilation
> on other archs:
> in arch/x86/include/asm/pci.h
> #define pci_fwnode		pci_fwnode
> 
> in include/asm-generic/pci.h
> #ifndef pci_fwnode
> #define pci_fwnode(bus)         ((void)(bus),NULL)
> #endif
> 
> Thanks,
> Gerry

Got it.  Thanks.  I'll fix and resend.

-- Jake Oshins
