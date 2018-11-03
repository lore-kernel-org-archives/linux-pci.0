Return-Path: <SRS0=Gu+H=NO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BA4C32789
	for <linux-pci@archiver.kernel.org>; Sat,  3 Nov 2018 01:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D4D20833
	for <linux-pci@archiver.kernel.org>; Sat,  3 Nov 2018 01:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RxTQ9HQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D4D20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeKCK5N (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 3 Nov 2018 06:57:13 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:37466 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeKCK5M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Nov 2018 06:57:12 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E71E724E0D73;
        Fri,  2 Nov 2018 18:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541209659; bh=5lBl+FBsjGfGquZ5OkAxJBRTVYjSY4E0Kqt8iAL3Xec=;
        h=Date:From:Subject:To:CC:From;
        b=RxTQ9HQjrsTMDGjW+fbrR97i0EqDG/Tv8uSNrS9+Tpe7suR7d/y5rvEvHTgCt822S
         PP/lY1QZobRWEKw1sV5YeQ7eiAc1+9d2nRulWaAupv1sLictnsffzO5TOQQ78wS4kB
         eaoEezb5dOtesMPRrNyNjW5IsD8Cw+UcdBr/CN6NNX/8teBP+s6o4khr1jRUi3523f
         i25YdLfx3RFusHc81MEjILYZqWyNm2iZ1fsaMRApXstcnEGbbNM8OU/XkifTFAB1q1
         QgzXfhvw6AOv22amdwU5pre5f2moU+pbgu3sb7HVBYjNY9jSscviW04s5GgNDm61no
         Xf/v/uu38TXuw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id CE7DF3ABB;
        Fri,  2 Nov 2018 18:47:39 -0700 (PDT)
Received: from US01WEHTC3.internal.synopsys.com (10.15.84.232) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 2 Nov 2018 18:47:39 -0700
Received: from te-lab16 (10.13.184.20) by US01WEHTC3.internal.synopsys.com
 (10.15.84.231) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 2 Nov
 2018 18:47:38 -0700
Received: by te-lab16 (sSMTP sendmail emulation); Fri, 02 Nov 2018 18:47:38
 -0700
Date:   Fri, 2 Nov 2018 18:47:38 -0700
Message-ID: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com>
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
Subject: [PATCH 1/2] pci: pci_ids: Move Synopsys HAPS platform device IDs
To:     Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC:     John Youn <john.youn@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.184.20]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move Synopsys HAPS platform device IDs to pci_ids.h.

Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
---
 drivers/usb/dwc3/dwc3-haps.c | 4 ----
 include/linux/pci_ids.h      | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-haps.c b/drivers/usb/dwc3/dwc3-haps.c
index c9cc33881bef..02d57d98ef9b 100644
--- a/drivers/usb/dwc3/dwc3-haps.c
+++ b/drivers/usb/dwc3/dwc3-haps.c
@@ -15,10 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
-#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3		0xabcd
-#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI	0xabce
-#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31	0xabcf
-
 /**
  * struct dwc3_haps - Driver private structure
  * @dwc3: child dwc3 platform_device
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d157983b84cf..c48550aa67e3 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2354,6 +2354,9 @@
 #define PCI_DEVICE_ID_CENATEK_IDE	0x0001
 
 #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
+#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3		0xabcd
+#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI	0xabce
+#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31	0xabcf
 
 #define PCI_VENDOR_ID_VITESSE		0x1725
 #define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
-- 
2.11.0

