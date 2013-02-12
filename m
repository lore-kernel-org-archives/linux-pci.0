Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:44480 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826Ab3BLWfI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Feb 2013 17:35:08 -0500
Date: Tue, 12 Feb 2013 15:35:11 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130212223511.GB31555@obsidianresearch.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 12, 2013 at 05:28:58PM +0100, Thomas Petazzoni wrote:
> +++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
[..]
> +pcie-controller {
> +	compatible = "marvell,armada-370-xp-pcie";
> +	status = "disabled";
> +
> +	#address-cells = <3>;
> +	#size-cells = <2>;
> +
> +	bus-range = <0x00 0xff>;
> +
> +	ranges = <0x00000800 0 0xd0040000 0xd0040000 0 0x00002000   /* port 0.0 registers */
> +	          0x00004800 0 0xd0042000 0xd0042000 0 0x00002000   /* port 2.0 registers */
> +	          0x00001000 0 0xd0044000 0xd0044000 0 0x00002000   /* port 0.1 registers */
> +	          0x00001800 0 0xd0048000 0xd0048000 0 0x00002000   /* port 0.2 registers */
> +	          0x00002000 0 0xd004C000 0xd004C000 0 0x00002000   /* port 0.3 registers */
> +		  0x00002800 0 0xd0080000 0xd0080000 0 0x00002000   /* port 1.0 registers */
> +	          0x00005000 0 0xd0082000 0xd0082000 0 0x00002000   /* port 3.0 registers */
> +		  0x00003000 0 0xd0084000 0xd0084000 0 0x00002000   /* port 1.1 registers */
> +		  0x00003800 0 0xd0088000 0xd0088000 0 0x00002000   /* port 1.2 registers */
> +		  0x00004000 0 0xd008C000 0xd008C000 0 0x00002000   /* port 1.3 registers */
> +		  0x81000000 0 0	  0xc0000000 0 0x00100000   /* downstream I/O */
> +		  0x82000000 0 0	  0xc1000000 0 0x08000000>; /* non-prefetchable memory */
> +
> +	#interrupt-cells = <1>;
> +	interrupt-map-mask = <0xf800 0 0 1>;
> +	interrupt-map = <0x0800 0 0 1 &mpic 58
> +		         0x1000 0 0 1 &mpic 59
> +			 0x1800 0 0 1 &mpic 60
> +			 0x2000 0 0 1 &mpic 61
> +			 0x2800 0 0 1 &mpic 62
> +		         0x3000 0 0 1 &mpic 63
> +			 0x3800 0 0 1 &mpic 64
> +			 0x4000 0 0 1 &mpic 65
> +			 0x4800 0 0 1 &mpic 99
> +			 0x5000 0 0 1 &mpic 103>;

This is out of date now?

> +	pcie@0,0 {
> +		device_type = "pciex";
> +		reg = <0x0800 0 0xd0040000 0 0x2000>;

It would be great to get this sorted as per my prior comments.. Maybe
like this is easy?

pcie-controller {
 compatible = "marvell,armada-370-xp-pcie";

 // Index by marvell,pcie-port ?
 regs = <0xd0040000 0x00002000
         0xd0080000 0x00002000>;

 ranges = <0x81000000 0 0  0xc0000000  0 0x00010000   /* downstream I/O */
           0x82000000 0 0  0xc1000000  0 0x08000000>; /* non-prefetchable memory */

 pcie@0,0 {
      device_type = "pci";
      reg = <0x0800 0 0 0>; // 00:01.0  (????)
      marvell,pcie-port = <0>;
 };
}

It is abusive to map the device internal per-port registers through
'0x00000800 0 0xd0040000' and 'reg' - that is not really the intent of
the OF spec.

Jason
