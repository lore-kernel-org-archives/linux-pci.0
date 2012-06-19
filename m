Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:42675 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159Ab2FSQko (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jun 2012 12:40:44 -0400
Message-ID: <4FE0AB87.9030007@wwwdotorg.org>
Date: Tue, 19 Jun 2012 10:40:39 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: Mitch Bradley <wmb@firmworks.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
References: <4FD84133.4060401@firmworks.com> <20120613075232.GA6139@avionic-0098.mockup.avionic-design.de> <4FD849CF.4030009@firmworks.com> <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de> <4FD85127.8050301@firmworks.com> <20120614091905.GA9081@avionic-0098.mockup.avionic-design.de> <4FDA2DDA.1030704@wwwdotorg.org> <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de> <4FDA40A0.4030206@wwwdotorg.org> <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de> <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/19/2012 07:30 AM, Thierry Reding wrote:
> On Fri, Jun 15, 2012 at 08:12:36AM +0200, Thierry Reding wrote:
>> On Thu, Jun 14, 2012 at 01:50:56PM -0600, Stephen Warren wrote:
...
>>> To me, working back from address to ID then using the ID to calculate
>>> some other addresses seems far more icky than just calculating all the
>>> addresses based off of one ID. But, I suppose this doesn't make a huge
>>> practical difference.
>>
>> This really depends on the device vs. no device decision below. If we can
>> make it work without needing an extra device for it, then using the index
>> is certainly better. However, if we instantiate devices from the DT, then
>> we have the address anyway and adding the index as a property would be
>> redundant and error prone (what happens if somebody sets the index of the
>> port at address 0x80000000 to 2?).
> 
> An additional problem with this is that we'd have to add the following
> to the pcie-controller node:
> 
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 
> This will conflict with the "ranges" property, because suddenly we can
> no longer map the regions properly. Maybe Mitch can comment on whether
> this is possible or not?
> 
> To make it clearer what I'm talking about, here's the DT snippet again
> (with the compatible property removed from the pci@ nodes because they
> are no longer probed by a driver, the "simple-bus" removed from the
> pcie-controller node's compatible property removed and its #address-
> and #size-cells properties adjusted as described above).
> 
> 	pcie-controller {
> 		compatible = "nvidia,tegra20-pcie";
> 		reg = <0x80003000 0x00000800   /* PADS registers */
> 		       0x80003800 0x00000200   /* AFI registers */
> 		       0x80004000 0x00100000   /* configuration space */
> 		       0x80104000 0x00100000>; /* extended configuration space */
> 		interrupts = <0 98 0x04   /* controller interrupt */
> 			      0 99 0x04>; /* MSI interrupt */
> 		status = "disabled";
> 
> 		ranges = <0x80000000 0x80000000 0x00002000   /* 2 root ports */
> 			  0x80400000 0x80400000 0x00010000   /* downstream I/O */
> 			  0x90000000 0x90000000 0x10000000   /* non-prefetchable memory */
> 			  0xa0000000 0xa0000000 0x10000000>; /* prefetchable memory */
> 
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		pci@0 {
> 			reg = <2>;
> 			status = "disabled";
> 
> 			#address-cells = <3>;
> 			#size-cells = <2>;
> 
> 			ranges = <0x81000000 0 0 0x80400000 0 0x00008000   /* I/O */
> 				  0x82000000 0 0 0x90000000 0 0x08000000   /* non-prefetchable memory */
> 				  0xc2000000 0 0 0xa0000000 0 0x08000000>; /* prefetchable memory */
> 
> 			nvidia,ctrl-offset = <0x110>;
> 			nvidia,num-lanes = <2>;
> 		};
> 
> 		pci@1 {
> 			reg = <1>;
> 			status = "disabled";
> 
> 			#address-cells = <3>;
> 			#size-cells = <2>;
> 
> 			ranges = <0x81000000 0 0 0x80408000 0 0x00008000   /* I/O */
> 				  0x82000000 0 0 0x98000000 0 0x08000000   /* non-prefetchable memory */
> 				  0xc2000000 0 0 0xa8000000 0 0x08000000>; /* prefetchable memory */
> 
> 			nvidia,ctrl-offset = <0x118>;
> 			nvidia,num-lanes = <2>;
> 		};
> 	};
> 
> AIUI none of the ranges properties are valid anymore, because the bus
> represented by pcie-controller no longer reflects the truth, namely that
> it translates the CPU address space to the PCI address space.

Yes, I imagine that's a show-stopper for this approach.
