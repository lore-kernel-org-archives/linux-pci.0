Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:60107 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759493Ab3BGX2k (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 18:28:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Murray <amurray@embedded-bits.co.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Thu, 7 Feb 2013 23:27:52 +0000
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
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
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <20130207183743.5c97d8b8@skate> <CAPcvp5EC=e8TbX9s88hF9uKMzTc6655k9=mgdEc0szP_phhbXQ@mail.gmail.com>
In-Reply-To: <CAPcvp5EC=e8TbX9s88hF9uKMzTc6655k9=mgdEc0szP_phhbXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302072327.52328.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 07 February 2013, Andrew Murray wrote:
> I'm not sure if the device pin part of the map is correct (I always
> forget how this works) - but I know this would definately work:
> 
>                          interrupt-map-mask = <0xf800 0 0 7>
>                          interrupt-map = <0x0800 0 0 1 &mpic 58
>                                           0x0800 0 0 2 &mpic 58
>                                           0x0800 0 0 3 &mpic 58
>                                           0x0800 0 0 4 &mpic 58
>                                           0x1000 0 0 1 &mpic 59
>                                           0x1000 0 0 2 &mpic 59
>                                           0x1000 0 0 3 &mpic 59
>                                           0x1000 0 0 4 &mpic 59
>                                           ....

If all the pins are routed to the same interrupt, you can leave
the pin out of the map-mask and save a bunch of lines in the
interrupt-map, at least  by the spec. I have not looked at the
source code to see if that is how Linux implements the lookup,
but that can be fixed if necessary.

	Arnd
