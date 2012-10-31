Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from webmail.solarflare.com ([12.187.104.25]:37363 "EHLO
	ocex02.SolarFlarecom.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755031Ab2JaXxP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 19:53:15 -0400
Message-ID: <1351727591.2706.52.camel@bwh-desktop.uk.solarflarecom.com>
Subject: Re: [PATCH 4/4] PCI,sriov: provide method to reduce the number of
 total VFs supported
From: Ben Hutchings <bhutchings@solarflare.com>
To: Donald Dutile <ddutile@redhat.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<yuvalmin@broadcom.com>, <gregory.v.rose@intel.com>,
	<yinghai@kernel.org>, <davem@davemloft.net>
Date: Wed, 31 Oct 2012 23:53:11 +0000
In-Reply-To: <1351718353-6124-5-git-send-email-ddutile@redhat.com>
References: <1351718353-6124-1-git-send-email-ddutile@redhat.com>
	 <1351718353-6124-5-git-send-email-ddutile@redhat.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2012-10-31 at 17:19 -0400, Donald Dutile wrote:
> Some implementations of SRIOV provide a capability structure
> value of TotalVFs that is greater than what the software can support.
> Provide a method to reduce the capability structure reported value
> to the value the driver can support.
> This ensures sysfs reports the current capability of the system,
> hardware and software.
> Example for its use: igb & ixgbe -- report 8 & 64 as TotalVFs,
> but drivers only support 7 & 63 maximum.
> 
> Signed-off-by: Donald Dutile <ddutile@redhat.com>
> ---
>  drivers/pci/iov.c       | 27 ++++++++++++++++++++++++++-
>  drivers/pci/pci-sysfs.c | 10 ++++++++--
>  drivers/pci/pci.h       |  1 +
>  include/linux/pci.h     |  5 +++++
>  4 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index aeccc91..98c3d37 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -682,7 +682,6 @@ int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
>  
>  	if (!dev->is_physfn)
>  		return -ENODEV;
> -
>  	return sriov_enable(dev, nr_virtfn);
>  }
>  EXPORT_SYMBOL_GPL(pci_enable_sriov);

This hunk doesn't belong in this patch.

> @@ -735,3 +734,29 @@ int pci_num_vf(struct pci_dev *dev)
>  		return dev->sriov->nr_virtfn;
>  }
>  EXPORT_SYMBOL_GPL(pci_num_vf);
> +
> +/**
> + * pci_sriov_set_totalvfs -- reduce the TotalVFs available
> + * @dev: the PCI PF device
> + * numvfs: number that should be used for TotalVFs supported
> + *
> + * Should be called from PF driver's probe routine with
> + * device's mutex held.
> + *
> + * Returns 0 if PF is an SRIOV-capable device and
> + * value of numvfs valid, otherwise -EINVAL

This says the only possible error is -EINVAL, but it can also return
-EIO!  And the already-enabled case might be one that some drivers will
need to handle specially.

> + */
> +int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
> +{
> +	if (!dev || !dev->is_physfn || (numvfs > dev->sriov->total))
> +		return -EINVAL;
> +
> +	/* Shouldn't change if VFs already enabled */
> +	if (dev->sriov->ctrl & PCI_SRIOV_CTRL_VFE)
> +		return -EIO;
[...]

EBUSY seems a bit more appropriate.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

