Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752061AbdHNUQx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Aug 2017 16:16:53 -0400
Date: Mon, 14 Aug 2017 15:16:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, gabriele.paoloni@huawei.com,
        charles.chenxin@huawei.com, linuxarm@huawei.com,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V2] PCI/DPC: Add eDPC support
Message-ID: <20170814201649.GC32525@bhelgaas-glaptop.roam.corp.google.com>
References: <1500716399-85612-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500716399-85612-1-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Keith]

Keith, any comments on this?  I have a few minor ones below.

On Sat, Jul 22, 2017 at 05:39:59PM +0800, Dongdong Liu wrote:
> This code is to add eDPC support. Get and print the RP PIO error
> information when the trigger condition is RP PIO error.
> 
> For more information on eDPC, view the PCI-SIG eDPC ECN here:
> https://pcisig.com/sites/default/files/specification_documents/ECN_Enhanced_DPC_2012-11-19_final.pdf

The ECN link is nice because I think it's available to anyone, but we
should include the PCIe spec references as well, since this ECN was
incorporated into PCIe r3.1, and for people who have the spec, that's
easier than chasing down each ECN separately.

> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> ---
> v1-->v2: Use a stack local variable instead of the allocated memory for
> 	 collecting RP PIO information.
> 	 Fix the condition of RP PIO error.
> 	 rebase on v4.13-rc1
> ---
>  drivers/pci/pcie/pcie-dpc.c   | 160 ++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |  10 +++
>  2 files changed, 170 insertions(+)
> 
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index c39f32e..724c548 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -16,11 +16,55 @@
>  #include <linux/pcieport_if.h>
>  #include "../pci.h"
>  
> +struct rp_pio_header_log_regs {
> +	u32 dw0;
> +	u32 dw1;
> +	u32 dw2;
> +	u32 dw3;
> +};
> +
> +struct dpc_rp_pio_regs {
> +	u32 status;
> +	u32 mask;
> +	u32 severity;
> +	u32 syserror;
> +	u32 exception;
> +
> +	struct rp_pio_header_log_regs header_log;
> +	u32 impspec_log;
> +	u32 tlp_prefix_log[4];
> +	u32 log_size;
> +	u16 first_error;
> +};
> +
>  struct dpc_dev {
>  	struct pcie_device	*dev;
>  	struct work_struct	work;
>  	int			cap_pos;
>  	bool			rp;
> +	u32			rp_pio_status;
> +};
> +
> +static const char * const rp_pio_error_string[] = {
> +	"Configuration Request received UR Completion",	 /* Bit Position 0  */
> +	"Configuration Request received CA Completion",	 /* Bit Position 1  */
> +	"Configuration Request Completion Timeout",	 /* Bit Position 2  */
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	"I/O Request received UR Completion",		 /* Bit Position 8  */
> +	"I/O Request received CA Completion",		 /* Bit Position 9  */
> +	"I/O Request Completion Timeout",		 /* Bit Position 10 */
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	"Memory Request received UR Completion",	 /* Bit Position 16 */
> +	"Memory Request received CA Completion",	 /* Bit Position 17 */
> +	"Memory Request Completion Timeout",		 /* Bit Position 18 */
>  };
>  
>  static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
> @@ -79,10 +123,121 @@ static void interrupt_event_handler(struct work_struct *work)
>  	dpc_wait_link_inactive(pdev);
>  	if (dpc->rp && dpc_wait_rp_inactive(dpc))
>  		return;
> +	if (dpc->rp && dpc->rp_pio_status)
> +		pci_write_config_dword(pdev,
> +				      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_STATUS,
> +				      dpc->rp_pio_status);
> +
>  	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
>  		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
>  }
>  
> +static void dpc_rp_pio_print_tlp_header(struct pci_dev *dev,
> +					struct rp_pio_header_log_regs *t)
> +{
> +	dev_err(&dev->dev, "TLP Header: %08x %08x %08x %08x\n",
> +		t->dw0, t->dw1, t->dw2, t->dw3);
> +}
> +
> +static void dpc_rp_pio_print_error(struct dpc_dev *dpc,
> +				   struct dpc_rp_pio_regs *rp_pio)
> +{
> +	struct pci_dev *pdev = dpc->dev->port;

  struct device *dev = &pdev->dev;

as in 7d630aaaa27f ("PCI: versatile: Add local struct device
pointers").

The existing code (before this patch) sometimes uses &pdev->dev and
sometimes &dpc->dev->device.  I'm not sure why the difference and I
wish they were all consistent.

> +	int i;
> +	u32 status;
> +
> +	dev_err(&pdev->dev, "rp_pio_status: 0x%08x, rp_pio_mask: 0x%08x\n",
> +			    rp_pio->status, rp_pio->mask);

> +
> +	dev_err(&pdev->dev, "RP PIO severity=0x%08x, syserror=0x%08x, exception=0x%08x\n",

Nit: use %#010x as in rest of the file.

> +		rp_pio->severity, rp_pio->syserror, rp_pio->exception);
> +
> +	status = (rp_pio->status & ~rp_pio->mask);
> +
> +	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
> +		if (!(status & (1 << i)))
> +			continue;
> +
> +		dev_err(&pdev->dev, "[%2d] %s%s\n", i, rp_pio_error_string[i],
> +			rp_pio->first_error == i ? " (First)" : "");
> +	}
> +
> +	dpc_rp_pio_print_tlp_header(pdev, &rp_pio->header_log);
> +	if (rp_pio->log_size == 4)
> +		return;
> +	dev_err(&pdev->dev, "RP PIO ImpSpec Log %08x\n", rp_pio->impspec_log);

Ditto.

> +
> +	for (i = 0; i < rp_pio->log_size - 5; i++)
> +		dev_err(&pdev->dev, "TLP Prefix Header: dw%d, %08x\n", i,
> +			rp_pio->tlp_prefix_log[i]);
> +}
> +
> +static void dpc_rp_pio_get_info(struct dpc_dev *dpc,
> +				struct dpc_rp_pio_regs *rp_pio)
> +{
> +	struct pci_dev *pdev = dpc->dev->port;
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

s/invaild/invalid/

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

s/precess/process/

> +{
> +	struct dpc_rp_pio_regs rp_pio_regs;

Is there value in defining the struct dpc_rp_pio_regs, reading all the
info into it with one function, then having a second function to print
the info?

It seems like you could have a single function that prints the info as
it reads it, without having to define a new struct.

> +	dpc_rp_pio_get_info(dpc, &rp_pio_regs);
> +	dpc_rp_pio_print_error(dpc, &rp_pio_regs);
> +
> +	dpc->rp_pio_status = rp_pio_regs.status;
> +}
> +
>  static irqreturn_t dpc_irq(int irq, void *context)
>  {
>  	struct dpc_dev *dpc = (struct dpc_dev *)context;
> @@ -109,6 +264,10 @@ static irqreturn_t dpc_irq(int irq, void *context)
>  			 (ext_reason == 0) ? "RP PIO error" :
>  			 (ext_reason == 1) ? "software trigger" :
>  					     "reserved error");
> +		/* show RP PIO error detail information */
> +		if (reason == 3 && ext_reason == 0)
> +			dpc_precess_rp_pio_error(dpc);
> +
>  		schedule_work(&dpc->work);
>  	}
>  	return IRQ_HANDLED;
> @@ -144,6 +303,7 @@ static int dpc_probe(struct pcie_device *dev)
>  
>  	dpc->rp = (cap & PCI_EXP_DPC_CAP_RP_EXT);
>  
> +

Spurious whitespace addition.

>  	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
>  	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index c22d3eb..1ce9627 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -967,6 +967,7 @@
>  #define  PCI_EXP_DPC_CAP_RP_EXT		0x20	/* Root Port Extensions for DPC */
>  #define  PCI_EXP_DPC_CAP_POISONED_TLP	0x40	/* Poisoned TLP Egress Blocking Supported */
>  #define  PCI_EXP_DPC_CAP_SW_TRIGGER	0x80	/* Software Triggering Supported */
> +#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE	0xF00	/* RP PIO log size */
>  #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
>  
>  #define PCI_EXP_DPC_CTL			6	/* DPC control */
> @@ -980,6 +981,15 @@
>  
>  #define PCI_EXP_DPC_SOURCE_ID		10	/* DPC Source Identifier */
>  
> +#define PCI_EXP_DPC_RP_PIO_STATUS	 0x0C	/* RP PIO Status */
> +#define PCI_EXP_DPC_RP_PIO_MASK		 0x10	/* RP PIO MASK */
> +#define PCI_EXP_DPC_RP_PIO_SEVERITY	 0x14	/* RP PIO Severity */
> +#define PCI_EXP_DPC_RP_PIO_SYSERROR	 0x18	/* RP PIO SysError */
> +#define PCI_EXP_DPC_RP_PIO_EXCEPTION	 0x1C	/* RP PIO Exception */
> +#define PCI_EXP_DPC_RP_PIO_HEADER_LOG	 0x20	/* RP PIO Header Log */
> +#define PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG	 0x30	/* RP PIO ImpSpec Log */
> +#define PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG 0x34	/* RP PIO TLP Prefix Log */
> +
>  /* Precision Time Measurement */
>  #define PCI_PTM_CAP			0x04	    /* PTM Capability */
>  #define  PCI_PTM_CAP_REQ		0x00000001  /* Requester capable */
> -- 
> 1.9.1
> 
