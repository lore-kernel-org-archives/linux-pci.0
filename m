Return-Path: <SRS0=KvoV=6P=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=KvoV=6P=codeaurora.org=okaya@kernel.org>
Subject: Re: PCI/DPC: Add eDPC support
To: Dongdong Liu <liudongdong3@huawei.com>, helgaas@kernel.org
Cc: linux-pci@vger.kernel.org, gabriele.paoloni@huawei.com,
 charles.chenxin@huawei.com, linuxarm@huawei.com
References: <1498295066-87895-1-git-send-email-liudongdong3@huawei.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <c718120c-c8ec-0866-db6f-7ac0ac3af5ac@codeaurora.org>
Date: Wed, 12 Jul 2017 16:52:00 -0400
MIME-Version: 1.0
In-Reply-To: <1498295066-87895-1-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 6/24/2017 5:04 AM, Dongdong Liu wrote:
> This code is to add eDPC support. Get and print the RP PIO error
> information when the trigger condition is RP PIO error.
> 
> For more information on eDPC, view the PCI-SIG eDPC ECN here:
> https://pcisig.com/sites/default/files/specification_documents/ECN_Enhanced_DPC_2012-11-19_final.pdf
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> ---
>  drivers/pci/pcie/pcie-dpc.c   | 161 ++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |  10 +++
>  2 files changed, 171 insertions(+)
> 
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index 77d2ca9..00fdf87 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -16,11 +16,55 @@
>  #include <linux/pcieport_if.h>
>  #include "../pci.h">  

<snip>

> +static void dpc_rp_pio_get_info(struct dpc_dev *dpc)
> +{
> +	struct pci_dev *pdev = dpc->dev->port;
> +	struct dpc_rp_pio_regs *rp_pio = dpc->rp_pio;
> +	int i;
> +	u16 cap;
> +	u16 status;
> +
> +	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_STATUS,
> +			      &rp_pio->status);
> +	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_MASK,
> +			      &rp_pio->mask);
> +
> +	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_SEVERITY,
> +			      &rp_pio->severity);
> +	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_SYSERROR,
> +			      &rp_pio->syserror);
> +	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_EXCEPTION,
> +			      &rp_pio->exception);
> +
> +	/* Get First Error Pointer */
> +	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
> +	rp_pio->first_error = (status & 0x1f00) >> 8;
> +
> +	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
> +	rp_pio->log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
> +	if (rp_pio->log_size < 4 || rp_pio->log_size > 9) {
> +		dev_err(&pdev->dev, "RP PIO log size %u is invaild\n",
> +			rp_pio->log_size);
> +		return;
> +	}
> +
> +	pci_read_config_dword(pdev,
> +			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
> +			      &rp_pio->header_log.dw0);
> +	pci_read_config_dword(pdev,
> +			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 4,
> +			      &rp_pio->header_log.dw1);
> +	pci_read_config_dword(pdev,
> +			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 8,
> +			      &rp_pio->header_log.dw2);
> +	pci_read_config_dword(pdev,
> +			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 12,
> +			      &rp_pio->header_log.dw3);
> +	if (rp_pio->log_size == 4)
> +		return;
> +
> +	pci_read_config_dword(pdev,
> +			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG,
> +			      &rp_pio->impspec_log);
> +	for (i = 0; i < rp_pio->log_size - 5; i++)
> +		pci_read_config_dword(pdev,
> +			dpc->cap_pos + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
> +			&rp_pio->tlp_prefix_log[i]);
> +}
> +
> +static void dpc_precess_rp_pio_error(struct dpc_dev *dpc)
> +{

Why not have a stack local variable where you collect the information
on the first function and print it on the second function.

What benefit the allocated memory brings?

> +	dpc_rp_pio_get_info(dpc);
> +	dpc_rp_pio_print_error(dpc);
> +}
> +

> @@ -144,6 +299,12 @@ static int dpc_probe(struct pcie_device *dev)
>  
>  	dpc->rp = (cap & PCI_EXP_DPC_CAP_RP_EXT);
>  
> +	if (dpc->rp) {
> +		dpc->rp_pio = devm_kzalloc(&pdev->dev, sizeof(*dpc->rp_pio),
> +					   GFP_KERNEL);
> +		if (!dpc->rp_pio)
> +			return -ENOMEM;
> +	}
>  	ctl |= PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
>  	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
>  

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
