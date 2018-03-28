Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alan Douglas <adouglas@cadence.com>
To: Niklas Cassel <niklas.cassel@axis.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Niklas Cassel <niklass@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 07/12] PCI: cadence: Set PCI_BASE_ADDRESS_MEM_TYPE_64
 if a 64-bit BAR was set-up
Date: Wed, 28 Mar 2018 13:24:10 +0000
Message-ID: <CO2PR07MB97221CD6D90F81C2D81D65BD8A30@CO2PR07MB972.namprd07.prod.outlook.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-8-niklas.cassel@axis.com>
In-Reply-To: <20180328115018.31921-8-niklas.cassel@axis.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On 28/03/2018 12:51, Niklas Cassel wrote:
> cdns_pcie_ep_set_bar() does some round-up of the BAR size, which means th=
at a 64-bit BAR can be set-up, even when the flag
> PCI_BASE_ADDRESS_MEM_TYPE_64 isn't set.

> If a 64-bit BAR was set-up, set the flag PCI_BASE_ADDRESS_MEM_TYPE_64, so=
 that the calling function can know what BAR width that was actually set-up=
.

> I'm not sure why cdns_pcie_ep_set_bar() doesn't obey the flag PCI_BASE_AD=
DRESS_MEM_TYPE_64, but I leave this for the MAINTAINER to fix, since there =
might be a reason why > this flag is ignored.
Will investigate and fix this in future patch

> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/cadence/pcie-cadence-ep.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/=
pcie-cadence-ep.c
> index cef36cd6b710..2905e098678c 100644
> --- a/drivers/pci/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/cadence/pcie-cadence-ep.c
> @@ -106,6 +106,9 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, =
u8 fn,
>  		if (is_64bits && (bar & 1))
>  			return -EINVAL;
> =20
> +		if (is_64bits && !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
> +			epf_bar->flags |=3D PCI_BASE_ADDRESS_MEM_TYPE_64;
> +
>  		if (is_64bits && is_prefetch)
>  			ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
>  		else if (is_prefetch)
> --
> 2.14.2
Change looks good to me.
