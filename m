Return-Path: <SRS0=myDI=LT=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=myDI=LT=intel.com=keith.busch@kernel.org>
Date: Wed, 5 Sep 2018 15:12:41 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] pci/sriov: Hold rescan lock while enumerating
Message-ID: <20180905211241.GA22152@localhost.localdomain>
References: <20180809163356.18650-1-keith.busch@intel.com>
 <20180905205840.GR107892@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905205840.GR107892@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 05, 2018 at 03:58:40PM -0500, Bjorn Helgaas wrote:
> [+cc Lukas, -stable]
> 
> On Thu, Aug 09, 2018 at 10:33:56AM -0600, Keith Busch wrote:
> > PCI enumeration/de-enumeration needs to run single threaded to prevent
> > race conditions with other threads changing the topology. Altering the
> > number of virtual functions was not taking the rescan/remove lock hile
> > adding or removing those virtual functions, so this patch adds that.
> > 
> > Reported-by: Krzysztof Wierzbicki <krzysztof.wierzbicki@intel.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> >  drivers/pci/pci-sysfs.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 9ecfe13157c0..611abe220b6f 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -591,6 +591,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
> >  	if (num_vfs > pci_sriov_get_totalvfs(pdev))
> >  		return -ERANGE;
> >  
> > +	pci_lock_rescan_remove();
> 
> I assume the usual path is something like this, where we end up in
> pci_enable_sriov():
> 
>   sriov_numvfs_store
> +   pci_lock_rescan_remove
>     pdev->driver->sriov_configure
>       ...
>         pci_enable_sriov
>           sriov_enable
>             pci_iov_add_virtfn
>               pci_alloc_dev
>               pci_device_add
> 
> But what about the other paths leading to pci_iov_add_virtfn()?  Don't
> we need similar locking for all of them?  

Good point. It looks like the only other path to pci_iov_add_virtfn is
through PPC eeh_reset_device, which coincidently enough already holds
pci_lock_rescan_remove.

It's not just pci_iov_add_virtfn, though. We also need to hold it during
pci_iov_remove_virtfn. PPC eeh_rmv_device is not holding the lock in
that path. I'll never be able to test with that h/w, but I'll look at it.

> >  	device_lock(&pdev->dev);
> >  
> >  	if (num_vfs == pdev->sriov->num_VFs)
> > @@ -627,6 +628,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
> >  
> >  exit:
> >  	device_unlock(&pdev->dev);
> > +	pci_unlock_rescan_remove();
> >  
> >  	if (ret < 0)
> >  		return ret;
> > -- 
> > 2.14.4
> > 
