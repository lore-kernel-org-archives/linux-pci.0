Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E1AC04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 22:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832C120821
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 22:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WtwsE6Qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832C120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeLJWH5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:07:57 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:37450 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeLJWH4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Dec 2018 17:07:56 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 534E710C0DAB;
        Mon, 10 Dec 2018 14:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544479676; bh=guDOEPbWIUj/mVlWhuR4e7Pw6PEF44vrZfTUxzPhAOo=;
        h=Date:From:Subject:To:CC:From;
        b=WtwsE6Qmp9xHj56yJu4n2ulw6l0CLmpLG7NsCH07gKB2BYs72kMCFzPn/FrMrPQgu
         lb3gGXBEUt05EKAORl+4WnmnuW6f5Zp//bqqehepgU9X+7iiTq4Tq8yNBN3nAMz5Uz
         47aPH6KxR9YDuaH5LmLoXJdmnOQHUvIZuAKSJJHu8/LPtriNJcrHWWWu63aIWpgknE
         HQJ2cVg06Wi6oOgcAxe4knyig0ErVRdFu5kridc0tKlQ2jmBuM+JHuByvkAE6LV+tv
         dZpdcYEQvOBsJQMFliBfWNa1hmzFnlDBcqbUHkDd9DPSkS70L0xmqFlOUkC6bdQU7/
         2HoFAhqdBmwHQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 255B33D6B;
        Mon, 10 Dec 2018 14:07:56 -0800 (PST)
Received: from US01WEHTC2.internal.synopsys.com (10.12.239.237) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 10 Dec 2018 14:07:55 -0800
Received: from te-lab16 (10.13.184.20) by US01WEHTC2.internal.synopsys.com
 (10.12.239.238) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 10 Dec
 2018 14:07:54 -0800
Received: by te-lab16 (sSMTP sendmail emulation); Mon, 10 Dec 2018 14:07:54
 -0800
Date:   Mon, 10 Dec 2018 14:07:54 -0800
Message-ID: <3aa06c4e54bf98a59e510d7a833934fce4b0083b.1544478969.git.thinhn@synopsys.com>
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
Subject: [PATCH v2 1/2] PCI: Move Synopsys HAPS platform device IDs
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     John Youn <john.youn@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.184.20]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move Synopsys HAPS platform device IDs to pci_ids.h so that both
drivers/pci/quirks.c and dwc3-haps driver can reference these IDs.

Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
Change in v2:
- Revise title to fit PCI patches' convention
- Revise commit message to include the change purpose

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
index 69f0abe1ba1a..25db0c1586ea 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2358,6 +2358,9 @@
 #define PCI_DEVICE_ID_CENATEK_IDE	0x0001
 
 #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
+#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3		0xabcd
+#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI	0xabce
+#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31	0xabcf
 
 #define PCI_VENDOR_ID_VITESSE		0x1725
 #define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
-- 
2.11.0

