Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:58198 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab2FLQAb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 12:00:31 -0400
Message-ID: <4FD7679A.2080800@wwwdotorg.org>
Date: Tue, 12 Jun 2012 10:00:26 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 05/10] ARM: tegra: Rewrite PCIe support as a driver
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de> <1339427118-32263-6-git-send-email-thierry.reding@avionic-design.de> <4FD65E98.4070200@wwwdotorg.org> <20120612064124.GF4040@avionic-0098.adnet.avionic-design.de> <20120612072444.GA8577@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120612072444.GA8577@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/12/2012 01:24 AM, Thierry Reding wrote:
> * Thierry Reding wrote:
>> AFAICT the even partitioning of the non-prefetchable and 
>> prefetchable memory regions is arbitrary and it could
>> potentially be useful to make it configurable via the DT.
> 
> So it turns out that this isn't true. But apart from the comments 
> in the driver I couldn't find any reference to how the prefetch
> and non-prefetch ranges are partitioned. Judging by the code for
> Tegra2 this is evenly partitioned among ports 0 and 1 but it would
> be interesting to know this is done on Tegra3. Is there any way
> you can find out?
> 
> It'd also be nice if some better documentation for the PCIe 
> controller could be made available. The Tegra2 TRM doesn't contain 
> any of the AFI or PADS registers and while the Tegra3 TRM
> documents more registers, their offsets are completely missing.

I've filed a bug to request better documentation.

Looking at our downstream driver, the quoted comment below implies
that the address space layout is pretty arbitrary and programmable at
least for Tegra30. The code in function
tegra_pcie_setup_translations() appears to support this (and is
executed for both Tegra20 and Tegra30, even though the comment for
Tegra20 doesn't mention any programmability).

Tegra20:

> /*
>  * Tegra2 defines 1GB in the AXI address map for PCIe.
>  *
>  * That address space is split into different regions, with sizes and
>  * offsets as follows:
>  *
>  * 0x80000000 - 0x80003fff - PCI controller registers
>  * 0x80004000 - 0x80103fff - PCI configuration space
>  * 0x80104000 - 0x80203fff - PCI extended configuration space
>  * 0x80203fff - 0x803fffff - unused
>  * 0x80400000 - 0x8040ffff - downstream IO
>  * 0x80410000 - 0x8fffffff - unused
>  * 0x90000000 - 0x9fffffff - non-prefetchable memory
>  * 0xa0000000 - 0xbfffffff - prefetchable memory
>  */

(I guess by "is split", it means the driver sets it up that way, not
that the HW is fixed that way)

Tegra30:

> /*
>  * AXI address map for the PCIe aperture , defines 1GB in the AXI
>  *  address map for PCIe.
>  *
>  *  That address space is split into different regions, with sizes and
>  *  offsets as follows. Exepct for the Register space, SW is free to slice the
>  *  regions as it chooces.
>  *
>  *  The split below seems to work fine for now.
>  *
>  *  0x0000_0000 to 0x00ff_ffff - Register space          16MB.
>  *  0x0100_0000 to 0x01ff_ffff - Config space            16MB.
>  *  0x0200_0000 to 0x02ff_ffff - Extended config space   16MB.
>  *  0x0300_0000 to 0x03ff_ffff - Downstream IO space
>  *   ... Will be filled with other BARS like MSI/upstream IO etc.
>  *  0x1000_0000 to 0x1fff_ffff - non-prefetchable memory aperture
>  *  0x2000_0000 to 0x3fff_ffff - Prefetchable memory aperture
>  *
>  *  Config and Extended config sizes are choosen to support
>  *  maximum of 256 devices,
>  *  which is good enough for all the current use cases.
>  *
>  */

From
http://nv-tegra.nvidia.com/gitweb/?p=linux-2.6.git;a=blob;f=arch/arm/mach-tegra/pcie.c;h=b98d4892b5ee46120a9777a969e820a0b5cbb68a;hb=android-tegra-nv-3.1
