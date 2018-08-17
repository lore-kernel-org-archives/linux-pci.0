Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeHQRxM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Aug 2018 13:53:12 -0400
Date: Fri, 17 Aug 2018 09:49:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hari Vyas <hari.vyas@broadcom.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: fix of read-write config operation in SMP
 environment
Message-ID: <20180817144930.GB128050@bhelgaas-glaptop.roam.corp.google.com>
References: <1534516668-1206-1-git-send-email-hari.vyas@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1534516668-1206-1-git-send-email-hari.vyas@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2018 at 08:07:48PM +0530, Hari Vyas wrote:
> Read modify write operations performed on same pci configuration
> registers which have bit fields may not work properly in SMP
> environment. Let us assume one thread tries to set master bit
> and other thread memory bit of PCI_COMMAND register, result may
> be unpredictable.

It's possible we'll need something like this, but we would have to
have a clear understanding of what threads are involved.

For example, if the problem were that a driver had two threads and
thread A tried to set PCI_COMMAND_MASTER and thread B tried to set
PCI_COMMAND_MEMORY, I'd say that's just a driver synchronization
problem that should be fixed in the driver.

So I'm going to defer this until we work through Ben's patches.
If you think we still need this after that, please repost it.

> Better we introduce a new routine in struct pci_ops like
> (int (*modify_safe)(struct pci_bus *bus, unsigned int devfn,
> int where, int size, u32 old, u32 new);
> This routine may first read current value and apply diff.
> 
> Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
> ---
>  drivers/pci/access.c    | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c       |  1 +
>  drivers/pci/setup-res.c |  2 +-
>  include/linux/pci.h     |  4 ++++
>  4 files changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index a3ad2fe..c4cf99b 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -588,3 +588,64 @@ int pci_write_config_dword(const struct pci_dev *dev, int where,
>  	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
>  }
>  EXPORT_SYMBOL(pci_write_config_dword);
> +
> +#define PCI_OP_MODIFY(size, type, len) \
> +int pci_bus_modify_config_##size \
> +	(struct pci_bus *bus, unsigned int devfn, int pos, 		\
> +	 type rval, type wval)						\
> +{									\
> +	int res;							\
> +	unsigned long flags;						\
> +	u32 rdata = 0;							\
> +	u32 wdata = 0;							\
> +	u32 temp_data = 0;						\
> +	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
> +	pci_lock_config(flags);						\
> +	if (bus->ops->modify) {						\
> +		res = bus->ops->modify(bus, devfn, pos, len,		\
> +				       rval, wval);			\
> +	} else {							\
> +		temp_data = rval ^ wval;				\
> +		res = bus->ops->read(bus, devfn, pos, len, &rdata);	\
> +		wdata = rdata ^ temp_data;				\
> +		res = bus->ops->write(bus, devfn, pos, len, wdata);	\
> +	}								\
> +	pci_unlock_config(flags);					\
> +	return res;							\
> +}
> +
> +PCI_OP_MODIFY(byte, u8, 1)
> +PCI_OP_MODIFY(word, u16, 2)
> +PCI_OP_MODIFY(dword, u32, 4)
> +int pci_modify_config_byte(const struct pci_dev *dev, int where,
> +			   u8 rval, u8 wval)
> +{
> +	if (pci_dev_is_disconnected(dev)) {
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +	return pci_bus_modify_config_byte(dev->bus, dev->devfn, where,
> +					  rval, wval);
> +}
> +EXPORT_SYMBOL(pci_modify_config_byte);
> +
> +int pci_modify_config_word(const struct pci_dev *dev, int where,
> +			   u16 rval, u16 wval)
> +{
> +	if (pci_dev_is_disconnected(dev)) {
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +	return pci_bus_modify_config_word(dev->bus, dev->devfn, where,
> +					  rval, wval);
> +}
> +EXPORT_SYMBOL(pci_modify_config_word);
> +
> +int pci_modify_config_dword(const struct pci_dev *dev, int where,
> +			    u32 rval, u32 wval)
> +{
> +	if (pci_dev_is_disconnected(dev)) {
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +	return pci_bus_modify_config_dword(dev->bus, dev->devfn, where,
> +					   rval, wval);
> +}
> +EXPORT_SYMBOL(pci_modify_config_dword);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 316496e..db1c132 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3712,6 +3712,7 @@ static void __pci_set_master(struct pci_dev *dev, bool enable)
>  		pci_dbg(dev, "%s bus mastering\n",
>  			enable ? "enabling" : "disabling");
>  		pci_write_config_word(dev, PCI_COMMAND, cmd);
> +		pci_modify_config_word(dev, PCI_COMMAND, old_cmd, cmd);
>  	}
>  	dev->is_busmaster = enable;
>  }
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index d8ca40a..a2e6fa4 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -493,7 +493,7 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
>  
>  	if (cmd != old_cmd) {
>  		pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
> -		pci_write_config_word(dev, PCI_COMMAND, cmd);
> +		pci_modify_config_word(dev, PCI_COMMAND, old_cmd, cmd);
>  	}
>  	return 0;
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c133ccf..d948c4b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -664,6 +664,7 @@ struct pci_ops {
>  	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
>  	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
>  	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
> +	int (*modify)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 rval, u32 wval);
>  };
>  
>  /*
> @@ -991,6 +992,9 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
>  int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val);
>  int pci_write_config_word(const struct pci_dev *dev, int where, u16 val);
>  int pci_write_config_dword(const struct pci_dev *dev, int where, u32 val);
> +int pci_modify_config_byte(const struct pci_dev *dev, int where, u8 rval, u8 wval);
> +int pci_modify_config_word(const struct pci_dev *dev, int where, u16 rval, u16 wval);
> +int pci_modify_config_dword(const struct pci_dev *dev, int where, u32 rval, u32 wval);
>  
>  int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
>  int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val);
> -- 
> 1.9.1
> 
