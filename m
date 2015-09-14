Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34076 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbbINQsE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2015 12:48:04 -0400
Received: by iofb144 with SMTP id b144so173253364iof.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2015 09:48:02 -0700 (PDT)
Date: Mon, 14 Sep 2015 11:47:56 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-pci@vger.kernel.org, thierry.reding@gmail.com,
	linux-tegra@vger.kernel.org, swarren@wwwdotorg.org
Subject: Re: [PATCH resend] PCI: tegra: use __pgprot() around static pgprot_t
 initializer
Message-ID: <20150914164756.GM829@google.com>
References: <1440578974-26527-1-git-send-email-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440578974-26527-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 26, 2015 at 10:49:34AM +0200, Ard Biesheuvel wrote:
> In order to comply with the rules that apply when STRICT_MM_TYPECHECKS
> is defined, wrap the initializer for a pgprot_t in __pgprot().
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied with Thierry's ack to pci/host-tegra for v4.4, thanks!

> ---
>  drivers/pci/host/pci-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 10c05718dbfd..0d3e6cb0c459 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -382,8 +382,8 @@ static unsigned long tegra_pcie_conf_offset(unsigned int devfn, int where)
>  static struct tegra_pcie_bus *tegra_pcie_bus_alloc(struct tegra_pcie *pcie,
>  						   unsigned int busnr)
>  {
> -	pgprot_t prot = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY | L_PTE_XN |
> -			L_PTE_MT_DEV_SHARED | L_PTE_SHARED;
> +	pgprot_t prot = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
> +				 L_PTE_XN | L_PTE_MT_DEV_SHARED | L_PTE_SHARED);
>  	phys_addr_t cs = pcie->cs->start;
>  	struct tegra_pcie_bus *bus;
>  	unsigned int i;
> -- 
> 1.9.1


commit 512ee2fd9ca1c0b447a144c6c49a53a010f8d6fa
Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed Aug 26 10:49:34 2015 +0200

    PCI: tegra: Wrap static pgprot_t initializer with __pgprot()
    
    Wrap pgprot_t initializer with __pgprot() to comply with the
    STRICT_MM_TYPECHECKS rules.
    
    [bhelgaas: changelog]
    Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Thierry Reding <treding@nvidia.com>

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 81df0c1..3018ae5 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -382,8 +382,8 @@ static unsigned long tegra_pcie_conf_offset(unsigned int devfn, int where)
 static struct tegra_pcie_bus *tegra_pcie_bus_alloc(struct tegra_pcie *pcie,
 						   unsigned int busnr)
 {
-	pgprot_t prot = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY | L_PTE_XN |
-			L_PTE_MT_DEV_SHARED | L_PTE_SHARED;
+	pgprot_t prot = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				 L_PTE_XN | L_PTE_MT_DEV_SHARED | L_PTE_SHARED);
 	phys_addr_t cs = pcie->cs->start;
 	struct tegra_pcie_bus *bus;
 	unsigned int i;
