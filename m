Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbdH3Q0P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Aug 2017 12:26:15 -0400
Date: Wed, 30 Aug 2017 11:26:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Himanshu Jha <himanshujha199640@gmail.com>, bhelgaas@google.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use PTR_ERR_OR_ZERO
Message-ID: <20170830162613.GB18250@bhelgaas-glaptop.roam.corp.google.com>
References: <1504013940-16304-1-git-send-email-himanshujha199640@gmail.com>
 <20170829135517.GA30733@ulmo>
 <20170830135931.GA18250@bhelgaas-glaptop.roam.corp.google.com>
 <20170830142547.GC1361@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170830142547.GC1361@ulmo>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 30, 2017 at 04:25:47PM +0200, Thierry Reding wrote:
> On Wed, Aug 30, 2017 at 08:59:31AM -0500, Bjorn Helgaas wrote:
> > On Tue, Aug 29, 2017 at 03:55:17PM +0200, Thierry Reding wrote:
> > > On Tue, Aug 29, 2017 at 07:09:00PM +0530, Himanshu Jha wrote:
> > > > Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> > > > 
> > > > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> > > > ---
> > > >  drivers/pci/host/pci-tegra.c | 5 +----
> > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> > > > index 9c40da5..90cda5b 100644
> > > > --- a/drivers/pci/host/pci-tegra.c
> > > > +++ b/drivers/pci/host/pci-tegra.c
> > > > @@ -1156,10 +1156,7 @@ static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
> > > >  		return PTR_ERR(pcie->afi_rst);
> > > >  
> > > >  	pcie->pcie_xrst = devm_reset_control_get_exclusive(dev, "pcie_x");
> > > > -	if (IS_ERR(pcie->pcie_xrst))
> > > > -		return PTR_ERR(pcie->pcie_xrst);
> > > > -
> > > > -	return 0;
> > > > +	return PTR_ERR_OR_ZERO(pcie->pcie_xrst);
> > > >  }
> > > 
> > > I'm not a big fan of this construct because it's a pain to undo this if
> > > ever we need to add code to this function. But since we do have scripts
> > > that will flag this, I guess this would pop up every now and again. The
> > > driver is unlikely to change in this part, too, so:
> > 
> > Thanks for pointing this out.  Do you know what the benefit of
> > PTR_ERR_OR_ZERO() is?  To me, it makes the following code harder
> > to read because the error tests are no longer parallel:
> > 
> >   ...
> >   res->ahb_reset = devm_reset_control_get(dev, "ahb");
> >   if (IS_ERR(res->ahb_reset))
> >     return PTR_ERR(res->ahb_reset);
> > 
> >   res->por_reset = devm_reset_control_get(dev, "por");
> >   if (IS_ERR(res->por_reset))
> >     return PTR_ERR(res->por_reset);
> > 
> >   res->phy_reset = devm_reset_control_get(dev, "phy");
> >   return PTR_ERR_OR_ZERO(res->phy_reset);
> > 
> > So I'd be inclined to avoid it unless there's some significant benefit.
> 
> Yeah, I don't like the optics much either. Aside from the fact that it
> reduces the line count, I'm not aware of any benefits that this inline
> function has. It doesn't have any side-effects or anything, just wraps
> the common pattern into a single line.
> 
> Looking at the history of the semantic patch that is the basis for the
> conversions (scripts/coccinelle/api/ptr_ret.cocci), or the static inline
> function itself, no rationale is given for why people prefer this. I've
> certainly seen such patches applied in some cases, but I've also seen
> other maintainers (including myself) reject them because of personal
> preference.

OK, I'm going to drop this then.
