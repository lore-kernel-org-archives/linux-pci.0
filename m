Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:56904 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbaHMRUg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Aug 2014 13:20:36 -0400
Received: by mail-ig0-f173.google.com with SMTP id h18so10912756igc.12
        for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2014 10:20:35 -0700 (PDT)
Date: Wed, 13 Aug 2014 11:20:32 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sachin Kamat <sachin.kamat@samsung.com>
Cc: linux-pci@vger.kernel.org, pratyush.anand@st.com,
	viresh.kumar@linaro.org, spk.linux@gmail.com, olof@lixom.net
Subject: Re: [PATCH 1/1] PCI: spear: Fix build error
Message-ID: <20140813172032.GA7298@google.com>
References: <1406892514-27996-1-git-send-email-sachin.kamat@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406892514-27996-1-git-send-email-sachin.kamat@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 01, 2014 at 04:58:34PM +0530, Sachin Kamat wrote:
> We get the following error when built as a module. Though the general fix would
> be in this case to export the below mentioned symbols, considering that
> dw_pcie_host_init is marked with __init and other PCI drivers do not support
> modular build, I have disabled building this driver as a module too.
> 
> ERROR: "dw_pcie_host_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_handle_msi_irq" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_msi_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_cfg_write" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_cfg_read" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_setup_rc" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_link_up" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>

Applied with ack and reviewed-by from Viresh and Jingoo to pci/spear for
v3.17, thanks!

> ---
>  drivers/pci/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 8922c37..90f5cca 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -56,7 +56,7 @@ config PCI_HOST_GENERIC
>  	  controller, such as the one emulated by kvmtool.
>  
>  config PCIE_SPEAR13XX
> -	tristate "STMicroelectronics SPEAr PCIe controller"
> +	bool "STMicroelectronics SPEAr PCIe controller"
>  	depends on ARCH_SPEAR13XX
>  	select PCIEPORTBUS
>  	select PCIE_DW
> -- 
> 1.8.1.2
> 
