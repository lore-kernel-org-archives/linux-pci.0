Return-Path: <SRS0=2MRH=JS=gmail.com=geert.uytterhoeven@kernel.org>
Return-Path: <SRS0=2MRH=JS=gmail.com=geert.uytterhoeven@kernel.org>
MIME-Version: 1.0
References: <1ca6adde-a91e-84d0-c7dc-fd01bfd9edcc@cogentembedded.com>
 <20180628132259.GB90450@bhelgaas-glaptop.roam.corp.google.com>
 <20180628142615.GA9101@red-moon> <ac015f99-c310-3701-35ce-846393b61235@cogentembedded.com>
 <20180702103316.GA10784@red-moon>
In-Reply-To: <20180702103316.GA10784@red-moon>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Jul 2018 13:08:45 +0200
Message-ID: <CAMuHMdUCNPrpYx1xOBTL0F23r3H2jc+kg+T5-rqMe0V-2w-LqQ@mail.gmail.com>
Subject: Re: [PATCH] pci: fix I/O space page leak
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci <linux-pci@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Joao.Pinto@synopsys.com,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Rob Herring <robh@kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>, ryder.lee@mediatek.com,
	Matthias Brugger <matthias.bgg@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-mediatek@lists.infradead.org,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Mon, Jul 2, 2018 at 12:31 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Sat, Jun 30, 2018 at 01:37:18PM +0300, Sergei Shtylyov wrote:
> > On 6/28/2018 5:26 PM, Lorenzo Pieralisi wrote:
> > >>>When testing the R-Car PCIe driver on the Condor board, I noticed that iff
> > >>>I  left the PCIe PHY driver disabled, the kernel crashed  with this BUG:
> > >>>
> > >>>[    1.225819] kernel BUG at lib/ioremap.c:72!

> > >>>It turned out that pci_remap_iospace() wasn't undone when the driver's
> > >>>probe failed, and since devm_phy_optional_get() returned -EPROBE_DEFER,
> > >>>the probe was retried,  finally causing the BUG due to trying to remap
> > >>>already remapped pages.
> > >>>
> > >>>The most feasible solution seems to introduce devm_pci_remap_iospace()
> > >>>and call it instead of pci_remap_iospace(), so that the pages get unmapped
> > >>>automagically on any probe failure.
> > >>>
> > >>>And  while fixing pci_parse_request_of_pci_ranges(), aslo fix the other
> > >>>drivers that have probably copied the bad example...
> > >>>
> > >>>Fixes: 4e64dbe226e7 ("PCI: generic: Expose pci_host_common_probe() for use by other drivers")
> > >>>Fixes: cbce7900598c ("PCI: designware: Make driver arch-agnostic")
> > >>>Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
> > >>>Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
> > >>>Fixes: 68a15eb7bd0c ("PCI: v3-semi: Add V3 Semiconductor PCI host driver")
> > >>>Fixes: b7e78170efd4 ("PCI: versatile: Add DT-based ARM Versatile PB PCIe host driver")
> > >>>Fixes: 5f6b6ccdbe1c ("PCI: xgene: Add APM X-Gene PCIe driver")
> > >>>Fixes: 637cfacae96f ("PCI: mediatek: Add MediaTek PCIe host controller support")
> > >>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > >>>Cc: stable@vger.kernel.org
> > >>
> > >>Let me know if you want me to take this, Lorenzo, otherwise:
> > >>s/pci: fix/PCI: Fix/ and
> > >>
> > >>Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > >Thank you Bjorn, yes it could go in as a fix but IMO it has to be split,
> > >more so given the stable tag (and I think that each "Fixes" tag should
> > >be self-contained),
> >
> >    It cannot be self-contained because it'll depend on the initial
> > commit adding devm_pci_remap_iobase(). If you mean finding the
> > earliest broken driver and introduce the deviec managed API while
> > fixing it and then make use of that
> > API in the subsequent patches, that surely can be done.
>
> Yes I think that's the best course of action.
>
> > >merging it as-is would give Greg (and us) a
> > >headache when it comes to backporting it.
> >
> >    The patch interdependency would give him headache too, and I was
> > hoping to relieve those with the monilitic patch. :-)
>
> The problem is that if any of the fixes has to be reverted we have
> to revert the whole thing instead of just the problematic patch,
> which, given that we are sending this to stable kernels may easily
> turn out quite complicated.
>
> So, I would add the new API along with the earliest broken driver
> and mark it for stable.
>
> In the same thread, add all other fixes (one per patch) without the
> stable tag. When the first fix gets merged into the mainline (and
> consequently goes to stable) we can send the stable backports for the
> remainder of fixes.
>
> How does that sound ?

If you want to be prepared for reverting, why not split off the first fix
from the patch that provides the new API as well?
Yes, it does mean a dependency for backporting, but it avoids the mess if
it turns out the first fix is the (only) one that needs to be reverted.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
