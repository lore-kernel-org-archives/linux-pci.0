Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:48365 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdBHGCS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2017 01:02:18 -0500
Date: Wed, 8 Feb 2017 07:04:10 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCHv6 3/5] pci: No config access for disconnected devices
Message-ID: <20170208060410.GA1026@wunner.de>
References: <1486495957-26177-1-git-send-email-keith.busch@intel.com>
 <1486495957-26177-4-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486495957-26177-4-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 07, 2017 at 02:32:35PM -0500, Keith Busch wrote:
> If we've  detected the PCI device is disconnected, there is no need to
> attempt to access its config space since we know the operation will
> fail. This patch has all the config reads and writes return -ENODEV
> error immediately when in such a state.
> 
> If a config read is sent to a disconnected device, the value will be
> set to all 1's. This is the same as what hardware is expected to return
> when accessing a removed device, but software can do this faster without
> relying on hardware.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/pci/access.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index d37b2ed..d63e9dd 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -892,12 +892,20 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
>  
>  int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
>  {
> +	if (pci_dev_is_disconnected(dev)) {

You used to have unlikely() here up until v4 but dropped it in v5.
Why?  Seemed sensible to me.

Thanks,

Lukas

> +		*val = ~0;
> +		return -ENODEV;
> +	}
>  	return pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
>  }
>  EXPORT_SYMBOL(pci_read_config_byte);
>  
>  int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
>  {
> +	if (pci_dev_is_disconnected(dev)) {
> +		*val = ~0;
> +		return -ENODEV;
> +	}
>  	return pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
>  }
>  EXPORT_SYMBOL(pci_read_config_word);
> @@ -905,18 +913,26 @@ EXPORT_SYMBOL(pci_read_config_word);
>  int pci_read_config_dword(const struct pci_dev *dev, int where,
>  					u32 *val)
>  {
> +	if (pci_dev_is_disconnected(dev)) {
> +		*val = ~0;
> +		return -ENODEV;
> +	}
>  	return pci_bus_read_config_dword(dev->bus, dev->devfn, where, val);
>  }
>  EXPORT_SYMBOL(pci_read_config_dword);
>  
>  int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val)
>  {
> +	if (pci_dev_is_disconnected(dev))
> +		return -ENODEV;
>  	return pci_bus_write_config_byte(dev->bus, dev->devfn, where, val);
>  }
>  EXPORT_SYMBOL(pci_write_config_byte);
>  
>  int pci_write_config_word(const struct pci_dev *dev, int where, u16 val)
>  {
> +	if (pci_dev_is_disconnected(dev))
> +		return -ENODEV;
>  	return pci_bus_write_config_word(dev->bus, dev->devfn, where, val);
>  }
>  EXPORT_SYMBOL(pci_write_config_word);
> @@ -924,6 +940,8 @@ EXPORT_SYMBOL(pci_write_config_word);
>  int pci_write_config_dword(const struct pci_dev *dev, int where,
>  					 u32 val)
>  {
> +	if (pci_dev_is_disconnected(dev))
> +		return -ENODEV;
>  	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
>  }
>  EXPORT_SYMBOL(pci_write_config_dword);
> -- 
> 2.7.2
> 
