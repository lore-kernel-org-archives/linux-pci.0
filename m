Return-Path: <briannorris@chromium.org>
Return-Path: <briannorris@chromium.org>
Date: Wed, 27 Jul 2016 13:04:44 -0700
From: Brian Norris <briannorris@chromium.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
	linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 2/2] PCI: Rockchip: Add Rockchip PCIe controller
 support
Message-ID: <20160727200443.GA30281@google.com>
References: <1468802533-17699-1-git-send-email-shawn.lin@rock-chips.com>
 <1468802533-17699-2-git-send-email-shawn.lin@rock-chips.com>
 <20160727182233.GB8901@localhost>
 <CAP=VYLqPj=81Q_8kV1wi=FHP-CB6arrXFAC0ktJrLqR-1TSCjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAP=VYLqPj=81Q_8kV1wi=FHP-CB6arrXFAC0ktJrLqR-1TSCjw@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

+ Guenter

Hi,

On Wed, Jul 27, 2016 at 03:56:36PM -0400, Paul Gortmaker wrote:
> On Wed, Jul 27, 2016 at 2:22 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Jul 18, 2016 at 08:42:13AM +0800, Shawn Lin wrote:
> >> This patch adds Rockchip PCIe controller support found
> >> on RK3399 Soc platform.
> >>
> >> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >>
> >> ---
> >>
> >> Changes in v7:
> >> - make it as a build-in driver
> 
> [...]
> 

...

> [...]
> 
> >> +static struct platform_driver rockchip_pcie_driver = {
> >> +     .driver = {
> >> +             .name = "rockchip-pcie",
> >> +             .of_match_table = rockchip_pcie_of_match,
> >> +     },
> >> +     .probe = rockchip_pcie_probe,
> >> +
> >> +};
> >> +module_platform_driver(rockchip_pcie_driver);
> >> +
> >> +MODULE_AUTHOR("Rockchip Inc");
> >> +MODULE_DESCRIPTION("Rockchip AXI PCIe driver");
> >> +MODULE_LICENSE("GPL v2");
> >
> > Per your Kconfig, this driver cannot be a module, so remove these MODULE_*
> > annotations.  This is to follow Paul Gortmaker's recent "Make explicitly
> > non-modular" work.  Also change the include of <linux/module.h> to
> > <linux/init.h>.
> 
> Thanks!  You beat me to it.    I didn't see any EXPORT_SYMBOL so it doesn't
> look like we need export.h  added here.   Also, at the risk of stating
> the obvious,
> the module_platform_driver becomes builtin_platform_driver.

Just for reference (not to necessarily disagree here): we've kinda
ping-ponged on this one. I suggested it could be built as a module, so
Shawn added it, but apparently we're missing an export:

https://lkml.org/lkml/2016/7/8/704

so he reverted back. It's probably best to just leave this built-in and
resolve the comments Paul and Bjorn made, to avoid too much more
flip-flopping. If we still want to patch up the __weak
pci_remap_iospace(), then we can make this a module at a later time.

Regards,
Brian
