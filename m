Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 27 Feb 2018 14:40:15 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, mheyne@amazon.de,
        liang-min.wang@intel.com, mark.d.rustad@intel.com,
        dwmw2@infradead.org, dwmw@amazon.co.uk
Subject: Re: [PATCH] pci-iov: Add support for unmanaged SR-IOV
Message-ID: <20180227144015.228d4f5c@w520.home>
In-Reply-To: <20180227190520.3273.79728.stgit@localhost.localdomain>
References: <20180227190520.3273.79728.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 27 Feb 2018 11:06:54 -0800
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch is meant to add support for SR-IOV on devices when the VFs are
> not managed by the kernel. Examples of recent patches attempting to do this
> include:

It appears to enable sriov when the _pf_ is not managed by the
kernel, but by "managed" we mean that either there is no pf driver or
the pf driver doesn't provide an sriov_configure callback,
intentionally or otherwise.

> virto - https://patchwork.kernel.org/patch/10241225/
> pci-stub - https://patchwork.kernel.org/patch/10109935/
> vfio - https://patchwork.kernel.org/patch/10103353/
> uio - https://patchwork.kernel.org/patch/9974031/

So is the goal to get around the issues with enabling sriov on each of
the above drivers by doing it under the covers or are you really just
trying to enable sriov for a truly unmanage (no pf driver) case?  For
example, should a driver explicitly not wanting sriov enabled implement
a dummy sriov_configure function?

> Since this is quickly blowing up into a multi-driver problem it is probably
> best to implement this solution in one spot.
> 
> This patch is an attempt to do that. What we do with this patch is provide
> a generic call to enable SR-IOV in the case that the PF driver is either
> not present, or the PF driver doesn't support configuring SR-IOV.
> 
> A new sysfs value called sriov_unmanaged_autoprobe has been added. This
> value is used as the drivers_autoprobe setting of the VFs when they are
> being managed by an external entity such as userspace or device firmware
> instead of being managed by the kernel.

Documentation/ABI/testing/sysfs-bus-pci update is missing.
 
> One side effect of this change is that the sriov_drivers_autoprobe and
> sriov_unmanaged_autoprobe will only apply their updates when SR-IOV is
> disabled. Attempts to update them when SR-IOV is in use will only update
> the local value and will not update sriov->autoprobe.

And we expect users to understand when sriov_drivers_autoprobe applies
vs sriov_unmanaged_autoprobe, even though they're using the same
interfaces to enable sriov?  Are all combinations expected to work, ex.
unmanaged sriov is enabled, a native pf driver loads, vfs work?  Not
only does it seems like there's opportunity to use this incorrectly, I
think maybe it might be difficult to use correctly.
 
> I based my patch set originally on the patch by Mark Rustad but there isn't
> much left after going through and cleaning out the bits that were no longer
> needed, and after incorporating the feedback from David Miller.
> 
> I have included the authors of the original 4 patches above in the Cc here.
> My hope is to get feedback and/or review on if this works for their use
> cases.
> 
> Cc: Mark Rustad <mark.d.rustad@intel.com>
> Cc: Maximilian Heyne <mheyne@amazon.de>
> Cc: Liang-Min Wang <liang-min.wang@intel.com>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/pci/iov.c        |   27 +++++++++++++++++++-
>  drivers/pci/pci-driver.c |    2 +
>  drivers/pci/pci-sysfs.c  |   62 +++++++++++++++++++++++++++++++++++++++++-----
>  drivers/pci/pci.h        |    4 ++-
>  include/linux/pci.h      |    1 +
>  5 files changed, 86 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 677924ae0350..7b8858bd8d03 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -446,6 +446,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  	pci_read_config_word(dev, pos + PCI_SRIOV_VF_DID, &iov->vf_device);
>  	iov->pgsz = pgsz;
>  	iov->self = dev;
> +	iov->autoprobe = true;
>  	iov->drivers_autoprobe = true;
>  	pci_read_config_dword(dev, pos + PCI_SRIOV_CAP, &iov->cap);
>  	pci_read_config_byte(dev, pos + PCI_SRIOV_FUNC_LINK, &iov->link);
> @@ -643,8 +644,11 @@ void pci_restore_iov_state(struct pci_dev *dev)
>   */
>  void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool auto_probe)
>  {
> -	if (dev->is_physfn)
> +	if (dev->is_physfn) {
>  		dev->sriov->drivers_autoprobe = auto_probe;
> +		if (!dev->sriov->num_VFs)
> +			dev->sriov->autoprobe = auto_probe;

Why is dev->sriov->autoprobe set any time other than immediately prior
to enabling VFs?

> +	}
>  }
>  
>  /**
> @@ -703,6 +707,27 @@ void pci_disable_sriov(struct pci_dev *dev)
>  EXPORT_SYMBOL_GPL(pci_disable_sriov);
>  
>  /**
> + * pci_sriov_configure_unmanaged - helper to configure unmanaged SR-IOV
> + * @dev: the PCI device
> + * @nr_virtfn: number of virtual functions to enable, 0 to disable
> + *
> + * Used to provide generic enable/disable SR-IOV option for devices
> + * that do not manage the VFs generated by their driver, or have no
> + * driver present.
> + */
> +int pci_sriov_configure_unmanaged(struct pci_dev *dev, int nr_virtfn)
> +{
> +	int rc = 0;
> +
> +	if (!nr_virtfn)
> +		pci_disable_sriov(dev);
> +	else
> +		rc = pci_enable_sriov(dev, nr_virtfn);
> +
> +	return rc ? rc : nr_virtfn;
> +}
> +
> +/**
>   * pci_num_vf - return number of VFs associated with a PF device_release_driver
>   * @dev: the PCI device
>   *
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3bed6beda051..2cc68dff6130 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -398,7 +398,7 @@ void __weak pcibios_free_irq(struct pci_dev *dev)
>  #ifdef CONFIG_PCI_IOV
>  static inline bool pci_device_can_probe(struct pci_dev *pdev)
>  {
> -	return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprobe);
> +	return (!pdev->is_virtfn || pdev->physfn->sriov->autoprobe);
>  }
>  #else
>  static inline bool pci_device_can_probe(struct pci_dev *pdev)
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index eb6bee8724cc..e701b6dbc267 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -605,6 +605,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>  				  struct device_attribute *attr,
>  				  const char *buf, size_t count)
>  {
> +	int (*sriov_configure)(struct pci_dev *dev, int num_vfs);
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	int ret;
>  	u16 num_vfs;
> @@ -622,15 +623,20 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>  		goto exit;
>  
>  	/* is PF driver loaded w/callback */
> -	if (!pdev->driver || !pdev->driver->sriov_configure) {
> -		pci_info(pdev, "Driver doesn't support SRIOV configuration via sysfs\n");
> -		ret = -ENOENT;
> -		goto exit;
> -	}
> +	if (pdev->driver && pdev->driver->sriov_configure)
> +		sriov_configure = pdev->driver->sriov_configure;
> +	else
> +		sriov_configure = pci_sriov_configure_unmanaged;

So an unwitting user is now able to enable vfs, independent of the
pf... the trouble being that they're probably going to expect them to
work and the more common case is that they won't.  For instance, what
can you do with an igbvf when igb isn't managing the pf?

Or what happens when vfio-pci owns the pf, sriov is enabled via the
unmanaged interface, and the pf user driver segfaults and gets killed,
causing vfio-pci to restore the pf state, including wiping the sriov
config?

I guess I don't understand how vfs can operate fully independent of the
pf and why vfio-pci wouldn't just implement a dummy sriov_configure to
avoid contending with such issues.
 
>  	if (num_vfs == 0) {
>  		/* disable VFs */
> -		ret = pdev->driver->sriov_configure(pdev, 0);
> +		ret = sriov_configure(pdev, 0);
> +
> +		/*
> +		 * Fall back to drivers_autoprobe in case legacy driver
> +		 * decides to enable SR-IOV on load.
> +		 */
> +		pdev->sriov->autoprobe = pdev->sriov->drivers_autoprobe;
>  		goto exit;
>  	}
>  
> @@ -642,7 +648,14 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>  		goto exit;
>  	}
>  
> -	ret = pdev->driver->sriov_configure(pdev, num_vfs);
> +	/*
> +	 * Update autoprobe based on unmanaged_autoprobe settings if PF
> +	 * driver is not managing the SR-IOV configuration for this device.
> +	 */
> +	if (!pdev->driver || !pdev->driver->sriov_configure)
> +		pdev->sriov->autoprobe = pdev->sriov->unmanaged_autoprobe;

Not sure why this is asymmetric, shouldn't we have an

else
	pdev->sriov->autoprobe = pdev->sriov->drivers_autoprobe;

Seems error prone otherwise, apply the one we actually intend to take
effect for the new vfs in one place, consistently.

> +
> +	ret = sriov_configure(pdev, num_vfs);
>  	if (ret < 0)
>  		goto exit;
>  
> @@ -705,7 +718,37 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
>  	if (kstrtobool(buf, &drivers_autoprobe) < 0)
>  		return -EINVAL;
>  
> +	device_lock(&pdev->dev);
> +
>  	pdev->sriov->drivers_autoprobe = drivers_autoprobe;
> +	if (!pdev->sriov->num_VFs)
> +		pdev->sriov->autoprobe = drivers_autoprobe;

This is another one that seems inconsistent to me.

> +
> +	device_unlock(&pdev->dev);
> +
> +	return count;
> +}
> +
> +static ssize_t sriov_unmanaged_autoprobe_show(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sprintf(buf, "%u\n", pdev->sriov->unmanaged_autoprobe);
> +}
> +
> +static ssize_t sriov_unmanaged_autoprobe_store(struct device *dev,
> +					       struct device_attribute *attr,
> +					       const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	bool unmanaged_autoprobe;
> +
> +	if (kstrtobool(buf, &unmanaged_autoprobe) < 0)
> +		return -EINVAL;
> +
> +	pdev->sriov->unmanaged_autoprobe = unmanaged_autoprobe;
>  
>  	return count;
>  }
> @@ -720,6 +763,10 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
>  static struct device_attribute sriov_drivers_autoprobe_attr =
>  		__ATTR(sriov_drivers_autoprobe, (S_IRUGO|S_IWUSR|S_IWGRP),
>  		       sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
> +static struct device_attribute sriov_unmanaged_autoprobe_attr =
> +		__ATTR(sriov_unmanaged_autoprobe, (S_IRUGO|S_IWUSR|S_IWGRP),
> +		       sriov_unmanaged_autoprobe_show,
> +		       sriov_unmanaged_autoprobe_store);
>  #endif /* CONFIG_PCI_IOV */
>  
>  static ssize_t driver_override_store(struct device *dev,
> @@ -1789,6 +1836,7 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
>  	&sriov_stride_attr.attr,
>  	&sriov_vf_device_attr.attr,
>  	&sriov_drivers_autoprobe_attr.attr,
> +	&sriov_unmanaged_autoprobe_attr.attr,
>  	NULL,
>  };
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fcd81911b127..b5f8b034f02d 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -272,7 +272,9 @@ struct pci_sriov {
>  	struct pci_dev	*dev;		/* Lowest numbered PF */
>  	struct pci_dev	*self;		/* This PF */
>  	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
> -	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
> +	bool		autoprobe;	/* Auto probing of VFs by VF driver */
> +	bool		drivers_autoprobe;	/* "" managed by PF driver */
> +	bool		unmanaged_autoprobe;	/* "" unmanaged by kernel */
>  };
>  
>  /* pci_dev priv_flags */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 024a1beda008..0d2b10aeadfa 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1947,6 +1947,7 @@ static inline void pci_mmcfg_late_init(void) { }
>  
>  int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
>  void pci_disable_sriov(struct pci_dev *dev);
> +int pci_sriov_configure_unmanaged(struct pci_dev *dev, int num_vfs);
>  int pci_iov_add_virtfn(struct pci_dev *dev, int id);
>  void pci_iov_remove_virtfn(struct pci_dev *dev, int id);
>  int pci_num_vf(struct pci_dev *dev);
> 
