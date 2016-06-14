Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51810 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbcFNTkI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Jun 2016 15:40:08 -0400
Date: Tue, 14 Jun 2016 14:40:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, jespern@axis.com,
	Niklas Cassel <niklass@axis.com>
Subject: Re: [PATCH] PCI: artpec: correct section mismatch for function
 artpec6_pcie_probe
Message-ID: <20160614194003.GA6003@localhost>
References: <201606141525.f3Gs5A4F%fengguang.wu@intel.com>
 <1465932023-10606-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465932023-10606-1-git-send-email-niklass@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 14, 2016 at 09:20:23PM +0200, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
> 
> WARNING: drivers/pci/host/built-in.o(.data+0xb00): Section mismatch in reference from the variable artpec6_pcie_driver to the function .init.text:artpec6_pcie_probe()
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Folded into the pci/host-artpec branch, thanks, Niklas!

> ---
> Reported by kbuild test robot.
> I converted to using module_platform_driver macro in
> v2 of this series, unfortunately I missed the
> section mismatch warning.
> Feel free to fold this into the original patch.
> 
>  drivers/pci/host/pcie-artpec6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
> index 19adc77..be54fad 100644
> --- a/drivers/pci/host/pcie-artpec6.c
> +++ b/drivers/pci/host/pcie-artpec6.c
> @@ -223,7 +223,7 @@ static int __init artpec6_add_pcie_port(struct pcie_port *pp,
>  	return 0;
>  }
>  
> -static int __init artpec6_pcie_probe(struct platform_device *pdev)
> +static int artpec6_pcie_probe(struct platform_device *pdev)
>  {
>  	struct artpec6_pcie *artpec6_pcie;
>  	struct pcie_port *pp;
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
