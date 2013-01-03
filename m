Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53132 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab3ACP5Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jan 2013 10:57:25 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
Date: Thu, 3 Jan 2013 15:56:31 +0000
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Rob Herring <robherring2@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com> <20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201301031556.31618.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 03 January 2013, Thierry Reding wrote:
> Stephen proposed drivers/pci/host on IRC and I second that.

Agreed, I like that, too. There is a little problem with cross-platform
PCI hosts still because some portion of the interface is still arch
specific, but I don't see this as a show-stopper for moving drivers
there. The ARM specific drivers can still use the ARM interfaces
for now, until everything is made generic. If they are going to
be shared with other architectures, those can use the same interfaces
that ARM has. I think Microblaze, ARC and Metag are strong candidates
for doing this.

	Arnd
