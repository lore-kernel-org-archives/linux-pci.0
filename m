Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52502 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab3A2XGZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 18:06:25 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 08/27] pci: implement an emulated PCI-to-PCI bridge
Date: Tue, 29 Jan 2013 23:06:13 +0000
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-9-git-send-email-thomas.petazzoni@free-electrons.com> <CAErSpo6ajS87mh7u58sLeN6oL5ixiPhaD7O7BrH1Av28mTk=qQ@mail.gmail.com>
In-Reply-To: <CAErSpo6ajS87mh7u58sLeN6oL5ixiPhaD7O7BrH1Av28mTk=qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201301292306.14012.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 29 January 2013, Bjorn Helgaas wrote:
> If you need this, it can be done in architecture code, can't it?  It's
> true that there's nothing architecture-specific in this patch (other
> than the fact that ARM is the only arch that needs it), but I'm not
> sure there's anything useful for sharing here.

Since we're moving the host bridge code to drivers/pci/host now, I think
this code should live in the same place. It's entirely possible that
it will be shared between arch/arm and arch/arm64, although I would
hope that we can do away with the emulated bridge code entirely.

More generally speaking, this is infrastructure code, and for any
piece of infrastructure my rule is

* don't add platform specific infrastructure if it can be done at
  the architecture level
* don't add architecture specific infrastructure if it can be
  written in an architecture independent way
* don't add global infrastructure if you can use or extend the
  existing infrastructure.

> In fact, it seems like what you're after is not so much an emulated
> bridge that has no corresponding hardware, as it is a wrapper that
> presents a standard PCIe interface to hardware that exists but doesn't
> conform to the PCIe spec.  If you really do need to ultimately connect
> this pci_sw_pci_bridge to a piece of hardware, that will certainly be
> arch-specific.

As Jason Gunthorpe suggested, we might not need this at all, if the
Linux PCI code can be convinced not to need a configuration space
for the devices that in case of the Marvell hardware don't provide
one.

	Arnd
