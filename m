Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:44814 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbcDUDxE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2016 23:53:04 -0400
Date: Thu, 21 Apr 2016 13:53:02 +1000
From: Simon Horman <horms@verge.net.au>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] PCI: rcar-pcie: Remove Gen2 designation from Kconfig
Message-ID: <20160421035302.GA28575@verge.net.au>
References: <1459384523-16146-1-git-send-email-horms+renesas@verge.net.au>
 <20160405181054.GB15353@localhost>
 <20160419212114.GD17863@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160419212114.GD17863@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 19, 2016 at 04:21:14PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 05, 2016 at 01:10:54PM -0500, Bjorn Helgaas wrote:
> > Hi Simon,
> > 
> > On Thu, Mar 31, 2016 at 09:35:23AM +0900, Simon Horman wrote:
> > > It appears that Gen2 is a misnomer for the R-Car PCIE driver
> > > which also supports Gen 1 and Gen 3 SoCs. Accordingly, drop Gen 2
> > > from the help text and Kconfig symbol.
> > > 
> > > Also, re-arange the Kconfig symbol name to use PCIE as the prefix.
> > > This appears to be in keeping with other PCIE Kconfig symbols.
> > > 
> > > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > ---
> > > Bjorn, if this patch is acceptable I would like to request that we
> > > co-ordinate things so that I can queue-up corresponding updates for
> > > arm and arm64 defconfigs in the same release. From my point of view
> > > v4.7 would make sense.
> > 
> > I'm fine with this.  What sort of coordination do you want to do?
> > It would probably be nice to combine this patch with the defconfig updates
> > so we don't have a bisection problem.  If you want to include this patch
> > and merge through another tree,
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Ping, do you want me to do anything with this?

Sorry, this had completely slipped my mind.

I have just posted
"[PATCH v3] PCI: rcar-pcie: Remove Gen2 designation from Kconfig"
which I am planning to take through the renesas tree.
