Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bbn0101.outbound.protection.outlook.com ([157.56.111.101]:61056
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965134AbbJ0Rfb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2015 13:35:31 -0400
From: Jake Oshins <jakeo@microsoft.com>
To: Jiang Liu <jiang.liu@linux.intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 4/7] PCI: Record an fwnode associated with root PCI
 buses, optionally
Date: Tue, 27 Oct 2015 17:19:48 +0000
Message-ID: <DM2PR0301MB12325E39B9C769A6AECDCCB0AB220@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1445901339-11924-1-git-send-email-jakeo@microsoft.com>
 <1445901339-11924-5-git-send-email-jakeo@microsoft.com>
 <562F2354.8040802@linux.intel.com>
In-Reply-To: <562F2354.8040802@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Jiang Liu [mailto:jiang.liu@linux.intel.com]
> Sent: Tuesday, October 27, 2015 12:10 AM
> To: Jake Oshins <jakeo@microsoft.com>; gregkh@linuxfoundation.org; KY
> Srinivasan <kys@microsoft.com>; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> vkuznets@redhat.com; tglx@linutronix.de; Haiyang Zhang
> <haiyangz@microsoft.com>; marc.zyngier@arm.com;
> bhelgaas@google.com; linux-pci@vger.kernel.org
> Subject: Re: [PATCH v3 4/7] PCI: Record an fwnode associated with root PCI
> buses, optionally
> 
> On 2015/10/27 7:15, jakeo@microsoft.com wrote:
> > From: Jake Oshins <jakeo@microsoft.com>
> >
> > This patch allows a PCI front-end implementation to supply an
> fwnode_handle
> > associated with a root PCI bus, optionally.  If supplied, the PCI driver
> > records this.
> >
> > This patch supports the next patch in the series, which looks up an IRQ
> domain
> > through this handle.
> Hi JaKeo,
> 	Instead of changing the pci_create_root_bus() interface,
> how about packing fwnode into sysdata, then we may
> either 1) introduce a helper to retrieve fwnode from sysdata
> or 2) set host_bridge->fwnode = sysdata in function
> pcibios_root_bridge_prepare.
> 
> Thanks,
> Gerry
> 

Thanks for the review.  I'll work up a version that uses this suggestion and resend.  (I'll respond to your feedback on the other patches, too.)

-- Jake Oshins

