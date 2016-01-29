Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:22166 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbcA2MCm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jan 2016 07:02:42 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sinan Kaya <okaya@codeaurora.org>
Subject: RE: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
Date: Fri, 29 Jan 2016 12:02:23 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1EC909F2@lhreml503-mbs>
References: <20160120160427.GD13437@red-moon>
 <569FB210.9090605@codeaurora.org> <20160120181003.GF13437@red-moon>
 <HK2PR0601MB1393A8E38392D17EC2DD7900F5C40@HK2PR0601MB1393.apcprd06.prod.outlook.com>
 <20160128172701.GA28468@red-moon>
In-Reply-To: <20160128172701.GA28468@red-moon>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo

Sorry to be so late on this

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org]
> On Behalf Of Lorenzo Pieralisi
> Sent: 28 January 2016 17:27
> To: Phil Edworthy; Pratyush Anand; Jingoo Han; Gabriele Paoloni
> Cc: linux-pci@vger.kernel.org; Wangzhou (B); Bjorn Helgaas; Sinan Kaya
> Subject: Re: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
> 
> [+ Pratyush, Jingoo, Gabriele]
> 
> any comment on this for the designware driver ?

>From our side we (HiSilicon) do not use such flag.

We just modified the designware to stay in line with the
generic host bridge as we were not sure if any other
designware driver used it.

So I think it can be removed.

Thanks

Gab

> 
> Thanks,
> Lorenzo
> 
> On Fri, Jan 22, 2016 at 04:28:39PM +0000, Phil Edworthy wrote:
> > Hi Lorenzo,
> >
> > On 20 January 2016 18:10, Lorenzo Pieralisi wrote:
> > > On Wed, Jan 20, 2016 at 11:13:04AM -0500, Sinan Kaya wrote:
> > > > On 1/20/2016 11:04 AM, Lorenzo Pieralisi wrote:
> > > > > Hi,
> > > > >
> > > > > I noticed that:
> > > > >
> > > > > 79953dd22c1d ("PCI: rcar: Remove dependency on ARM-specific struct
> > > hw_pci")
> > > > > cbce7900598c ("PCI: designware: Make driver arch-agnostic")
> > > > >
> > > > > added code in the respective host controller drivers to size bridges
> > > > > and assign resources only if the PCI_PROBE_ONLY flag is clear, which
> makes
> > > > > me wonder if there exists PCI_PROBE_ONLY set-ups for the respective
> > > > > host controllers:
> > > > >
> > <snip>
> >
> > > Resources claiming and assignment should be managed in arch code,
> > > not in host controllers specific code, and that's the reason I
> > > complained in this RFC about the scattering of PCI_PROBE_ONLY flag
> > > checks in host drivers, it is becoming unmanageable (if useful
> > > at all on designware and rcar, I would like to know if there are
> > > PCI_PROBE_ONLY set-ups probing those host drivers).
> >
> > I am pretty sure  there are no rcar set-ups that use PCI_PROBE_ONLY,
> > so I am happy for that code to go.
> >
> > Thanks
> > Phil
> >
> > > Does it make the point clearer ?
> > >
> > > > > https://patchwork.ozlabs.org/patch/545671/
> > > > >
> > > > > so unless you really have *existing* set-ups that require it, please
> > > > > remove the respective checks from the host controller drivers, this is
> > > > > becoming a serious issue, because either:
> > > > >
> > > > > - we claim resources if and only if PCI_PROBE_ONLY is set
> > > > >
> > > > > Either like this (to be done for every host controllers and ARM
> > > > > bios32):
> > > > >
> > > > > https://patchwork.ozlabs.org/patch/545670/
> > > > >
> > > > > or in core ARM/ARM64 code - eg pcibios_fixup_bus() - (to avoid adding
> a
> > > > > resource claiming call in ALL PCI host controllers)
> > > > >
> > > > > - or we *always* carry out resource claiming regardless of
> PCI_PROBE_ONLY
> > > > >   (but on ARM we can't really do that since PCI FW set-up on most of
> the
> > > > >   platforms is not present)
> > > > >
> > > > > On PCI_PROBE_ONLY systems resources claiming is mandatory if we want
> > > > > to get rid of arches workarounds:
> > > >
> > > > I'm hoping to see x86 like behavior on ARM64 without any gotchas as
> > > > there is nothing special about CPU type when it comes to PCI.
> > >
> > > As I said, we must enforce it with ACPI, for DT platforms I am all
> > > ears to decide how we can implement it sanely (I think the only way
> > > to do it is by claiming the PCI resources on PCI_PROBE_ONLY systems,
> > > that's not ideal but it simplifies things a lot).
> > >
> > > Thanks,
> > > Lorenzo
> > >
> > > >
> > > > >
> > > > > https://patchwork.ozlabs.org/patch/545671/
> > > > >
> > > > > Comments very appreciated.
> > > > >
> > > > > Thanks,
> > > > > Lorenzo
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > >
> > > >
> > > >
> > > > --
> > > > Sinan Kaya
> > > > Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> > > > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> Linux
> > > Foundation Collaborative Project
> > > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
