Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60393 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab3AaQnM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2013 11:43:12 -0500
Date: Thu, 31 Jan 2013 16:42:58 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
	systems
Message-ID: <20130131164258.GD23505@n2100.arm.linux.org.uk>
References: <CAErSpo7gCFfLB6+ebvANQjkr7Bii8Jqt3y5YqExD-DcnBG7hgA@mail.gmail.com> <20130129184157.GA29274@obsidianresearch.com> <CAErSpo5K8yKqjzQ6s+imb3d5wLSkhvWp-d=pPv9CZk+o67kyaQ@mail.gmail.com> <20130129191853.GB29274@obsidianresearch.com> <CAErSpo4Zvy7=ROajygecfsEFVJxy-yNbSntdQdDFcQBPz=Qgfg@mail.gmail.com> <CAErSpo41TbWTZ_6m0_uv-EaKnnqMR9jpqsarOJLGYZ31mrdkiw@mail.gmail.com> <20130130103501.1873d39c@skate> <CAErSpo5NTyrHv8AQkw3hYpJRiZsk1HKHP3jP_MMpEVVhCgjKYg@mail.gmail.com> <20130131170401.4b3bfbbf@skate> <CAErSpo7fPzrF_OZSL7Ss0LT70Qz+veXLW-ihA7fAXCwsn142cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo7fPzrF_OZSL7Ss0LT70Qz+veXLW-ihA7fAXCwsn142cQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 31, 2013 at 09:30:07AM -0700, Bjorn Helgaas wrote:
> Linux makes the unwarranted assumption that the PCI hierarchy has
> already been configured by firmware.  If the only problem is the
> messages above, I think we could just rework the message so it doesn't
> look like an error.

That's not a safe assumption, especially on platforms where there's no
BIOS (like ARM platforms).  Thankfully, for the platforms I care about,
the boot loaders I wrote for them _do_ do a full bus setup, so I don't
see a problem. :)

However, I have historially had the kernel over many years (probably
around 14 or 15 now) reassign all resources so that things are how the
kernel wants them, and not how my half-hearted attempt at setting them
up did (which only does a limited job enough to get the system to a
state where we can load the kernel.)
