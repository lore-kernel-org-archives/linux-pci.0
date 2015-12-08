Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55346 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbbLHApU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2015 19:45:20 -0500
Date: Tue, 8 Dec 2015 09:45:19 +0900
From: Simon Horman <horms@verge.net.au>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/4] PCI: rcar-gen2: Add device tree support for r8a7793
Message-ID: <20151208004519.GK10799@verge.net.au>
References: <1448954672-27236-1-git-send-email-horms+renesas@verge.net.au>
 <1448954672-27236-3-git-send-email-horms+renesas@verge.net.au>
 <20151204212649.GJ20125@localhost>
 <CAMuHMdWEXA-KTkqJsofXuBTQKBrtGW7x+2r+V42CuWwbjkqmvQ@mail.gmail.com>
 <20151207153833.GB7994@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151207153833.GB7994@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 07, 2015 at 09:38:33AM -0600, Bjorn Helgaas wrote:
> On Sat, Dec 05, 2015 at 11:38:37AM +0100, Geert Uytterhoeven wrote:
> > Hi Bjorn,
> > 
> > On Fri, Dec 4, 2015 at 10:26 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Dec 01, 2015 at 04:24:30PM +0900, Simon Horman wrote:
> > >> Simply document new compat strings.
> > >> There appears to be no need for a driver updates.
> > >>
> > >> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > >> ---
> > >>  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 1 +
> > >>  1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> > >> index b19be08a8113..7c231b3e5872 100644
> > >> --- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> > >> +++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> > >> @@ -8,6 +8,7 @@ OHCI and EHCI controllers.
> > >>  Required properties:
> > >>  - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
> > >>             "renesas,pci-r8a7791" for the R8A7791 SoC;
> > >> +           "renesas,pci-r8a7793" for the R8A7793 SoC;
> > >
> > > What's the benefit of adding a string here if the driver doesn't check
> > > for it?  Since the driver doesn't look for it, there's no way to test
> > > anything.
> > 
> > If we ever discover a difference between PCI on r8a7793 compared to PCI on
> > other SoCs of the R-Car Gen2 family, we can handle that difference in the
> > driver.
> > 
> > > It doesn't seem like this file is an authoritative source of names, so
> > 
> > Yes it is. When adding compatible values to a DTS, checkpatch.pl will check
> > for their existence in the binding documentation. Hence we always add the
> > compatible values to the DT binding docs, before we start using them.
> > 
> > > if we add it here, there's the possibility the r8a7793 will be
> > > canceled or renamed, and then we'd have to update this if the driver
> > > ever did need an r8a7793-specific quirk.  If we waited until the
> > 
> > I don't understand what you mean here.
> > 
> > > driver actually needs a quirk, then we'd know exactly what name to
> > > look for and we could update the driver, DT, and doc all together.
> > 
> > If we update driver, DT, and doc only after we discover the need for a quirk,
> > it's already too late, due to stable DT rules. Hence we always document and
> > use SoC-specific compatible values, sometimes combined with family-specific
> > compatible values. The driver only matches to the as least specific value as
> > possible.
> 
> The stable DT rules seem to be the key here, but I don't know what
> they are.  I found Documentation/devicetree/bindings/ABI.txt, but it
> doesn't clear it up for me.
> 
> I was assuming vendors could ship a DT in a platform ROM, in the same
> way platforms ship with an ACPI system description.  For ACPI, the
> _HID/_CID in the ROM in the field is authoritative in the sense that
> we have to regard it as a fixed, unchangeable feature of the platform.
> If we want a driver to recognize that device, we have to build the ID
> from the ROM into the driver, and it doesn't matter what is documented
> in the spec or in the kernel source.
> 
> If we had a one-sentence description of why adding the doc update when
> we actually need it is too late, that would probably be enough.

I agree that would be useful.

> I'm perfectly happy with the PCI changes, so if somebody else wants to
> just merge all these via a DT tree, I'm happy to ack the PCI ones.

I have no fixed ideas about who should take these changes
but I think you could take them through the PCI tree if you
are so inclined.
