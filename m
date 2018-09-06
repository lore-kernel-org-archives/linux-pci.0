Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729445AbeIFXpV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Sep 2018 19:45:21 -0400
Date: Thu, 6 Sep 2018 14:08:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci: fix pci.c kernel-doc parameter warning
Message-ID: <20180906190830.GF214747@bhelgaas-glaptop.roam.corp.google.com>
References: <1fe6f0c6-7ebb-7ddd-af91-659afad2d7da@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1fe6f0c6-7ebb-7ddd-af91-659afad2d7da@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 02, 2018 at 07:32:50PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warning:
> 
> ../drivers/pci/pci.c:218: warning: Excess function parameter 'p' description in 'pci_dev_str_match_path'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Applied to pci/misc for v4.20, thanks!

> ---
>  drivers/pci/pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-419-rc2.orig/drivers/pci/pci.c
> +++ lnx-419-rc2/drivers/pci/pci.c
> @@ -196,7 +196,7 @@ EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
>  /**
>   * pci_dev_str_match_path - test if a path string matches a device
>   * @dev:    the PCI device to test
> - * @p:      string to match the device against
> + * @path:   string to match the device against
>   * @endptr: pointer to the string after the match
>   *
>   * Test if a string (typically from a kernel parameter) formatted as a
> 
