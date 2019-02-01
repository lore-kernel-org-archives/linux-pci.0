Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7598FC282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 23:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3036121872
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 23:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549063922;
	bh=eZeAGi2kBx3NA56dbb2fOKTlZZI44FGHzrEj9jIgcC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ztyVvHHoiQmvNzNytdOakY9vFPduSclo39ffXl4x/1gWK7cJnoUAFum5p7uZA0eM5
	 1sQ7t70/3zzJn1L1rDLZEt/kZSK/izR000NrU8lFgAnsyr6PYqfGho5vkyHQasjb/0
	 57soPWLHufUAsBPFZvYlAPVdXcENB3O5wfWumhp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfBAXcB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:32:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfBAXcB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 18:32:01 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A23D021872;
        Fri,  1 Feb 2019 23:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549063919;
        bh=eZeAGi2kBx3NA56dbb2fOKTlZZI44FGHzrEj9jIgcC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcpDBfpFLkrkmxTu7k50xvSSdbbcOZjHmb/Ur9JB4VkdIySXn8C7HIn74Wf+QXiKY
         p9RsdVvG89ViK9g7R1WRxprIAjsBdZad+iP2jQasMVhy61Be2Q9BIJUEt/EjhM356u
         f8U+9cKteMK2lGDnZB3VU/8FZSGJrEiOUZtM0BXE=
Date:   Fri, 1 Feb 2019 17:31:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] PCI: Move Rohm vendor ID to generic list
Message-ID: <20190201233156.GW229773@google.com>
References: <20181107195856.43223-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107195856.43223-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 09:58:56PM +0200, Andy Shevchenko wrote:
> Move the Rohm vendor ID to pci_ids.h from dozen of drivers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I applied this to pci/misc for v5.1 with acks from Mark and Linus W.
I did change "dozen" to "several" just for truth-in-advertising :)

> ---
> 
> I believe the best chance to get it merged and be less intrusive to ongoing
> work is through PCI subsystem as a _fix_ for v4.20.
> 
>  drivers/dma/pch_dma.c                                | 1 -
>  drivers/gpio/gpio-ml-ioh.c                           | 2 --
>  drivers/gpio/gpio-pch.c                              | 1 -
>  drivers/i2c/busses/i2c-eg20t.c                       | 1 -
>  drivers/misc/pch_phub.c                              | 1 -
>  drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 7 ++-----
>  drivers/spi/spi-topcliff-pch.c                       | 1 -
>  drivers/tty/serial/pch_uart.c                        | 2 --
>  drivers/usb/gadget/udc/pch_udc.c                     | 1 -
>  include/linux/pci_ids.h                              | 2 ++
>  10 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
> index afd8f27bda96..538b6e0e17bb 100644
> --- a/drivers/dma/pch_dma.c
> +++ b/drivers/dma/pch_dma.c
> @@ -972,7 +972,6 @@ static void pch_dma_remove(struct pci_dev *pdev)
>  }
>  
>  /* PCI Device ID of DMA device */
> -#define PCI_VENDOR_ID_ROHM             0x10DB
>  #define PCI_DEVICE_ID_EG20T_PCH_DMA_8CH        0x8810
>  #define PCI_DEVICE_ID_EG20T_PCH_DMA_4CH        0x8815
>  #define PCI_DEVICE_ID_ML7213_DMA1_8CH	0x8026
> diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
> index 51c7d1b84c2e..0c076dce9e17 100644
> --- a/drivers/gpio/gpio-ml-ioh.c
> +++ b/drivers/gpio/gpio-ml-ioh.c
> @@ -31,8 +31,6 @@
>  
>  #define IOH_IRQ_BASE		0
>  
> -#define PCI_VENDOR_ID_ROHM             0x10DB
> -
>  struct ioh_reg_comn {
>  	u32	ien;
>  	u32	istatus;
> diff --git a/drivers/gpio/gpio-pch.c b/drivers/gpio/gpio-pch.c
> index ffce0ab912ed..8c7f3d20e30e 100644
> --- a/drivers/gpio/gpio-pch.c
> +++ b/drivers/gpio/gpio-pch.c
> @@ -524,7 +524,6 @@ static int pch_gpio_resume(struct pci_dev *pdev)
>  #define pch_gpio_resume NULL
>  #endif
>  
> -#define PCI_VENDOR_ID_ROHM             0x10DB
>  static const struct pci_device_id pch_gpio_pcidev_id[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x8803) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ROHM, 0x8014) },
> diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
> index 835d54ac2971..231675b10376 100644
> --- a/drivers/i2c/busses/i2c-eg20t.c
> +++ b/drivers/i2c/busses/i2c-eg20t.c
> @@ -177,7 +177,6 @@ static wait_queue_head_t pch_event;
>  static DEFINE_MUTEX(pch_mutex);
>  
>  /* Definition for ML7213 by LAPIS Semiconductor */
> -#define PCI_VENDOR_ID_ROHM		0x10DB
>  #define PCI_DEVICE_ID_ML7213_I2C	0x802D
>  #define PCI_DEVICE_ID_ML7223_I2C	0x8010
>  #define PCI_DEVICE_ID_ML7831_I2C	0x8817
> diff --git a/drivers/misc/pch_phub.c b/drivers/misc/pch_phub.c
> index 540845651b8c..309703e9c42e 100644
> --- a/drivers/misc/pch_phub.c
> +++ b/drivers/misc/pch_phub.c
> @@ -64,7 +64,6 @@
>  #define CLKCFG_UARTCLKSEL			(1 << 18)
>  
>  /* Macros for ML7213 */
> -#define PCI_VENDOR_ID_ROHM			0x10db
>  #define PCI_DEVICE_ID_ROHM_ML7213_PHUB		0x801A
>  
>  /* Macros for ML7223 */
> diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> index 43c0c10dfeb7..3a4225837049 100644
> --- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> +++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> @@ -27,7 +27,6 @@
>  #define DRV_VERSION     "1.01"
>  const char pch_driver_version[] = DRV_VERSION;
>  
> -#define PCI_DEVICE_ID_INTEL_IOH1_GBE	0x8802		/* Pci device ID */
>  #define PCH_GBE_MAR_ENTRIES		16
>  #define PCH_GBE_SHORT_PKT		64
>  #define DSC_INIT16			0xC000
> @@ -37,11 +36,9 @@ const char pch_driver_version[] = DRV_VERSION;
>  #define PCH_GBE_PCI_BAR			1
>  #define PCH_GBE_RESERVE_MEMORY		0x200000	/* 2MB */
>  
> -/* Macros for ML7223 */
> -#define PCI_VENDOR_ID_ROHM			0x10db
> -#define PCI_DEVICE_ID_ROHM_ML7223_GBE		0x8013
> +#define PCI_DEVICE_ID_INTEL_IOH1_GBE		0x8802
>  
> -/* Macros for ML7831 */
> +#define PCI_DEVICE_ID_ROHM_ML7223_GBE		0x8013
>  #define PCI_DEVICE_ID_ROHM_ML7831_GBE		0x8802
>  
>  #define PCH_GBE_TX_WEIGHT         64
> diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
> index 97d137591b18..d794180e83dc 100644
> --- a/drivers/spi/spi-topcliff-pch.c
> +++ b/drivers/spi/spi-topcliff-pch.c
> @@ -92,7 +92,6 @@
>  #define PCH_MAX_SPBR		1023
>  
>  /* Definition for ML7213/ML7223/ML7831 by LAPIS Semiconductor */
> -#define PCI_VENDOR_ID_ROHM		0x10DB
>  #define PCI_DEVICE_ID_ML7213_SPI	0x802c
>  #define PCI_DEVICE_ID_ML7223_SPI	0x800F
>  #define PCI_DEVICE_ID_ML7831_SPI	0x8816
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index cb85002a10d8..d04108e7503a 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -192,8 +192,6 @@ enum {
>  #define PCH_UART_HAL_LOOP		(PCH_UART_MCR_LOOP)
>  #define PCH_UART_HAL_AFE		(PCH_UART_MCR_AFE)
>  
> -#define PCI_VENDOR_ID_ROHM		0x10DB
> -
>  #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
>  
>  #define DEFAULT_UARTCLK   1843200 /*   1.8432 MHz */
> diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
> index afaea11ec771..5b6f2b9eaa5f 100644
> --- a/drivers/usb/gadget/udc/pch_udc.c
> +++ b/drivers/usb/gadget/udc/pch_udc.c
> @@ -368,7 +368,6 @@ struct pch_udc_dev {
>  #define PCI_DEVICE_ID_INTEL_QUARK_X1000_UDC	0x0939
>  #define PCI_DEVICE_ID_INTEL_EG20T_UDC		0x8808
>  
> -#define PCI_VENDOR_ID_ROHM		0x10DB
>  #define PCI_DEVICE_ID_ML7213_IOH_UDC	0x801D
>  #define PCI_DEVICE_ID_ML7831_IOH_UDC	0x8808
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 69f0abe1ba1a..7fc8d79260e6 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1137,6 +1137,8 @@
>  #define PCI_VENDOR_ID_TCONRAD		0x10da
>  #define PCI_DEVICE_ID_TCONRAD_TOKENRING	0x0508
>  
> +#define PCI_VENDOR_ID_ROHM		0x10db
> +
>  #define PCI_VENDOR_ID_NVIDIA			0x10de
>  #define PCI_DEVICE_ID_NVIDIA_TNT		0x0020
>  #define PCI_DEVICE_ID_NVIDIA_TNT2		0x0028
> -- 
> 2.19.1
> 
