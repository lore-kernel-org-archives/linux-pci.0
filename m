Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:45727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbeB1K3y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Feb 2018 05:29:54 -0500
Date: Wed, 28 Feb 2018 11:29:41 +0100 (CET)
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
cc: Rolf Evers-Fischer <embedded24@evers-fischer.de>, kishon@ti.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: Re: [PATCH v3 2/2] pci: endpoint: Fix kernel panic after
 put_device()
In-Reply-To: <20180227175756.GB12756@e107981-ln.cambridge.arm.com>
Message-ID: <alpine.LNX.2.20.1802281122100.29501@5HSWXM1.fritz.box>
References: <20180227100231.22561-1-embedded24@evers-fischer.de> <20180227100231.22561-3-embedded24@evers-fischer.de> <20180227175756.GB12756@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Lorenzo!

On Tue, 27 Feb 2018, Lorenzo Pieralisi wrote:

> On Tue, Feb 27, 2018 at 11:02:30AM +0100, Rolf Evers-Fischer wrote:
> > From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> > 
> > 'put_device()' calls the relase function 'pci_epf_dev_release()',
> > which already frees 'epf->name' and 'epf'.
> > 
> > Therefore we must not free them again after 'put_device()'.
> > 
> > Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
> > 
> > Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> > ---
> >  drivers/pci/endpoint/pci-epf-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > index 1f2506f32bb9..1878a6776519 100644
> > --- a/drivers/pci/endpoint/pci-epf-core.c
> > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > @@ -232,7 +232,7 @@ struct pci_epf *pci_epf_create(const char *name)
> >  
> >  put_dev:
> >  	put_device(dev);
> > -	kfree(epf->name);
> > +	return ERR_PTR(ret);
> 
> Another thing you could do, which would get rid of these multiple return
> statements (yes there is another one) would consist in removing the goto
> labels completely and handle the errors at the respective call site and
> just return instead of jumping around.
> 

Thank you for sharing this idea! I've already changed it locally and it 
seems that we can get rid of 11 code lines with that.
It is being verified. If it really works, there will be a new commit
soon.

Kind regards,
 Rolf
