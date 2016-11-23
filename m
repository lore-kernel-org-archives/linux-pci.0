Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35765 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbcKWCph (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2016 21:45:37 -0500
Received: by mail-pf0-f174.google.com with SMTP id i88so92162pfk.2
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2016 18:45:37 -0800 (PST)
Date: Tue, 22 Nov 2016 18:45:34 -0800
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH 3/3] PCI: rockchip: Add system PM support
Message-ID: <20161123024527.GA18020@google.com>
References: <1479863953-123874-1-git-send-email-shawn.lin@rock-chips.com>
 <1479863953-123874-3-git-send-email-shawn.lin@rock-chips.com>
 <20161123020835.GB119441@google.com>
 <1c4bd848-67f7-0d31-6392-d9550e4767a9@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1c4bd848-67f7-0d31-6392-d9550e4767a9@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 23, 2016 at 10:39:30AM +0800, Shawn Lin wrote:
> 在 2016/11/23 10:08, Brian Norris 写道:
> >On Wed, Nov 23, 2016 at 09:19:13AM +0800, Shawn Lin wrote:
> >>diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> >>index 71d056d..720535b 100644
> >>--- a/drivers/pci/host/pcie-rockchip.c
> >>+++ b/drivers/pci/host/pcie-rockchip.c

...

> >>+static int rockchip_pcie_wait_l2(struct rockchip_pcie *rockchip)
> >>+{
> >>+	u32 value;
> >>+	int err;
> >>+
> >>+	/* send PME_TURN_OFF message */
> >>+	writel(0x0, rockchip->msg_region + PCIE_RC_SEND_PME_OFF);
> >>+
> >>+	/* read LTSSM and wait for falling into L2 link state */
> >>+	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_DEBUG_OUT_0,
> >>+				 value, PCIE_LINK_IS_L2(value), 20,
> >>+				 jiffies_to_usecs(5 * HZ));
> >
> >You really want to wait a whole 5 seconds for this? Last I saw, you were
> >doing testing with about 500ms or less. As I read the spec, there's cap
> >on per-device time to ACK the request, and I recall that was on the
> >order of 10s of milliseconds. But technically that can add up if you
> >have a large hierarchy of devices attached...
> >
> 
> I have no very clear thought about how long we should set up the
> timeout for PME_ACK. As you point out that a large hierarchy of devices
> need quite a long time I guess.
> 
> A possible work for PCIe core is walk through the hierarchy of devices
> and calculate the max ACK timeout(including the latency of HUB).. But
> I guess ACPI-base platforms don't need linux-pci to handle L2 stuff at
> S3 at all, instead it will be handled by firmware, so still I don't
> know how they will calculate it.

I'm not sure if that's necessary. I was just curious on how this got
determined, when it seemed that 500ms was plenty.

We shouldn't be hitting this (and if we do, then that means we'd
probably need to reassess anyway), so maybe "too large" is fine.

Brian
