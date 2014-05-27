Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:63877 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbaE0XQa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 May 2014 19:16:30 -0400
Received: by mail-ig0-f172.google.com with SMTP id uy17so1745962igb.5
        for <linux-pci@vger.kernel.org>; Tue, 27 May 2014 16:16:30 -0700 (PDT)
Date: Tue, 27 May 2014 17:16:26 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, gthelen@google.com
Subject: Re: [PATCH v2] PCI: Fix return value from
 pci_user_{read,write}_config_*()
Message-ID: <20140527231626.GH11907@google.com>
References: <1400649810-11065-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400649810-11065-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 21, 2014 at 03:23:30PM +1000, Gavin Shan wrote:
> PCI accessors from user space pci_user_{read,write}_config_*()
> return negative error number, which was introduced by commit
> 34e32072 ("PCI: handle positive error codes"). That patch coverts
> all positive error numbers from platform specific PCI config
> accessors to -EINVAL. The upper layer calling to those PCI config
> accessors hardly know the specific cause from the return value
> when hitting failures.
> 
> The patch fixes the issue by doing the conversion (from positive
> to negative) using existing function pcibios_err_to_errno().
> 
> v2: pcibios_err_to_errno() translates unrecognized value to -ERANGE.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied with Greg's ack to pci/misc for v3.16, thanks!

> ---
>  drivers/pci/access.c | 12 ++++--------
>  include/linux/pci.h  |  4 ++--
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 7f8b78c..8c148f3 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -148,7 +148,7 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
>  int pci_user_read_config_##size						\
>  	(struct pci_dev *dev, int pos, type *val)			\
>  {									\
> -	int ret = 0;							\
> +	int ret = PCIBIOS_SUCCESSFUL;					\
>  	u32 data = -1;							\
>  	if (PCI_##size##_BAD)						\
>  		return -EINVAL;						\
> @@ -159,9 +159,7 @@ int pci_user_read_config_##size						\
>  					pos, sizeof(type), &data);	\
>  	raw_spin_unlock_irq(&pci_lock);				\
>  	*val = (type)data;						\
> -	if (ret > 0)							\
> -		ret = -EINVAL;						\
> -	return ret;							\
> +	return pcibios_err_to_errno(ret);				\
>  }									\
>  EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
>  
> @@ -170,7 +168,7 @@ EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
>  int pci_user_write_config_##size					\
>  	(struct pci_dev *dev, int pos, type val)			\
>  {									\
> -	int ret = -EIO;							\
> +	int ret = PCIBIOS_SUCCESSFUL;					\
>  	if (PCI_##size##_BAD)						\
>  		return -EINVAL;						\
>  	raw_spin_lock_irq(&pci_lock);				\
> @@ -179,9 +177,7 @@ int pci_user_write_config_##size					\
>  	ret = dev->bus->ops->write(dev->bus, dev->devfn,		\
>  					pos, sizeof(type), val);	\
>  	raw_spin_unlock_irq(&pci_lock);				\
> -	if (ret > 0)							\
> -		ret = -EINVAL;						\
> -	return ret;							\
> +	return pcibios_err_to_errno(ret);				\
>  }									\
>  EXPORT_SYMBOL_GPL(pci_user_write_config_##size);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aab57b4..ece7bef 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -518,7 +518,7 @@ static inline int pcibios_err_to_errno(int err)
>  	case PCIBIOS_FUNC_NOT_SUPPORTED:
>  		return -ENOENT;
>  	case PCIBIOS_BAD_VENDOR_ID:
> -		return -EINVAL;
> +		return -ENOTTY;
>  	case PCIBIOS_DEVICE_NOT_FOUND:
>  		return -ENODEV;
>  	case PCIBIOS_BAD_REGISTER_NUMBER:
> @@ -529,7 +529,7 @@ static inline int pcibios_err_to_errno(int err)
>  		return -ENOSPC;
>  	}
>  
> -	return -ENOTTY;
> +	return -ERANGE;
>  }
>  
>  /* Low-level architecture-dependent routines */
> -- 
> 1.8.3.2
> 
