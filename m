Return-Path: <SRS0=YVMP=3A=chromium.org=briannorris@kernel.org>
Return-Path: <SRS0=YVMP=3A=chromium.org=briannorris@kernel.org>
Date: Thu, 23 Mar 2017 15:33:49 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Wenrui Li <wenrui.li@rock-chips.com>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/5] PCI: rockchip: fix sign issues for current limits
Message-ID: <20170323223348.GA102312@google.com>
References: <20170310024617.67303-1-briannorris@chromium.org>
 <20170323222717.GD23612@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170323222717.GD23612@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 23, 2017 at 05:27:17PM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 09, 2017 at 06:46:13PM -0800, Brian Norris wrote:
> > The regulator framework can return negative error codes via
> > regulator_get_current_limit() for regulators that don't provide current
> > information. The subsequent check for postive values isn't very useful,
> > if the variable is unsigned.
> > 
> > Let's just match the signedness of the return value.
> > 
> > Prevents error messages like this, seen on Samsung Chromebook Plus:
> > 
> > [    1.069372] rockchip-pcie f8000000.pcie: invalid power supply
> > 
> > Fixes: 4816c4c7b82b ("PCI: rockchip: Provide captured slot power limit and scale")
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> I applied the first two patches (this already has Shawn's ack and the
> second is trivially obvious) to pci/host-rockchip.

Thanks!

> I'm not sure what the
> current state of the others is.

Patch 4 seems like it should be fine (it was discussed previously, but
never done).

Apart from existing leaks in the PCI framework (which Jeffy and Shawn
are trying to patch [1]), I don't think there are any known issues with
3 and 5. It's certainly better than having 100% broken unbind at least,
IMO.

I suppose it's worth getting an ack/nack from Shawn though.

Brian

[1] https://patchwork.kernel.org/patch/9638353/
    https://patchwork.kernel.org/patch/9640545/
    https://patchwork.kernel.org/patch/9640549/
