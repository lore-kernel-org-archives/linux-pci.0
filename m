Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Heiko Stuebner <heiko@sntech.de>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: add binding description of Rockchip PCIe controller
Date: Mon, 23 May 2016 21:53:06 +0200
Message-ID: <35714508.Tep5CcJBvk@phil>
In-Reply-To: <766c3fc9-7e92-6235-76d5-803cc116845a@rock-chips.com>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com> <3930626.4a3xBnzHhK@phil> <766c3fc9-7e92-6235-76d5-803cc116845a@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Samstag, 21. Mai 2016, 11:55:35 schrieb Shawn Lin:
> On 2016/5/20 19:20, Heiko Stuebner wrote:
> > Hi Shawn,
> > 
> > Am Freitag, 20. Mai 2016, 18:29:06 schrieb Shawn Lin:
> >> This patch add some required and optional properties for Rockchip
> >> PCIe controller. Also we add a example for how to use it.
> >> 
> >> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >> 
> >> ---

[...]

> >> +- msi-parent: Link to the hardware entity that serves as the Message
> >> +- pinctrl-names : The pin control state names
> >> +- pinctrl-0: The "default" pinctrl state
> > 
> > I'm not sure if pinctrl-properties need to be described when you don't
> > need special handling in the form of additional pin states. The pcie
> > part does not do any pin-handling of its own.
> 
> We need it in prevention of any firmwares change the default state
> of #CLKREQ which is useful for ASPM. Also we have a backup pin for
> clkreqn called clkreqnb, which should be taken more consideration since
> when refering to any one of these two, pinctrl should configure the
> bit[14] of GRF_SOC_CON7 automatically. But it is unfortunately beyound
> the implementation of pinctrl-rk3399.
> 
> BTW, I don't know if we wanna support this action inside the pinctrl
> code?

The TRM says for me for that bit only "pcie_clkreq_sel port control" and 
that naming really suggests that it is a property of the pcie controller, 
not the generic pinctrl. So if this needs to be touched the pcie controller 
needs to do it.


> >> +- interrupt-map-mask and interrupt-map: standard PCI properties
> >> +- interrupt-controller: identifies the node as an interrupt controller
> >> +
> >> +Optional Property:
> >> +- ep-gpios: contain the entry for pre-reset gpio
> >> +- num-lanes: number of lanes to use
> >> +- assigned-clocks, assigned-clock-parents and assigned-clock-rates:
> >> standard +		   clock bindings. See ../clock/clock-bindings.txt
> > 
> > Again that (assigned-clocks handling) is not actual part of the pci-
> > controllers actions, but other parts and also described already
> > elsewhere.
> Basically it does. But this is an alternative choice for pcie-phy to
> generate the ref_clk. When we want 100MHz src clk for PLL inside the
> pcie-phy，we should add them, otherwise it's taken from xin 24MHz.
> 
> This is useful for SI testing or some others special cases. So should we
> add it as an option and leave a sample here?

What I meant was that while clock handling is important when looking at the 
whole system, the pcie controller itself does only care that it gets a 
clock, but not that much where you get it from.

So while assigned-clocks has its place in the real devicetree, I don't think 
it is an element of the actual pcie-controller binding.


Heiko
