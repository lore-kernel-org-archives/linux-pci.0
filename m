Return-Path: <SRS0=e0LY=EZ=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=e0LY=EZ=codeaurora.org=okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 29 Jan 2018 19:42:54 -0500
From: okaya@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org, Dongdong
 Liu <liudongdong3@huawei.com>, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH 6/8] PCI/DPC: Consolidate RP PIO get/print functions
In-Reply-To: <20180126225622.58614.24127.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180126225043.58614.99920.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180126225622.58614.24127.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <51b6a3709f193727d85e08cee97c4133@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-26 17:56, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously we defined a structure for RP PIO log information, allocated 
> it
> on the stack, called one function to fill it in from DPC registers, and
> called another to print it out.
> 
> Simplify this by dropping the structure and printing the error 
> information
> as soon as we read it from the DPC capability.  This way we don't need 
> a
> structure, there's one function instead of four, and everything we do 
> with
> the register information is in one place instead of being split between
> functions.
> 
> No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/pcie-dpc.c |  132 
> +++++++++++++------------------------------
>  1 file changed, 39 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index a6b8d1496322..06d3af112580 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -17,26 +17,6 @@
>  #include "../pci.h"
>  #include "aer/aerdrv.h"
> 
> -struct rp_pio_header_log_regs {
> -	u32 dw0;
> -	u32 dw1;
> -	u32 dw2;
> -	u32 dw3;
> -};
> -
> -struct dpc_rp_pio_regs {
> -	u32 status;
> -	u32 mask;
> -	u32 severity;
> -	u32 syserror;
> -	u32 exception;
> -
> -	struct rp_pio_header_log_regs header_log;
> -	u32 impspec_log;
> -	u32 tlp_prefix_log[4];
> -	u16 first_error;
> -};
> -
>  struct dpc_dev {
>  	struct pcie_device	*dev;
>  	struct work_struct	work;
> @@ -142,100 +122,66 @@ static void dpc_work(struct work_struct *work)
>  			      ctl | PCI_EXP_DPC_CTL_INT_EN);
>  }
> 
> -static void dpc_rp_pio_print_tlp_header(struct device *dev,
> -					struct rp_pio_header_log_regs *t)
> -{
> -	dev_err(dev, "TLP Header: %#010x %#010x %#010x %#010x\n",
> -		t->dw0, t->dw1, t->dw2, t->dw3);
> -}
> -
> -static void dpc_rp_pio_print_error(struct dpc_dev *dpc,
> -				   struct dpc_rp_pio_regs *rp_pio)
> +static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>  {
>  	struct device *dev = &dpc->dev->device;
> +	struct pci_dev *pdev = dpc->dev->port;
> +	u16 cap = dpc->cap_pos;
> +	u32 status, mask;
> +	u32 sev, syserr, exc;
> +	u16 dpc_status, first_error;
>  	int i;
> -	u32 status;
> +	u32 dw0, dw1, dw2, dw3;
> +	u32 log;
> +	u32 prefix;
> 
> +	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, 
> &status);
> +	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_MASK, &mask);
>  	dev_err(dev, "rp_pio_status: %#010x, rp_pio_mask: %#010x\n",
> -		rp_pio->status, rp_pio->mask);
> +		status, mask);
> 
> +	dpc->rp_pio_status = status;
> +
> +	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SEVERITY, &sev);
> +	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SYSERROR, 
> &syserr);
> +	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_EXCEPTION, 
> &exc);
>  	dev_err(dev, "RP PIO severity=%#010x, syserror=%#010x, 
> exception=%#010x\n",
> -		rp_pio->severity, rp_pio->syserror, rp_pio->exception);
> +		sev, syserr, exc);
> 
> -	status = (rp_pio->status & ~rp_pio->mask);
> +	/* Get First Error Pointer */
> +	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &dpc_status);
> +	first_error = (dpc_status & 0x1f00) >> 8;

This didn't look like a simple change here.

> 
> +	status &= ~mask;
>  	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
> -		if (!(status & (1 << i)))
> -			continue;
> -
> -		dev_err(dev, "[%2d] %s%s\n", i, rp_pio_error_string[i],
> -			rp_pio->first_error == i ? " (First)" : "");
> +		if (status & (1 << i))
> +			dev_err(dev, "[%2d] %s%s\n", i, rp_pio_error_string[i],
> +				first_error == i ? " (First)" : "");
>  	}
> 
> -	dpc_rp_pio_print_tlp_header(dev, &rp_pio->header_log);
> -	if (dpc->rp_log_size == 4)
> -		return;
> -
> -	dev_err(dev, "RP PIO ImpSpec Log %#010x\n", rp_pio->impspec_log);
> -
> -	for (i = 0; i < dpc->rp_log_size - 5; i++)
> -		dev_err(dev, "TLP Prefix Header: dw%d, %#010x\n", i,
> -			rp_pio->tlp_prefix_log[i]);
> -}
> -
> -static void dpc_rp_pio_get_info(struct dpc_dev *dpc,
> -				struct dpc_rp_pio_regs *rp_pio)
> -{
> -	struct pci_dev *pdev = dpc->dev->port;
> -	int i;
> -	u16 cap = dpc->cap_pos, status;
> -
> -	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
> -			      &rp_pio->status);
> -	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_MASK,
> -			      &rp_pio->mask);
> -
> -	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SEVERITY,
> -			      &rp_pio->severity);
> -	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SYSERROR,
> -			      &rp_pio->syserror);
> -	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_EXCEPTION,
> -			      &rp_pio->exception);
> -
> -	/* Get First Error Pointer */
> -	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> -	rp_pio->first_error = (status & 0x1f00) >> 8;
> -
>  	if (dpc->rp_log_size < 4)
>  		return;
> -
>  	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
> -			      &rp_pio->header_log.dw0);
> +			      &dw0);
>  	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 4,
> -			      &rp_pio->header_log.dw1);
> +			      &dw1);
>  	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 8,
> -			      &rp_pio->header_log.dw2);
> +			      &dw2);
>  	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 12,
> -			      &rp_pio->header_log.dw3);
> -	if (dpc->rp_log_size == 4)
> +			      &dw3);
> +	dev_err(dev, "TLP Header: %#010x %#010x %#010x %#010x\n",
> +		dw0, dw1, dw2, dw3);
> +
> +	if (dpc->rp_log_size < 5)
>  		return;
> +	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG, 
> &log);
> +	dev_err(dev, "RP PIO ImpSpec Log %#010x\n", log);
> 
> -	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG,
> -			      &rp_pio->impspec_log);
> -	for (i = 0; i < dpc->rp_log_size - 5; i++)
> +	for (i = 0; i < dpc->rp_log_size - 5; i++) {
>  		pci_read_config_dword(pdev,
> -			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
> -			&rp_pio->tlp_prefix_log[i]);
> -}
> -
> -static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
> -{
> -	struct dpc_rp_pio_regs rp_pio_regs;
> -
> -	dpc_rp_pio_get_info(dpc, &rp_pio_regs);
> -	dpc_rp_pio_print_error(dpc, &rp_pio_regs);
> -
> -	dpc->rp_pio_status = rp_pio_regs.status;
> +			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
> +		dev_err(dev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
> +	}
>  }
> 
>  static irqreturn_t dpc_irq(int irq, void *context)
