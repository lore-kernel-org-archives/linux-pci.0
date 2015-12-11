Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36556 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbbLKP6H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2015 10:58:07 -0500
MIME-Version: 1.0
In-Reply-To: <20151211145916.GA21907@localhost>
References: <1449096700-23304-1-git-send-email-horms+renesas@verge.net.au>
	<20151209183743.GH31930@localhost>
	<20151211021434.GH9927@verge.net.au>
	<20151211145916.GA21907@localhost>
Date: Fri, 11 Dec 2015 16:58:06 +0100
Message-ID: <CAMuHMdVN5VtZHcC9T4dzpsW-f8FpcjmJeTX_HHqRs0X5HdJCOw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PCI: rcar, rcar-gen2: More Gen2 compatibility strings
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Fri, Dec 11, 2015 at 3:59 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Dec 11, 2015 at 11:14:34AM +0900, Simon Horman wrote:
>> On Wed, Dec 09, 2015 at 12:37:43PM -0600, Bjorn Helgaas wrote:
>> > On Thu, Dec 03, 2015 at 07:51:36AM +0900, Simon Horman wrote:
>> > > this short series adds generic gen2 and SoC-specific r8a7793 compatibility
>> > > strings to the rcar PCI and rcar-gen2 PCIE drivers. The intention is to
>> > > provide a complete set of compatibility strings for known Gen2 SoCs.
>> > >
>> > > Key Changes in v2:
>> > > * Include "rcar-" in generic bindings
>> > >
>> > > Simon Horman (4):
>> > >   PCI: rcar-gen2: add gen2 fallback compatibility string
>> > >   PCI: rcar-gen2: add device tree support for r8a7793
>> > >   PCI: rcar: add gen2 fallback compatibility string
>> > >   PCI: rcar: add device tree support for r8a7793
>> > >
>> > >  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 12 ++++++++++--
>> > >  Documentation/devicetree/bindings/pci/rcar-pci.txt      | 14 +++++++++++---
>> > >  drivers/pci/host/pci-rcar-gen2.c                        |  1 +
>> > >  drivers/pci/host/pcie-rcar.c                            |  1 +
>> > >  4 files changed, 23 insertions(+), 5 deletions(-)
>> >
>> > I applied these:
>> >
>> > >   PCI: rcar-gen2: add gen2 fallback compatibility string
>> > >   PCI: rcar: add gen2 fallback compatibility string
>> >
>> > to pci/host-rcar for v4.5, thanks!
>> >
>> > I haven't applied the R8A7793 binding documentation updates yet, but
>> > I'll be happy to do so given a short description of why they're
>> > useful (since they don't update a DT or the driver).  Or they could be
>> > merged via a DT tree.
>>
>> To clarify: you would like a description in the changelog?
>
> Yes, please.  The email discussion so far hasn't contained what I'm
> looking for (if it had, I would have just inserted it and been done
> with it).
>
> Apparently it has to do with the stable DT rules, which I don't know.
> A concrete example would probably help clear it up.

The stable DT rules mean that an old DTS should keep on working with
newer kernels.

Suppose we have two SoCs, that both contain "foo" modules, which look
identical. Hence the DTS for both declares the devices to be compatible
with "vendor,foo".

Later, we discover a difference between the two "foo" modules in the two
SoCs (e.g. a feature present in one of them, or worse, a bug), which we
need to handle in the driver. But how can we distinguish between them?
We can change the compatible value in the DTS, but that means the user
has to update the DTS when updating the kernel. For a new feature that
may be deemed acceptable, for a bug fix that's not acceptable.

Hence we always use an SoC-specific compatible value, which may or may
not be accompanied by a family-specific and/or generic compatible value.
As long as everything can be handled the same, the driver will just match
against the most generic compatible value used. But if needed later, the
driver can be updated to match against a more specific compatible value,
and can have special handling for  a module in a specific SoC.

So that's why we want to have compatible value in the DT bindings that
are not necessarily used by the driver.

In a perfect world, where all hardware is properly documented, or even
Open Source, we wouldn't need this. There we could just declare a device
compatible with what it really is, based on the module's internal version ID
(ideally a git commit ID of its HDL source ;-).

I hope the above explains it. If you have more questions, feel free to ask!

> I've applied the parts that touch PCI.  I won't be offended if the
> binding documentation patches go as-is via another tree.  It's just
> that if *I'm* going to apply them, I'd like to understand better what
> the benefit is.

DT binding updates typically go through the subsystem maintainer,
just like driver updates.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
