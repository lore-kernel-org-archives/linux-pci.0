Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.141]:44692 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbdHJIkW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2017 04:40:22 -0400
Message-ID: <598C1BDF.6010203@rock-chips.com>
Date: Thu, 10 Aug 2017 16:39:59 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [RFC PATCH] PCI: rockchip: fix system hang up if activate CONFIG_DEBUG_SHIRQ
References: <1502353273-123788-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1502353273-123788-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi shawn,

On 08/10/2017 04:21 PM, Shawn Lin wrote:
> With CONFIG_DEBUG_SHIRQ enabled, the irq tear down routine
> would still access the irq handler registed as a shard irq.
> Per the comment within the function of __free_irq, it says
> "It's a shared IRQ -- the driver ought to be prepared for
> an IRQ event to happen even now it's being freed". However
> when failing to probe the driver, it may disable the clock
> for accessing the register and the following check for shared
> irq state would call the irq handler which accesses the register
> w/o the clk enabled. That will hang the system forever.

i think this extra irq call is to make sure it's safe to get a shared 
irq when we are freeing it, and we would not get this irq after freed it.

so maybe just call devm_free_irq before disable clks(and other required 
resources for the irq handler)? and also do it in the rockchip_pcie_remove.
