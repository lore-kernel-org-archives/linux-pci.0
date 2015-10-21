Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59564 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220AbbJUVkJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Oct 2015 17:40:09 -0400
Date: Wed, 21 Oct 2015 16:40:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Li Yang <leoli@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v4 1/6] PCI: layerscape: remove ls_pcie_establish_link()
Message-ID: <20151021214005.GL1583@localhost>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 16, 2015 at 03:19:15PM +0800, Minghuan Lian wrote:
> ls_pcie_establish_link() does not do any real operation, except
> to wait for the linkup establishment. In fact, this is not
> necessary. Moreover, each PCIe controller not inserted device
> will increase the Linux startup time about 200ms.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>

It'd be handy if there were a [0/6] cover letter where I could reply
with this update about the whole series.

I applied patches 1-5 to pci/host-layerscape for v4.4, thanks!

I split patch 5 (adding LS1043a and LS2080a support) into one patch
that removes the unused struct fields and a second patch that actually
adds the LS1043a and LS2080a support.

I haven't applied patch 6 because it doesn't make sense to me (more
details in the response to it).  I'll be happy to apply it if you
explain what I'm missing.

Bjorn

> ---
> Change log
> v4: split from [PATCH v3] PCI: layerscape: Add PCIe support for LS1043a and LS2080a
> 
>  drivers/pci/host/pci-layerscape.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index b2328ea1..6dd44a0 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -11,7 +11,6 @@
>   */
>  
>  #include <linux/kernel.h>
> -#include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of_pci.h>
> @@ -62,27 +61,12 @@ static int ls_pcie_link_up(struct pcie_port *pp)
>  	return 1;
>  }
>  
> -static int ls_pcie_establish_link(struct pcie_port *pp)
> -{
> -	unsigned int retries;
> -
> -	for (retries = 0; retries < 200; retries++) {
> -		if (dw_pcie_link_up(pp))
> -			return 0;
> -		usleep_range(100, 1000);
> -	}
> -
> -	dev_err(pp->dev, "phy link never came up\n");
> -	return -EINVAL;
> -}
> -
>  static void ls_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct ls_pcie *pcie = to_ls_pcie(pp);
>  	u32 val;
>  
>  	dw_pcie_setup_rc(pp);
> -	ls_pcie_establish_link(pp);
>  
>  	/*
>  	 * LS1021A Workaround for internal TKT228622
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
