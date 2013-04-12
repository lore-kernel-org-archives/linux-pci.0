Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28236 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab3DLAsk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2013 20:48:40 -0400
Date: Thu, 11 Apr 2013 20:48:21 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	Olof Johansson <olof@lixom.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Mitch Bradley <wmb@firmworks.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCHv8 12/19] arm: mvebu: add PCIe Device Tree informations
 for Armada 370
Message-ID: <20130412004821.GT28693@titan.lakedaemon.net>
References: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365541601-14095-13-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130412002811.GS28693@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130412002811.GS28693@titan.lakedaemon.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 11, 2013 at 08:28:11PM -0400, Jason Cooper wrote:
> On Tue, Apr 09, 2013 at 11:06:33PM +0200, Thomas Petazzoni wrote:
> > The Armada 370 SoC has two 1x PCIe 2.0 interfaces, so we add the
> > necessary Device Tree informations to make these interfaces availabel.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/armada-370.dtsi |   51 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> 
> Patches 12 through 18 applied to mvebu/dt.  Now Gregory can rebase LPAE
> :)

Gregory,

Hold off for an hour or so.  I just realized that mvebu/fixes contains a
few more relevant dts changes than I had pulled in to mvebu/dt.  I'll
let you know once I push an updated branch.

thx,

Jason.
