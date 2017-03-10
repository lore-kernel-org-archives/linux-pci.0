Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 9 Mar 2017 18:27:40 -0800
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/3] PCI: rockchip: fix sign issues for current limits
Message-ID: <20170310022739.GA130422@google.com>
References: <20170308233748.54706-1-briannorris@chromium.org>
 <662fb87d-de80-ac96-4a25-c478956cceb2@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <662fb87d-de80-ac96-4a25-c478956cceb2@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 09, 2017 at 04:59:15PM +0800, Shawn Lin wrote:
> On 2017/3/9 7:37, Brian Norris wrote:
> >The regulator framework can return negative error codes via
> >regulator_get_current_limit() for regulators that don't provide current
> >information. The subsequent check for postive values isn't very useful,
> >if the variable is unsigned.
> >
> >Let's just match the signedness of the return value.
> >
> >Prevents error messages like this, seen on Samsung Chromebook Plus:
> >
> >[    1.069372] rockchip-pcie f8000000.pcie: invalid power supply
> >
> 
> For this patch,
> 
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks.

> And I think patch 2 is not so urgent so we could just wait for your
> non-WIP patch 3?

Sure. I'll be resending the series with a proper patch 3 (and 4 and 5
actually) soon anyway. No changes to the first 2.

Brian
