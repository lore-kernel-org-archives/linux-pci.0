Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751525AbdAaSJU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Jan 2017 13:09:20 -0500
Date: Tue, 31 Jan 2017 12:09:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: rcar: Check for OF device match early
Message-ID: <20170131180915.GA16450@bhelgaas-glaptop.roam.corp.google.com>
References: <20170131151044.14062.85997.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAMuHMdWxoMsZAobYSmxeuga1NdMbruss4g-KQjczNeurcn_wkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdWxoMsZAobYSmxeuga1NdMbruss4g-KQjczNeurcn_wkA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 31, 2017 at 04:33:15PM +0100, Geert Uytterhoeven wrote:
> Hi Bjorn,
> 
> On Tue, Jan 31, 2017 at 4:10 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > A match in the rcar_pcie_of_match[] table is required, so check that first,
> > before we start setting up things that need to be undone if it fails.  No
> > functional change intended.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/host/pcie-rcar.c |   10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> > index 0d9b96c3c49d..c91ff0b91be8 100644
> > --- a/drivers/pci/host/pcie-rcar.c
> > +++ b/drivers/pci/host/pcie-rcar.c
> > @@ -1129,6 +1129,10 @@ static int rcar_pcie_probe(struct platform_device *pdev)
> >         int err;
> >         int (*hw_init_fn)(struct rcar_pcie *);
> >
> > +       of_id = of_match_device(rcar_pcie_of_match, dev);
> > +       if (!of_id || !of_id->data)
> > +               return -EINVAL;
> > +
> 
> As this driver is DT-only, none of the above can fail, and you could just do
> 
>        hw_init_fn = of_device_get_match_data(dev);
> 
> instead, getting rid of of_id completely.

Oh, I really like that, thanks for pointing that out!

I was about to say that I personally would not check of_id->data for NULL,
because it is only NULL if somebody adds an entry to rcar_pcie_of_match
without a .data member.  In that case, I'd rather take the NULL pointer
dereference than return -EINVAL because it's too easy to ignore the
-EINVAL.

What do you think about the following?


commit 25bd3aa972ee32f04590aa68b2b785dce36b036a
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Jan 31 08:45:49 2017 -0600

    PCI: rcar: Use of_device_get_match_data() to simplify probe
    
    This is a DT-only driver, so the only way to call rcar_pcie_probe() is to
    match an entry in rcar_pcie_of_match[], so of_id cannot be NULL.
    
    Furthermore, of_id->data can only be NULL if an rcar_pcie_of_match[] entry
    has a NULL .data member.  That's a driver defect, and we don't want to
    return -EINVAL, which is easy to ignore.  We'd rather take the NULL pointer
    dereference so we notice the problem and fix it.
    
    Use of_device_get_match_data() to retrieve the hw_init_fn pointer.  No
    functional change intended.
    
    Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 0d9b96c3c49d..cb07c45c1858 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1125,7 +1125,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rcar_pcie *pcie;
 	unsigned int data;
-	const struct of_device_id *of_id;
 	int err;
 	int (*hw_init_fn)(struct rcar_pcie *);
 
@@ -1149,11 +1148,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	of_id = of_match_device(rcar_pcie_of_match, dev);
-	if (!of_id || !of_id->data)
-		return -EINVAL;
-	hw_init_fn = of_id->data;
-
 	pm_runtime_enable(dev);
 	err = pm_runtime_get_sync(dev);
 	if (err < 0) {
@@ -1162,6 +1156,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	}
 
 	/* Failure to get a link might just be that no cards are inserted */
+	hw_init_fn = of_device_get_match_data(dev);
 	err = hw_init_fn(pcie);
 	if (err) {
 		dev_info(dev, "PCIe link down\n");
