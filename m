Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59817 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964954Ab3BMWZA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2013 17:25:00 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Yinghai Lu <yinghai@kernel.org>
Subject: Re: Giving special alignment/size constraints to the Linux PCI core?
Date: Wed, 13 Feb 2013 22:24:53 +0000
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de> <201302132110.55087.arnd@arndb.de> <CAE9FiQVHQqpE+Dupcmt=dpUUEJk=3JoxsMmFf0SXtqE==YJ9Fg@mail.gmail.com>
In-Reply-To: <CAE9FiQVHQqpE+Dupcmt=dpUUEJk=3JoxsMmFf0SXtqE==YJ9Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302132224.53456.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 13 February 2013, Yinghai Lu wrote:
> On Wed, Feb 13, 2013 at 1:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > The problem I see with the current implementation is that it reserves
> > a fixed size window and does not reassign the window of the bridge
> > itself, only the devices below it, at least if I am reading the
> > code correctly. I have not tried this myself.
> 
> Which file?
> 
> Current code we do change the bridge itself resource (mmio, pref mmio, and io)
> in
> pciehp_configure_device/pci_assign_unassigned_bridge_resources
> 
> Let met if it does not work you.

That is the code I was looking at, but I probably misunderstood something
there. I did not actually run it, just attempted to understand what it
does by inspection.

I found the code now, sorry for the confusion on my end.

Jason, Thomas: you win :-)

The concept that root ports don't get resized is hardwired a lot of places
along the way. That could be changed, but there is a significant risk
of regressions if we try that. Adding fake bridges to work around that
isn't the nicest solution, but the code is there and works without
being able to break something else, so let's do that unless there are
new problems that make it harder.

	Arnd
