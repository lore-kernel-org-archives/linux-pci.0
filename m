Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.32.191]:60622 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059Ab3ACPKF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jan 2013 10:10:05 -0500
Date: Thu, 3 Jan 2013 16:09:58 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Eran Ben-Avi <benavi@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robherring2@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
Message-ID: <20130103160958.3edf3005@skate>
In-Reply-To: <20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Thierry Reding,

On Thu, 3 Jan 2013 15:39:31 +0100, Thierry Reding wrote:

> Thomas' RFC series incited me to put in some more work on the Tegra
> PCIe controller driver. This in turn brought up an old issue: should
> we move PCIe controller drivers to some central location rather than
> keeping them in machine-specific directories? Last time I brought
> this up there was no consensus but I really think there's some value
> in keeping these drivers in a common location, especially now that a
> few people are starting to work on similar problems. It may also
> provide some more momentum to get the various DT implementations
> factored out of various architectures.
> 
> Stephen proposed drivers/pci/host on IRC and I second that.

I for sure would be interested in a direction such as this one being
taken for PCI support. Having drivers in a common directory will help
comparing them, extracting common patterns, etc.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
