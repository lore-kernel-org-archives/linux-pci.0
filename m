Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52911 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754285AbcBEQKc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Feb 2016 11:10:32 -0500
Date: Fri, 5 Feb 2016 10:10:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] PCI: rcar, rcar-gen2: More Gen2 compatibility
 strings
Message-ID: <20160205161028.GC29306@localhost>
References: <1449096700-23304-1-git-send-email-horms+renesas@verge.net.au>
 <20151209183743.GH31930@localhost>
 <20151211021434.GH9927@verge.net.au>
 <20151211145916.GA21907@localhost>
 <CAMuHMdVN5VtZHcC9T4dzpsW-f8FpcjmJeTX_HHqRs0X5HdJCOw@mail.gmail.com>
 <20160204220146.GA17060@localhost>
 <CAMuHMdXJqSpgaundL4-hMpD4jvYn5ZWyZP8ofr-4uqqZjcJ9kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdXJqSpgaundL4-hMpD4jvYn5ZWyZP8ofr-4uqqZjcJ9kQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 05, 2016 at 08:43:55AM +0100, Geert Uytterhoeven wrote:
> On Thu, Feb 4, 2016 at 11:01 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Dec 11, 2015 at 04:58:06PM +0100, Geert Uytterhoeven wrote:
> >> On Fri, Dec 11, 2015 at 3:59 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> > On Fri, Dec 11, 2015 at 11:14:34AM +0900, Simon Horman wrote:
> >> >> On Wed, Dec 09, 2015 at 12:37:43PM -0600, Bjorn Helgaas wrote:
> >> >> > On Thu, Dec 03, 2015 at 07:51:36AM +0900, Simon Horman wrote:
> >> >> > > this short series adds generic gen2 and SoC-specific r8a7793 compatibility
> >> >> > > strings to the rcar PCI and rcar-gen2 PCIE drivers. The intention is to
> >> >> > > provide a complete set of compatibility strings for known Gen2 SoCs.
> >> >> > >
> >> >> > > Key Changes in v2:
> >> >> > > * Include "rcar-" in generic bindings
> >> >> > >
> >> >> > > Simon Horman (4):
> >> >> > >   PCI: rcar-gen2: add gen2 fallback compatibility string
> >> >> > >   PCI: rcar-gen2: add device tree support for r8a7793
> >> >> > >   PCI: rcar: add gen2 fallback compatibility string
> >> >> > >   PCI: rcar: add device tree support for r8a7793
> >> >> > >
> >> >> > >  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 12 ++++++++++--
> >> >> > >  Documentation/devicetree/bindings/pci/rcar-pci.txt      | 14 +++++++++++---
> >> >> > >  drivers/pci/host/pci-rcar-gen2.c                        |  1 +
> >> >> > >  drivers/pci/host/pcie-rcar.c                            |  1 +
> >> >> > >  4 files changed, 23 insertions(+), 5 deletions(-)
> >> >> >
> >> >> > I applied these:
> >> >> >
> >> >> > >   PCI: rcar-gen2: add gen2 fallback compatibility string
> >> >> > >   PCI: rcar: add gen2 fallback compatibility string
> >> >> >
> >> >> > to pci/host-rcar for v4.5, thanks!
> >> >> >
> >> >> > I haven't applied the R8A7793 binding documentation updates yet, but
> >> >> > I'll be happy to do so given a short description of why they're
> >> >> > useful (since they don't update a DT or the driver).  Or they could be
> >> >> > merged via a DT tree.
> >> >>
> >> >> To clarify: you would like a description in the changelog?
> >> >
> >> > Yes, please.  The email discussion so far hasn't contained what I'm
> >> > looking for (if it had, I would have just inserted it and been done
> >> > with it).
> >> >
> >> > Apparently it has to do with the stable DT rules, which I don't know.
> >> > A concrete example would probably help clear it up.
> >>
> >> The stable DT rules mean that an old DTS should keep on working with
> >> newer kernels.
> >>
> >> Suppose we have two SoCs, that both contain "foo" modules, which look
> >> identical. Hence the DTS for both declares the devices to be compatible
> >> with "vendor,foo".
> >>
> >> Later, we discover a difference between the two "foo" modules in the two
> >> SoCs (e.g. a feature present in one of them, or worse, a bug), which we
> >> need to handle in the driver. But how can we distinguish between them?
> >> We can change the compatible value in the DTS, but that means the user
> >> has to update the DTS when updating the kernel. For a new feature that
> >> may be deemed acceptable, for a bug fix that's not acceptable.
> >>
> >> Hence we always use an SoC-specific compatible value, which may or may
> >> not be accompanied by a family-specific and/or generic compatible value.
> >> As long as everything can be handled the same, the driver will just match
> >> against the most generic compatible value used. But if needed later, the
> >> driver can be updated to match against a more specific compatible value,
> >> and can have special handling for  a module in a specific SoC.
> >>
> >> So that's why we want to have compatible value in the DT bindings that
> >> are not necessarily used by the driver.
> >>
> >> In a perfect world, where all hardware is properly documented, or even
> >> Open Source, we wouldn't need this. There we could just declare a device
> >> compatible with what it really is, based on the module's internal version ID
> >> (ideally a git commit ID of its HDL source ;-).
> >>
> >> I hope the above explains it. If you have more questions, feel free to ask!
> >
> > The above is all pretty standard device identification technique.
> > That's not what I've been missing.
> >
> > But I just had an epiphany.  Tell me if I'm talking sense or
> > gibberish:
> >
> >   If a patch adds a use of "renesas,pcie-r8a7793" in a .dts, .c, or .h
> >   file, e.g., in arch/arm/boot/dts/ or in the driver, and somebody
> >   runs checkpatch on that patch, checkpatch will complain unless
> >   "renesas,pcie-r8a7793" appears somewhere in
> >   devicetree/bindings/pci/.
> >
> > So if I understand correctly, the only point of this patch is to shut
> > up checkpatch in that situation.  It doesn't seem terribly useful to
> > me because checkpatch is only relevant to Linux kernel patches, and
> > even there it's optional and advisory.
> >
> > The latest changelog says "By documenting this compat string it may be
> > used in DTSs shipped, for example as part of ROMs", which seems to be
> > saying a DTS may not be shipped unless checkpatch approves of it.
> > That's a social and procedural question, not a coding question.
> >
> > It's fine with me if you want to try to enforce that via checkpatch,
> > but I'd just like to be clear on the mechanism.
> 
> A DT binding (e.g. a compatible value) may only be used in a DTS after it's
> been documented and approved in a DT binding document.
> 
> Checkpath is just a tool. AFAIK there's no other tool enforcing the above.
> 
> As both DTSes and DT binding documents are (still) in the kernel, and changes
> to them go in the kernel through patches, and most people run checkpatch
> on patches, I think having the check in checkpatch makes perfect sense.
> Adding and using yet another tool would complicate matters.

Like I said, it's fine with me if your DTS process relies on
checkpatch, and I'm not suggesting any other tool.

I'm just trying to get clarity on the nitty-gritty technical benefits
of this patch, and I think it is "this patch enables people to add a
DTS containing 'renesas,pcie-r8a7793' to the kernel source without
having checkpatch complain."

If the convention is that OEMs can't ship a DT unless it's in the
kernel source and has passed checkpatch, that's fine, but it can't be
enforced by a kernel patch.

Bjorn
