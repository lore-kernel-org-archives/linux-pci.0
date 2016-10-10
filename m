Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35525 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753107AbcJJRUu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2016 13:20:50 -0400
Received: by mail-pa0-f49.google.com with SMTP id qn10so54085392pac.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Oct 2016 10:20:50 -0700 (PDT)
Date: Mon, 10 Oct 2016 10:20:47 -0700
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4] PCI: rockchip: Support property to specify the link
 capability
Message-ID: <20161010172046.GA30803@localhost>
References: <1475743800-1036-1-git-send-email-shawn.lin@rock-chips.com>
 <20161010141639.GA22113@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161010141639.GA22113@rob-hp-laptop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rob,

On Mon, Oct 10, 2016 at 09:16:39AM -0500, Rob Herring wrote:
> On Thu, Oct 06, 2016 at 04:50:00PM +0800, Shawn Lin wrote:
> > From: Brian Norris <briannorris@chromium.org>
> > 
> > rk3399 supports PCIe 2.x link speeds marginally at best, and on some
> > boards, the link won't train at 5 GT/s at all. Rather than sacrifice 500
> > ms waiting for training that will never happen, let's add a property
> > from devicetree to specify link capability.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > 
> > ---
> > 
> > Changes in v4:
> > - define link_gen as u32
> > - elaborate more for rockchip,max-link-speed on doc
> > 
> > Changes in v3:
> > - Cast a warning for invalid max link speed and use gen1 for it.
> >   That looks better than v2. (Suggested by Brian)
> > 
> > Changes in v2:
> > - rename the property to rockchip,max-link-speed according to
> >   Bjorn's recommendation and take some bits from imx6q-pcie to
> >   make this requirement more consisent.
> > 
> >  .../devicetree/bindings/pci/rockchip-pcie.txt      |  4 ++
> >  drivers/pci/host/pcie-rockchip.c                   | 63 ++++++++++++++--------
> >  2 files changed, 44 insertions(+), 23 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > index ba67b39..9bb29de 100644
> > --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > @@ -42,6 +42,10 @@ Required properties:
> >  Optional Property:
> >  - ep-gpios: contain the entry for pre-reset gpio
> >  - num-lanes: number of lanes to use
> > +- rockchip,max-link-speed: Specify PCI gen for link capability. Must
> > +	be '2' for gen2, and '1' for gen1, otherwise will default to gen1.
> > +	For backward compatibility, if this property isn't assigned, we
> > +	use gen2 by default.
> 
> Defaults to gen1 or gen2?

The wording is a bit confusing, but I think Shawn intended for:
(a) if no property is provided, default to the maximum supported (i.e.,
    gen2), to keep backward compatibility
(b) if a property is provided, but it doesn't contain 1 or 2, just
    default to 1

I already disagreed with (b) (and suggested we make this an error
instead; we have no business accepting malformed device trees here IMO).
Alternatives to clear up the confusion Rob pointed out might include:
(1) explaining this better (i.e., what does "otherwise" mean in the
    original sentence?)
(2) changing this to uniformly default to 2 (if someone used an
    unsupported value, treat it as if the property wasn't there at all)
(3) reject incorrect values outright (so we don't have this fuzzy middle
    ground at all)

> Let's drop rockchip and make this a common property. 

As in, handle this in some generic/common way? AFAICT, there's really
no way to do that given the current structure of PCIe handling (and the
nature of these kinds of limitations).

Or, do you just mean make the name common? (i.e,. "max-link-speed"
instead of "rockchip,max-link-speed")

Also for the record, Shawn already sent v5 before your comments.
Presumably he'll need a v6 then...

Brian

> >  - vpcie3v3-supply: The phandle to the 3.3v regulator to use for PCIe.
> >  - vpcie1v8-supply: The phandle to the 1.8v regulator to use for PCIe.
> >  - vpcie0v9-supply: The phandle to the 0.9v regulator to use for PCIe.
