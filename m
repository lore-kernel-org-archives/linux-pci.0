Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17182 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395Ab3FGOrs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jun 2013 10:47:48 -0400
Date: Fri, 7 Jun 2013 10:47:12 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	linux-arm-kernel@lists.infradead.org,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>
Subject: Re: [PATCH v2 0/8] MSI support for Marvell EBU PCIe driver
Message-ID: <20130607144712.GT23859@titan.lakedaemon.net>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606171747.GK23859@titan.lakedaemon.net>
 <20130607101429.10277e02@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130607101429.10277e02@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 07, 2013 at 10:14:29AM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Thu, 6 Jun 2013 13:17:47 -0400, Jason Cooper wrote:
> 
> > Please be aware that for-next is *not* stable.  I rebuild it every time
> > I pull new stuff in.  It's much more helpful to list only the branches
> > you need to build/test.
> 
> Yes, I'm aware that for-next is not stable. Since the previous
> iteration of this patch series generated a lot of discussion, I was
> assuming there would be additional discussions on this new iteration,
> and that it would certainly not be the final version. So for ease of
> work, I've just based it on the branch that 'contains everything'.

Ahh, ok, I've done the same.  Thanks for the clarification.

thx,

Jason.
