Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs140.luxsci.com ([74.205.78.114]:38673 "EHLO rs140.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815Ab3CJFFs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 10 Mar 2013 00:05:48 -0500
Message-ID: <513C1473.60600@firmworks.com>
Date: Sat, 09 Mar 2013 19:04:51 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
CC: Thierry Reding <thierry.reding@avionic-design.de>,
	Lior Amsalem <alior@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
References: <20130212223511.GB31555@obsidianresearch.com> <20130306105441.4d24033e@skate> <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de> <20130306180946.GA2433@obsidianresearch.com> <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de> <20130307174955.GC20840@obsidianresearch.com> <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de> <20130307200235.GB20695@obsidianresearch.com> <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de> <51392B4D.9040404@gmail.com> <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de> <513A7044.1020700@gmail.com>
In-Reply-To: <513A7044.1020700@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/8/2013 1:12 PM, Rob Herring wrote:
> On 03/08/2013 01:14 AM, Thierry Reding wrote:
>> On Thu, Mar 07, 2013 at 06:05:33PM -0600, Rob Herring wrote:
>>> On 03/07/2013 02:47 PM, Thierry Reding wrote:
>> [...]
>>>> In a nutshell (since some of the context isn't quoted anymore) the
>>>> problem that we're trying to solve is that some of the embedded SoCs
>>>> require per-root-port registers for configuration. The PCI DT
>>>> specification doesn't make any provisions for this. A few alternatives
>>>> have been discussed so far:
>>>
>>> I'm not sure I follow. This is different than the host controller
>>> registers? Why would this not just be multiple entries in the reg property?
>>
>> Well the register regions are per root-port. On Tegra20 there's 2 of
>> them, Tegra30 has 3 and if I understand correctly Marvell can have up to
>> 10 (!). Adding all of them to the reg property of the host controller
>> could work but it needs some way to match the reg entry to the root port
>> similar to option 1 below.
> 
> The compatible property of the PCI host controller can imply what each
> index of the reg property entries is for.
> 
>>
>> Adding a property in the root port nodes seems like a cleaner and more
>> accurate representation of the hardware to me, but if that's not
>> acceptable perhaps we need to bite the bullet and add the code to look
>> the registers up from the parent's reg property.
> 
> What I don't like is a new property defined to describe mmio addresses.
> We already have a property for that and it is "reg". But I think I'm
> still missing something:


As stated in my recent reply to Jason, I thing the correct property is
"ranges".  "Ranges" translates mappable child address space addresses
into parent addresses, and that is exactly what is going on.  A specific
subset of config addresses is mappable into parent MMIO space.

When done that way, there is no need for the multi-entry reg property at
the top level, and the correspondence between specific root port DT
nodes and their MMIO addresses is easily determined by matching child
reg properties to parent ranges entries.

> 
>>>> 			pci@0,1 {
>>>> 				...
>>>> 				reg = <0x00000800 0 0 0 0>;
> 
> Is this a PCI bus address?
> 
>>>> 				regs = <0x80000000 0x00001000>;
>>>> 			};
> 
> Rob
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
