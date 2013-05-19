Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61579 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754237Ab3ESUrp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 19 May 2013 16:47:45 -0400
Date: Sun, 19 May 2013 16:47:03 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mike Turquette <mturquette@linaro.org>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Rob Herring <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv10 5/9] clk: mvebu: create parent-child relation for
 PCIe clocks on Armada 370
Message-ID: <20130519204703.GP11137@titan.lakedaemon.net>
References: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1368719725-21265-6-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368719725-21265-6-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 16, 2013 at 05:55:20PM +0200, Thomas Petazzoni wrote:
> The Armada 370 has two gatable clocks for each PCIe interface, and we
> want both of them to be enabled. We therefore make one of the two
> clocks a child of the other, as we did for the sataX and sataXlnk
> clocks on Armada XP.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> ---
>  drivers/clk/mvebu/clk-gating-ctrl.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patches 5 - 8 applied to mvebu/pcie, with a dep on Sebastian's clock
rework and mvebu/of_pci.  Thanks for the head's up on the clk conflict.
My resolution should match yours.  Please let me know if it doesn't.

thx,

Jason.
