Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] PCI: dwc: Add MSI-X callbacks handler
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1526576613.git.gustavo.pimentel@synopsys.com>
 <24e9cdc20d57aaea0bcb62879824c57004df46c9.1526576613.git.gustavo.pimentel@synopsys.com>
 <758acd51-a36a-ae68-2e28-5ce184707dda@ti.com>
From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <0759e266-505f-41cc-5213-eabbff2512ad@synopsys.com>
Date: Fri, 1 Jun 2018 12:05:13 +0100
MIME-Version: 1.0
In-Reply-To: <758acd51-a36a-ae68-2e28-5ce184707dda@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 31/05/2018 11:49, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Thursday 17 May 2018 10:39 PM, Gustavo Pimentel wrote:
>> Change pcie_raise_irq() signature, namely the interrupt_num variable type
>> from u8 to u16 to accommodate 2048 maximum MSI-X interrupts.
>>
>> Add PCIe config space capability search function.
>>
>> Add sysfs set/get interface to allow the change of EP MSI-X maximum number.
>>
>> Add EP MSI-X callback for triggering interruptions.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Change v1->v2:
>>  - Nothing changed, just to follow the patch set version.
>>
>>  drivers/pci/dwc/pci-dra7xx.c           |   2 +-
>>  drivers/pci/dwc/pcie-artpec6.c         |   2 +-
>>  drivers/pci/dwc/pcie-designware-ep.c   | 146 ++++++++++++++++++++++++++++++++-
>>  drivers/pci/dwc/pcie-designware-plat.c |   4 +-
>>  drivers/pci/dwc/pcie-designware.h      |  14 +++-
>>  5 files changed, 163 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
>> index f688204..bdf948b 100644
>> --- a/drivers/pci/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>> @@ -370,7 +370,7 @@ static void dra7xx_pcie_raise_msi_irq(struct dra7xx_pcie *dra7xx,
>>  }
>>  
>>  static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>> -				 enum pci_epc_irq_type type, u8 interrupt_num)
>> +				 enum pci_epc_irq_type type, u16 interrupt_num)
>>  {
>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
>> diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
>> index 321b56c..9a2474b 100644
>> --- a/drivers/pci/dwc/pcie-artpec6.c
>> +++ b/drivers/pci/dwc/pcie-artpec6.c
>> @@ -428,7 +428,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
>>  }
>>  
>>  static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>> -				  enum pci_epc_irq_type type, u8 interrupt_num)
>> +				  enum pci_epc_irq_type type, u16 interrupt_num)
>>  {
>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> 
> I think you should change pci_epc_raise_irq (in previous patch) and the above
> two changes in a separate patch. You can also include pcie-cadence-ep.c along
> with that.

Ok.

>>  
>> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
>> index 1eec441..e5f2377 100644
>> --- a/drivers/pci/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/dwc/pcie-designware-ep.c
>> @@ -40,6 +40,39 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>>  	__dw_pcie_ep_reset_bar(pci, bar, 0);
>>  }
>>  
>> +u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>> +			      u8 cap)
>> +{
>> +	u8 cap_id, next_cap_ptr;
>> +	u16 reg;
>> +
>> +	reg = dw_pcie_readw_dbi(pci, cap_ptr);
>> +	next_cap_ptr = (reg & 0xff00) >> 8;
>> +	cap_id = (reg & 0x00ff);
>> +
>> +	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
>> +		return 0;
>> +
>> +	if (cap_id == cap)
>> +		return cap_ptr;
>> +
>> +	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>> +}
>> +
>> +u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
>> +{
>> +	u8 next_cap_ptr;
>> +	u16 reg;
>> +
>> +	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
>> +	next_cap_ptr = (reg & 0x00ff);
>> +
>> +	if (!next_cap_ptr)
>> +		return 0;
>> +
>> +	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>> +}
>> +
>>  static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
>>  				   struct pci_epf_header *hdr)
>>  {
>> @@ -241,8 +274,47 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 encode_int)
>>  	return 0;
>>  }
>>  
>> +static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
>> +{
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	u32 val, reg;
>> +
>> +	if (!ep->msix_cap)
>> +		return 0;
> 
> return -EINVAL?

Definitely yes. Well spotted!

> 
> or pci_epc_get_msix() will return 1.
>> +
>> +	reg = ep->msix_cap + PCI_MSIX_FLAGS;
>> +	val = dw_pcie_readw_dbi(pci, reg);
>> +	if (!(val & PCI_MSIX_FLAGS_ENABLE))
>> +		return -EINVAL;
>> +
>> +	val &= PCI_MSIX_FLAGS_QSIZE;
>> +
>> +	return val;
>> +}
>> +
>> +static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
>> +{
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	u32 val, reg;
>> +
>> +	if (!ep->msix_cap)
>> +		return 0;
> 
> here too return -EINVAL.

A copy & paste bug :)

>> +
>> +	reg = ep->msix_cap + PCI_MSIX_FLAGS;
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
>> -				enum pci_epc_irq_type type, u8 interrupt_num)
>> +				enum pci_epc_irq_type type, u16 interrupt_num)
>>  {
>>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>>  
>> @@ -282,6 +354,8 @@ static const struct pci_epc_ops epc_ops = {
>>  	.unmap_addr		= dw_pcie_ep_unmap_addr,
>>  	.set_msi		= dw_pcie_ep_set_msi,
>>  	.get_msi		= dw_pcie_ep_get_msi,
>> +	.set_msix		= dw_pcie_ep_set_msix,
>> +	.get_msix		= dw_pcie_ep_get_msix,
>>  	.raise_irq		= dw_pcie_ep_raise_irq,
>>  	.start			= dw_pcie_ep_start,
>>  	.stop			= dw_pcie_ep_stop,
>> @@ -322,6 +396,64 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
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
>> +	u32 reg, msg_data, vec_ctrl;
>> +	u64 tbl_addr, msg_addr, reg_u64;
>> +	void __iomem *msix_tbl;
>> +	int ret;
>> +
>> +	reg = ep->msix_cap + PCI_MSIX_TABLE;
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
> 
> You can skip else if you can use something like below>
> bar_addr_upper = 0
> bar_addr_lower = dw_pcie_readl_dbi(pci, reg);
> reg_u64 = (bar_addr_lower & PCI_BASE_ADDRESS_MEM_TYPE_MASK);
> if (reg_u64 == PCI_BASE_ADDRESS_MEM_TYPE_64)
> 	bar_addr_upper = dw_pcie_readl_dbi(pci, reg + 4);

Sure.

>> +
>> +	tbl_addr = ((u64) bar_addr_upper) << 32 | bar_addr_lower;
>> +	tbl_addr += (tbl_offset + ((interrupt_num - 1) * PCI_MSIX_ENTRY_SIZE));
>> +	tbl_addr &= PCI_BASE_ADDRESS_MEM_MASK;
>> +
>> +	msix_tbl = ioremap_nocache(ep->phys_base + tbl_addr, ep->addr_size);
> 
> Why do you want to ioremap the entire address region?

Hum, this was from my initial tests...
I guess, I could limit it to the MSIX entry size (PCI_MSIX_ENTRY_SIZE).

>> +	if (!msix_tbl)
>> +		return -EINVAL;
>> +
>> +	msg_addr_lower = readl(msix_tbl + PCI_MSIX_ENTRY_LOWER_ADDR);
>> +	msg_addr_upper = readl(msix_tbl + PCI_MSIX_ENTRY_UPPER_ADDR);
>> +	msg_addr = ((u64) msg_addr_upper) << 32 | msg_addr_lower;
>> +	msg_data = readl(msix_tbl + PCI_MSIX_ENTRY_DATA);
>> +	vec_ctrl = readl(msix_tbl + PCI_MSIX_ENTRY_VECTOR_CTRL);
>> +
>> +	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT)
>> +		return -EPERM;
>> +
>> +	iounmap(msix_tbl);

I noticed now this bug... The ioumap should be above the if.

>> +
>> +	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msix_mem_phys, msg_addr,
>> +				  epc->mem->page_size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	writel(msg_data, ep->msix_mem);
>> +
>> +	dw_pcie_ep_unmap_addr(epc, func_no, ep->msix_mem_phys);
>> +
>> +	return 0;
>> +}
>> +
>>  void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>>  {
>>  	struct pci_epc *epc = ep->epc;
>> @@ -329,6 +461,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>>  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
>>  			      epc->mem->page_size);
>>  
>> +	pci_epc_mem_free_addr(epc, ep->msix_mem_phys, ep->msix_mem,
>> +			      epc->mem->page_size);
>> +
>>  	pci_epc_mem_exit(epc);
>>  }
>>  
>> @@ -410,6 +545,15 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>  		dev_err(dev, "Failed to reserve memory for MSI\n");
>>  		return -ENOMEM;
>>  	}
>> +	ep->msi_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSI);
> 
> msi_cap is not used anywhere else.
> 
> Thanks
> Kishon
> 
