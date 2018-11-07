Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF93C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 19:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED3320818
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 19:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED3320818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeKHFax (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:30:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:41325 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbeKHFax (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Nov 2018 00:30:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 11:59:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,476,1534834800"; 
   d="scan'208";a="102417620"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2018 11:58:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0A801E6; Wed,  7 Nov 2018 21:58:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] PCI: Move Rohm vendor ID to generic list
Date:   Wed,  7 Nov 2018 21:58:56 +0200
Message-Id: <20181107195856.43223-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the Rohm vendor ID to pci_ids.h from dozen of drivers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

I believe the best chance to get it merged and be less intrusive to ongoing
work is through PCI subsystem as a _fix_ for v4.20.

 drivers/dma/pch_dma.c                                | 1 -
 drivers/gpio/gpio-ml-ioh.c                           | 2 --
 drivers/gpio/gpio-pch.c                              | 1 -
 drivers/i2c/busses/i2c-eg20t.c                       | 1 -
 drivers/misc/pch_phub.c                              | 1 -
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 7 ++-----
 drivers/spi/spi-topcliff-pch.c                       | 1 -
 drivers/tty/serial/pch_uart.c                        | 2 --
 drivers/usb/gadget/udc/pch_udc.c                     | 1 -
 include/linux/pci_ids.h                              | 2 ++
 10 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index afd8f27bda96..538b6e0e17bb 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -972,7 +972,6 @@ static void pch_dma_remove(struct pci_dev *pdev)
 }
 
 /* PCI Device ID of DMA device */
-#define PCI_VENDOR_ID_ROHM             0x10DB
 #define PCI_DEVICE_ID_EG20T_PCH_DMA_8CH        0x8810
 #define PCI_DEVICE_ID_EG20T_PCH_DMA_4CH        0x8815
 #define PCI_DEVICE_ID_ML7213_DMA1_8CH	0x8026
diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index 51c7d1b84c2e..0c076dce9e17 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -31,8 +31,6 @@
 
 #define IOH_IRQ_BASE		0
 
-#define PCI_VENDOR_ID_ROHM             0x10DB
-
 struct ioh_reg_comn {
 	u32	ien;
 	u32	istatus;
diff --git a/drivers/gpio/gpio-pch.c b/drivers/gpio/gpio-pch.c
index ffce0ab912ed..8c7f3d20e30e 100644
--- a/drivers/gpio/gpio-pch.c
+++ b/drivers/gpio/gpio-pch.c
@@ -524,7 +524,6 @@ static int pch_gpio_resume(struct pci_dev *pdev)
 #define pch_gpio_resume NULL
 #endif
 
-#define PCI_VENDOR_ID_ROHM             0x10DB
 static const struct pci_device_id pch_gpio_pcidev_id[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x8803) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_ROHM, 0x8014) },
diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 835d54ac2971..231675b10376 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -177,7 +177,6 @@ static wait_queue_head_t pch_event;
 static DEFINE_MUTEX(pch_mutex);
 
 /* Definition for ML7213 by LAPIS Semiconductor */
-#define PCI_VENDOR_ID_ROHM		0x10DB
 #define PCI_DEVICE_ID_ML7213_I2C	0x802D
 #define PCI_DEVICE_ID_ML7223_I2C	0x8010
 #define PCI_DEVICE_ID_ML7831_I2C	0x8817
diff --git a/drivers/misc/pch_phub.c b/drivers/misc/pch_phub.c
index 540845651b8c..309703e9c42e 100644
--- a/drivers/misc/pch_phub.c
+++ b/drivers/misc/pch_phub.c
@@ -64,7 +64,6 @@
 #define CLKCFG_UARTCLKSEL			(1 << 18)
 
 /* Macros for ML7213 */
-#define PCI_VENDOR_ID_ROHM			0x10db
 #define PCI_DEVICE_ID_ROHM_ML7213_PHUB		0x801A
 
 /* Macros for ML7223 */
diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 43c0c10dfeb7..3a4225837049 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -27,7 +27,6 @@
 #define DRV_VERSION     "1.01"
 const char pch_driver_version[] = DRV_VERSION;
 
-#define PCI_DEVICE_ID_INTEL_IOH1_GBE	0x8802		/* Pci device ID */
 #define PCH_GBE_MAR_ENTRIES		16
 #define PCH_GBE_SHORT_PKT		64
 #define DSC_INIT16			0xC000
@@ -37,11 +36,9 @@ const char pch_driver_version[] = DRV_VERSION;
 #define PCH_GBE_PCI_BAR			1
 #define PCH_GBE_RESERVE_MEMORY		0x200000	/* 2MB */
 
-/* Macros for ML7223 */
-#define PCI_VENDOR_ID_ROHM			0x10db
-#define PCI_DEVICE_ID_ROHM_ML7223_GBE		0x8013
+#define PCI_DEVICE_ID_INTEL_IOH1_GBE		0x8802
 
-/* Macros for ML7831 */
+#define PCI_DEVICE_ID_ROHM_ML7223_GBE		0x8013
 #define PCI_DEVICE_ID_ROHM_ML7831_GBE		0x8802
 
 #define PCH_GBE_TX_WEIGHT         64
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 97d137591b18..d794180e83dc 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -92,7 +92,6 @@
 #define PCH_MAX_SPBR		1023
 
 /* Definition for ML7213/ML7223/ML7831 by LAPIS Semiconductor */
-#define PCI_VENDOR_ID_ROHM		0x10DB
 #define PCI_DEVICE_ID_ML7213_SPI	0x802c
 #define PCI_DEVICE_ID_ML7223_SPI	0x800F
 #define PCI_DEVICE_ID_ML7831_SPI	0x8816
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index cb85002a10d8..d04108e7503a 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -192,8 +192,6 @@ enum {
 #define PCH_UART_HAL_LOOP		(PCH_UART_MCR_LOOP)
 #define PCH_UART_HAL_AFE		(PCH_UART_MCR_AFE)
 
-#define PCI_VENDOR_ID_ROHM		0x10DB
-
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
 #define DEFAULT_UARTCLK   1843200 /*   1.8432 MHz */
diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index afaea11ec771..5b6f2b9eaa5f 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -368,7 +368,6 @@ struct pch_udc_dev {
 #define PCI_DEVICE_ID_INTEL_QUARK_X1000_UDC	0x0939
 #define PCI_DEVICE_ID_INTEL_EG20T_UDC		0x8808
 
-#define PCI_VENDOR_ID_ROHM		0x10DB
 #define PCI_DEVICE_ID_ML7213_IOH_UDC	0x801D
 #define PCI_DEVICE_ID_ML7831_IOH_UDC	0x8808
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 69f0abe1ba1a..7fc8d79260e6 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1137,6 +1137,8 @@
 #define PCI_VENDOR_ID_TCONRAD		0x10da
 #define PCI_DEVICE_ID_TCONRAD_TOKENRING	0x0508
 
+#define PCI_VENDOR_ID_ROHM		0x10db
+
 #define PCI_VENDOR_ID_NVIDIA			0x10de
 #define PCI_DEVICE_ID_NVIDIA_TNT		0x0020
 #define PCI_DEVICE_ID_NVIDIA_TNT2		0x0028
-- 
2.19.1

