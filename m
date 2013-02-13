Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:49214 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312Ab3BMI5F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2013 03:57:05 -0500
Date: Wed, 13 Feb 2013 09:57:01 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130213095701.0d9f9f20@skate>
In-Reply-To: <20130212223511.GB31555@obsidianresearch.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130212223511.GB31555@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Tue, 12 Feb 2013 15:35:11 -0700, Jason Gunthorpe wrote:

> This is out of date now?

Yes, will fix.

> > +	pcie@0,0 {
> > +		device_type = "pciex";
> > +		reg = <0x0800 0 0xd0040000 0 0x2000>;
> 
> It would be great to get this sorted as per my prior comments.. Maybe
> like this is easy?
> 
> pcie-controller {
>  compatible = "marvell,armada-370-xp-pcie";
> 
>  // Index by marvell,pcie-port ?
>  regs = <0xd0040000 0x00002000
>          0xd0080000 0x00002000>;
> 
>  ranges = <0x81000000 0 0  0xc0000000  0 0x00010000   /* downstream I/O */
>            0x82000000 0 0  0xc1000000  0 0x08000000>; /* non-prefetchable memory */
> 
>  pcie@0,0 {
>       device_type = "pci";
>       reg = <0x0800 0 0 0>; // 00:01.0  (????)
>       marvell,pcie-port = <0>;
>  };
> }
> 
> It is abusive to map the device internal per-port registers through
> '0x00000800 0 0xd0040000' and 'reg' - that is not really the intent of
> the OF spec.

I am not sure to understand how this would work. Given a pcie@X,Y node,
how would I find the address of the internal registers (i.e the ones at
0xd0040000, 0xd0080000) ?

You seem to propose a global regs = <...> property under
pcie-controller, but indexing using marvell,pcie-port cannot work. PCIe
interfaces are identified by two values (port,lane), so we have 0.0,
0.1, 0.2, 0.3, 1.0, 1.1, 1.2, 1.3, 2.0 and 3.0 on MV78460. I really
would like to avoid having bizarre computations to find which entry in
this big regs = <...> array correspond to a given PCIe interface.

Could you give a more detailed example, matching the PCIe DT data of
the MV78460, which has many PCIe interfaces ?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
