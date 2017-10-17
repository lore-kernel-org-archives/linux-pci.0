Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757991AbdJQS6P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Oct 2017 14:58:15 -0400
Date: Tue, 17 Oct 2017 13:58:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] misc: pci_endpoint_test: Prevent some integer
 overflows
Message-ID: <20171017185813.GH5641@bhelgaas-glaptop.roam.corp.google.com>
References: <20170930081552.rm4tjhxcyegpg3vn@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170930081552.rm4tjhxcyegpg3vn@mwanda>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 30, 2017 at 11:15:52AM +0300, Dan Carpenter wrote:
> "size + max" can have an arithmetic overflow when we're allocating:
> 
> 	orig_src_addr = dma_alloc_coherent(dev, size + alignment, ...
> 
> I've added a few checks to prevent that.
> 
> Fixes: 13107c60681f ("misc: pci_endpoint_test: Add support to provide aligned buffer addresses")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Both applied to pci/endpoint for v4.15, thanks!

Kishon, if you want to ack/nack this, I'll act accordingly.

> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index deb203026496..c0d323077ad0 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -226,6 +226,9 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
>  	u32 src_crc32;
>  	u32 dst_crc32;
>  
> +	if (size > SIZE_MAX - alignment)
> +		goto err;
> +
>  	orig_src_addr = dma_alloc_coherent(dev, size + alignment,
>  					   &orig_src_phys_addr, GFP_KERNEL);
>  	if (!orig_src_addr) {
> @@ -311,6 +314,9 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
>  	size_t alignment = test->alignment;
>  	u32 crc32;
>  
> +	if (size > SIZE_MAX - alignment)
> +		goto err;
> +
>  	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
>  				       GFP_KERNEL);
>  	if (!orig_addr) {
> @@ -369,6 +375,9 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
>  	size_t alignment = test->alignment;
>  	u32 crc32;
>  
> +	if (size > SIZE_MAX - alignment)
> +		goto err;
> +
>  	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
>  				       GFP_KERNEL);
>  	if (!orig_addr) {
