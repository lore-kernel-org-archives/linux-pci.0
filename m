Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Long Li <longli@microsoft.com>
To: Greg KH <greg@kroah.com>
CC: KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [Resend PATCH 2/2 v3] pci-hyperv: lock pci bus on device eject
Date: Mon, 27 Feb 2017 21:51:46 +0000
Message-ID: <BN3PR03MB22271398236EE893B6AB53BACE570@BN3PR03MB2227.namprd03.prod.outlook.com>
References: <BN3PR03MB22273E86EDBC8875C55E2FB7CE520@BN3PR03MB2227.namprd03.prod.outlook.com>
 <20170225080218.GA2291@kroah.com>
In-Reply-To: <20170225080218.GA2291@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ok, I will resend.

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Saturday, February 25, 2017 12:02 AM
> To: Long Li <longli@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Bjorn Helgaas <bhelgaas@google.com>;
> devel@linuxdriverproject.org; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org
> Subject: Re: [Resend PATCH 2/2 v3] pci-hyperv: lock pci bus on device eje=
ct
>=20
> On Fri, Feb 24, 2017 at 09:49:17PM +0000, Long Li wrote:
> > A PCI_EJECT message can arrive at the same time we are calling
> pci_scan_child_bus in the workqueue for the previous PCI_BUS_RELATIONS
> message or in create_root_hv_pci_bus(), in this case we could potentailly
> modify the bus from multiple places. Properly lock the bus access.
>=20
> Properly wrap your changelog comments at 72 columns like your editor is
> telling you to do...
