Return-Path: <heiko@sntech.de>
Return-Path: <heiko@sntech.de>
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Doug Anderson <dianders@chromium.org>, Wenrui Li <wenrui.li@rock-chips.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [v10,2/2] PCI: Rockchip: Add Rockchip PCIe controller support
Date: Thu, 01 Sep 2016 19:46:42 +0200
Message-ID: <3757057.lFUFRYFCvk@diego>
In-Reply-To: <20160901171400.GA4093@localhost>
References: <1471570498-3284-1-git-send-email-shawn.lin@rock-chips.com> <20160901163455.GA9471@localhost> <20160901171400.GA4093@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, 1. September 2016, 10:14:01 schrieb Brian Norris:
> On Thu, Sep 01, 2016 at 11:34:55AM -0500, Bjorn Helgaas wrote:
> > In the interest of making progress, I made most of the changes Guenter
> > suggested (thanks very much, Guenter!) and made some more of my own on
> > top of those.
> 
> I'm not sure, but was this change your idea Bjorn?
> 
> commit 88cb3f59d73e261a3cd1957ff392f98c9916a5d1
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Sep 1 10:27:44 2016 -0500
> 
>     Simplify the confusing HIWORD_UPDATE scheme.
> 
> [Which I'll summarize here; you're replacing the macro:
> 
> -/*
> -  * The higher 16-bit of this register is used for write protection
> -  * only if BIT(x + 16) set to 1 the BIT(x) can be written.
> -  */
> -#define HIWORD_UPDATE(val, mask, shift) \
> -       ((val) << (shift) | (mask) << ((shift) + 16))
> 
> with its expansions:
> 
> +
> +/*
> + * The higher 16-bit of this register is used for write protection
> + * only if BIT(x + 16) set to 1 the BIT(x) can be written.
> + */
> +#define PCIE_CLIENT_CONF_ENABLE                (0x00010000 | 0x0001)
> +#define PCIE_CLIENT_LINK_TRAIN_ENABLE  (0x00020000 | 0x0002)
> +#define PCIE_CLIENT_ARI_ENABLE         (0x00080000 | 0x0008)
> +#define PCIE_CLIENT_CONF_LANE_NUM(x)   (0x00300000 | (((x >> 1) & 3) << 4)
> +#define PCIE_CLIENT_MODE_RC            (0x00400000 | 0x0040)
> +#define PCIE_CLIENT_GEN_SEL(x)         (0x00800000 | ((x & 1) << 7)
> +#define  PCIE_CLIENT_GEN_SEL_0                 0
> +#define  PCIE_CLIENT_GEN_SEL_2                 1
> 
> Full change can be had by:
> git fetch git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> pci/host-rockchip-wip ]
> 
> 
> The use of HIWORD_UPDATE can indeed be a bit confusing, IMO, but this is
> really a common Rockchip-ism that, once you read several of their
> drivers, can make a little more sense. If you grep around, it's in at
> least their clock, ethernet, SDHCI, PHY, and DP/DRM drivers. I might
> defer to Heiko (upstream maintainer of Rockchip code) for a decision.
> Maybe there's some intermediate ground where we keep the HIWORK_UPDATE()
> logic (it does make sure we get the 16-bit shift right, I think) while
> still refactoring a few other bits (like PCIE_CLIENT_CONF_LANE_NUM() and
> PCIE_CLIENT_GEN_SEL() for wrapping HIWORK_UPDATE()?).
> 
> Anyway, just a thought. If it really is most understandable to write it
> this way, then maybe it's fine to be different than the other 16
> rockchip files that have this pattern.

personally I find it nicer to explicitly state, this is the common HIWORD-
update mechanism we have in a lot of places and not some other register 
voodoo.

Because right now, GRF and PMU syscons even contain most registers using that 
mechanism, but some that don't.

But I guess I won't protest to loudly if you like it differently in your 
subsystem ;-)


Heiko
