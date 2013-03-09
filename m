Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:38705 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273Ab3CII65 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 9 Mar 2013 03:58:57 -0500
Date: Sat, 9 Mar 2013 09:58:49 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Rob Herring <robherring2@gmail.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130309095849.639f398e@skate>
In-Reply-To: <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
References: <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
	<20130306180946.GA2433@obsidianresearch.com>
	<20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
	<20130307174955.GC20840@obsidianresearch.com>
	<20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
	<20130307200235.GB20695@obsidianresearch.com>
	<20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
	<51392B4D.9040404@gmail.com>
	<20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
	<20130308165228.GB4094@obsidianresearch.com>
	<20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Thierry Reding,

On Fri, 8 Mar 2013 20:12:27 +0100, Thierry Reding wrote:

> Oh well. I don't like it, but if that's the way it has to be, then so be
> it.

I don't like it too much either, but it's not a big problem either. It
works, and satisfies the DT requirements reasonably.

> Any reason why the reg-names can't match the root port's node name
> so that it can be used directly instead of going through hoops to
> construct a string from extra parameters? Like below:
> 
> 	pcie-controller {
> 		regs = <...>;
> 		reg-names = ..., "pcie@1,0", "pcie@2,0";
> 
> 		pcie@1,0 {
> 			...
> 		};
> 
> 		pcie@2,0 {
> 			...
> 		};
> 	};

Yes, I thought about doing this, but in my driver, I also use the
"pcie0.0" string to request the address decoding window from the
mvebu-mbus driver. So I would anyway have to construct this "pciX.Y"
string. But if you feel like using "pcie@X,Y" for the reg-names is
better even if I still need to construct the "pcieX.Y" string, then I
will be perfectly ok with making this change.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
