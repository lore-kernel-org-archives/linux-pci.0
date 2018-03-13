Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:26237 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752280AbeCMUGp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 16:06:45 -0400
Date: Tue, 13 Mar 2018 14:08:41 -0600
From: Keith Busch <keith.busch@intel.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <scott.bauer@intel.com>
Subject: Re: [PATCHv2] PCI: vmd: Use affinity to chain child device interrupts
Message-ID: <20180313200840.GA28002@localhost.localdomain>
References: <20180206202225.1124-1-keith.busch@intel.com>
 <20180313171039.GB20373@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180313171039.GB20373@e107981-ln.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 13, 2018 at 05:10:39PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Feb 06, 2018 at 01:22:25PM -0700, Keith Busch wrote:
> > @@ -233,9 +266,11 @@ static int vmd_msi_prepare(struct irq_domain *domain, struct device *dev,
> >  	struct pci_dev *pdev = to_pci_dev(dev);
> >  	struct vmd_dev *vmd = vmd_from_bus(pdev->bus);
> >  
> > -	if (nvec > vmd->msix_count)
> > +	if (nvec > vmd->msix_count) {
> > +		if (vmd->msix_count > 1)
> > +			return vmd->msix_count - 1;
> >  		return vmd->msix_count;
> 
> I am about to apply this patch but I do not understand what's this hunk
> is there for, to me vmd_msi_prepare() should just return an error in
> this code path unless I am getting this wrong.

Hi Lorenzo,

It's not really an error if a driver requests more vectors than
can be allocated. The return here ultimately propogates back to
__pci_enable_msix, which returns 0 for sucess, < 0 for error, and >
0 if the requested count was too high.

The change above is fixing an off-by-one. It is really a bug fix on its
own, but it wasn't really harmful without the affinity awareness this
patch adds, where not having it starts to negatively affect performance.

Thanks,
Keith
