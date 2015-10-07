Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30793 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbbJGUVi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Oct 2015 16:21:38 -0400
Date: Wed, 7 Oct 2015 15:21:36 -0500
From: Ben Shelton <benjamin.h.shelton@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: IOV: reread SRIOV_NUM_VF after enabling ARI
Message-ID: <20151007202136.GA19836@bhshelto-vm>
References: <1442008500-3570-1-git-send-email-benjamin.h.shelton@intel.com>
 <20151007192940.GE27633@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151007192940.GE27633@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Wed, Oct 07, 2015 at 02:29:40PM -0500, Bjorn Helgaas wrote:
> Hi Ben,
> 
> On Fri, Sep 11, 2015 at 04:55:00PM -0500, Ben Shelton wrote:
> > For some SR-IOV devices, the number of available virtual functions
> > increases after enabling ARI.  Currently, SRIOV_NUM_VF is read and saved
> > off before the ARI control bit is enabled.  This causes an issue when VFs
> > are enabled.
> > 
> > At device init, SRIOV_INITIAL_VF and SRIOV_NUM_VF are specified to contain
> > the number of available VFs for the device.  sriov_enable() does a sanity
> > check that PCI_SRIOV_INITIAL_VF is not greater than iov->total_VFs, the
> > saved-off value of SRIOV_NUM_VF.  Since the value of both SRIOV_INITIAL_VF
> > and SRIOV_NUM_VF has increased after enabling the ARI bit, the check fails,
> > and the VFs cannot be enabled.
> > 
> > To fix the issue, after ARI is enabled for a device, reread SRIOV_NUM_VF.
> > 
> > Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
> > ---
> >  drivers/pci/iov.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index ee0ebff..88b1959 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -388,6 +388,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
> >  	struct pci_sriov *iov;
> >  	struct resource *res;
> >  	struct pci_dev *pdev;
> > +	bool total_needs_reread = false;
> >  
> >  	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END &&
> >  	    pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT)
> > @@ -409,12 +410,18 @@ static int sriov_init(struct pci_dev *dev, int pos)
> >  			goto found;
> >  
> >  	pdev = NULL;
> > -	if (pci_ari_enabled(dev->bus))
> > +	if (pci_ari_enabled(dev->bus)) {
> >  		ctrl |= PCI_SRIOV_CTRL_ARI;
> > +		total_needs_reread = true;
> > +	}
> >  
> >  found:
> >  	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
> >  	pci_write_config_word(dev, pos + PCI_SRIOV_NUM_VF, 0);
> > +
> > +	if (total_needs_reread)
> > +		pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &total);
> 
> Can we just *move* the PCI_SRIOV_TOTAL_VF read from its original
> location and do it unconditionally here?  I don't think we use "total"
> for anything in the interim, and it'd be nice if we could do this
> without the "total_needs_reread" flag.

The only thing we do with 'total' is return early if it's read as 0
(i.e. for a device that does not support any VFs).  If we just move the
read to here, a PCI device with no VFs would have its PCI_SRIOV_CTRL
config word written before PCI_SRIOV_TOTAL_VF is read as 0 and
sriov_init() returns.  The reread preserves the original behavior.

If the change in behavior is OK, I'll make the change and submit a v2.

Thanks,
Ben

> 
> >  	pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET, &offset);
> >  	pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE, &stride);
> >  	if (!offset || (total > 1 && !stride))
> > -- 
> > 1.9.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
