Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37279 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeDGSf3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Apr 2018 14:35:29 -0400
Received: by mail-lf0-f66.google.com with SMTP id m200-v6so4736712lfm.4
        for <linux-pci@vger.kernel.org>; Sat, 07 Apr 2018 11:35:29 -0700 (PDT)
Subject: Re: [PATCH 3/4] pcie-rcar: add R-Car gen3 PHY support
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
 <d8dde257-814f-142c-d58b-91eaf78a7d10@cogentembedded.com>
Message-ID: <175cd86f-aaca-ab0e-3ca8-10ef44118e23@cogentembedded.com>
Date: Sat, 7 Apr 2018 21:35:25 +0300
MIME-Version: 1.0
In-Reply-To: <d8dde257-814f-142c-d58b-91eaf78a7d10@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

On 04/06/2018 02:08 PM, Sergei Shtylyov wrote:

> On R-Car gen3 SoCs the PCIe PHY has its own register region -- and I have
> written  a generic PHY driver for it, thus we need to add the corresponding
> code in  rcar_pcie_hw_init_gen3() and call devm_phy_optional_get() at the
> driver's probing time,  so that the existing R-Car gen3 device trees (not
> having a PHY node) would still work (we only need  to power up the PHY on
> R-Car V3H).
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  drivers/pci/host/pcie-rcar.c |   27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> Index: pci/drivers/pci/host/pcie-rcar.c
> ===================================================================
> --- pci.orig/drivers/pci/host/pcie-rcar.c
> +++ pci/drivers/pci/host/pcie-rcar.c
[...]
> @@ -916,6 +933,10 @@ static int rcar_pcie_get_resources(struc
>  	struct resource res;
>  	int err, i;
>  
> +	pcie->phy = devm_phy_optional_get(dev, "pcie");
> +	if (IS_ERR(pcie->phy))
> +		return PTR_ERR(pcie->phy);
> +

   Forgot to update the bindings. Sigh... :-(

[...]

MBR, Sergei
