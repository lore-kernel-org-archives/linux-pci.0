Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs130.luxsci.com ([72.32.115.17]:59087 "EHLO rs130.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906Ab2FMIhY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Jun 2012 04:37:24 -0400
Message-ID: <4FD85127.8050301@firmworks.com>
Date: Tue, 12 Jun 2012 22:36:55 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: Stephen Warren <swarren@wwwdotorg.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
References: <4FD66410.7090001@wwwdotorg.org> <20120612062124.GE4040@avionic-0098.adnet.avionic-design.de> <4FD763C5.3090500@wwwdotorg.org> <20120612172041.GA28010@avionic-0098.adnet.avionic-design.de> <4FD7A36B.9090409@wwwdotorg.org> <4FD7B085.1020006@firmworks.com> <20120613064519.GD31001@avionic-0098.mockup.avionic-design.de> <4FD84133.4060401@firmworks.com> <20120613075232.GA6139@avionic-0098.mockup.avionic-design.de> <4FD849CF.4030009@firmworks.com> <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/12/2012 10:19 PM, Thierry Reding wrote:
> On Tue, Jun 12, 2012 at 10:05:35PM -1000, Mitch Bradley wrote:
>> On 6/12/2012 9:52 PM, Thierry Reding wrote:
>>> I think the configuration spaces and downstream I/O ranges need to be in the
>>> pcie-controller's reg property because they are remapped and used by the
>>> controller driver, not by the individual ports.
>>>
>>> That's probably not really necessary but rather a result of how the driver
>>> was written. Perhaps the driver should handle them differently instead,
>>> listing the regions in the ranges property of the parent and listing the
>>> corresponding partitions in the ranges properties of the pci child nodes.
>>>
>>> Like in the following, where the ranges property of the ports partition the
>>> ranges passed from the parent evenly:
>>>
>>> 	pcie-controller {
>>> 		compatible = "nvidia,tegra20-pcie";
>>> 		reg =<0x80003000 0x00000800   /* PADS registers */
>>> 		       0x80003800 0x00000200>; /* AFI registers */
>>> 		interrupts =<0 98 0x04   /* controller interrupt */
>>> 			      0 99 0x04>; /* MSI interrupt */
>>> 		status = "disabled";
>>>
>>> 		ranges =<0x80000000 0x80000000 0x00002000   /* 2 root ports */
>>> 			  0x80004000 0x80004000 0x00100000   /* configuration space */
>>> 			  0x80104000 0x80100000 0x00100000   /* extended configuration space */
>>> 			  0x80400000 0x80400000 0x00010000   /* downstream I/O */
>>> 			  0x90000000 0x90000000 0x10000000   /* non-prefetchable memory */
>>> 			  0xa0000000 0xa0000000 0x10000000>; /* prefetchable memory */
>>>
>>> 		#address-cells =<1>;
>>> 		#size-cells =<1>;
>>>
>>> 		pci@80000000 {
>>> 			reg =<0x80000000 0x00001000>;
>>> 			status = "disabled";
>>>
>>> 			#address-cells =<3>;
>>> 			#size-cells =<2>;
>>>
>>> 			ranges =<0x80400000 0x80400000 0x00008000   /* I/O */
>>> 				  0x90000000 0x90000000 0x08000000   /* non-prefetchable memory */
>>> 				  0xa0000000 0xa0000000 0x08000000>; /* prefetchable memory */
>>
>> You are on the right track here, but the format of the child-address
>> portion of the above ranges property is incorrect.  Since the child
>> address space is the PCI address space, the child-address portion
>> needs to be 3 cells.  It's not a linear address but rather a triple.
>> The first cell identifies the address type (config, I/O, memory..)
>> and the second and third cells are offsets within that subspace.
>> The second and third cells will typically be 0.  The PCI binding has
>> details.

Also, the size field in ranges is specified according to the child 
address space, so there must be 2 size cells in the ranges at this 
level.  Each ranges entry at this level is:

<child_address_space, child_address_high, child_address_low, 
parent_address, child_size_high, child_size_low>

The above should be:

			ranges =<0x81000000 0 0  0x80400000  0 0x00008000   /* I/O */
				 0x82000000 0 0  0x90000000  0 0x08000000   /* non-prefetchable memory */
				 0xc2000000 0 0  0xa0000000  0 0x08000000>; /* prefetchable memory */


>>
>
> Okay, I'll need to read up some more.
>
> Thanks,
> Thierry
