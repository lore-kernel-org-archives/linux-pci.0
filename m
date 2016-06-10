Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36141 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbcFJHh6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jun 2016 03:37:58 -0400
Date: Fri, 10 Jun 2016 08:37:51 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: Rockchip: Add Rockchip PCIe controller
 support
Message-ID: <20160610083751.05a82c80@arm.com>
In-Reply-To: <CAD=FV=U2fNgkNNLZbSAkt5LjfsSazjZnga=3h0MUi8AFMgjk_w@mail.gmail.com>
References: <1465373154-882-1-git-send-email-shawn.lin@rock-chips.com>
	<CAD=FV=U2fNgkNNLZbSAkt5LjfsSazjZnga=3h0MUi8AFMgjk_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 9 Jun 2016 21:00:08 -0700
Doug Anderson <dianders@chromium.org> wrote:

Hi Doug,

> Shawn,
> 
> On Wed, Jun 8, 2016 at 1:05 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> > This patch adds Rockchip PCIe controller support found
> > on RK3399 Soc platform.
> >
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >
> > ---
> >
> > Changes in v2:
> > - remove phy related stuff and call phy API
> > - add new head file and define lots of macro to make
> >   the code more readable
> > - remove lots msi related code suggested by Marc
> > - add IO window address translation
> > - init_port and parse_dt reconstruction suggested by Bharat
> > - improve wr_own_conf suggested by Arnd
> > - make pcie as an interrupt controller and fix wrong int handler
> >   suggested by Marc
> > - remove PCI_PROBE_ONLY suggested by Lorenzo
> >
> >  drivers/pci/host/Kconfig         |   11 +
> >  drivers/pci/host/Makefile        |    1 +
> >  drivers/pci/host/pcie-rockchip.c | 1049 ++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/host/pcie-rockchip.h |  209 ++++++++
> >  4 files changed, 1270 insertions(+)
> 
> A few drive-by comments for things I ran into trying to get this
> working.  I'm no PCI expert.
> 
> 
> > +config PCIE_ROCKCHIP
> > +       bool "Rockchip PCIe controller"
> > +       depends on ARM64 && ARCH_ROCKCHIP
> > +       depends on OF
> > +       select MFD_SYSCON
> > +       select PCI_MSI_IRQ_DOMAIN if PCI_MSI
> 
> Probably because I don't know what I'm doing, but when I had PCI_MSI
> configured I had trouble getting interrupts.  Figured I'd mention it
> even though it's probably user error.

Could you please elaborate on this? Do you see MSIs being
allocated but not delivered? Or something else?

The reason I'm asking is that it is very easy to end-up with MSIs
issues with the GICv3 ITS if there is *anything* between the RC and the
ITS. Typically, you'd have an SMMU that could potentially remap PCIe
Requested IDs to Device IDs. Short of describing transformations in the
msi-map property, you could end-up with no MSI being delivered.

Please let me know if I can help.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
