Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750890AbeDDNnv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Apr 2018 09:43:51 -0400
Date: Wed, 4 Apr 2018 08:43:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Zhichang Yuan <yuanzhichang@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddeodr.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] lib: logic_pio: Fix potential NULL pointer dereference
Message-ID: <20180404134349.GQ9322@bhelgaas-glaptop.roam.corp.google.com>
References: <20180403211505.GA29612@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180403211505.GA29612@embeddedor.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Tue, Apr 03, 2018 at 04:15:05PM -0500, Gustavo A. R. Silva wrote:
> new_range is being dereferenced before it is null checked, hence
> there is a potential null pointer dereference.
> 
> Fix this by moving the pointer dereference after new_range has
> been properly null checked.
> 
> Addresses-Coverity-ID: 1466163 ("Dereference before null check")
> Fixes: 0a7198426259 ("lib: Add generic PIO mapping method")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Folded into 0a7198426259 on pci/lpc, thanks!

> ---
>  lib/logic_pio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/logic_pio.c b/lib/logic_pio.c
> index 29cedea..30dfdce 100644
> --- a/lib/logic_pio.c
> +++ b/lib/logic_pio.c
> @@ -33,8 +33,8 @@ static DEFINE_MUTEX(io_range_mutex);
>  int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>  {
>  	struct logic_pio_hwaddr *range;
> -	resource_size_t start = new_range->hw_start;
> -	resource_size_t end = new_range->hw_start + new_range->size;
> +	resource_size_t start;
> +	resource_size_t end;
>  	resource_size_t mmio_sz = 0;
>  	resource_size_t iio_sz = MMIO_UPPER_LIMIT;
>  	int ret = 0;
> @@ -42,6 +42,9 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>  	if (!new_range || !new_range->fwnode || !new_range->size)
>  		return -EINVAL;
>  
> +	start = new_range->hw_start;
> +	end = new_range->hw_start + new_range->size;
> +
>  	mutex_lock(&io_range_mutex);
>  	list_for_each_entry_rcu(range, &io_range_list, list) {
>  		if (range->fwnode == new_range->fwnode) {
> -- 
> 2.7.4
> 
