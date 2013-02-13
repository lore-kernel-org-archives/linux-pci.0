Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55173 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932427Ab3BMJhG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2013 04:37:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3] PCIe support for the Armada 370 and Armada XP SoCs
Date: Wed, 13 Feb 2013 09:37:02 +0000
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
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com> <201302121812.11566.arnd@arndb.de> <20130213095025.079fdd89@skate>
In-Reply-To: <20130213095025.079fdd89@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302130937.02266.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 13 February 2013, Thomas Petazzoni wrote:
> On Tue, 12 Feb 2013 18:12:11 +0000, Arnd Bergmann wrote:
> 
> > You can add my 'Reviewed-by' tag on all paches except 5, 6, and 24.
> > 
> > I'm fine with adding the other ones to 3.9, as well as adding
> > the binding document if you split that out from patch 24. Sorry for
> > making this so hard for you.
> 
> Is this really true that some more code can be taken for 3.9 ? It
> somewhat contradicts the statement that Olof has made on LAKML just a
> few hours ago "arm-soc: No new material from 3.9, fixes only".

Sorry, that was bad communiation between Olof and me. Olof has
been handling basically all of the pulls for this release
and his decision is final. The only part of the series that
I believe we should take is patch 7, since that is a bug fix.

	Arnd
