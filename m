Return-Path: <SRS0=f3i4=7Q=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=f3i4=7Q=intel.com=keith.busch@kernel.org>
Date: Mon, 14 Aug 2017 14:09:35 -0400
From: Keith Busch <keith.busch@intel.com>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org,
	gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
	linuxarm@huawei.com
Subject: Re: [PATCH V2] PCI/DPC: Add eDPC support
Message-ID: <20170814180935.GE7233@localhost.localdomain>
References: <1500716399-85612-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500716399-85612-1-git-send-email-liudongdong3@huawei.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 22, 2017 at 05:39:59PM +0800, Dongdong Liu wrote:
> This code is to add eDPC support. Get and print the RP PIO error
> information when the trigger condition is RP PIO error.
> 
> For more information on eDPC, view the PCI-SIG eDPC ECN here:
> https://pcisig.com/sites/default/files/specification_documents/ECN_Enhanced_DPC_2012-11-19_final.pdf
> 
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

After clearing the status, you need to set dpc->rp_pio_status to 0 to
prevent non-rp detected errors from logging stale events.

Otherwise, this looks fine to me.
