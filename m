Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60768 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232AbaGYNbt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 25 Jul 2014 09:31:49 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] pch_uart: use pci_get_dma_device() helper
Date: Fri, 25 Jul 2014 16:31:43 +0300
Message-Id: <1406295104-20082-2-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1406295104-20082-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1406295104-20082-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since we have pci_get_dma_device() public we may use it in the drivers. It
considers the function 0 as a DMA controller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/pch_uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 2f06e5a..c38fdee 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -736,9 +736,8 @@ static void pch_request_dma(struct uart_port *port)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	dma_dev = pci_get_bus_and_slot(priv->pdev->bus->number,
-				       PCI_DEVFN(0xa, 0)); /* Get DMA's dev
-								information */
+	dma_dev = pci_get_dma_device(priv->pdev); /* Get DMA's dev information */
+
 	/* Set Tx DMA */
 	param = &priv->param_tx;
 	param->dma_dev = &dma_dev->dev;
-- 
2.0.1

