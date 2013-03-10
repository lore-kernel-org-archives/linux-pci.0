Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs140.luxsci.com ([74.205.78.114]:38578 "EHLO rs140.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124Ab3CJExJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 9 Mar 2013 23:53:09 -0500
Message-ID: <513C117D.6080800@firmworks.com>
Date: Sat, 09 Mar 2013 18:52:13 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: Thierry Reding <thierry.reding@avionic-design.de>,
	Lior Amsalem <alior@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
References: <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de> <20130307200235.GB20695@obsidianresearch.com> <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de> <51392B4D.9040404@gmail.com> <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de> <20130308165228.GB4094@obsidianresearch.com> <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de> <513A3F4F.2090501@firmworks.com> <20130308200245.GC29435@obsidianresearch.com> <513A7845.6040304@firmworks.com> <20130309013152.GA3883@obsidianresearch.com>
In-Reply-To: <20130309013152.GA3883@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/8/2013 3:31 PM, Jason Gunthorpe wrote:
> On Fri, Mar 08, 2013 at 01:46:13PM -1000, Mitch Bradley wrote:
>> On 3/8/2013 10:02 AM, Jason Gunthorpe wrote:
>>> On Fri, Mar 08, 2013 at 09:43:11AM -1000, Mitch Bradley wrote:
>>>
>>>>>> http://www.spinics.net/lists/arm-kernel/msg228749.html
>>>>
>>>> The example in that posting looks messed up to me.
>>>>
>>>> 1) It has "reg = <0x0800 0 0 0 0>", but 0x0800 0 0  is not a valid
>>>> address in the address space defined by its parent - because the
form of
>>>> the parent's ranges property indicates that it's a PCI-style address
>>>> form.  0x0800 0 0 lacks the top bits that indicate non-relocatable and
>>>> the type (I/O, memory, etc).
>>>
>>> You need to review the OF PCI bindings to make sense of this.  The
>>> subnodes are PCI devices. Those PCI devices show up in the
>>> configuration space (ie lspci). They are the PCI root port bridges.
>>
>> As it turns out, I wrote those bindings, almost 20 years ago.
>>
>> Having dug through old versions of that patch, I think I see the source
>> of the confusion.
>
> Not sure, I think this has gone into a weird tangent, your conclusions
> don't match how the PCI-E root complex is presented to the kernel.
>
> Lets just go back to the start?
>
> The pci-controller node is a root complex.
>
> The children of that node are elements in the root complex - they are
> the root port bridges. They are all on PCI bus 0.
>
> Each root port bridge responds to configuration cycles, and has a PCI
> configuration space. They show up in lspci.
>
> The host controller device driver knows how to issue configuration
> cycles, and it knows how to deliver configuration cycles on bus 0 to
> the bridges.
>
> This one:
> +			pcie@0,0 {
> +				device_type = "pci";
> +				reg = <0x0800 0 0 0 0>;
>
> Responds to bus 0, device 1, function 0.
>
> Each root port bridge has an associated non-PCI MMIO address
> space. The child above is associated with 0xd0040000. This MMIO
> address space is needed by the host controller driver to operate the
> port.
>
> The text after the @ is a mistake, Linux doesn't enforce anything
> about this text so nobody noticed till now, it should be corrected to
> @1,0, similarly for the second one.
>
> Also, from your comments the top level should gain a 'device_type =
> "pci"'.
>
> So, from that point, does the DT start to make sense? Are there other
> problems?
>
> The question at hand is how do you associate the non-PCI MMIO space
> 0xd0040000 with the root port bridge 'pcie@1,0' ? The patch proposes
> to use a reg array in the controller plus reg-names to do this.
>
> I have trouble making sense of your suggestions to switch away from
> 5dw addressing. It is critical that the DT child stanza be associated
> with the PCI discovered root port bridge. By my understanding Linux
> does this based on the configuration space format 'reg' value. How is
> that association possible if you switch things away from 5dw
> addressing?
>
> Also, this is for firmware-less embedded. Linux is required to scan
> the bus and do full address assignment of all PCI devies, including
> the root port bridges. The ranges property on the top node specifies
> the addressing apertures that are available for this process. This is
> common practice, there are many examples of this in kernel dts for PCI
> controllers.

Okay, I think I finally get it.  The Marvell root port bridge setup
registers look like standard config headers, even though they aren't
really in config space (because you need a different access method for
them, compared to real config accesses to downstream devices).

So, in order for the common code that enumerates the PCI bus to work,
you need to "spoof" the config accesses so that when you try to access
those particular "pseudo config headers", it uses the MMIO method
instead of the real config access method.

If that is indeed the case, them I would vote for a slight modification
of the intermediate patch that I cited earlier - the one in which the
ranges property includes translations from those special config
addresses into CPU addresses.  The modification is to fix the sizes,
changing 0x2000 to 0x800, so those ranges entries do not overlap in the
child address domain.

With that change, plus fixing the "@port,lane" strings to be "@dev,fun",
the DT would not raise all the red flags that led me down this rathole.

The controller driver would still have to implement the magic spoofing
of those funky config headers, but at least it would be doing it based
on well-established representation principles, specifically ranges
entries and well-formed child addresses, without having to resort to the
new sideband "port and lane" address representation.

Here's what it would look like:

pcie-controller {
	compatible = "marvell,armada-370-pcie";
	status = "disabled";

	#address-cells = <3>;
	#size-cells = <2>;

	bus-range = <0x00 0xff>;

	ranges = <0x00000800 0 0          0xd4004000 0 0x00000800   /* Root
port config header */
	          0x00001000 0 0          0xd4008000 0 0x00000800   /* Root
port config header */
		  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /*
non-prefetchable memory */
	          0x81000000 0 0          0xe8000000 0 0x00100000>; /*
downstream I/O */

	pcie@1,0 {
		device_type = "pci";
		reg = <0x0800 0 0 0 0>;
		#address-cells = <3>;
		#size-cells = <2>;
		#interrupt-cells = <1>;
		interrupt-map-mask = <0 0 0 0>;
		interrupt-map = <0 0 0 0 &mpic 58>;
		marvell,pcie-port = <0>;
		marvell,pcie-lane = <0>;
		clocks = <&gateclk 5>;
		status = "disabled";
	};

	pcie@2,0 {
		device_type = "pci";
		reg = <0x1000 0 0 0 0>;
		#address-cells = <3>;
		#size-cells = <2>;
		#interrupt-cells = <1>;
		interrupt-map-mask = <0 0 0 0>;
		interrupt-map = <0 0 0 0 &mpic 62>;
		marvell,pcie-port = <1>;
		marvell,pcie-lane = <0>;
		clocks = <&gateclk 9>;
		status = "disabled";
	};
};


>
> It is impossible to specify any detail for the bridges (be it address
> ranges or bus number ranges) because we have no idea what discovery
> will find, or what values Linux will choose to assign.
>
>> In neither case would you need the controversial "reg-names" thing.
>
> reg-names has been a standard feature in the Linux kernel for a bit
> already..
>
> Thanks a lot for looking at this,
> Jason
>
