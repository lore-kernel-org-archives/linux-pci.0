Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38944 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbcDLIqx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Apr 2016 04:46:53 -0400
Subject: Re: 4.6-rc2 regression with commit 104daa71b396: check VPD access
 offset against length
To: Hariprasad Shenai <hariprasad@chelsio.com>
References: <BY2PR12MB06483CA232B6B3BFF7179012C8910@BY2PR12MB0648.namprd12.prod.outlook.com>
 <BY2PR12MB0648F0C35D907AA640D7E56CC8940@BY2PR12MB0648.namprd12.prod.outlook.com>
 <02ec01d1941e$3dda2010$b98e6030$@opengridcomputing.com>
 <20160412053700.GF11361@localhost> <570C93BD.2030102@suse.com>
 <20160412082304.GB2771@hari-Latitude-E5550>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Steve Wise <swise@opengridcomputing.com>,
	'Casey Leedom' <leedom@chelsio.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com
From: Hannes Reinecke <hare@suse.com>
Message-ID: <570CB5FA.7010507@suse.com>
Date: Tue, 12 Apr 2016 10:46:50 +0200
MIME-Version: 1.0
In-Reply-To: <20160412082304.GB2771@hari-Latitude-E5550>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/12/2016 10:23 AM, Hariprasad Shenai wrote:
[ .. ]
> 
> Hi,
> 
> How about adding a PCI helper function to set the actual VPD_SIZE.
> 
> Some thing like below. We have tested this and works. The bnx2x and the tg3
> drive may also need this, because I see them calling pci_read_vpd()
> with non-zero offsets. The bnx2x in particular looks like it's doing something
> similar to cxgb4 so it would also probably benefit from this change (once it's
> fixed to call the new pci_set_size_vpd() API).
> 
That indeed looks reasonable.
Please find some comments inline.

> Thanks,
> Hari
> 
> ====
> 
> --- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c	
> +++ a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c	
> @@ -2557,6 +2557,7 @@ void t4_get_regs(struct adapter *adap, void *buf, size_t buf_size)
>  }
>  
>  #define EEPROM_STAT_ADDR   0x7bfc
> +#define VPD_SIZE           0x800
>  #define VPD_BASE           0x400
>  #define VPD_BASE_OLD       0
>  #define VPD_LEN            1024
> @@ -2594,6 +2595,15 @@ int t4_get_raw_vpd_params(struct adapter *adapter, struct vpd_params *p)
>  	if (!vpd)
>  		return -ENOMEM;
>  
> +	/* We have two VPD data structures stored in the adapter VPD area.
> +	 * By default, Linux calculates the size of the VPD area by traversing
> +	 * the first VPD area at offset 0x0, so we need to tell the OS what
> +	 * our real VPD size is.
> +	 */
> +	ret = pci_set_size_vpd(adapter->pdev, VPD_SIZE);
> +	if (ret < 0)
> +		goto out;
> +
>  	/* Card information normally starts at VPD_BASE but early cards had
>  	 * it at 0.
>  	 */
> --- a/drivers/pci/access.c	
> +++ a/drivers/pci/access.c	
> @@ -275,6 +275,19 @@ ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void
>  }
>  EXPORT_SYMBOL(pci_write_vpd);
>  
> +/**
> + * pci_set_size_vpd - Set size of Vital Product Data space
> + * @dev:	pci device struct
> + * @len:	size of vpd space
> + */
> +ssize_t pci_set_size_vpd(struct pci_dev *dev, size_t len)
> +{
> +	if (!dev->vpd || !dev->vpd->ops)
> +		return -ENODEV;
> +	return dev->vpd->ops->set_size(dev, len);
> +}
> +EXPORT_SYMBOL(pci_set_size_vpd);
> +
>  #define PCI_VPD_MAX_SIZE (PCI_VPD_ADDR_MASK + 1)
>  
>  /**
> @@ -392,13 +405,8 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>  	if (vpd->len == 0)
>  		return -EIO;
>  
> -	if (pos > vpd->len)
> -		return 0;
> -
> -	if (end > vpd->len) {
> -		end = vpd->len;
> -		count = end - pos;
> -	}
> +	if (end > vpd->len)
> +		return -EINVAL;
>  
>  	if (mutex_lock_killable(&vpd->lock))
>  		return -EINTR;
Why do you need this change?
We still would be needing to validate 'pos', don't we?
I'd prefer not to have this bit in.

> @@ -498,9 +506,23 @@ out:
>  	return ret ? ret : count;
>  }
>  
> +static ssize_t pci_vpd_set_size(struct pci_dev *dev, size_t len)
> +{
> +	struct pci_vpd *vpd = dev->vpd;
> +
> +	if (len == 0 || len > PCI_VPD_MAX_SIZE)
> +		return -EIO;
> +
> +	vpd->valid = 1;
> +	vpd->len = len;
> +
> +	return 0;
> +}
> +
>  static const struct pci_vpd_ops pci_vpd_ops = {
>  	.read = pci_vpd_read,
>  	.write = pci_vpd_write,
> +	.set_size = pci_vpd_set_size,
>  };
>  
>  static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
> @@ -533,9 +555,24 @@ static ssize_t pci_vpd_f0_write(struct pci_dev *dev, loff_t pos, size_t count,
>  	return ret;
>  }
>  
> +static ssize_t pci_vpd_f0_set_size(struct pci_dev *dev, size_t len)
> +{
> +	struct pci_dev *tdev = pci_get_slot(dev->bus,
> +					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> +	ssize_t ret;
> +
> +	if (!tdev)
> +		return -ENODEV;
> +
> +	ret = pci_set_size_vpd(tdev, len);
> +	pci_dev_put(tdev);
> +	return ret;
> +}
> +
>  static const struct pci_vpd_ops pci_vpd_f0_ops = {
>  	.read = pci_vpd_f0_read,
>  	.write = pci_vpd_f0_write,
> +	.set_size = pci_vpd_f0_set_size,
>  };
>  
>  int pci_vpd_init(struct pci_dev *dev)
> --- a/drivers/pci/pci.h	
> +++ a/drivers/pci/pci.h	
> @@ -97,6 +97,7 @@ static inline bool pci_has_subordinate(struct pci_dev *pci_dev)
>  struct pci_vpd_ops {
>  	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
>  	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
> +	ssize_t (*set_size)(struct pci_dev *dev, size_t len);
>  };
>  
>  struct pci_vpd {
> --- a/include/linux/pci.h	
> +++ a/include/linux/pci.h	
> @@ -1111,6 +1111,7 @@ void pci_unlock_rescan_remove(void);
>  /* Vital product data routines */
>  ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
>  ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
> +ssize_t pci_set_size_vpd(struct pci_dev *dev, size_t len);
>  
>  /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
>  resource_size_t pcibios_retrieve_fw_addr(struct pci_dev *dev, int idx);
> 
> 

Remaining bits look okay.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
