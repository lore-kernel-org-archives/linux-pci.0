Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58283 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933173Ab3CVKVE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2013 06:21:04 -0400
Date: Fri, 22 Mar 2013 11:20:59 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v5 01/17] of/pci: Provide support for parsing PCI DT
 ranges property
Message-ID: <20130322112059.35675858@skate>
In-Reply-To: <20130322101238.GA22929@avionic-0098.mockup.avionic-design.de>
References: <1363887025-19931-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1363887025-19931-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130322101238.GA22929@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On Fri, 22 Mar 2013 11:12:39 +0100, Thierry Reding wrote:

> This sounds like you're trying to do too much within the for loop. When
> we discussed this previously I had a vague idea that this functionality
> could be wrapped into something a bit more object-like.
> 
> What I had in mind was something like:
> 
> 	struct of_pci_range_parser;
> 	struct of_pci_range;
> 
> 	struct of_pci_range_parser parser;
> 	struct of_pci_range range;
> 
> 	err = of_pci_range_parser(&parser, np);
> 	if (err < 0)
> 		return err;
> 
> 	for_each_of_pci_range(range, parser) {
> 		struct resource res;
> 
> 		...
> 		usage of range similar to iterator
> 		...
> 
> 		of_pci_range_to_resource(&res, &range);
> 	}
> 
> In the above the of_pci_range structure pretty much replaces the
> iterator and the whole is wrapped up within a parser structure to give
> some extra flexibility and provides for easier (or more structured)
> setup compared to doing all of it within the loop statement.
> 
> But aside from the (perceived?) increased robustness there's not a lot
> of technical benefit over your implementation, so it isn't a very hard
> objection. I find it to be a little more encapsulated and therefore
> easier to work with, but that's possibly just a matter of taste.

I don't have a strong opinion on this. Andrew, what do you think?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
