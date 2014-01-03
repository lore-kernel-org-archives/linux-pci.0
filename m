Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2lp0237.outbound.protection.outlook.com ([207.46.163.237]:56869
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753362AbaACWbF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 3 Jan 2014 17:31:05 -0500
Date: Fri, 3 Jan 2014 16:16:03 -0600
From: Scott Wood <scottwood@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [11/12,v3] pci: fsl: update PCI EDAC driver
Message-ID: <20140103221603.GA22546@home.buserror.net>
References: <1382524894-15164-11-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1382524894-15164-11-git-send-email-Minghuan.Lian@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 23, 2013 at 06:41:33PM +0800, Minghuan Lian wrote:
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 40d2e1d..4a03e1a 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -236,6 +236,7 @@ void fsl_arch_pci_sys_remove(struct fsl_pci *pci)
>  	if (!hose)
>  		return;
>  
> +	mpc85xx_pci_err_remove(to_platform_device(pci->dev));
>  	pcibios_free_controller(hose);

This causes a linker error if the EDAC driver is enabled, due to commit
0f1741c74aa6794b1c7fbdd19f26a4f2377a11c6 ("edac/85xx: Remove
mpc85xx_pci_err_remove").

-Scott
