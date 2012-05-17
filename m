Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40451 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967579Ab2EQSvS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 May 2012 14:51:18 -0400
Message-ID: <4FB548A8.9010003@redhat.com>
Date: Thu, 17 May 2012 14:51:20 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Prarit Bhargava <prarit@redhat.com>
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci, Add AER_panic sysfs file
References: <1337274270-18785-1-git-send-email-prarit@redhat.com>
In-Reply-To: <1337274270-18785-1-git-send-email-prarit@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/17/2012 01:04 PM, Prarit Bhargava wrote:
> Consider the following case
>
> 		[ RP ]
> 		  |
> 		  |
> 	+---------+-----------+
> 	|	  |	      |
>         [H1]      [H2]        [X1]
>
> where RP is a PCIE Root Port, H1 and H2 are devices with drivers that support
> PCIE AER driver error handling (ie, they have pci_error_handlers defined in
> the driver), and X1 is a device with a driver that does not support PCIE
> AER driver error handling.
>
> If the Root Port takes an error what currently happens is that the
> bus resets and H1&  H2 call their slot_reset functions.  X1 does nothing.
>
> In some cases a user may not wish the system to continue because X1 is
> an unhardened driver.  In these cases, the system should not do a bus reset,
> but rather the system should panic to avoid any further possible data
> corruption.
>
> This patch implements an AER_panic sysfs entry for each root port which
> a user can modify.  AER_panic = 1, means the system will panic on a
> PCIE error which would have normally resulted in a secondary bus reset.
>
> Signed-off-by: Prarit Bhargava<prarit@redhat.com>
> Cc: Bjorn Helgaas<bhelgaas@google.com>
> ---
>   drivers/pci/pci-sysfs.c       |   42 ++++++++++++++++++++++++++++++++++++++++-
>   drivers/pci/pcie/aer/aerdrv.c |    3 ++
>   include/linux/pci.h           |    1 +
>   3 files changed, 45 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index a55e248..8c6d525 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1135,6 +1135,35 @@ static ssize_t reset_store(struct device *dev,
>
>   static struct device_attribute reset_attr = __ATTR(reset, 0200, NULL, reset_store);
>
> +static ssize_t AER_panic_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sprintf(buf, "%d\n", pdev->rp_AER_panic);
> +}
> +
> +static ssize_t AER_panic_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0,&val)<  0)
> +		return -EINVAL;
> +
> +	if ((val>  1) || (val<  0))
> +		return -EINVAL;
> +
> +	pdev->rp_AER_panic = val;
> +
> +	return count;
> +}
> +
> +static struct device_attribute rp_AER_panic_attr =
> +	      __ATTR(AER_panic, 0600, AER_panic_show, AER_panic_store);
> +
>   static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>   {
>   	int retval;
> @@ -1169,8 +1198,16 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>   			goto error;
>   		dev->reset_fn = 1;
>   	}
> -	return 0;
>
> +	/* PCIE Root Port panic-on-AER allows a user to configure each root
> +	 * port to panic on an AER error instead of issuing a bus reset.
> +	 */
> +	if (dev->pcie_type == PCI_EXP_TYPE_ROOT_PORT) {
> +		retval = device_create_file(&dev->dev,&rp_AER_panic_attr);
> +		if (retval)
> +			goto error;
> +	}
> +	return 0;
>   error:
>   	pcie_aspm_remove_sysfs_dev_files(dev);
>   	if (dev->vpd&&  dev->vpd->attr) {
> @@ -1279,6 +1316,9 @@ static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
>   		device_remove_file(&dev->dev,&reset_attr);
>   		dev->reset_fn = 0;
>   	}
> +
> +	if (dev->pcie_type == PCI_EXP_TYPE_ROOT_PORT)
> +		device_remove_file(&dev->dev,&rp_AER_panic_attr);
>   }
>
>   /**
> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 58ad791..dd6b352 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -346,6 +346,9 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>   	u32 reg32;
>   	int pos;
>
> +	if (dev->rp_AER_panic)
> +		panic("%s: AER detected on Root Port", pci_name(dev));
> +
It'd be more informative if the Root Port D:B:D.F was printed out above,
so one knows where the errors are coming from the system.  More likely than
not, the root is ok, but a device dangling from it is the 'root cause' (all pun intended)
of the error.

>   	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>
>   	/* Disable Root's interrupt in response to error messages */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e444f5b..a4e6a5a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -324,6 +324,7 @@ struct pci_dev {
>   	unsigned int    is_hotplug_bridge:1;
>   	unsigned int    __aer_firmware_first_valid:1;
>   	unsigned int	__aer_firmware_first:1;
> +	unsigned int	rp_AER_panic:1; /* if 1, panic on AER bus reset */
>   	pci_dev_flags_t dev_flags;
>   	atomic_t	enable_cnt;	/* pci_enable_device has been called */
>

