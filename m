Return-Path: <SRS0=KX5l=AK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5BDC433E1
	for <linux-pci@archiver.kernel.org>; Mon, 29 Jun 2020 19:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912662067D
	for <linux-pci@archiver.kernel.org>; Mon, 29 Jun 2020 19:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733176AbgF2Tb2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:31:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:36748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733162AbgF2Tb2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jun 2020 15:31:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58867AE7A;
        Mon, 29 Jun 2020 16:18:59 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, robh@kernel.org,
        wahrenst@gmx.net, p.zabel@pengutronix.de, andy.shevchenko@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        mathias.nyman@linux.intel.com, lorenzo.pieralisi@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v5 6/9] Revert "USB: pci-quirks: Add Raspberry Pi 4 quirk"
Date:   Mon, 29 Jun 2020 18:18:42 +0200
Message-Id: <20200629161845.6021-7-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629161845.6021-1-nsaenzjulienne@suse.de>
References: <20200629161845.6021-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit c65822fef4adc0ba40c37a47337376ce75f7a7bc.

The initialization of Raspberry Pi 4's USB chip is now handled through a
reset controller. No need to directly call the firmware routine through a
PCI quirk.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

---

Changes since v4:
 - Correct typos in description
 - add space between include types

 drivers/firmware/Kconfig      |  3 +--
 drivers/usb/host/pci-quirks.c | 15 ---------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index fbd785dd0513..4843e94713a4 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -178,9 +178,8 @@ config ISCSI_IBFT
 	  Otherwise, say N.
 
 config RASPBERRYPI_FIRMWARE
-	bool "Raspberry Pi Firmware Driver"
+	tristate "Raspberry Pi Firmware Driver"
 	depends on BCM2835_MBOX
-	default USB_PCI
 	help
 	  This option enables support for communicating with the firmware on the
 	  Raspberry Pi.
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 0b949acfa258..358015328391 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -17,8 +17,6 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 
-#include <soc/bcm2835/raspberrypi-firmware.h>
-
 #include "pci-quirks.h"
 #include "xhci-ext-caps.h"
 
@@ -1246,24 +1244,11 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 
 static void quirk_usb_early_handoff(struct pci_dev *pdev)
 {
-	int ret;
-
 	/* Skip Netlogic mips SoC's internal PCI USB controller.
 	 * This device does not need/support EHCI/OHCI handoff
 	 */
 	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
 		return;
-
-	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483) {
-		ret = rpi_firmware_init_vl805(pdev);
-		if (ret) {
-			/* Firmware might be outdated, or something failed */
-			dev_warn(&pdev->dev,
-				 "Failed to load VL805's firmware: %d. Will continue to attempt to work, but bad things might happen. You should fix this...\n",
-				 ret);
-		}
-	}
-
 	if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_EHCI &&
-- 
2.27.0

