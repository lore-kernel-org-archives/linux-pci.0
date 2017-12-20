Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:32800 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756377AbdLTTTR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Dec 2017 14:19:17 -0500
Date: Wed, 20 Dec 2017 11:19:12 -0800
From: Tony Lindgren <tony@atomide.com>
To: Brian Norris <briannorris@chromium.org>
Cc: jeffy <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, shawn.lin@rock-chips.com,
        dianders@chromium.org, Heiko Stuebner <heiko@sntech.de>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 1/3] PCI: rockchip: Add support for pcie wake irq
Message-ID: <20171220191912.GM3875@atomide.com>
References: <20170817120431.12398-1-jeffy.chen@rock-chips.com>
 <20170817120431.12398-2-jeffy.chen@rock-chips.com>
 <20170818170107.GA119461@google.com>
 <20170818181416.GF6008@atomide.com>
 <5997486D.4040803@rock-chips.com>
 <20170822172653.GJ6008@atomide.com>
 <599CDB37.3070307@rock-chips.com>
 <20171219004811.GA216620@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171219004811.GA216620@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

* Brian Norris <briannorris@chromium.org> [171219 00:50]:
> On Wed, Aug 23, 2017 at 09:32:39AM +0800, Jeffy Chen wrote:
> 
> Did this problem ever get resolved? To be clear, I believe the problem
> at hand is:
> 
> (a) in suspend/resume (not runtime PM; we may not even have runtime PM
> support for most PCI devices)

It seems it should be enough to implement runtime PM in the PCI
controller. Isn't each PCI WAKE# line is wired from each PCI device
to the PCI controller?

Then the PCI controller can figure out from which PCI device the
WAKE# came from.

> Options I can think of:
> (1) implement runtime PM callbacks for all PCI devices, where we clear
> any PME status and ensure WAKE# stops asserting [1]

I don't think this is needed, it should be enough to have just
the PCI controller implement runtime PM :)

Regards,

Tony
