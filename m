Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:7506 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752140AbbCYJvG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Mar 2015 05:51:06 -0400
Date: Wed, 25 Mar 2015 09:44:40 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"cpgs@samsung.com" <cpgs@samsung.com>
Subject: Re: [PATCH] pci: pci-exynos: fixed the sentence error
Message-ID: <20150325094440.GJ14917@e106497-lin.cambridge.arm.com>
References: <1427260392-4186-1-git-send-email-jh80.chung@samsung.com>
MIME-Version: 1.0
In-Reply-To: <1427260392-4186-1-git-send-email-jh80.chung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 25, 2015 at 05:13:12AM +0000, Jaehoon Chung wrote:
> There is the sentence error.
> Changed the semicolon instead of comma.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/pci/host/pci-exynos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index d202b37..c139237 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -396,7 +396,7 @@ static void exynos_pcie_enable_irq_pulse(struct pcie_port *pp)
>  
>  	/* enable INTX interrupt */
>  	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
> -		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT,
> +		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
>  	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_PULSE);
>  }

Well spotted. The original change dates from July 2013, I'm guessing no one uses
PCIe on Exynos?

Best regards,
Liviu

>  
> -- 
> 1.9.1
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

