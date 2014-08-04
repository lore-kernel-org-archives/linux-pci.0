Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:44485 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbaHDHIi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Aug 2014 03:08:38 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so4752324oag.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Aug 2014 00:08:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1406892514-27996-1-git-send-email-sachin.kamat@samsung.com>
References: <1406892514-27996-1-git-send-email-sachin.kamat@samsung.com>
Date: Mon, 4 Aug 2014 12:38:37 +0530
Message-ID: <CAKohpo=tbN5UXz8C+c=EJbRdxUfkWpSUQHSi8YT0RduDsNTFFg@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI: spear: Fix build error
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sachin Kamat <sachin.kamat@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Sachin Kamat <spk.linux@gmail.com>,
	"olof@lixom.net" <olof@lixom.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1 August 2014 16:58, Sachin Kamat <sachin.kamat@samsung.com> wrote:
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
> ---
>  drivers/pci/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 8922c37..90f5cca 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -56,7 +56,7 @@ config PCI_HOST_GENERIC
>           controller, such as the one emulated by kvmtool.
>
>  config PCIE_SPEAR13XX
> -       tristate "STMicroelectronics SPEAr PCIe controller"
> +       bool "STMicroelectronics SPEAr PCIe controller"
>         depends on ARCH_SPEAR13XX
>         select PCIEPORTBUS
>         select PCIE_DW

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
