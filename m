Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:61117 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaABVo6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jan 2014 16:44:58 -0500
Received: by mail-ig0-f180.google.com with SMTP id m12so3652658iga.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Jan 2014 13:44:58 -0800 (PST)
Date: Thu, 2 Jan 2014 14:44:54 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jason Cooper' <jason@lakedaemon.net>
Subject: Re: [PATCH] PCI: mvebu: Use max_t() instead of max(resource_size_t,)
Message-ID: <20140102214454.GA7228@google.com>
References: <000601cf029b$6bb27e40$43177ac0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000601cf029b$6bb27e40$43177ac0$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 27, 2013 at 09:34:36AM +0900, Jingoo Han wrote:
> Use max_t() instead of max(resource_size_t,) in order to fix
> the following checkpatch warning.
> 
>   WARNING: max() should probably be max_t(resource_size_t, SZ_64K, size)
>   WARNING: max() should probably be max_t(resource_size_t, SZ_1M, size)
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied with Jason's ack to pci/host-mvebu for v3.14, thanks!

Bjorn

> ---
>  drivers/pci/host/pci-mvebu.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index bedc0b1..fa140e1 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -735,9 +735,9 @@ static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
>  	 * aligned on their size
>  	 */
>  	if (res->flags & IORESOURCE_IO)
> -		return round_up(start, max((resource_size_t)SZ_64K, size));
> +		return round_up(start, max_t(resource_size_t, SZ_64K, size));
>  	else if (res->flags & IORESOURCE_MEM)
> -		return round_up(start, max((resource_size_t)SZ_1M, size));
> +		return round_up(start, max_t(resource_size_t, SZ_1M, size));
>  	else
>  		return start;
>  }
> -- 
> 1.7.10.4
> 
> 
