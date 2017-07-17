Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35792 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbdGQVDr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 17:03:47 -0400
Received: by mail-pf0-f172.google.com with SMTP id e199so742840pfh.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2017 14:03:47 -0700 (PDT)
Date: Mon, 17 Jul 2017 14:03:44 -0700
From: Brian Norris <briannorris@chromium.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] phy-rockchip-pcie: add set_mode callback
Message-ID: <20170717210342.GA115703@google.com>
References: <1497601068-181656-1-git-send-email-shawn.lin@rock-chips.com>
 <cea27b15-2c2d-a4a9-76f8-f4798c152101@ti.com>
 <CA+ASDXOpPdk+mrVQxrDmhsL-SUNSnQ_CqGXuW-Vrh_D7Gh8jxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+ASDXOpPdk+mrVQxrDmhsL-SUNSnQ_CqGXuW-Vrh_D7Gh8jxA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 10, 2017 at 10:20:32PM -0700, Brian Norris wrote:
> Hi Kishon,

Hi again Kishon,

I didn't get a response from you, but Shawn is continuing to send
several versions of a patchset implementing one of these suggestions.
I'd like to ping back here, in the hopes of getting an answer.

> On Mon, Jul 10, 2017 at 9:45 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > On Friday 16 June 2017 01:47 PM, Shawn Lin wrote:
> > > phy_mode was added for switching USB mode purposely as
> > > well as phy_set_mode API. However other types of PHY could
> > > also have some miscellaneous setting/modes need to be
> > > handled. This patch is gonna support this callback for
> > > phy-rockchip-pcie and do some power-saving work there.
> > > Note that we just stuff in some other values other that the
> > > existing phy_mode and convert it in the coressponding driver
> > > instead, otherwise we should extend the phy_mode again which
> > > it doesn't make sense to add in new driver's specificed value.
> > > Overall it looks fine to me as the controller's driver and the
> > > phy's driver are paired so that the caller and the consumer should
> > > be able to keep the value(mode) in consistent.
> >
> > I really don't prefer using an API other that what it is intended for. We have
> > to come up with a better way for handling this.
> >
> > IIUC this patch sets unused lanes in idle mode? If yes, then can't we model
> > each lane as a separate phy, so that we can power-on/power-off each lane
> > independently.
> 
> I suggested the same to Shawn previously. I'm interested in seeing his response.

Judging by Shawn's subsequent patches, I guess he saw no problem with
this. I'm still not so sure.

> But personally I'm still not sure if that's the most accurate way to
> describe this PHY, except for the fact that inevitably, most device
> tree bindings get molded to match the related kernel APIs, rather than
> the other way around. What if instead, we added an enum mode entry
> that represents "finished link training", at which point the PHY would
> then know it can power down the unused lanes (that's assuming the PHY
> can figure that part out)?

Can I get an answer here? Is it possible that we extend the PHY API with
either a new 'phy_mode', or with some other PCIe-specific extension? As
I said above, it doesn't actually seem like a natural description of the
hardware to say that there are 4 PHYs here, instead of just 1. And then
it puts more burden on the provider/consumer drivers to do a lot of
weird accounting, just so that this single piece of hardware can fit the
current limited set of APIs.

This is not the first time that some concept isn't so easy to fit into
the existing framework. I think it would be prudent to consider ways to
better extend the API to support modes specific to device classes.
You've already done that for some USB pieces, and I think it would make
sense to extend this to PCIe. For instance, we could have the PHY export
things like "number of PCIe lanes", and support callbacks for "disable
unused lanes".

> Or if we did re-model this PHY, how are we supposed to handle backward
> compatibility? Can the same PHY driver support 2 different of_xlate
> methods? I guess we'd have to provide an implementation that sets the
> driver up to behave completely differently based on the number of
> #phy-cells?

I guess Shawn was able to work out some of this. But all the extra
state-tracking and reference counting appears to be hard to get right...

Brian
