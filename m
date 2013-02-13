Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:50915 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758775Ab3BMPav (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2013 10:30:51 -0500
Date: Wed, 13 Feb 2013 16:30:31 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Christophe Vu-Brugier <cvubrugier@lacie.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v3] PCIe support for the Armada 370 and Armada XP SoCs
Message-ID: <20130213163031.42a4135d@skate>
In-Reply-To: <20130213162750.6797e79a@grp-cvubrugier.lacie.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130213162750.6797e79a@grp-cvubrugier.lacie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Christophe Vu-Brugier,

On Wed, 13 Feb 2013 16:27:50 +0100, Christophe Vu-Brugier wrote:
> Hi Thomas,
> 
> On Tue, 12 Feb 2013 17:28:34 +0100, Thomas Petazzoni wrote :
> > This series of patches introduces PCIe support for the Marvell Armada
> > 370 and Armada XP.
> 
> Tested on a Marvell DB-MV784MP-GP evaluation board with a Marvell 9220
> SATA controller. Disks attached to this controller are working.
> 
> Tested-by: Christophe Vu-Brugier <cvubrugier@lacie.com>

Awesome, thanks a lot again Christophe for having taken the time to
test this patch series!

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
