Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45730 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbdKHJ2S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2017 04:28:18 -0500
Received: by mail-lf0-f68.google.com with SMTP id n69so2323455lfn.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Nov 2017 01:28:18 -0800 (PST)
Subject: Re: [PATCH] PCI: rcar: Add compatible string for r8a7796
To: Marek Vasut <marek.vasut@gmail.com>, linux-pci@vger.kernel.org
Cc: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20171108091521.8423-1-marek.vasut+renesas@gmail.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <538f7964-0f69-2ed2-35f2-e14244a7e6ba@cogentembedded.com>
Date: Wed, 8 Nov 2017 12:28:16 +0300
MIME-Version: 1.0
In-Reply-To: <20171108091521.8423-1-marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

On 11/8/2017 12:15 PM, Marek Vasut wrote:

> From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
> 
> Add compatible string for the RCar M3 R8A7796 SoC.

    It's M3-W.

> Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>   drivers/pci/host/pcie-rcar.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 12796eccb2be..8b51208875fc 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -1062,6 +1062,7 @@ static const struct of_device_id rcar_pcie_of_match[] = {
>   	{ .compatible = "renesas,pcie-rcar-gen2",
>   	  .data = rcar_pcie_hw_init_gen2 },
>   	{ .compatible = "renesas,pcie-r8a7795", .data = rcar_pcie_hw_init },
> +	{ .compatible = "renesas,pcie-r8a7796", .data = rcar_pcie_hw_init },

    Why, if we already have the line below? And don't you need to update the 
bindings?

>   	{ .compatible = "renesas,pcie-rcar-gen3", .data = rcar_pcie_hw_init },
>   	{},
>   };

MBR, Sergei
