Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:40502 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862AbbBTKGl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 20 Feb 2015 05:06:41 -0500
Message-ID: <54E7072C.30303@mm-sol.com>
Date: Fri, 20 Feb 2015 12:06:36 +0200
From: Stanimir Varbanov <svarbanov@mm-sol.com>
MIME-Version: 1.0
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
CC: mohit.kumar@st.com, viresh.kumar@linaro.org,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pci: spear: Drop __initdata from spear13xx_pcie_driver
References: <1424367708-17149-1-git-send-email-matwey@sai.msu.ru>
In-Reply-To: <1424367708-17149-1-git-send-email-matwey@sai.msu.ru>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/19/2015 07:41 PM, Matwey V. Kornilov wrote:
> spear13xx_pcie_driver.driver is allocated in text.init section
> and then the pointer to it is passed futher. This patch is to avoid
> crashes like the following, when freed memory is used.
> 
> Also, __init has been dropped from the probe() function referred from the struct
> and all called functions.
> 

<snip>

> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
> Changes from v2:
>  - Drop __init from all probing functions to allow deferred probing.
> Changes from v1:
>  - Use platform_driver_probe instead of platform_driver_register to make linker happy.
> 
>  drivers/pci/host/pcie-designware.c | 2 +-
>  drivers/pci/host/pcie-spear13xx.c  | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index df781cd..5b8a056 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -339,7 +339,7 @@ static const struct irq_domain_ops msi_domain_ops = {
>  	.map = dw_pcie_msi_map,
>  };
>  
> -int __init dw_pcie_host_init(struct pcie_port *pp)
> +int dw_pcie_host_init(struct pcie_port *pp)
>  {

we need to fix up the other pci drivers which use dw_pcie_host_init(), too.

pci-exynos, pci-imx6, pci-keystone and pci-layerscape.

Could you prepare a patch with above drivers included?

<snip>

-- 
regards,
Stan
