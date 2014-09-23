Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:56447 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbaIWSXO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 14:23:14 -0400
Received: by mail-ie0-f173.google.com with SMTP id tr6so9938824ieb.4
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2014 11:23:14 -0700 (PDT)
Date: Tue, 23 Sep 2014 12:23:11 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: Remove the redundant irq_set_msi_desc()
Message-ID: <20140923182311.GC6776@google.com>
References: <1410320852-17725-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410320852-17725-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 10, 2014 at 11:47:32AM +0800, Yijing Wang wrote:
> Irq and msi_desc will be associated in arch MSI
> setup code. The irq_set_msi_desc() in msix_program_entries()
> is redundant.

Can you help me review this by mentioning exactly *where* the IRQ and
msi_desc are associated by the arch MSI setup code?

> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/msi.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 5a40516..902b0cb 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -719,7 +719,6 @@ static void msix_program_entries(struct pci_dev *dev,
>  						PCI_MSIX_ENTRY_VECTOR_CTRL;
>  
>  		entries[i].vector = entry->irq;
> -		irq_set_msi_desc(entry->irq, entry);
>  		entry->masked = readl(entry->mask_base + offset);
>  		msix_mask_irq(entry, 1);
>  		i++;
> -- 
> 1.7.1
> 
