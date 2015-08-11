Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37214 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbbHKUMT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2015 16:12:19 -0400
Received: by igbpg9 with SMTP id pg9so99588380igb.0
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2015 13:12:18 -0700 (PDT)
Date: Tue, 11 Aug 2015 15:12:15 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: linux-pci@vger.kernel.org, zajec5@gmail.com, rjui@broadcom.com.com,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] PCI: iproc_bcma: allow build as module
Message-ID: <20150811201215.GF13982@google.com>
References: <1437851724-10519-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437851724-10519-1-git-send-email-hauke@hauke-m.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Scott, bcm-kernel-feedback-list]

On Sat, Jul 25, 2015 at 09:15:24PM +0200, Hauke Mehrtens wrote:
> Changes this to tristate to make it possible to build this driver as a
> module.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Waiting for an ack from Ray or Scott.

> ---
>  drivers/pci/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index c132bdd..e339a8c 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -135,7 +135,7 @@ config PCIE_IPROC_PLATFORM
>  	  through the generic platform bus interface
>  
>  config PCIE_IPROC_BCMA
> -	bool "Broadcom iProc PCIe BCMA bus driver"
> +	tristate "Broadcom iProc PCIe BCMA bus driver"
>  	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
>  	select PCIE_IPROC
>  	select BCMA
> -- 
> 2.1.4
> 
