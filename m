Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 8 Jun 2015 16:46:58 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Steve Longerbeam <slongerbeam@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [RFT v2 11/48] ipu: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
Message-ID: <20150608111658.GL28601@localhost>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <1433391238-19471-12-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433391238-19471-12-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 04, 2015 at 12:13:21PM +0800, Jiang Liu wrote:
> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
> 
> Do the same thing to avoid pattern "irq_get_chip_data(data->irq)".

And I am missing the context, it is a bad practice to send some part of the
series without giving context. Is this dependent on something else...?

-- 
~Vinod
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/dma/ipu/ipu_irq.c       |    2 +-
>  drivers/gpu/ipu-v3/ipu-common.c |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/ipu/ipu_irq.c b/drivers/dma/ipu/ipu_irq.c
> index 2e284a4438bc..0e12af37fe2f 100644
> --- a/drivers/dma/ipu/ipu_irq.c
> +++ b/drivers/dma/ipu/ipu_irq.c
> @@ -268,7 +268,7 @@ int ipu_irq_unmap(unsigned int source)
>  /* Chained IRQ handler for IPU error interrupt */
>  static void ipu_irq_err(unsigned int irq, struct irq_desc *desc)
>  {
> -	struct ipu *ipu = irq_get_handler_data(irq);
> +	struct ipu *ipu = irq_desc_get_handler_data(desc);
>  	u32 status;
>  	int i, line;
>  
> diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
> index 67bab5c36056..7022825b7a2c 100644
> --- a/drivers/gpu/ipu-v3/ipu-common.c
> +++ b/drivers/gpu/ipu-v3/ipu-common.c
> @@ -915,8 +915,8 @@ static void ipu_irq_handle(struct ipu_soc *ipu, const int *regs, int num_regs)
>  static void ipu_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
>  	struct ipu_soc *ipu = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	const int int_reg[] = { 0, 1, 2, 3, 10, 11, 12, 13, 14};
> -	struct irq_chip *chip = irq_get_chip(irq);
>  
>  	chained_irq_enter(chip, desc);
>  
> @@ -928,8 +928,8 @@ static void ipu_irq_handler(unsigned int irq, struct irq_desc *desc)
>  static void ipu_err_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
>  	struct ipu_soc *ipu = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	const int int_reg[] = { 4, 5, 8, 9};
> -	struct irq_chip *chip = irq_get_chip(irq);
>  
>  	chained_irq_enter(chip, desc);
>  
> -- 
> 1.7.10.4
> 

-- 
