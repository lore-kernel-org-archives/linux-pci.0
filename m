Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:49168 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab3CZVRX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 17:17:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCHv6 10/17] arm: mvebu: add PCIe Device Tree informations for Armada 370
Date: Tue, 26 Mar 2013 21:17:17 +0000
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com> <201303262050.12847.arnd@arndb.de> <20130326211234.GA1295@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20130326211234.GA1295@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201303262117.17478.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 26 March 2013, Thierry Reding wrote:
> On Tue, Mar 26, 2013 at 08:50:12PM +0000, Arnd Bergmann wrote:
> > On Tuesday 26 March 2013, Thierry Reding wrote:
> > >                 pci@1,0 {
> > >                         device_type = "pci";
> > >                         assigned-addresses = <0x82000800 0 0x80000000 0 0x1000>;
> > >                         reg = <0x000800 0 0 0 0>;
> > >                         status = "disabled";
> > > 
> > >                         #address-cells = <3>;
> > >                         #size-cells = <2>;
> > > 
> > >                         nvidia,num-lanes = <2>;
> > >                 };
> > 
> > Shouldn't there be an empty ranges property in there as well?
> 
> Technically yes, I think. Though it doesn't make a bit of a difference
> on Linux.

Only because we have a workaround for old Power Macintoshs that we should
remove or at least disable on non-PowerPC systems.

	Arnd
