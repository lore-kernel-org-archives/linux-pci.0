Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:32134 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752958Ab3GORdy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2013 13:33:54 -0400
Date: Mon, 15 Jul 2013 13:33:30 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCHv5 00/11] MSI support for Marvell EBU PCIe driver
Message-ID: <20130715173329.GA12062@titan.lakedaemon.net>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <51E4167B.4000208@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51E4167B.4000208@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 15, 2013 at 09:34:19AM -0600, Stephen Warren wrote:
> On 07/15/2013 05:52 AM, Thomas Petazzoni wrote:
> > Hello,
> > 
> > This set of patches introduces Message Signaled Interrupt support in
> > the Marvell EBU PCIe driver. It has been successfully tested on the
> > Armada XP GP platform with an Intel e1000e PCIe network card that
> > supports MSI.
> > 
> > This patch set is intended for merging in 3.12, so the respective
> > maintainers of the different areas are invited to review/ack the
> > patches, see below for the details. This set of patches applies on top
> > of 3.11-rc1.
> 
> Thomas, who is going to merge this series?

In a previous version of this series, Thomas and I discussed the
feasibility of sending the irq changes through tglx, the pci changes
through Bjorn, and the mvebu stuff through us.  With that version,
Thomas felt it would work out fine, without depending on each other.

If this is still the case, we'll just ask Thomas and Bjorn (or, at least
Bjorn) to make topic branches for us.

thx,

Jason.
