Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:17063 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753205AbbJSIyW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 19 Oct 2015 04:54:22 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] PCI: rcar-pcie: Remove dependency on ARM-specific
 struct hw_pci
Date: Mon, 19 Oct 2015 08:54:17 +0000
Message-ID: <SIXPR06MB0415009813059B03D363F41BF53A0@SIXPR06MB0415.apcprd06.prod.outlook.com>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
 <1443781507-5011-3-git-send-email-phil.edworthy@renesas.com>
 <20151016213400.GC21346@localhost>
In-Reply-To: <20151016213400.GC21346@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks for the review.

On 16 October 2015 22:34, Bjorn wrote:
> On Fri, Oct 02, 2015 at 11:25:05AM +0100, Phil Edworthy wrote:
> > The R-Car PCIe host controller driver uses pci_common_init_dev(),
> > which is ARM-specific and requires the ARM struct hw_pci. The part of
> > pci_common_init_dev() that is needed is limited and can be done here
> > without using hw_pci.
> >
> > Note that the ARM pcibios functions expect the PCI sysdata to be a pointer
> > to a struct pci_sys_data. Add a struct pci_sys_data as the first element
> > in struct gen_pci so that when we use a gen_pci pointer as sysdata, it is
> > also a pointer to a struct pci_sys_data.
> >
> > Create and scan the root bus directly without using the ARM
> > pci_common_init_dev() interface.
> >
> > This change is based on commit
> <499733e0cc1a00523c5056a690f65dea7b9da140>
> > "PCI: generic: Remove dependency on ARM-specific struct hw_pci".
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
<snip>

> > +
> > +	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> > +		pci_bus_size_bridges(bus);
> > +		pci_bus_assign_resources(bus);
> >
> > -	pci_common_init_dev(&pdev->dev, &rcar_pci);
> > +		list_for_each_entry(child, &bus->children, node)
> > +			pcie_bus_configure_settings(child);
> 
> I see this is exactly the same in 499733e0cc1a ("PCI: generic: Remove
> dependency on ARM-specific struct hw_pci").  But it seems like we should do
> pcie_bus_configure_settings() (MPS configuration) *always*, even if
> PCI_PROBE_ONLY.  I expected PCI_PROBE_ONLY to mean "don't change any
> BARs"
> but I don't think it means we have to preserve *everything*.
I guess it could be interpreted both ways.

At the moment, we don't have any need for PCI_PROBE_ONLY as we always
probe. However, I purposely used the same code as the generic driver so as
to make any future refactoring easier to identify.

I'm happy to change it or leave it the same, your call.

Thanks
Phil
