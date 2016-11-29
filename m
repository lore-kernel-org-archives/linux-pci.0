Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755579AbcK2RZ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Nov 2016 12:25:27 -0500
Date: Tue, 29 Nov 2016 11:25:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RESEND PATCH 2/2] PCI: rockchip: Add quirk to disable RC's ASPM
 L0s
Message-ID: <20161129172519.GA17112@bhelgaas-glaptop.roam.corp.google.com>
References: <1479096666-112668-1-git-send-email-shawn.lin@rock-chips.com>
 <1479096666-112668-2-git-send-email-shawn.lin@rock-chips.com>
 <CAL_JsqKkK15Jb3tWh1Mw7RU6d8=6RYMjSEs-c4EQySaUAwnFUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqKkK15Jb3tWh1Mw7RU6d8=6RYMjSEs-c4EQySaUAwnFUA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 29, 2016 at 09:34:09AM -0600, Rob Herring wrote:
> On Sun, Nov 13, 2016 at 10:11 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> > Rockchip's RC outputs 100MHz reference clock but there are
> > two methods for PHY to generate it.
> >
> > (1)One of them is to use system PLL to generate 100MHz clock and
> > the PHY will relock it and filter signal noise then outputs the
> > reference clock.
> >
> > (2)Another way is to share Soc's 24MHZ crystal oscillator with
> > PHY and force PHY's DLL to generate 100MHz internally.
> >
> > When using case(2), the exit from L0s doesn't work fine occasionally
> > due to the broken design of RC receiver's logical circuit. So even if
> > we use extended-synch, it still fails for PHY to relock the bits from
> > FTS sometimes. This will hang the system.
> >
> > Maybe we could argue that why not use case(1) to avoid it? The reason
> > is that as we could see the reference clock is derived from system PLL
> > and the path from it to PHY isn't so clean which means there are some
> > noise introduced by power-domain and other buses can't be filterd out
> > by PHY and we could see noise from the frequency spectrum by oscilloscope.
> > This makes the TX compatibility test a little difficult to pass the spec.
> > So case(1) and case(2) are both used indeed now. If using case(2), we
> > should disable RC's L0s support, and that is why we need this property to
> > indicate this quirk.
> >
> > Also after checking quirk.c, I noticed there is already a quirk for
> > disabling L0s unconditionally, quirk_disable_aspm_l0s. But obviously we
> > shouldn't do that as mentioned above that case(1) could still works fine
> > with L0s.
> >
> > Reported-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> > Cc: Brian Norris <briannorris@chromium.org>
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >
> > ---
> >
> >  Documentation/devicetree/bindings/pci/rockchip-pcie.txt | 2 ++
> >  drivers/pci/host/pcie-rockchip.c                        | 9 +++++++++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > index ba67b39..cfa44a7 100644
> > --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > @@ -42,6 +42,8 @@ Required properties:
> >  Optional Property:
> >  - ep-gpios: contain the entry for pre-reset gpio
> >  - num-lanes: number of lanes to use
> > +- quirk,aspm-no-l0s: RC won't support ASPM L0s. This property is needed if
> 
> quirk is not a vendor. Drop it.

I dropped this patch from pci/host-rockchip for now.
