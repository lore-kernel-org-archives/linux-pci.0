Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:51677 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964970Ab3DHVfC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Apr 2013 17:35:02 -0400
Date: Mon, 8 Apr 2013 23:34:57 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm" <linux-arm-kernel@lists.infradead.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCHv7 08/17] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130408233457.7127eab2@skate>
In-Reply-To: <201304082331.30809.arnd@arndb.de>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1364395234-11195-9-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAErSpo7fGPe3wFha36kNMxeRP4gBpBWgfw85aTLey-DSz2ZYew@mail.gmail.com>
	<201304082331.30809.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Mon, 8 Apr 2013 23:31:30 +0200, Arnd Bergmann wrote:

> > Too bad to have to adjust CFLAGS here.  Seems like I remember earlier
> > discussion, but I didn't pay much attention, and if this is the best
> > we can do, I guess it's OK.
> 
> I'm pretty sure I NAK'ed this part. I'm surprised it's still there.

As I said in my reply to Bjorn, it's a mistake. I did so much efforts
to get rid of the mach-mvebu and plat-orion dependencies, that in the
end, I forgot that the original reason was to get rid of those special
cflags.

For sure, I'll send a v8 that has those cflags removed, they are
unneeded.

Sorry for this.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
