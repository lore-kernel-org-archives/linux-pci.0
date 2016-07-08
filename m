Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:37888 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550AbcGHIqH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jul 2016 04:46:07 -0400
Date: Fri, 8 Jul 2016 10:45:25 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: export pci_bridge_d3_possible
Message-ID: <20160708084525.GA1205@al>
References: <20160707235448.2622-1-peter@lekensteyn.nl>
 <20160708082503.GY23527@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160708082503.GY23527@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 08, 2016 at 11:25:03AM +0300, Mika Westerberg wrote:
> On Fri, Jul 08, 2016 at 01:54:48AM +0200, Peter Wu wrote:
> > Allow the nouveau driver to find out whether the bridge can put itself
> > in the D3cold state or whether it should use a specific DSM method to
> > achieve the same result.
> > 
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> > ---
> > Since it is not yet merged in Linus tree, maybe the patch in pci/pm can be
> > amended? This is the follow-up patch I had in mind for nouveau:
> > 
> >     --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> >     +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> >     @@ -223,6 +223,9 @@ static bool nouveau_pr3_present(struct pci_dev *pdev)
> >      	if (!parent_pdev)
> >      		return false;
> >      
> >     +	if (!pci_bridge_d3_possible(parent_pdev))
> >     +		return false;
> >     +
> 
> Why not check bridge_d3 directly?
> 
> 	if (!parent_dev->bridge_d3)
> 		return false;

I have thought of that but then dismissed the idea because
pci_bridge_d3_update could change it after initialization based on the
d3cold_allowed flag on the bridge or its children. Then this could
happen:

 - initially d3cold_allowed is set false by the user
 - nouveau decides to use DSM
 - d3cold_allowed is set by user to true
 - PCI thinks that power resources are OK to use, but that conflicts
   with nouveau.

Hmm, maybe it is usable, but then something like this is needed:

    /* Initially assume that D3cold is OK. */
    pci_d3cold_enable(pdev);

    if (!parent_dev->bridge_d3) {
        /* bridge does not support D3cold, keep it disabled. */
        pci_d3cold_disable(pdev);
        return false;
    }

How does that look?
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
