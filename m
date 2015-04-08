Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33495 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbbDHTd1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2015 15:33:27 -0400
Received: by oblw8 with SMTP id w8so104401177obl.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Apr 2015 12:33:26 -0700 (PDT)
Date: Wed, 8 Apr 2015 14:33:24 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>,
	Liviu.Dudau@arm.com, cpgs@samsung.com
Subject: Re: [PATCH] pci: pci-exynos: fixed the sentence error
Message-ID: <20150408193324.GE30967@google.com>
References: <1427260392-4186-1-git-send-email-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427260392-4186-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 25, 2015 at 02:13:12PM +0900, Jaehoon Chung wrote:
> There is the sentence error.
> Changed the semicolon instead of comma.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Applied to pci/host-exynos for v4.1.  Jingoo, speak up if you object, but
this looks like a pretty obvious error.

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
>  
> -- 
> 1.9.1
> 
