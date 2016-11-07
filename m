Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:25573 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932373AbcKGNce (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2016 08:32:34 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Simon Horman <horms+renesas@verge.net.au>
CC: Magnus Damm <magnus.damm@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH/RFC] PCI: rcar: Restrict pci_fixup_irqs to the same PCI
 domain
Date: Mon, 7 Nov 2016 13:32:28 +0000
Message-ID: <HK2PR0601MB1393486793C40576FB24106CF5A70@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <1478520048-25430-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1478520048-25430-1-git-send-email-horms+renesas@verge.net.au>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Simon,

On 07 November 2016 12:01, Simon Horman wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>=20
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>=20
> Phil, this is from the 3.3.2 BSP.
> Is it appropriate for mainline?
No, this is not for upstream. The pci_fixup_irqs_local function was an RFC
that should be solved in a more generic way.
See https://patchwork.kernel.org/patch/9220653

BR
Phil

> ---
>  drivers/pci/host/pcie-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 62700d1896f4..06e7a75094c7 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -472,7 +472,7 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
>  		return -ENODEV;
>  	}
>=20
> -	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +	pci_fixup_irqs_local(bus, pci_common_swizzle,
> of_irq_parse_and_map_pci);
>=20
>  	pci_bus_size_bridges(bus);
>  	pci_bus_assign_resources(bus);
> --
> 2.7.0.rc3.207.g0ac5344

