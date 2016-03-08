Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41523 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbcCHXKZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Mar 2016 18:10:25 -0500
Date: Tue, 8 Mar 2016 17:10:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Auchter <michael.auchter@ni.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: add pci_clear_master() stub for !CONFIG_PCI
Message-ID: <20160308231017.GA11153@localhost>
References: <1457476481-13654-1-git-send-email-michael.auchter@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457476481-13654-1-git-send-email-michael.auchter@ni.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Michael,

On Tue, Mar 08, 2016 at 04:34:41PM -0600, Michael Auchter wrote:
> Add a stub for pci_clear_master() for when CONFIG_PCI is not set,
> similar to what's done for pci_set_master().

Does this fix a problem?  If so, what is it?  Some driver that doesn't
build when CONFIG_PCI is not set?

> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> ---
>  include/linux/pci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2771625..5f684d0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1425,6 +1425,7 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
>  #define pci_dev_put(dev)	do { } while (0)
>  
>  static inline void pci_set_master(struct pci_dev *dev) { }
> +static inline void pci_clear_master(struct pci_dev *dev) { }
>  static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
>  static inline void pci_disable_device(struct pci_dev *dev) { }
>  static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
