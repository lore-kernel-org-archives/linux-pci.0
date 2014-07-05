Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:52708 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbaGERrp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 5 Jul 2014 13:47:45 -0400
Received: by mail-ig0-f175.google.com with SMTP id h3so9551281igd.14
        for <linux-pci@vger.kernel.org>; Sat, 05 Jul 2014 10:47:45 -0700 (PDT)
Date: Sat, 5 Jul 2014 11:47:42 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: horms@verge.net.au, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, phil.edworthy@renesas.com
Subject: Re: [PATCH] pcie-rcar: kill duplicate checks
Message-ID: <20140705174742.GD26618@google.com>
References: <201406271859.13626.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201406271859.13626.sergei.shtylyov@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 27, 2014 at 06:59:13PM +0400, Sergei Shtylyov wrote:
> The PCI core will have already checked the configuration register address before
> calling the {read|write}() methods, no need to check it again in these methods.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied with Phil and Simon's acks to pci/host-rcar for v3.17, thanks!

> ---
> The patch is against the 'next' branch of Bjorn Helgaas' 'pci.git' repo.
> 
>  drivers/pci/host/pcie-rcar.c |   10 ----------
>  1 file changed, 10 deletions(-)
> 
> Index: pci/drivers/pci/host/pcie-rcar.c
> ===================================================================
> --- pci.orig/drivers/pci/host/pcie-rcar.c
> +++ pci/drivers/pci/host/pcie-rcar.c
> @@ -260,11 +260,6 @@ static int rcar_pcie_read_conf(struct pc
>  	struct rcar_pcie *pcie = sys_to_pcie(bus->sysdata);
>  	int ret;
>  
> -	if ((size == 2) && (where & 1))
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -	else if ((size == 4) && (where & 3))
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -
>  	ret = rcar_pcie_config_access(pcie, PCI_ACCESS_READ,
>  				      bus, devfn, where, val);
>  	if (ret != PCIBIOS_SUCCESSFUL) {
> @@ -291,11 +286,6 @@ static int rcar_pcie_write_conf(struct p
>  	int shift, ret;
>  	u32 data;
>  
> -	if ((size == 2) && (where & 1))
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -	else if ((size == 4) && (where & 3))
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -
>  	ret = rcar_pcie_config_access(pcie, PCI_ACCESS_READ,
>  				      bus, devfn, where, &data);
>  	if (ret != PCIBIOS_SUCCESSFUL)
