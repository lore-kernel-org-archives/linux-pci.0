Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57811 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460Ab3A2PPN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 10:15:13 -0500
Date: Tue, 29 Jan 2013 15:15:01 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Message-ID: <20130129151501.GY23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-6-git-send-email-thomas.petazzoni@free-electrons.com> <20130129161211.7bb8cada@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130129161211.7bb8cada@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 29, 2013 at 04:12:11PM +0100, Thomas Petazzoni wrote:
> Russell,
> 
> As the arch/arm/kernel/ maintainer, what is your position regarding the
> below patch?

Given the description, I'd feel much happier with this if we specified
the alignment numerically rather than allowing "some random code" to do
something with the passed values.
