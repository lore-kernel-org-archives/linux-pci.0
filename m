Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34477 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933261AbbHJWme (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 18:42:34 -0400
Message-ID: <55C928D8.3040200@gmail.com>
Date: Mon, 10 Aug 2015 15:42:32 -0700
From: Frank Rowand <frowand.list@gmail.com>
Reply-To: frowand.list@gmail.com
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com, aik@ozlabs.ru
Subject: Re: [PATCH v6 40/42] drivers/of: Return allocated memory chunk from
 of_fdt_unflatten_tree()
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com> <1438834307-26960-41-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-41-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/5/2015 9:11 PM, Gavin Shan wrote:
> This changes of_fdt_unflatten_tree() so that it returns the allocated
> memory chunk for unflattened device-tree, which can be released once
> it's obsoleted.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/of/fdt.c       | 11 ++++++-----
>  include/linux/of_fdt.h |  2 +-
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 074870a..8e1ba7e 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -408,7 +408,7 @@ static void *unflatten_dt_node(const void *blob,
>   * @dt_alloc: An allocator that provides a virtual address to memory
>   * for the resulting tree
>   */
> -static void __unflatten_device_tree(const void *blob,
> +static void *__unflatten_device_tree(const void *blob,
>  			     struct device_node *dad,
>  			     struct device_node **mynodes,
>  			     void * (*dt_alloc)(u64 size, u64 align))

Please add a description of the return value to the documentation header.


> @@ -421,7 +421,7 @@ static void __unflatten_device_tree(const void *blob,
>  
>  	if (!blob) {
>  		pr_debug("No device tree pointer\n");
> -		return;
> +		return NULL;
>  	}
>  
>  	pr_debug("Unflattening device tree:\n");
> @@ -431,7 +431,7 @@ static void __unflatten_device_tree(const void *blob,
>  
>  	if (fdt_check_header(blob)) {
>  		pr_err("Invalid device tree blob header\n");
> -		return;
> +		return NULL;
>  	}
>  
>  	/* First pass, scan for size */
> @@ -458,6 +458,7 @@ static void __unflatten_device_tree(const void *blob,
>  			   be32_to_cpup(mem + size));
>  
>  	pr_debug(" <- unflatten_device_tree()\n");
> +	return mem;
>  }
>  
>  static void *kernel_tree_alloc(u64 size, u64 align)
> @@ -473,11 +474,11 @@ static void *kernel_tree_alloc(u64 size, u64 align)
>   * pointers of the nodes so the normal device-tree walking functions
>   * can be used.
>   */
> -void of_fdt_unflatten_tree(const unsigned long *blob,
> +void *of_fdt_unflatten_tree(const unsigned long *blob,

Please add a description of the return value to the documentation header.


>  			struct device_node *dad,
>  			struct device_node **mynodes)
>  {
> -	__unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
> +	return __unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
>  }
>  EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>  
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index 3644960..00db279 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -37,7 +37,7 @@ extern bool of_fdt_is_big_endian(const void *blob,
>  				 unsigned long node);
>  extern int of_fdt_match(const void *blob, unsigned long node,
>  			const char *const *compat);
> -extern void of_fdt_unflatten_tree(const unsigned long *blob,
> +extern void *of_fdt_unflatten_tree(const unsigned long *blob,
>  			       struct device_node *dad,
>  			       struct device_node **mynodes);
>  
> 

