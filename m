Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52315 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754180AbcGHJYw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jul 2016 05:24:52 -0400
Date: Fri, 8 Jul 2016 12:24:40 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Peter Wu <peter@lekensteyn.nl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: export pci_bridge_d3_possible
Message-ID: <20160708092440.GA23527@lahna.fi.intel.com>
References: <20160707235448.2622-1-peter@lekensteyn.nl>
 <20160708082503.GY23527@lahna.fi.intel.com>
 <20160708084525.GA1205@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160708084525.GA1205@al>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 08, 2016 at 10:45:25AM +0200, Peter Wu wrote:
> On Fri, Jul 08, 2016 at 11:25:03AM +0300, Mika Westerberg wrote:
> > On Fri, Jul 08, 2016 at 01:54:48AM +0200, Peter Wu wrote:
> > > Allow the nouveau driver to find out whether the bridge can put itself
> > > in the D3cold state or whether it should use a specific DSM method to
> > > achieve the same result.
> > > 
> > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> > > ---
> > > Since it is not yet merged in Linus tree, maybe the patch in pci/pm can be
> > > amended? This is the follow-up patch I had in mind for nouveau:
> > > 
> > >     --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> > >     +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> > >     @@ -223,6 +223,9 @@ static bool nouveau_pr3_present(struct pci_dev *pdev)
> > >      	if (!parent_pdev)
> > >      		return false;
> > >      
> > >     +	if (!pci_bridge_d3_possible(parent_pdev))
> > >     +		return false;
> > >     +
> > 
> > Why not check bridge_d3 directly?
> > 
> > 	if (!parent_dev->bridge_d3)
> > 		return false;
> 
> I have thought of that but then dismissed the idea because
> pci_bridge_d3_update could change it after initialization based on the
> d3cold_allowed flag on the bridge or its children. Then this could
> happen:
> 
>  - initially d3cold_allowed is set false by the user
>  - nouveau decides to use DSM
>  - d3cold_allowed is set by user to true
>  - PCI thinks that power resources are OK to use, but that conflicts
>    with nouveau.

Indeed that might happen. However, to be on the safe side I think we
should just do something like this:

	if (!parent_dev->bridge_d3) {
		/*
		 * Parent PCI bridge is currently not power managed.
		 * Since userspace can change these afterwards to be on
		 * the safe side we stick with _DSM and prevent usage of
		 * _PR3 from the bridge.
		 */
		pci_d3cold_disable(pdev);
		return false;
	}
