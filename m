Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932262AbdHWQ5f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Aug 2017 12:57:35 -0400
Date: Wed, 23 Aug 2017 11:57:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: manipulate phy properly if failing to
 probe the driver
Message-ID: <20170823165729.GC8498@bhelgaas-glaptop.roam.corp.google.com>
References: <1502277263-187898-1-git-send-email-shawn.lin@rock-chips.com>
 <20170822204750.GG6948@bhelgaas-glaptop.roam.corp.google.com>
 <4680e7be-0715-132a-3b4c-ae266d459ad2@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4680e7be-0715-132a-3b4c-ae266d459ad2@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 09:03:04AM +0800, Shawn Lin wrote:
> Hi Bjorn,
> 
> On 2017/8/23 4:47, Bjorn Helgaas wrote:
> >On Wed, Aug 09, 2017 at 07:14:23PM +0800, Shawn Lin wrote:
> >>We observed that the clk_pciephy_ref is still enabled when we actually
> >>fail to probe the driver.
> >>
> >>root@linaro-alip:~# cat /sys/kernel/debug/clk/clk_summary | grep pcie
> >>clk_pciephy_ref			  1	1	 24000000	0 0
> >>clk_pcie_pm			  0	0	 24000000	0 0
> >>       clk_pcie_core_cru           0	0	125000000	0 0
> >>       clk_pciephy_ref100m         0	0	100000000	0 0
> >>		aclk_pcie         0	0	148500000	0 0
> >>		aclk_perf_pcie    0	0	148500000	0 0
> >>			pclk_pcie 0	0	 37125000	0 0
> >>clk_pcie_core                     0	0		0	0 0
> >>
> >>clk_pciephy_ref is used by phy driver and we need to properly disable
> >>it for this case. So this patch add error handle for the function of
> >>rockchip_pcie_init_port to fix this issue.
> >>
> >>Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >
> >Applied to pci/host-rockchip for v4.14, thanks!
> 
> I actually posted a v2 sometime ago, so could you please drop this one?

Oops, sorry.  I dropped this one and will pick it up from the new v5 series
you posted.

Bjorn
