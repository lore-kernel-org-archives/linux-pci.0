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
Subject: RE: [RFC 01/10] PCI: dwc: Add MSI-X callbacks handler
Date: Tue, 24 Apr 2018 09:15:00 +0000
Message-ID: <SN6PR07MB4512414ADA94E98C0E4EA61DD8880@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
 <77b7b2687e9618d3f7d1f11c3fc6ecec9a9442ef.1523379766.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <77b7b2687e9618d3f7d1f11c3fc6ecec9a9442ef.1523379766.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 10 April 2018 18:15 Gustavo Pimentel wrote:
> Changes the pcie_raise_irq function signature, namely the interrupt_num
> variable type from u8 to u16 to accommodate the MSI-X maximum interrupts
> of 2048.
>=20
> Implements a PCIe config space capability iterator function to search and=
 save
> the MSI and MSI-X pointers. With this method the code becomes more
> generic and flexible.
>=20
> Implements MSI-X set/get functions for sysfs interface in order to change=
 the
> EP entries number.
>=20
> Implements EP MSI-X interface for triggering interruptions.
>=20
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c           |   2 +-
>  drivers/pci/dwc/pcie-artpec6.c         |   2 +-
>  drivers/pci/dwc/pcie-designware-ep.c   | 145
> ++++++++++++++++++++++++++++++++-
>  drivers/pci/dwc/pcie-designware-plat.c |   6 +-
>  drivers/pci/dwc/pcie-designware.h      |  23 +++++-
>  5 files changed, 173 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c =
index
> ed8558d..5265725 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -369,7 +369,7 @@ static void dra7xx_pcie_raise_msi_irq(struct
> dra7xx_pcie *dra7xx,  }
>=20
>  static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				 enum pci_epc_irq_type type, u8
> interrupt_num)
> +				 enum pci_epc_irq_type type, u16
> interrupt_num)
>  {
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	struct dra7xx_pcie *dra7xx =3D to_dra7xx_pcie(pci); diff --git
> a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c index
> e66cede..96dc259 100644
> --- a/drivers/pci/dwc/pcie-artpec6.c
> +++ b/drivers/pci/dwc/pcie-artpec6.c
> @@ -428,7 +428,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep
> *ep)  }
>=20
>  static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				  enum pci_epc_irq_type type, u8
> interrupt_num)
> +				  enum pci_epc_irq_type type, u16
> interrupt_num)
>  {
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>=20
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-
> designware-ep.c
> index 15b22a6..874d4c2 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -40,6 +40,44 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci,
> enum pci_barno bar)
>  	__dw_pcie_ep_reset_bar(pci, bar, 0);
>  }
>=20
> +void dw_pcie_ep_find_cap_addr(struct dw_pcie_ep *ep) {
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +	u8 next_ptr, curr_ptr, cap_id;
> +	u16 reg;
> +
> +	memset(&ep->cap_addr, 0, sizeof(ep->cap_addr));
> +
> +	reg =3D dw_pcie_readw_dbi(pci, PCI_STATUS);
> +	if (!(reg & PCI_STATUS_CAP_LIST))
> +		return;
> +
> +	reg =3D dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
> +	next_ptr =3D (reg & 0x00ff);
> +	if (!next_ptr)
> +		return;
> +
> +	reg =3D dw_pcie_readw_dbi(pci, next_ptr);
> +	curr_ptr =3D next_ptr;
> +	next_ptr =3D (reg & 0xff00) >> 8;
> +	cap_id =3D (reg & 0x00ff);
> +
> +	while (next_ptr && (cap_id <=3D PCI_CAP_ID_MAX)) {
> +		switch (cap_id) {
> +		case PCI_CAP_ID_MSI:
> +			ep->cap_addr.msi_addr =3D curr_ptr;
> +			break;
> +		case PCI_CAP_ID_MSIX:
> +			ep->cap_addr.msix_addr =3D curr_ptr;
> +			break;
> +		}
> +		reg =3D dw_pcie_readw_dbi(pci, next_ptr);
> +		curr_ptr =3D next_ptr;
> +		next_ptr =3D (reg & 0xff00) >> 8;
> +		cap_id =3D (reg & 0x00ff);
> +	}
> +}
> +
>  static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
>  				   struct pci_epf_header *hdr)
>  {
> @@ -241,8 +279,47 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc,
> u8 func_no, u8 encode_int)
>  	return 0;
>  }
>=20
> +static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no) {
> +	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +	u32 val, reg;
> +
> +	if (ep->cap_addr.msix_addr =3D=3D 0)
> +		return 0;
> +
> +	reg =3D ep->cap_addr.msix_addr + PCI_MSIX_FLAGS;
> +	val =3D dw_pcie_readw_dbi(pci, reg);
> +	if (!(val & PCI_MSIX_FLAGS_ENABLE))
> +		return -EINVAL;
> +
> +	val &=3D PCI_MSIX_FLAGS_QSIZE;
> +
> +	return val;
> +}
> +
> +static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16
> +interrupts) {
> +	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +	u32 val, reg;
> +
> +	if (ep->cap_addr.msix_addr =3D=3D 0)
> +		return 0;
> +
> +	reg =3D ep->cap_addr.msix_addr + PCI_MSIX_FLAGS;
> +	val =3D dw_pcie_readw_dbi(pci, reg);
> +	val &=3D ~PCI_MSIX_FLAGS_QSIZE;
> +	val |=3D interrupts;
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	dw_pcie_writew_dbi(pci, reg, val);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	return 0;
> +}
> +
>  static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
> -				enum pci_epc_irq_type type, u8
> interrupt_num)
> +				enum pci_epc_irq_type type, u16
> interrupt_num)
>  {
>  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>=20
> @@ -282,6 +359,8 @@ static const struct pci_epc_ops epc_ops =3D {
>  	.unmap_addr		=3D dw_pcie_ep_unmap_addr,
>  	.set_msi		=3D dw_pcie_ep_set_msi,
>  	.get_msi		=3D dw_pcie_ep_get_msi,
> +	.set_msix		=3D dw_pcie_ep_set_msix,
> +	.get_msix		=3D dw_pcie_ep_get_msix,
>  	.raise_irq		=3D dw_pcie_ep_raise_irq,
>  	.start			=3D dw_pcie_ep_start,
>  	.stop			=3D dw_pcie_ep_stop,
> @@ -322,6 +401,60 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep
> *ep, u8 func_no,
>  	return 0;
>  }
>=20
> +int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> +			     u16 interrupt_num)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +	struct pci_epc *epc =3D ep->epc;
> +	u16 tbl_offset, bir;
> +	u32 bar_addr_upper, bar_addr_lower;
> +	u32 msg_addr_upper, msg_addr_lower;
> +	u32 reg, msg_data;
> +	u64 tbl_addr, msg_addr, reg_u64;
> +	void __iomem *msix_tbl;
> +	int ret;
> +
> +	reg =3D ep->cap_addr.msix_addr + PCI_MSIX_TABLE;
> +	tbl_offset =3D dw_pcie_readl_dbi(pci, reg);
> +	bir =3D (tbl_offset & PCI_MSIX_TABLE_BIR);
> +	tbl_offset &=3D PCI_MSIX_TABLE_OFFSET;
> +	tbl_offset >>=3D 3;
> +
> +	reg =3D PCI_BASE_ADDRESS_0 + (4 * bir);
> +	bar_addr_lower =3D dw_pcie_readl_dbi(pci, reg);
> +	reg_u64 =3D (bar_addr_lower & PCI_BASE_ADDRESS_MEM_TYPE_MASK);
> +	if (reg_u64 =3D=3D PCI_BASE_ADDRESS_MEM_TYPE_64)
> +		bar_addr_upper =3D dw_pcie_readl_dbi(pci, reg + 4);
> +	else
> +		bar_addr_upper =3D 0;
> +
> +	tbl_addr =3D ((u64) bar_addr_upper) << 32 | bar_addr_lower;
> +	tbl_addr +=3D (tbl_offset + ((interrupt_num - 1) * PCI_MSIX_ENTRY_SIZE)=
);
> +	tbl_addr &=3D PCI_BASE_ADDRESS_MEM_MASK;
> +
> +	msix_tbl =3D ioremap_nocache(ep->phys_base + tbl_addr, ep->addr_size);
> +	if (!msix_tbl)
> +		return -EINVAL;
> +
I think you need to check the mask bit in  vector control for the requested=
 IRQ.
You could set the pending bit if masked, but would then need some output=20
signal to inform when the mask bit is cleared (or poll it) so the message c=
an be sent
later.

Also, do you need to check PCI_MSIX_FLAGS_ENABLE here as well, or is it che=
cked earlier?

Regards,
Alan
