Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58765 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933109Ab3BLSNM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 13:13:12 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3] PCIe support for the Armada 370 and Armada XP SoCs
Date: Tue, 12 Feb 2013 18:12:11 +0000
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201302121812.11566.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 12 February 2013, Thomas Petazzoni wrote:
> This series of patches introduces PCIe support for the Marvell Armada
> 370 and Armada XP.
> 
> This PATCHv3 follows:
>  * PATCHv2, sent on January, 28th 2013
>  * RFCv1, sent on December, 7th 2012
> 
> Thanks to all the people who discussed on the previous version of the
> patch set. The discussions have been long and complicated, but
> certainly very useful.
> 
> In order to make progress on this, and help reducing the size of the
> patch set, I would ask if it would be possible to merge patches 1 to
> 17 from the series for 3.9 (only preparation work), keeping the rest
> for 3.10. The patches in question are PCI-related, ARM-related, and
> mvebu/orion-related.

You can add my 'Reviewed-by' tag on all paches except 5, 6, and 24.

I'm fine with adding the other ones to 3.9, as well as adding
the binding document if you split that out from patch 24. Sorry for
making this so hard for you.

	Arnd
