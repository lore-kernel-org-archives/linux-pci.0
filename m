Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:60248 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbcKYC0D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Nov 2016 21:26:03 -0500
Message-ID: <1480040757.2423.1.camel@intel.com>
Subject: Re: [PATCH] PCI: altera: use builtin_platform_driver
From: Ley Foon Tan <ley.foon.tan@intel.com>
To: Geliang Tang <geliangtang@gmail.com>,
        Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: "rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 25 Nov 2016 10:25:57 +0800
In-Reply-To: <b12dde3b7465f3bba35ab7a9226b464f30f27412.1479912709.git.geliangtang@gmail.com>
References: <b12dde3b7465f3bba35ab7a9226b464f30f27412.1479912709.git.geliangtang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Rab, 2016-11-23 at 14:52 +0000, Geliang Tang wrote:
> Use builtin_platform_driver() helper to simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>

> ---
>  drivers/pci/host/pcie-altera.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-
> altera.c
> index b0ac4df..eefcb38 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -641,8 +641,4 @@ static struct platform_driver altera_pcie_driver
> = {
>         },
>  };
> 
> -static int altera_pcie_init(void)
> -{
> -       return platform_driver_register(&altera_pcie_driver);
> -}
> -device_initcall(altera_pcie_init);
> +builtin_platform_driver(altera_pcie_driver);
> --
> 2.9.3
> 
