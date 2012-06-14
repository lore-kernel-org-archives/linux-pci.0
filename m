Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:40123 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab2FNTvA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jun 2012 15:51:00 -0400
Message-ID: <4FDA40A0.4030206@wwwdotorg.org>
Date: Thu, 14 Jun 2012 13:50:56 -0600
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
References: <4FD7A36B.9090409@wwwdotorg.org> <4FD7B085.1020006@firmworks.com> <20120613064519.GD31001@avionic-0098.mockup.avionic-design.de> <4FD84133.4060401@firmworks.com> <20120613075232.GA6139@avionic-0098.mockup.avionic-design.de> <4FD849CF.4030009@firmworks.com> <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de> <4FD85127.8050301@firmworks.com> <20120614091905.GA9081@avionic-0098.mockup.avionic-design.de> <4FDA2DDA.1030704@wwwdotorg.org> <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/14/2012 01:29 PM, Thierry Reding wrote:
> On Thu, Jun 14, 2012 at 12:30:50PM -0600, Stephen Warren wrote:
>> On 06/14/2012 03:19 AM, Thierry Reding wrote:
...
>>> #address-cells = <1>; #size-cells = <1>;
>>> 
>>> pci@80000000 {
>> 
>> I'm still not convinced that using the address of the port's
>> registers is the correct way to represent each port. The port
>> index seems much more useful.
>> 
>> The main reason here is that there are a lot of registers that
>> contain fields for each port - far more than the combination of
>> this node's reg and ctrl-offset (which I assume is an address
>> offset for just one example of this issue) properties can
>> describe. The bit position and bit stride of these fields isn't
>> necessarily the same in each register. Do we want a property like
>> ctrl-offset for every single type of field in every single shared
>> register that describes the location of the relevant data, or
>> just a single "port ID" bit that can be applied to anything?
>> 
>> (Perhaps this isn't so obvious looking at the TRM since it
>> doesn't document all registers, and I'm also looking at the
>> Tegra30 documentation too, which might be more exposed to this -
>> I haven't correlated all the documentation sources to be sure
>> though)
> 
> I agree that maybe adding properties for each bit position or
> register offset may not work out too well. But I think it still
> makes sense to use the base address of the port's registers (see
> below). We could of course add some code to determine the index
> from the base address at initialization time and reuse the index
> where appropriate.

To me, working back from address to ID then using the ID to calculate
some other addresses seems far more icky than just calculating all the
addresses based off of one ID. But, I suppose this doesn't make a huge
practical difference.

>>> compatible = "nvidia,tegra20-pcie-port"; reg = <0x80000000 
>>> 0x00001000>; status = "disabled";
>>> 
>>> #address-cells = <3>; #size-cells = <2>;
>>> 
>>> ranges = <0x81000000 0 0 0x80400000 0 0x00008000   /* I/O */ 
>>> 0x82000000 0 0 0x90000000 0 0x08000000   /* non-prefetchable
>>> memory */ 0xc2000000 0 0 0xa0000000 0 0x08000000>; /*
>>> prefetchable memory */
>> 
>> The values here appear identical for both ports. Surely they
>> should describe just the parts of the overall address space that
>> have been assigned/delegated to the individual port/bridge?
> 
> They're not identical. Port 0 gets the first half and port 1 gets
> the second half of the ranges specified in the parent.

Oh right, I missed some 8s and 0s that looked the same!

>>> While looking into some more code, trying to figure out how to
>>> hook this all up with the device tree I ran into a problem. I
>>> need to actually create a 'struct device' for each of the
>>> ports, so I added the "simple-bus" to the pcie-controller's
>>> "compatible" property. Furthermore, each PCI root port now
>>> becomes a platform_device, which are supported by a new
>>> tegra-pcie-port driver. I'm not sure if "port" is very common
>>> in PCI speek, so something like tegra-pcie-bridge (compatible =
>>> "nvidia,tegra20-pcie-bridge") may be more appropriate?
>> 
>> What is it that drives the need for each port to be a 'struct
>> device'? The current driver supports 2 host ports, yet there's
>> only a single struct device for it. Does the DT code assume a 1:1
>> mapping between struct device and DT node that represents the
>> child bus? If so, perhaps it'd be better to rework that code to
>> accept a DT node as a parameter and call it multiple times,
>> rather than accept a struct device as a parameter and hence need
>> multiple devices?
> 
> It's not so much the DT code, but rather the PCI core and
> ultimately the device model that requires it. Each port is
> basically a PCI host bridge that provides a root PCI bus and the
> device model is used to represent the hierachy of the busses.
> Providing just the DT node isn't going to be enough.

But the existing driver works without /any/ devices, let alone one per
port.
