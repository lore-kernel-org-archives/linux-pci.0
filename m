Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:65408 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbaIDW5l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 18:57:41 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so184122pab.6
        for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2014 15:57:41 -0700 (PDT)
Date: Thu, 4 Sep 2014 16:57:36 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, alex.williamson@redhat.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: Export MSI message relevant functions
Message-ID: <20140904225736.GJ17125@google.com>
References: <1400468470-11262-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400468470-11262-2-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400468470-11262-2-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 19, 2014 at 01:01:07PM +1000, Gavin Shan wrote:
> The patch exports 2 MSI message relevant functions, which will be
> used by VFIO PCI driver. The VFIO PCI driver would be built as
> a module.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I think Alex will merge this along with the other ones.  Sorry this
took so long.  I don't really like this, but I just can't figure out
any solution that's better.

> ---
>  drivers/pci/msi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 955ab79..2350271 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -324,6 +324,7 @@ void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
>  
>  	__get_cached_msi_msg(entry, msg);
>  }
> +EXPORT_SYMBOL_GPL(get_cached_msi_msg);
>  
>  void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  {
> @@ -368,6 +369,7 @@ void write_msi_msg(unsigned int irq, struct msi_msg *msg)
>  
>  	__write_msi_msg(entry, msg);
>  }
> +EXPORT_SYMBOL_GPL(write_msi_msg);
>  
>  static void free_msi_irqs(struct pci_dev *dev)
>  {
> -- 
> 1.8.3.2
> 
