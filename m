Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37842 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbbBZBXP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Feb 2015 20:23:15 -0500
Received: by mail-ig0-f173.google.com with SMTP id a13so40603729igq.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2015 17:23:15 -0800 (PST)
Date: Wed, 25 Feb 2015 19:23:12 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Phong Tran <tranmanphong@gmail.com>
Cc: tinamdar@apm.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] PCI: xgene: Fix the map_bus callback prototype
Message-ID: <20150226012312.GV6220@google.com>
References: <1424686899-7869-1-git-send-email-tranmanphong@gmail.com>
 <20150226011824.GU6220@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150226011824.GU6220@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 25, 2015 at 07:18:24PM -0600, Bjorn Helgaas wrote:
> [+cc Fabio]
> 
> On Mon, Feb 23, 2015 at 05:21:39PM +0700, Phong Tran wrote:
> > The return value should be void __iomem *.
> > Tested by compile only.
> > 
> > Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> 
> I've already applied an identical patch from Fabio Estevam.  I added
> Arnd's ack to it and also mentioned you in the credits, Phong.

Dropped in favor of a more complete fix:
https://patchwork.ozlabs.org/patch/440759/

> > ---
> >  drivers/pci/host/pci-xgene.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> > index aab5547..9c3bfd8 100644
> > --- a/drivers/pci/host/pci-xgene.c
> > +++ b/drivers/pci/host/pci-xgene.c
> > @@ -127,7 +127,7 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
> >  	return false;
> >  }
> >  
> > -static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> > +static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> >  			      int offset)
> >  {
> >  	struct xgene_pcie_port *port = bus->sysdata;
> > -- 
> > 2.1.0
> > 
