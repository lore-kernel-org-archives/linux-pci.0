Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0086.outbound.protection.outlook.com ([104.47.42.86]:7288
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751150AbeC2Qtx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Mar 2018 12:49:53 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Niklas Cassel <niklas.cassel@axis.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v5 07/12] PCI: cadence: Set PCI_BASE_ADDRESS_MEM_TYPE_64
 if a 64-bit BAR was set-up
Date: Thu, 29 Mar 2018 16:49:51 +0000
Message-ID: <CO2PR07MB97249009D56FA041EAD1146D8A20@CO2PR07MB972.namprd07.prod.outlook.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-8-niklas.cassel@axis.com>
 <CO2PR07MB97221CD6D90F81C2D81D65BD8A30@CO2PR07MB972.namprd07.prod.outlook.com>
 <20180328193717.GA97213@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180328193717.GA97213@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 28, 2018 at 20:37, Bjorn Helgaas wrote:
> On Wed, Mar 28, 2018 at 01:24:10PM +0000, Alan Douglas wrote:
> > > On 28/03/2018 12:51, Niklas Cassel wrote:
> > > cdns_pcie_ep_set_bar() does some round-up of the BAR size, which
> > > means that a 64-bit BAR can be set-up, even when the flag
> > > PCI_BASE_ADDRESS_MEM_TYPE_64 isn't set.
> >
> > > If a 64-bit BAR was set-up, set the flag
> PCI_BASE_ADDRESS_MEM_TYPE_64, so that the calling function can know
> what BAR width that was actually set-up.
> >
> > > I'm not sure why cdns_pcie_ep_set_bar() doesn't obey the flag
> PCI_BASE_ADDRESS_MEM_TYPE_64, but I leave this for the MAINTAINER to
> fix, since there might be a reason why > this flag is ignored.
> > Will investigate and fix this in future patch
> >
> > > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > > ---
> > >  drivers/pci/cadence/pcie-cadence-ep.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > Change looks good to me.
>=20
> It will be helpful to Lorenzo if you spell this out, e.g.,
>=20
>   Acked-by: Alan Douglas <adouglas@cadence.com>
Acked-by: Alan Douglas <adouglas@cadence.com>
>=20
> Also, it looks like we need a MAINTAINERS update to add drivers/pci/caden=
ce/
> to the "PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
> filename patterns.
Lorenzo please let me know if I should create a patch for this, it sounds g=
ood to me.
