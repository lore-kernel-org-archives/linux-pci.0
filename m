Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:37920 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932131AbaBUPjL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2014 10:39:11 -0500
Date: Fri, 21 Feb 2014 16:37:50 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	"Longchamp, Valentin" <Valentin.Longchamp@keymile.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: pci-mvebu driver on km_kirkwood
Message-ID: <20140221163750.3741a8ad@skate>
In-Reply-To: <2344852.BKudsNuPXM@wuerfel>
References: <53039894.10905@keymile.com>
	<2193926.ls2teBqnfK@wuerfel>
	<20140221161108.50a4c932@skate>
	<2344852.BKudsNuPXM@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Fri, 21 Feb 2014 16:20:45 +0100, Arnd Bergmann wrote:

> > What if the size of your BAR is 128 MB + 64 MB + 32 MB ? Then you need
> > three windows, and your algorithm doesn't work 
> 
> I was hoping we could avoid using more than two windows.
> With the algorithm above we would round up to 256MB and
> fail if that doesn't fit, which is the same thing that
> happens when you run out of space.

The problem is precisely that we currently don't have any well to tell
the Linux PCI core that we need to round up the size of a BAR. That's
the whole starting point of the discussion :-)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
