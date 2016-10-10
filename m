Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbcJJTef (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Oct 2016 15:34:35 -0400
MIME-Version: 1.0
In-Reply-To: <20161010172046.GA30803@localhost>
References: <1475743800-1036-1-git-send-email-shawn.lin@rock-chips.com>
 <20161010141639.GA22113@rob-hp-laptop> <20161010172046.GA30803@localhost>
From: Rob Herring <robh@kernel.org>
Date: Mon, 10 Oct 2016 14:34:10 -0500
Message-ID: <CAL_Jsq+p3Vnw0U4ja09HRbfJ_ECzZjHCGmajAoVRdpPZrM6KTA@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: rockchip: Support property to specify the link capability
To: Brian Norris <briannorris@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 10, 2016 at 12:20 PM, Brian Norris <briannorris@chromium.org> wrote:
> Hi Rob,
>
> On Mon, Oct 10, 2016 at 09:16:39AM -0500, Rob Herring wrote:
>> On Thu, Oct 06, 2016 at 04:50:00PM +0800, Shawn Lin wrote:
>> > From: Brian Norris <briannorris@chromium.org>
>> >
>> > rk3399 supports PCIe 2.x link speeds marginally at best, and on some
>> > boards, the link won't train at 5 GT/s at all. Rather than sacrifice 500
>> > ms waiting for training that will never happen, let's add a property
>> > from devicetree to specify link capability.
>> >
>> > Signed-off-by: Brian Norris <briannorris@chromium.org>
>> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> >
>> > ---
>> >
>> > Changes in v4:
>> > - define link_gen as u32
>> > - elaborate more for rockchip,max-link-speed on doc
>> >
>> > Changes in v3:
>> > - Cast a warning for invalid max link speed and use gen1 for it.
>> >   That looks better than v2. (Suggested by Brian)
>> >
>> > Changes in v2:
>> > - rename the property to rockchip,max-link-speed according to
>> >   Bjorn's recommendation and take some bits from imx6q-pcie to
>> >   make this requirement more consisent.
>> >
>> >  .../devicetree/bindings/pci/rockchip-pcie.txt      |  4 ++
>> >  drivers/pci/host/pcie-rockchip.c                   | 63 ++++++++++++++--------
>> >  2 files changed, 44 insertions(+), 23 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> > index ba67b39..9bb29de 100644
>> > --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> > +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> > @@ -42,6 +42,10 @@ Required properties:
>> >  Optional Property:
>> >  - ep-gpios: contain the entry for pre-reset gpio
>> >  - num-lanes: number of lanes to use
>> > +- rockchip,max-link-speed: Specify PCI gen for link capability. Must
>> > +   be '2' for gen2, and '1' for gen1, otherwise will default to gen1.
>> > +   For backward compatibility, if this property isn't assigned, we
>> > +   use gen2 by default.
>>
>> Defaults to gen1 or gen2?
>
> The wording is a bit confusing, but I think Shawn intended for:
> (a) if no property is provided, default to the maximum supported (i.e.,
>     gen2), to keep backward compatibility
> (b) if a property is provided, but it doesn't contain 1 or 2, just
>     default to 1
>
> I already disagreed with (b) (and suggested we make this an error
> instead; we have no business accepting malformed device trees here IMO).
> Alternatives to clear up the confusion Rob pointed out might include:
> (1) explaining this better (i.e., what does "otherwise" mean in the
>     original sentence?)
> (2) changing this to uniformly default to 2 (if someone used an
>     unsupported value, treat it as if the property wasn't there at all)
> (3) reject incorrect values outright (so we don't have this fuzzy middle
>     ground at all)

Sounds good.

>> Let's drop rockchip and make this a common property.
>
> As in, handle this in some generic/common way? AFAICT, there's really
> no way to do that given the current structure of PCIe handling (and the
> nature of these kinds of limitations).
>
> Or, do you just mean make the name common? (i.e,. "max-link-speed"
> instead of "rockchip,max-link-speed")

Right, just the name and document in a common spot. Could be a simple
helper function that drivers can call as well.

Rob
