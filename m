Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934039AbdKGAd6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Nov 2017 19:33:58 -0500
Date: Mon, 6 Nov 2017 18:33:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci: fix kernel-doc build warning
Message-ID: <20171107003355.GE9538@bhelgaas-glaptop.roam.corp.google.com>
References: <85dcffe7-1e6b-5735-2552-d35d127e392b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <85dcffe7-1e6b-5735-2552-d35d127e392b@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Oct 29, 2017 at 05:07:11PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build error in kernel-doc notation:
> 
> ../drivers/pci/pci.c:3479: ERROR: Unexpected indentation.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc:	Bjorn Helgaas <bhelgaas@google.com>
> Cc:	linux-pci@vger.kernel.org
> ---
>  drivers/pci/pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-414-rc7.orig/drivers/pci/pci.c
> +++ lnx-414-rc7/drivers/pci/pci.c
> @@ -3471,7 +3471,7 @@ EXPORT_SYMBOL(devm_pci_remap_cfgspace);
>   * All operations are managed and will be undone on driver detach.
>   *
>   * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
> - * on failure. Usage example:
> + * on failure. Usage example::

I don't understand what's going on here.  Apparently there's something
special about two colons?  I saw plenty of double colons in
Documentation/, but I couldn't quickly find out what it means.

If kernel-doc thinks "example:" is a mistake, maybe we could recast
the sentence as "Example usage:"?  Putting a double colon here makes
the text look like a mistake to this human reader.

>   *
>   *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   *	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
> 
> 
