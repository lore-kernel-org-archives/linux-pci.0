Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:56568 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbeB0PfI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Feb 2018 10:35:08 -0500
Date: Tue, 27 Feb 2018 10:35:02 -0500 (EST)
Message-Id: <20180227.103502.2160088807348773566.davem@davemloft.net>
To: mark.d.rustad@intel.com
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.daly@intel.com, alex.williamson@redhat.com, MRustad@gmail.com,
        alexander.duyck@gmail.com, mst@redhat.com
Subject: Re: [RFC PATCH V3] virtio_pci: Add SR-IOV support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180226031911.18980.80488.stgit@mdrustad-mac04.local>
References: <20180226031911.18980.80488.stgit@mdrustad-mac04.local>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Mark Rustad <mark.d.rustad@intel.com>
Date: Sun, 25 Feb 2018 19:19:11 -0800

> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 677924ae0350..ddd44a9d93ec 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -367,6 +367,54 @@ static void sriov_disable(struct pci_dev *dev)
>  	pci_iov_set_numvfs(dev, 0);
>  }
>  
> +/**
> + * pci_sriov_disable - standard helper to disable SR-IOV
> + * @dev:the PCI PF device whose VFs are to be disabled
> + */
> +int pci_sriov_disable(struct pci_dev *dev)
> +{
> +	/*
> +	 * If vfs are assigned we cannot shut down SR-IOV without causing
> +	 * issues, so just leave the hardware available.
> +	 */
> +	if (pci_vfs_assigned(dev)) {
> +		pci_warn(&dev->dev,
> +			 "Cannot disable SR-IOV while VFs are assigned - VFs will not be deallocated\n");
> +		return -EPERM;
> +	}
> +	pci_disable_sriov(dev);
> +	return 0;
> +}
> +
> +static int pci_sriov_enable(struct pci_dev *dev, int num_vfs)
> +{
> +	int rc;
> +
> +	if (pci_num_vf(dev))
> +		return -EINVAL;
> +
> +	rc = pci_enable_sriov(dev, num_vfs);
> +	if (rc) {
> +		pci_warn(dev, "Failed to enable PCI sriov: %d\n", rc);
> +		return rc;
> +	}
> +	dev_info(dev, "SR-IOV enabled with %d VFs\n", num_vfs);
> +	return num_vfs;
> +}

I don't like these helpers on many different levels.

The pci_num_vf() test in pci_sriov_enable() is redundant, the pci_enable_sriov() code
path does that check and returns the same exact error code from sriov_enable().

Just call pci_enable_sriov() directly.  The log message adds no value justifying
an entirely new (and confusingly named) helper.  If the log message is useful, add
it to pci_enable_sriov().

Speaking of naming, is this stuff confusing or what?  As a programmer
what am I supposed to think when I consider what may be the difference
between two interfaces, the only difference in naming is that two
words are transposed?

	pci_enable_sriov()
	pci_sriov_enable()

	pci_disable_sriov()
	pci_sriov_disable()

?!?!?!?!

As per pci_sriov_disable() explicitly, all it does different is check
for vf assignment and return failure.

If you want a little help that does that, name it appropriately.

	pci_disable_sriov_if_unassigned()

So kill off pci_sriov_enable() helper completely, it is unnecessary,
and rename the disable helper so that it says something meaningful to
the reader.

Thanks.
