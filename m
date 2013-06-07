Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47155 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553Ab3FGIOd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jun 2013 04:14:33 -0400
Date: Fri, 7 Jun 2013 10:14:29 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>
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
Message-ID: <20130607101429.10277e02@skate>
In-Reply-To: <20130606171747.GK23859@titan.lakedaemon.net>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130606171747.GK23859@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Cooper,

On Thu, 6 Jun 2013 13:17:47 -0400, Jason Cooper wrote:

> Please be aware that for-next is *not* stable.  I rebuild it every time
> I pull new stuff in.  It's much more helpful to list only the branches
> you need to build/test.

Yes, I'm aware that for-next is not stable. Since the previous
iteration of this patch series generated a lot of discussion, I was
assuming there would be additional discussions on this new iteration,
and that it would certainly not be the final version. So for ease of
work, I've just based it on the branch that 'contains everything'.

For sure, if I get the proper ACKs and acceptance of the general idea,
I'll go ahead and send a proper version based on the correct branches.

You suggested mvebu/pcie as a base, but it means I also need to merge
mvebu/of_pci before that, and maybe also mvebu/pcie_bridge to have the
latest changes in the PCIe driver, etc. Which is why I just went the
easy/lazy way and did everything based on for-next :)

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
