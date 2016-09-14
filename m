Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759948AbcINVuJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 17:50:09 -0400
Date: Wed, 14 Sep 2016 16:50:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-pci@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH -next] PCI: spear: Use builtin_platform_driver to
 simplify the code
Message-ID: <20160914215003.GE16581@localhost>
References: <1473510634-23872-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473510634-23872-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Paul]

On Sat, Sep 10, 2016 at 12:30:34PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Use the builtin_platform_driver() macro to make the code simpler.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pci/host/pcie-spear13xx.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index 09aed85..1c957eb 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -364,8 +364,4 @@ static struct platform_driver spear13xx_pcie_driver = {
>  	},
>  };
>  
> -static int __init spear13xx_pcie_init(void)
> -{
> -	return platform_driver_register(&spear13xx_pcie_driver);
> -}
> -device_initcall(spear13xx_pcie_init);
> +builtin_platform_driver(spear13xx_pcie_driver);

Hmm.  It looks like maybe we could use builtin_platform_driver_probe()?
In most or all of the drivers/pci/host drivers?

If you want to do that, please base your patches on my
pci/demodularize branch, since that's where I would apply them.

I have to say that the plethora of helper macros is getting a little
confusing:

  module_driver
  module_platform_driver
  module_platform_driver_probe
  module_pci_driver
  ...
  builtin_driver
  builtin_platform_driver
  builtin_platform_driver_probe
  builtin_pci_driver
  ...

Actually, seeing the list organized like this makes me feel better,
like there really is some underlying structure here.  It's just hard
to discover in the middle of all the comments and CPP magic.

It is kind of amusing that each one has a big comment header like:

  /* module_platform_driver_probe() - Helper macro for drivers that don't do
   * anything special in module init/exit.  This eliminates a lot of
   * boilerplate.  Each module may only use this macro once, and
   * calling it replaces module_init() and module_exit()
   */

It amuses me that the comments about eliminating boilerplate are
*themselves* boilerplate.  I guess I'm easily amused.

Bjorn
