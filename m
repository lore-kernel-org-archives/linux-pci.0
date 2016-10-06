Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36792 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935642AbcJFViE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2016 17:38:04 -0400
Received: by mail-pf0-f173.google.com with SMTP id i85so14719134pfa.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Oct 2016 14:38:04 -0700 (PDT)
Date: Thu, 6 Oct 2016 14:38:00 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] PCI: rockchip: Support property to specify the link
 capability
Message-ID: <20161006213800.GA2347@localhost>
References: <1475743800-1036-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475743800-1036-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 06, 2016 at 04:50:00PM +0800, Shawn Lin wrote:
> From: Brian Norris <briannorris@chromium.org>
> 
> rk3399 supports PCIe 2.x link speeds marginally at best, and on some
> boards, the link won't train at 5 GT/s at all. Rather than sacrifice 500
> ms waiting for training that will never happen, let's add a property
> from devicetree to specify link capability.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v4:
> - define link_gen as u32
> - elaborate more for rockchip,max-link-speed on doc
> 
> Changes in v3:
> - Cast a warning for invalid max link speed and use gen1 for it.
>   That looks better than v2. (Suggested by Brian)
> 
> Changes in v2:
> - rename the property to rockchip,max-link-speed according to
>   Bjorn's recommendation and take some bits from imx6q-pcie to
>   make this requirement more consisent.
> 
>  .../devicetree/bindings/pci/rockchip-pcie.txt      |  4 ++
>  drivers/pci/host/pcie-rockchip.c                   | 63 ++++++++++++++--------
>  2 files changed, 44 insertions(+), 23 deletions(-)

Not sure if it means anything much, since I wrote half of this, but:

Reviewed-by: Brian Norris <briannorris@chromium.org>
