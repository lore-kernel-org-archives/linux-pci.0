Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:52303 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeFDQJf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jun 2018 12:09:35 -0400
Date: Mon, 4 Jun 2018 10:12:13 -0600
From: Keith Busch <keith.busch@intel.com>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: bhelgaas@google.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: access.c: Piggyback user config access on
 pci_read/write_*()
Message-ID: <20180604161213.GA7712@localhost.localdomain>
References: <20180604154803.14185-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180604154803.14185-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 04, 2018 at 10:48:02AM -0500, Alexandru Gagniuc wrote:
> +++ b/drivers/pci/access.c
> @@ -223,16 +223,9 @@ int pci_user_read_config_##size						\
>  	(struct pci_dev *dev, int pos, type *val)			\
>  {									\
>  	int ret = PCIBIOS_SUCCESSFUL;					\
> -	u32 data = -1;							\
>  	if (PCI_##size##_BAD)						\
>  		return -EINVAL;						\
> -	raw_spin_lock_irq(&pci_lock);				\
> -	if (unlikely(dev->block_cfg_access))				\
> -		pci_wait_cfg(dev);					\
> -	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
> -					pos, sizeof(type), &data);	\
> -	raw_spin_unlock_irq(&pci_lock);				\
> -	*val = (type)data;						\
> +	ret = pci_read_config_##size(dev, pos, val);			\
>  	return pcibios_err_to_errno(ret);				\
>  }									\

If it wasn't for the block_cfg_access check for user access, this would
have been a nice code reuse cleanup.
