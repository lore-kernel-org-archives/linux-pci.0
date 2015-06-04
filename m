Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 4 Jun 2015 08:14:35 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [RFT v2 32/48] mfd: Prepare for killing the first parameter
 'irq' of irq_flow_handler_t
Message-ID: <20150604071435.GB22293@x1>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <1433391238-19471-33-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1433391238-19471-33-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Change irq flow handler to prepare for killing the first parameter 'irq'
> of irq_flow_handler_t.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/mfd/ucb1x00-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
> index 58ea9fdd3a15..08ce1dad4167 100644
> --- a/drivers/mfd/ucb1x00-core.c
> +++ b/drivers/mfd/ucb1x00-core.c
> @@ -292,7 +292,7 @@ static void ucb1x00_irq(unsigned int irq, struct irq_desc *desc)
>  	ucb1x00_reg_write(ucb, UCB_IE_CLEAR, isr);
>  	ucb1x00_reg_write(ucb, UCB_IE_CLEAR, 0);
>  
> -	for (i = 0; i < 16 && isr; i++, isr >>= 1, irq++)
> +	for (i = 0; i < 16 && isr; i++, isr >>= 1)
>  		if (isr & 1)
>  			generic_handle_irq(ucb->irq_base + i);
>  	ucb1x00_disable(ucb);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
