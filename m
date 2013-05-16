Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:57707 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab3EPHoV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2013 03:44:21 -0400
Date: Thu, 16 May 2013 09:44:17 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Mike Turquette <mturquette@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Rob Herring <rob.herring@calxeda.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	devicetree-discuss@lists.ozlabs.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCHv9 5/9] clk: mvebu: create parent-child relation for PCIe
 clocks on Armada 370
Message-ID: <20130516094417.24b1ca0d@skate>
In-Reply-To: <20130515214154.12127.73539@quantum>
References: <1368624323-24311-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1368624323-24311-6-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130515214154.12127.73539@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Mike Turquette,

On Wed, 15 May 2013 14:41:54 -0700, Mike Turquette wrote:
> Quoting Thomas Petazzoni (2013-05-15 06:25:19)
> > The Armada 370 has two gatable clocks for each PCIe interface, and we
> > want both of them to be enabled. We therefore make one of the two
> > clocks a child of the other, as we did for the sataX and sataXlnk
> > clocks on Armada XP.
> 
> Ack for patches #5 and #6.  Do you want me to take them?

I don't know, I guess with your Ack, it would be easier to carry them
through the Marvell maintainers and then the arm-soc tree, so that we
can test arm-soc and have all the pieces needed in here.

That said, Sebastian Hesselbarth has submitted a big rework of the
mvebu clock drivers, which would conflict with this patch, and
Sebastian's rework would most likely go through your tree. If that's
the case, I guess it would be better to let you take #5 and #6 in this
patch series.

That's something to be discussed with the Marvell maintainers (Jason
Cooper, Andrew Lunn, Gregory Clement).

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
