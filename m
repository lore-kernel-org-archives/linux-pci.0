Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:55374 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab3BGIqM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 03:46:12 -0500
Date: Thu, 7 Feb 2013 09:45:56 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 22/27] arm: mvebu: add PCIe Device Tree informations
 for Armada XP
Message-ID: <20130207094556.423de279@skate>
In-Reply-To: <201302070804.12256.arnd@arndb.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<201302062241.14444.arnd@arndb.de>
	<20130207000715.0b3d662d@skate>
	<201302070804.12256.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Thu, 7 Feb 2013 08:04:12 +0000, Arnd Bergmann wrote:
> 	address-map {
> 		/* this device translates 64 bit MMIO bus addresses into 32 bit CPU addresses */
> 		compatible = "marvell,armada-addr-decoding-controller";
> 		reg = <0xd0020000 0x258>;
> 		#addres-cells = <2>;
> 		#address-cells = <1>;
> 
> 		/* each remapped window has one entry here */
> 		ranges = <0xa 0 0xc0000000 0x10000>,     /* map window a to 0xc0000000 */
> 		         <0xb 0 0xc1000000 0x08000000>,  /* map window b to 0xc1000000 */
> 			 <...>; /* more windows */
> 
> 		pciex {
> 			#addres-cells = <3>;
> 			#size-cells = <2>;
> 			ranges = <0x81000000 0 0 0xa 0 0 0x00010000,  /* I/O is window a */
> 				  0x82000000 0 0 0xb 0 0 0x08000000>; /* non-prefetchable memory */
> 			...
> 		};
> 
> 
> 		something-else {
> 			...
> 			reg = <0xc 0 0x10000>; /* window c */
> 		};
> 	};
> };

Unfortunately, this means the windows are statically defined in the DT,
which is simply not possible for PCIe, as we have already explained
several times in this thread.

Any solution where the PCIe windows are statically described is
simply /not/ acceptable.

We have 10 PCIe interfaces, each requiring up to two windows, and we
have on the system a *total* of 20 windows. Doing static assignments of
windows is simply not an option.

Of course, you'll tell me that it's up to each board .dts to have a
number of windows that matches the number of actually existing PCIe
interface. But it means that each and every developer adding the
support for a new board must understand this complex problem, which is
something we do not want. We have a solution that makes all of this
PCIe window assignment dynamic, so it surprises me that we have to
continue to explain why a static solution is not appropriate.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
