Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:47042 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400Ab3A3VG2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 30 Jan 2013 16:06:28 -0500
Date: Wed, 30 Jan 2013 14:06:23 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Message-ID: <20130130210623.GA5241@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301292254.01069.arnd@arndb.de>
 <20130130042103.GB5734@obsidianresearch.com>
 <201301300955.49473.arnd@arndb.de>
 <20130130124721.0ad0294e@skate>
 <CAErSpo4GKimzwTBB8aN4aj7ms=8pfkoV1=j8mstPDCxc-+gPxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4GKimzwTBB8aN4aj7ms=8pfkoV1=j8mstPDCxc-+gPxQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 30, 2013 at 01:48:33PM -0700, Bjorn Helgaas wrote:

> This is a tangent since you're removing the emulated host bridge
> anyway, but it's been mentioned a couple of times, and I'd like to
> understand this.  Jason mentioned earlier in the [07/27] emulated host
> bridge thread that the PCIe spec requires a host bridge at 00:00.0.
> I've never seen that mentioned in the spec; can somebody point me to
> the actual requirement that host bridges appear in config space?

Hum, a more careful search/reading brings up this:

7.2.2.1. Host Bridge Requirements

 [...] The use of Host Bridge PCI class code is reserved for backwards
 compatibility; host Bridge configuration space is opaque to standard
 PCI Express software and may be implemented in an implementation
 specific manner that is compatible with PCI Host Bridge Type 0
 configuration space. A PCI Express Host Bridge is not required to
 signal errors through a Root Complex Event Collector. This support is
 optional for PCI Express Host Bridges.

So, if it is present it is required to be compatible with the 'PCI
Host Bridge' stuff, but it is not mandatory.

My bad, I believe I got also confused with the spec language regarding
a 'host bridge' vs a 'host bridge configuration space'

Regards,
Jason
