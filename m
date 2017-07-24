Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50637 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753251AbdGXIfS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2017 04:35:18 -0400
Message-ID: <1500885314.2391.52.camel@pengutronix.de>
Subject: Re: [PATCH 054/102] PCI: rockchip: explicitly request exclusive
 reset control
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Date: Mon, 24 Jul 2017 10:35:14 +0200
In-Reply-To: <f4a8b573-7a5f-ff8a-65c3-f6b907e6a10a@rock-chips.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
         <20170719152646.25903-55-p.zabel@pengutronix.de>
         <f4a8b573-7a5f-ff8a-65c3-f6b907e6a10a@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On Sat, 2017-07-22 at 21:12 +0800, Shawn Lin wrote:
> Hi Philipp,
> 
> On 2017/7/19 23:25, Philipp Zabel wrote:
> > Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> > reset lines") started to transition the reset control request API calls
> > to explicitly state whether the driver needs exclusive or shared reset
> > control behavior. Convert all drivers requesting exclusive resets to the
> > explicit API call so the temporary transition helpers can be removed.
> >
> > No functional changes.
> >
> > Cc: Shawn Lin <shawn.lin@rock-chips.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-rockchip@lists.infradead.org
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  drivers/pci/host/pcie-rockchip.c | 15 ++++++++-------
> 
> As mentioned in the thread of conversion for phy-rockchip-pcie,
> I would prefer add your patches after the reconstruction work got
> merged.

Feel free to add them when and where it is most convenient for you.
Please let me know if you want me to rebase them somewhere.

regards
Philipp
