Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:42120 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaABVsj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jan 2014 16:48:39 -0500
Received: by mail-ig0-f175.google.com with SMTP id j1so42704772iga.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Jan 2014 13:48:39 -0800 (PST)
Date: Thu, 2 Jan 2014 14:48:36 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org, 'Mohit Kumar' <mohit.kumar@st.com>
Subject: Re: [PATCH] PCI: designware: Fix indent code style
Message-ID: <20140102214836.GB7228@google.com>
References: <000401cf029a$d63943d0$82abcb70$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000401cf029a$d63943d0$82abcb70$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 27, 2013 at 09:30:25AM +0900, Jingoo Han wrote:
> Fix indent code style and replace 'MSI interrupt controller'
> of comment with 'MSI controller', in order to fix the following
> checkpatch issues.
> 
>   ERROR: code indent should use tabs where possible
>   WARNING: please, no spaces at the start of a line
>   WARNING: line over 80 characters
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to pci/host-designware for v3.14, thanks!

Bjorn

> ---
>  drivers/pci/host/pcie-designware.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 4a08d30..17ce88f 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -213,14 +213,14 @@ static int find_valid_pos0(struct pcie_port *pp, int msgvec, int pos, int *pos0)
>  }
>  
>  static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
> -                            unsigned int nvec, unsigned int pos)
> +			    unsigned int nvec, unsigned int pos)
>  {
>  	unsigned int i, res, bit, val;
>  
>  	for (i = 0; i < nvec; i++) {
>  		irq_set_msi_desc_off(irq_base, i, NULL);
>  		clear_bit(pos + i, pp->msi_irq_in_use);
> -		/* Disable corresponding interrupt on MSI interrupt controller */
> +		/* Disable corresponding interrupt on MSI controller */
>  		res = ((pos + i) / 32) * 12;
>  		bit = (pos + i) % 32;
>  		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
> -- 
> 1.7.10.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
