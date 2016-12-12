Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33273 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbcLLUTv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2016 15:19:51 -0500
Received: by mail-pf0-f181.google.com with SMTP id d2so14191249pfd.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2016 12:19:51 -0800 (PST)
Date: Mon, 12 Dec 2016 12:19:48 -0800
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] PCI: rockchip: Add quirk to disable RC's ASPM L0s
Message-ID: <20161212201947.GA37027@google.com>
References: <1481543487-33152-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481543487-33152-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Mon, Dec 12, 2016 at 07:51:27PM +0800, Shawn Lin wrote:
> Rockchip's RC outputs 100MHz reference clock but there are
> two methods for PHY to generate it.
> 
> (1)One of them is to use system PLL to generate 100MHz clock and
> the PHY will relock it and filter signal noise then outputs the
> reference clock.
> 
> (2)Another way is to share Soc's 24MHZ crystal oscillator with
> PHY and force PHY's DLL to generate 100MHz internally.
> 
> When using case(2), the exit from L0s doesn't work fine occasionally
> due to the broken design of RC receiver's logical circuit. So even if
> we use extended-synch, it still fails for PHY to relock the bits from
> FTS sometimes. This will hang the system.
> 
> Maybe we could argue that why not use case(1) to avoid it? The reason
> is that as we could see the reference clock is derived from system PLL
> and the path from it to PHY isn't so clean which means there are some
> noise introduced by power-domain and other buses can't be filterd out
> by PHY and we could see noise from the frequency spectrum by
> oscilloscope. This makes the TX compatibility test a little difficult
> to pass the spec. So case(1) and case(2) are both used indeed now. If
> using case(2), we should disable RC's L0s support, and that is why we
> need this property to indicate this quirk.
> 
> Also after checking quirk.c, I noticed there is already a quirk for
> disabling L0s unconditionally, quirk_disable_aspm_l0s. But obviously we
> shouldn't do that as mentioned above that case(1) could still works fine
> with L0s.

Side note: I think Doug mentioned previously that the default
rk3399.dtsi actually leaves the default clock choice (i.e., case 2), so
it might be good to patch this property into the rk3399.dtsi instead of
the board files. If any board goes with option 1, they can delete the
property.

I can patch this up myself if you don't, as I'm working on upstreaming
the rk3399-gbased Gru/Kevin device trees.

> Reported-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - drop the quirk prefix
> 
>  Documentation/devicetree/bindings/pci/rockchip-pcie.txt | 2 ++
>  drivers/pci/host/pcie-rockchip.c                        | 9 +++++++++
>  2 files changed, 11 insertions(+)

FWIW:

Reviewed-by: Brian Norris <briannorris@chromium.org>
