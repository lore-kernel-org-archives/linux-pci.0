Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751777AbeB1LWd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 06:22:33 -0500
Date: Wed, 28 Feb 2018 11:22:29 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 5/6] PCI: rockchip: Add Endpoint controller driver for
 Rockchip PCIe controller
Message-ID: <20180228112229.GB18879@e107981-ln.cambridge.arm.com>
References: <1519348503-243259-1-git-send-email-shawn.lin@rock-chips.com>
 <1519348654-243597-1-git-send-email-shawn.lin@rock-chips.com>
 <20180227153202.GB7184@e107981-ln.cambridge.arm.com>
 <8244c52c-73d3-5b20-eb39-ddc37968163a@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8244c52c-73d3-5b20-eb39-ddc37968163a@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 28, 2018 at 09:40:36AM +0800, Shawn Lin wrote:
> Dear Lorenzo,
> 
> On 2018/2/27 23:32, Lorenzo Pieralisi wrote:
> >On Fri, Feb 23, 2018 at 09:17:33AM +0800, Shawn Lin wrote:
> >>This patch adds support to the Rockchip PCIe controller in endpoint mode
> >>which currently supports up to 32 regions, and each regions should at
> >>least be 1MB per TRM.
> >>
> >>Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >>
> 
> >
> >I reviewed this patch and I then realized that it is not bits, it is
> >that the drivers are almost identical. Are we talking about the same IP
> >(possibly with some HW wrapper of sorts) ?
> >
> 
> Nope, I would seriouly say they are not the same IP legally :)
> If we take about IP, it's referred to a functional entity designed
> and licensed by the provider, but it's not the case here since
> 
> (1) There is nothing about cadence throughout the TRM when upstreamed
> it in 2016, and actually it was designed much earlier than 2016.
> (2) Much of the flow was different, and even some of the bit offset is
> different per my reading of cadence's driver, though most registers
> looks much similar.
> 
> So my best guess was HW guys referenced to cadence's register layout(or
> the reverse), so they are much partially compatible from the
> register level POV, but the backend design are different leading to the
> quite different control flow and also rockchip controller have lots of
> HW bugs that I didn't see them when reviewing cadence's driver which do
> the same flow using similar register. That's very common if you search
> drivers/mmc/host/sdhci*, which means all of them share the *same*
> register layout and control flow, so it makes software guys' life easy,
> but still they are different IPs. But it's sightly different here as
> the pcie registers aren't the totally same and the flow control is
> different.
> 
> Also historically that happened for other controllers designed from
> rockchip, for instance, SPI controller looks much like designware one,
> but the flow control was totally differnt preventing SW guys to
> refactor the designware driver to fit for rockchip one.
> 
> This is all I could guess here, hope that help for you.

Well - there is still lots of duplicated code there, which may mean
duplicate bugs to fix, that's not ideal at all. It would be great if
we manage to separate common code and glue code (you call it "flow"
which I have no idea what it refers to) around it.

I will review this patch anyway but this driver and cadence's are pretty
much indentical, there is not much doubt about that.

Thanks,
Lorenzo
