Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:50570 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab2FNSay (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jun 2012 14:30:54 -0400
Message-ID: <4FDA2DDA.1030704@wwwdotorg.org>
Date: Thu, 14 Jun 2012 12:30:50 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: Mitch Bradley <wmb@firmworks.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
References: <4FD763C5.3090500@wwwdotorg.org> <20120612172041.GA28010@avionic-0098.adnet.avionic-design.de> <4FD7A36B.9090409@wwwdotorg.org> <4FD7B085.1020006@firmworks.com> <20120613064519.GD31001@avionic-0098.mockup.avionic-design.de> <4FD84133.4060401@firmworks.com> <20120613075232.GA6139@avionic-0098.mockup.avionic-design.de> <4FD849CF.4030009@firmworks.com> <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de> <4FD85127.8050301@firmworks.com> <20120614091905.GA9081@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120614091905.GA9081@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/14/2012 03:19 AM, Thierry Reding wrote:
...
> Okay, so the new pcie-controller node looks like this:
> 
> pcie-controller { compatible = "nvidia,tegra20-pcie",
> "simple-bus"; reg = <0x80003000 0x00000800   /* PADS registers */ 
> 0x80003800 0x00000200   /* AFI registers */ 0x80004000 0x00100000
> /* configuration space */ 0x80104000 0x00100000>; /* extended
> configuration space */ interrupts = <0 98 0x04   /* controller
> interrupt */ 0 99 0x04>; /* MSI interrupt */ status = "disabled";
> 
> ranges = <0x80000000 0x80000000 0x00002000   /* 2 root ports */ 
> 0x80400000 0x80400000 0x00010000   /* downstream I/O */ 0x90000000
> 0x90000000 0x10000000   /* non-prefetchable memory */ 0xa0000000
> 0xa0000000 0x10000000>; /* prefetchable memory */

Do we actually need to specifically enumerate all the ranges; would
just "ranges;" be simpler?

> #address-cells = <1>; #size-cells = <1>;
> 
> pci@80000000 {

I'm still not convinced that using the address of the port's registers
is the correct way to represent each port. The port index seems much
more useful.

The main reason here is that there are a lot of registers that contain
fields for each port - far more than the combination of this node's
reg and ctrl-offset (which I assume is an address offset for just one
example of this issue) properties can describe. The bit position and
bit stride of these fields isn't necessarily the same in each
register. Do we want a property like ctrl-offset for every single type
of field in every single shared register that describes the location
of the relevant data, or just a single "port ID" bit that can be
applied to anything?

(Perhaps this isn't so obvious looking at the TRM since it doesn't
document all registers, and I'm also looking at the Tegra30
documentation too, which might be more exposed to this - I haven't
correlated all the documentation sources to be sure though)

> compatible = "nvidia,tegra20-pcie-port"; reg = <0x80000000
> 0x00001000>; status = "disabled";
> 
> #address-cells = <3>; #size-cells = <2>;
> 
> ranges = <0x81000000 0 0 0x80400000 0 0x00008000   /* I/O */ 
> 0x82000000 0 0 0x90000000 0 0x08000000   /* non-prefetchable memory
> */ 0xc2000000 0 0 0xa0000000 0 0x08000000>; /* prefetchable memory
> */

The values here appear identical for both ports. Surely they should
describe just the parts of the overall address space that have been
assigned/delegated to the individual port/bridge?

Note that initial indications are that the overall controller receives
transactions for those address ranges, and standard PCIe bridge
registers are used to steer chunks of these address ranges into the
individual downstream ports/busses. Hence, standard PCIe documentation
should indicate how to do this.

> nvidia,ctrl-offset = <0x110>; nvidia,num-lanes = <2>; };
> 
> pci@80001000 { compatible = "nvidia,tegra20-pcie-port"; reg =
> <0x80001000 0x00001000>; status = "disabled";
> 
> #address-cells = <3>; #size-cells = <2>;
> 
> ranges = <0x81000000 0 0 0x80408000 0 0x00008000   /* I/O */ 
> 0x82000000 0 0 0x98000000 0 0x08000000   /* non-prefetchable memory
> */ 0xc2000000 0 0 0xa8000000 0 0x08000000>; /* prefetchable memory
> */
> 
> nvidia,ctrl-offset = <0x118>; nvidia,num-lanes = <2>; }; };
> 
> While looking into some more code, trying to figure out how to hook
> this all up with the device tree I ran into a problem. I need to
> actually create a 'struct device' for each of the ports, so I added
> the "simple-bus" to the pcie-controller's "compatible" property.
> Furthermore, each PCI root port now becomes a platform_device,
> which are supported by a new tegra-pcie-port driver. I'm not sure
> if "port" is very common in PCI speek, so something like 
> tegra-pcie-bridge (compatible = "nvidia,tegra20-pcie-bridge") may
> be more appropriate?

What is it that drives the need for each port to be a 'struct device'?
The current driver supports 2 host ports, yet there's only a single
struct device for it. Does the DT code assume a 1:1 mapping between
struct device and DT node that represents the child bus? If so,
perhaps it'd be better to rework that code to accept a DT node as a
parameter and call it multiple times, rather than accept a struct
device as a parameter and hence need multiple devices?
