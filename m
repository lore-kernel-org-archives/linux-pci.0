Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alan Douglas <adouglas@cadence.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 02/10] PCI: cadence: Update cdns_pcie_ep_raise_irq function
 signature
Date: Fri, 13 Apr 2018 16:05:31 +0000
Message-ID: <SN6PR07MB4512CAD75BB34CA72D10713AD8B30@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
 <52314006c63f8d21907dfaa03207b39e36bb8171.1523379766.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <52314006c63f8d21907dfaa03207b39e36bb8171.1523379766.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 10 at 18.15, Gustavo Pimentel wrote:
> From: Gustavo Pimentel [mailto:gustavo.pimentel@synopsys.com]
> Changes the cdns_pcie_ep_raise_irq function signature, namely the
> interrupt_num variable type from u8 to u16 to accommodate the MSI-X
> maximum interrupts of 2048.
>=20
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/pci/cadence/pcie-cadence-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/cadence/pcie-cadence-ep.c
> b/drivers/pci/cadence/pcie-cadence-ep.c
> index 3d8283e..6d6322c 100644
> --- a/drivers/pci/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/cadence/pcie-cadence-ep.c
> @@ -363,7 +363,7 @@ static int cdns_pcie_ep_send_msi_irq(struct
> cdns_pcie_ep *ep, u8 fn,  }
>=20
>  static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
> -				  enum pci_epc_irq_type type, u8
> interrupt_num)
> +				  enum pci_epc_irq_type type, u16
> interrupt_num)
>  {
>  	struct cdns_pcie_ep *ep =3D epc_get_drvdata(epc);
>=20
> --
> 2.7.4
>=20
Acked-by: Alan Douglas <adouglas@cadence.com>
