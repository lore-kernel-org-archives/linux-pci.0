Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:50550 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752428AbdL2JXw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Dec 2017 04:23:52 -0500
Subject: Re: [PATCH v2 7/9] PCI: endpoint: Add the function number as argument
 to EPC ops
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
 <425171aaba3a9e8ea68b9e94f37b1c97e8cf9861.1513620412.git.cyrille.pitchen@free-electrons.com>
CC: <adouglas@cadence.com>, <stelford@cadence.com>,
        <dgary@cadence.com>, <kgopi@cadence.com>, <eandrews@cadence.com>,
        <thomas.petazzoni@free-electrons.com>, <sureshp@cadence.com>,
        <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ca8f5a74-3db5-87f4-3af5-ed5ee0d3b634@ti.com>
Date: Fri, 29 Dec 2017 14:53:37 +0530
MIME-Version: 1.0
In-Reply-To: <425171aaba3a9e8ea68b9e94f37b1c97e8cf9861.1513620412.git.cyrille.pitchen@free-electrons.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Monday 18 December 2017 11:46 PM, Cyrille Pitchen wrote:
> This patch updates the prototype of most handlers from 'struct
> pci_epc_ops' so the EPC library can now support multi-function devices.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> ---
>  drivers/pci/dwc/pcie-designware-ep.c          | 20 +++++----
>  drivers/pci/endpoint/functions/pci-epf-test.c | 41 ++++++++++--------
>  drivers/pci/endpoint/pci-epc-core.c           | 62 ++++++++++++++++-----------
>  include/linux/pci-epc.h                       | 43 +++++++++++--------
>  4 files changed, 96 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index d53d5f168363..7a573d8bb62d 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -39,7 +39,7 @@ static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>  	dw_pcie_writel_dbi(pci, reg, 0x0);
>  }
>  
> -static int dw_pcie_ep_write_header(struct pci_epc *epc,
> +static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
>  				   struct pci_epf_header *hdr)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> @@ -112,7 +112,8 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, phys_addr_t phys_addr,
>  	return 0;
>  }
>  
> -static void dw_pcie_ep_clear_bar(struct pci_epc *epc, enum pci_barno bar)
> +static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no,
> +				 enum pci_barno bar)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -124,7 +125,8 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, enum pci_barno bar)
>  	clear_bit(atu_index, &ep->ib_window_map);
>  }
>  
> -static int dw_pcie_ep_set_bar(struct pci_epc *epc, enum pci_barno bar,
> +static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
> +			      enum pci_barno bar,
>  			      dma_addr_t bar_phys, size_t size, int flags)
>  {
>  	int ret;
> @@ -163,7 +165,8 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
>  	return -EINVAL;
>  }
>  
> -static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, phys_addr_t addr)
> +static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no,
> +				  phys_addr_t addr)
>  {
>  	int ret;
>  	u32 atu_index;
> @@ -178,7 +181,8 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, phys_addr_t addr)
>  	clear_bit(atu_index, &ep->ob_window_map);
>  }
>  
> -static int dw_pcie_ep_map_addr(struct pci_epc *epc, phys_addr_t addr,
> +static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
> +			       phys_addr_t addr,
>  			       u64 pci_addr, size_t size)
>  {
>  	int ret;
> @@ -194,7 +198,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, phys_addr_t addr,
>  	return 0;
>  }
>  
> -static int dw_pcie_ep_get_msi(struct pci_epc *epc)
> +static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no)
>  {
>  	int val;
>  	u32 lower_addr;
> @@ -214,7 +218,7 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc)
>  	return val;
>  }
>  
> -static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 encode_int)
> +static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 encode_int)
>  {
>  	int val;
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> @@ -226,7 +230,7 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 encode_int)
>  	return 0;
>  }
>  
> -static int dw_pcie_ep_raise_irq(struct pci_epc *epc,
> +static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
>  				enum pci_epc_irq_type type, u8 interrupt_num)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index f9308c2f22e6..7bacca8daec6 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -104,7 +104,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  		goto err;
>  	}
>  
> -	ret = pci_epc_map_addr(epc, src_phys_addr, reg->src_addr, reg->size);
> +	ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, reg->src_addr,
> +			       reg->size);
>  	if (ret) {
>  		dev_err(dev, "failed to map source address\n");
>  		reg->status = STATUS_SRC_ADDR_INVALID;
> @@ -119,7 +120,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  		goto err_src_map_addr;
>  	}
>  
> -	ret = pci_epc_map_addr(epc, dst_phys_addr, reg->dst_addr, reg->size);
> +	ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, reg->dst_addr,
> +			       reg->size);
>  	if (ret) {
>  		dev_err(dev, "failed to map destination address\n");
>  		reg->status = STATUS_DST_ADDR_INVALID;
> @@ -128,13 +130,13 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  
>  	memcpy(dst_addr, src_addr, reg->size);
>  
> -	pci_epc_unmap_addr(epc, dst_phys_addr);
> +	pci_epc_unmap_addr(epc, epf->func_no, dst_phys_addr);
>  
>  err_dst_addr:
>  	pci_epc_mem_free_addr(epc, dst_phys_addr, dst_addr, reg->size);
>  
>  err_src_map_addr:
> -	pci_epc_unmap_addr(epc, src_phys_addr);
> +	pci_epc_unmap_addr(epc, epf->func_no, src_phys_addr);
>  
>  err_src_addr:
>  	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
> @@ -164,7 +166,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  		goto err;
>  	}
>  
> -	ret = pci_epc_map_addr(epc, phys_addr, reg->src_addr, reg->size);
> +	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->src_addr,
> +			       reg->size);
>  	if (ret) {
>  		dev_err(dev, "failed to map address\n");
>  		reg->status = STATUS_SRC_ADDR_INVALID;
> @@ -186,7 +189,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  	kfree(buf);
>  
>  err_map_addr:
> -	pci_epc_unmap_addr(epc, phys_addr);
> +	pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
>  
>  err_addr:
>  	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
> @@ -215,7 +218,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  		goto err;
>  	}
>  
> -	ret = pci_epc_map_addr(epc, phys_addr, reg->dst_addr, reg->size);
> +	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->dst_addr,
> +			       reg->size);
>  	if (ret) {
>  		dev_err(dev, "failed to map address\n");
>  		reg->status = STATUS_DST_ADDR_INVALID;
> @@ -242,7 +246,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  	kfree(buf);
>  
>  err_map_addr:
> -	pci_epc_unmap_addr(epc, phys_addr);
> +	pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
>  
>  err_addr:
>  	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
> @@ -260,11 +264,11 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq)
>  	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>  
>  	reg->status |= STATUS_IRQ_RAISED;
> -	msi_count = pci_epc_get_msi(epc);
> +	msi_count = pci_epc_get_msi(epc, epf->func_no);
>  	if (irq > msi_count || msi_count <= 0)
> -		pci_epc_raise_irq(epc, PCI_EPC_IRQ_LEGACY, 0);
> +		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_LEGACY, 0);
>  	else
> -		pci_epc_raise_irq(epc, PCI_EPC_IRQ_MSI, irq);
> +		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI, irq);
>  }
>  
>  static void pci_epf_test_cmd_handler(struct work_struct *work)
> @@ -291,7 +295,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  
>  	if (command & COMMAND_RAISE_LEGACY_IRQ) {
>  		reg->status = STATUS_IRQ_RAISED;
> -		pci_epc_raise_irq(epc, PCI_EPC_IRQ_LEGACY, 0);
> +		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_LEGACY, 0);
>  		goto reset_handler;
>  	}
>  
> @@ -326,11 +330,11 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	}
>  
>  	if (command & COMMAND_RAISE_MSI_IRQ) {
> -		msi_count = pci_epc_get_msi(epc);
> +		msi_count = pci_epc_get_msi(epc, epf->func_no);
>  		if (irq > msi_count || msi_count <= 0)
>  			goto reset_handler;
>  		reg->status = STATUS_IRQ_RAISED;
> -		pci_epc_raise_irq(epc, PCI_EPC_IRQ_MSI, irq);
> +		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI, irq);
>  		goto reset_handler;
>  	}
>  
> @@ -358,7 +362,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
>  		if (epf_test->reg[bar]) {
>  			pci_epf_free_space(epf, epf_test->reg[bar], bar);
> -			pci_epc_clear_bar(epc, bar);
> +			pci_epc_clear_bar(epc, epf->func_no, bar);
>  		}
>  	}
>  }
> @@ -380,7 +384,8 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  
>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
>  		epf_bar = &epf->bar[bar];
> -		ret = pci_epc_set_bar(epc, bar, epf_bar->phys_addr,
> +		ret = pci_epc_set_bar(epc, epf->func_no, bar,
> +				      epf_bar->phys_addr,
>  				      epf_bar->size, flags);
>  		if (ret) {
>  			pci_epf_free_space(epf, epf_test->reg[bar], bar);
> @@ -433,7 +438,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	if (WARN_ON_ONCE(!epc))
>  		return -EINVAL;
>  
> -	ret = pci_epc_write_header(epc, header);
> +	ret = pci_epc_write_header(epc, epf->func_no, header);
>  	if (ret) {
>  		dev_err(dev, "configuration header write failed\n");
>  		return ret;
> @@ -447,7 +452,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	if (ret)
>  		return ret;
>  
> -	ret = pci_epc_set_msi(epc, epf->msi_interrupts);
> +	ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index cd7d4788b94d..77420364a728 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -141,25 +141,26 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
>  /**
>   * pci_epc_raise_irq() - interrupt the host system
>   * @epc: the EPC device which has to interrupt the host
> + * @func_no: the endpoint function number in the EPC device
>   * @type: specify the type of interrupt; legacy or MSI
>   * @interrupt_num: the MSI interrupt number
>   *
>   * Invoke to raise an MSI or legacy interrupt
>   */
> -int pci_epc_raise_irq(struct pci_epc *epc, enum pci_epc_irq_type type,
> -		      u8 interrupt_num)
> +int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
> +		      enum pci_epc_irq_type type, u8 interrupt_num)
>  {
>  	int ret;
>  	unsigned long flags;
>  
> -	if (IS_ERR(epc))
> +	if (IS_ERR(epc) || func_no > BAR_5)

why is function number compared with BAR? here and everywhere below..

Thanks
Kishon
