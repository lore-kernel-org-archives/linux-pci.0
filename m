Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1948752AbdEZVk1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 May 2017 17:40:27 -0400
Date: Fri, 26 May 2017 16:40:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Krishna Dhulipala <krishnad@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCH] PCI: Make error code types consistent in
 pci_{read,write}_config_*
Message-ID: <20170526214024.GC21531@bhelgaas-glaptop.roam.corp.google.com>
References: <1495177107-203736-1-git-send-email-shawn.lin@rock-chips.com>
 <20170523184359.GB115572@google.com>
 <20170523193655.GA144183@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170523193655.GA144183@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 23, 2017 at 12:36:58PM -0700, Brian Norris wrote:
> Callers normally treat the config space accessors as returning PCBIOS_*
> error codes, not Linux error codes (or they don't look at them at all).
> We have pcibios_err_to_errno(), in case the error code needs translated.
> 
> Fixes: 4b1038834739 ("PCI: Don't attempt config access to disconnected devices")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied with Keith's reviewed-by to for-linus for v4.12, thanks, Brian!

> ---
> + others, change subject
> 
> On Tue, May 23, 2017 at 11:44:01AM -0700, Brian Norris wrote:
> > But the high level code doesn't handle this
> > consistently. See, e.g., pci_read_config_byte() which can return regular
> > Linux error codes (like -ENODEV), except it also passes up the return
> > code of pci_read_config_byte() (a PCIBIOS_* code) directly.
> 
> Apparently this is new (inconsistent) behavior in 4.12-rc1. Seems like
> an oversight to me.
> 
> > So callers don't really know whether to treat the value from
> > pci_read_config_<foo>() as a PCIBIOS_* code (which should be translated
> > with pcibios_err_to_errno()) or as a standard Linux errno.
> > 
> > But then, there are relatively few callers (less than 10% of
> > pci_read_config_<foo>(); even fewer for writes) that actually check the
> > error codes...
> > 
> > Maybe the "fix" is to replace -ENODEV with PCIBIOS_DEVICE_NOT_FOUND for
> > the inconsistent cases (pci_{read,write}_config_{byte,word,dword}()).
> 
> Fix implemented in the surrounding patch.
> 
>  drivers/pci/access.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 74cf5fffb1e1..c80e37a69305 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -896,7 +896,7 @@ int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
>  {
>  	if (pci_dev_is_disconnected(dev)) {
>  		*val = ~0;
> -		return -ENODEV;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  	return pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
>  }
> @@ -906,7 +906,7 @@ int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
>  {
>  	if (pci_dev_is_disconnected(dev)) {
>  		*val = ~0;
> -		return -ENODEV;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  	return pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
>  }
> @@ -917,7 +917,7 @@ int pci_read_config_dword(const struct pci_dev *dev, int where,
>  {
>  	if (pci_dev_is_disconnected(dev)) {
>  		*val = ~0;
> -		return -ENODEV;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  	return pci_bus_read_config_dword(dev->bus, dev->devfn, where, val);
>  }
> @@ -926,7 +926,7 @@ EXPORT_SYMBOL(pci_read_config_dword);
>  int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val)
>  {
>  	if (pci_dev_is_disconnected(dev))
> -		return -ENODEV;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
>  	return pci_bus_write_config_byte(dev->bus, dev->devfn, where, val);
>  }
>  EXPORT_SYMBOL(pci_write_config_byte);
> @@ -934,7 +934,7 @@ EXPORT_SYMBOL(pci_write_config_byte);
>  int pci_write_config_word(const struct pci_dev *dev, int where, u16 val)
>  {
>  	if (pci_dev_is_disconnected(dev))
> -		return -ENODEV;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
>  	return pci_bus_write_config_word(dev->bus, dev->devfn, where, val);
>  }
>  EXPORT_SYMBOL(pci_write_config_word);
> @@ -943,7 +943,7 @@ int pci_write_config_dword(const struct pci_dev *dev, int where,
>  					 u32 val)
>  {
>  	if (pci_dev_is_disconnected(dev))
> -		return -ENODEV;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
>  	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
>  }
>  EXPORT_SYMBOL(pci_write_config_dword);
> -- 
> 2.13.0.219.gdb65acc882-goog
