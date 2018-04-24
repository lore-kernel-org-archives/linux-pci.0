Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC 01/10] PCI: dwc: Add MSI-X callbacks handler
To: Alan Douglas <adouglas@cadence.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
 <77b7b2687e9618d3f7d1f11c3fc6ecec9a9442ef.1523379766.git.gustavo.pimentel@synopsys.com>
 <SN6PR07MB4512414ADA94E98C0E4EA61DD8880@SN6PR07MB4512.namprd07.prod.outlook.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <57bb52a5-08bd-ef73-5fc3-a5ef327055f5@synopsys.com>
Date: Tue, 24 Apr 2018 12:43:43 +0100
MIME-Version: 1.0
In-Reply-To: <SN6PR07MB4512414ADA94E98C0E4EA61DD8880@SN6PR07MB4512.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 24/04/2018 10:15, Alan Douglas wrote:
> Hi,
> 
> On 10 April 2018 18:15 Gustavo Pimentel wrote:
>> Changes the pcie_raise_irq function signature, namely the interrupt_num
>> variable type from u8 to u16 to accommodate the MSI-X maximum interrupts
>> of 2048.
>>
>> Implements a PCIe config space capability iterator function to search and save
>> the MSI and MSI-X pointers. With this method the code becomes more
>> generic and flexible.
>>
>> Implements MSI-X set/get functions for sysfs interface in order to change the
>> EP entries number.
>>
>> Implements EP MSI-X interface for triggering interruptions.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>>  drivers/pci/dwc/pci-dra7xx.c           |   2 +-
>>  drivers/pci/dwc/pcie-artpec6.c         |   2 +-
>>  drivers/pci/dwc/pcie-designware-ep.c   | 145
>> ++++++++++++++++++++++++++++++++-
>>  drivers/pci/dwc/pcie-designware-plat.c |   6 +-
>>  drivers/pci/dwc/pcie-designware.h      |  23 +++++-
>>  5 files changed, 173 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c index
>> ed8558d..5265725 100644
>> --- a/drivers/pci/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>> @@ -369,7 +369,7 @@ static void dra7xx_pcie_raise_msi_irq(struct
>> dra7xx_pcie *dra7xx,  }
>>
>>  static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>> -				 enum pci_epc_irq_type type, u8
>> interrupt_num)
>> +				 enum pci_epc_irq_type type, u16
>> interrupt_num)
>>  {
>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci); diff --git
>> a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c index
>> e66cede..96dc259 100644
>> --- a/drivers/pci/dwc/pcie-artpec6.c
>> +++ b/drivers/pci/dwc/pcie-artpec6.c
>> @@ -428,7 +428,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep
>> *ep)  }
>>
>>  static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>> -				  enum pci_epc_irq_type type, u8
>> interrupt_num)
>> +				  enum pci_epc_irq_type type, u16
>> interrupt_num)
>>  {
>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>
>> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-
>> designware-ep.c
>> index 15b22a6..874d4c2 100644
>> --- a/drivers/pci/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/dwc/pcie-designware-ep.c
>> @@ -40,6 +40,44 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci,
>> enum pci_barno bar)
>>  	__dw_pcie_ep_reset_bar(pci, bar, 0);
>>  }
>>
>> +void dw_pcie_ep_find_cap_addr(struct dw_pcie_ep *ep) {
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	u8 next_ptr, curr_ptr, cap_id;
>> +	u16 reg;
>> +
>> +	memset(&ep->cap_addr, 0, sizeof(ep->cap_addr));
>> +
>> +	reg = dw_pcie_readw_dbi(pci, PCI_STATUS);
>> +	if (!(reg & PCI_STATUS_CAP_LIST))
>> +		return;
>> +
>> +	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
>> +	next_ptr = (reg & 0x00ff);
>> +	if (!next_ptr)
>> +		return;
>> +
>> +	reg = dw_pcie_readw_dbi(pci, next_ptr);
>> +	curr_ptr = next_ptr;
>> +	next_ptr = (reg & 0xff00) >> 8;
>> +	cap_id = (reg & 0x00ff);
>> +
>> +	while (next_ptr && (cap_id <= PCI_CAP_ID_MAX)) {
>> +		switch (cap_id) {
>> +		case PCI_CAP_ID_MSI:
>> +			ep->cap_addr.msi_addr = curr_ptr;
>> +			break;
>> +		case PCI_CAP_ID_MSIX:
>> +			ep->cap_addr.msix_addr = curr_ptr;
>> +			break;
>> +		}
>> +		reg = dw_pcie_readw_dbi(pci, next_ptr);
>> +		curr_ptr = next_ptr;
>> +		next_ptr = (reg & 0xff00) >> 8;
>> +		cap_id = (reg & 0x00ff);
>> +	}
>> +}
>> +
>>  static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
>>  				   struct pci_epf_header *hdr)
>>  {
>> @@ -241,8 +279,47 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc,
>> u8 func_no, u8 encode_int)
>>  	return 0;
>>  }
>>
>> +static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no) {
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	u32 val, reg;
>> +
>> +	if (ep->cap_addr.msix_addr == 0)
>> +		return 0;
>> +
>> +	reg = ep->cap_addr.msix_addr + PCI_MSIX_FLAGS;
>> +	val = dw_pcie_readw_dbi(pci, reg);
>> +	if (!(val & PCI_MSIX_FLAGS_ENABLE))
>> +		return -EINVAL;
>> +
>> +	val &= PCI_MSIX_FLAGS_QSIZE;
>> +
>> +	return val;
>> +}
>> +
>> +static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16
>> +interrupts) {
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	u32 val, reg;
>> +
>> +	if (ep->cap_addr.msix_addr == 0)
>> +		return 0;
>> +
>> +	reg = ep->cap_addr.msix_addr + PCI_MSIX_FLAGS;
>> +	val = dw_pcie_readw_dbi(pci, reg);
>> +	val &= ~PCI_MSIX_FLAGS_QSIZE;
>> +	val |= interrupts;
>> +	dw_pcie_dbi_ro_wr_en(pci);
>> +	dw_pcie_writew_dbi(pci, reg, val);
>> +	dw_pcie_dbi_ro_wr_dis(pci);
>> +
>> +	return 0;
>> +}
>> +
>>  static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
>> -				enum pci_epc_irq_type type, u8
>> interrupt_num)
>> +				enum pci_epc_irq_type type, u16
>> interrupt_num)
>>  {
>>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>>
>> @@ -282,6 +359,8 @@ static const struct pci_epc_ops epc_ops = {
>>  	.unmap_addr		= dw_pcie_ep_unmap_addr,
>>  	.set_msi		= dw_pcie_ep_set_msi,
>>  	.get_msi		= dw_pcie_ep_get_msi,
>> +	.set_msix		= dw_pcie_ep_set_msix,
>> +	.get_msix		= dw_pcie_ep_get_msix,
>>  	.raise_irq		= dw_pcie_ep_raise_irq,
>>  	.start			= dw_pcie_ep_start,
>>  	.stop			= dw_pcie_ep_stop,
>> @@ -322,6 +401,60 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep
>> *ep, u8 func_no,
>>  	return 0;
>>  }
>>
>> +int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>> +			     u16 interrupt_num)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	struct pci_epc *epc = ep->epc;
>> +	u16 tbl_offset, bir;
>> +	u32 bar_addr_upper, bar_addr_lower;
>> +	u32 msg_addr_upper, msg_addr_lower;
>> +	u32 reg, msg_data;
>> +	u64 tbl_addr, msg_addr, reg_u64;
>> +	void __iomem *msix_tbl;
>> +	int ret;
>> +
>> +	reg = ep->cap_addr.msix_addr + PCI_MSIX_TABLE;
>> +	tbl_offset = dw_pcie_readl_dbi(pci, reg);
>> +	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
>> +	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
>> +	tbl_offset >>= 3;
>> +
>> +	reg = PCI_BASE_ADDRESS_0 + (4 * bir);
>> +	bar_addr_lower = dw_pcie_readl_dbi(pci, reg);
>> +	reg_u64 = (bar_addr_lower & PCI_BASE_ADDRESS_MEM_TYPE_MASK);
>> +	if (reg_u64 == PCI_BASE_ADDRESS_MEM_TYPE_64)
>> +		bar_addr_upper = dw_pcie_readl_dbi(pci, reg + 4);
>> +	else
>> +		bar_addr_upper = 0;
>> +
>> +	tbl_addr = ((u64) bar_addr_upper) << 32 | bar_addr_lower;
>> +	tbl_addr += (tbl_offset + ((interrupt_num - 1) * PCI_MSIX_ENTRY_SIZE));
>> +	tbl_addr &= PCI_BASE_ADDRESS_MEM_MASK;
>> +
>> +	msix_tbl = ioremap_nocache(ep->phys_base + tbl_addr, ep->addr_size);
>> +	if (!msix_tbl)
>> +		return -EINVAL;
>> +
> I think you need to check the mask bit in  vector control for the requested IRQ.
> You could set the pending bit if masked, but would then need some output 
> signal to inform when the mask bit is cleared (or poll it) so the message can be sent
> later.

I have to analyze this careful and with detail to provide you a valid and good
feedback as soon as possible.

> 
> Also, do you need to check PCI_MSIX_FLAGS_ENABLE here as well, or is it checked earlier?

I applied the same logic for MSI-X already implemented before for the MSI.

Before calling the pci_epc_raise_irq(), the number of interrupts is checked by
calling the pci_epc_get_msi() first, which leads to one of
dw_pcie_ep_get_msi()/cdns_pcie_ep_get_msi().

>From what I could see the PCI_MSI_FLAGS_ENABLE/PCI_MSIX_FLAGS_ENABLE flags are
check on the dw_pcie_ep_get_msi()/dw_pcie_ep_get_msix() funcitons, the same
logic is applied on cdns_pcie_ep_get_msi().

> 
> Regards,
> Alan
> 
