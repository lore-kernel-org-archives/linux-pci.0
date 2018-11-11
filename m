Return-Path: <SRS0=P2LY=NW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7C0C43441
	for <linux-pci@archiver.kernel.org>; Sun, 11 Nov 2018 10:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F0D21479
	for <linux-pci@archiver.kernel.org>; Sun, 11 Nov 2018 10:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY74k029"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F0D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeKKUib (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 11 Nov 2018 15:38:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41531 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeKKUib (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Nov 2018 15:38:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id v18-v6so6259314wrt.8;
        Sun, 11 Nov 2018 02:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5kTx2HB8ae+vHqTJdFKw6PM45/e6xYCcRZtQFIvqnvg=;
        b=SY74k029FXZy5aD6lrwPjCHLRjH+x11oHYI5xtEQaWSIVUXt3/BL3sDlvhXGnTkt5q
         jwZ7cmMJ6VSStKuPBw//uIuqN71PiIDi69lNkVHg288jlYdA5hF3HiAaVgRpqZGPglfW
         TPqT7msB2booLKdQS0NlIC2qpFjPO6Ec8gsgdlXbaifVZDZt6LR0S4Cg8niFVjKXhdPn
         JpG6pMpzMGdVr8H5evaxhmPUoWpp9KNW/xfCEN99zL2tSMS2ydVkZoeBNLHqI0pcCmWR
         Z34v875lP74k85CAzA70zXQBxj5yoMKaEsm1qV/PwLLbHivNGAuhxvK3Ix5mW9pG17Fx
         Ygow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5kTx2HB8ae+vHqTJdFKw6PM45/e6xYCcRZtQFIvqnvg=;
        b=sqvlsEyeTncM5NOgFeoL77Me2YPnJaidzRmcGmAzOE3lrx7759E6oG4ebWfPzUwhmP
         IpK9uQP403yKj3KKwnVvdYQSzS0bNJYHozfoi1Mbp4Ak95sa9+HPfEaXjh3bOBkK+4Ik
         CjB1+Ob6xT13lIx4FiNiaNh+FMz5xLqfkIag+HXBMjk/aT5BZJQn1c6Wj0hYWLQYb8S4
         Rl1TgGr7cUt5RpDS2S30YS9D6VP5TM/7RCts/6WaApH5dcvfbEgFY7GVwgzvKnEXx6dJ
         H54U1Xt/0h3ti+LaLS/MbgxYWr25xNG7dCDL/wJFEGDXKnh5n0Apdvu57a2BvLEKVh0a
         b5TA==
X-Gm-Message-State: AGRZ1gKew3STQ9KFdlrvymAHKlIdO4g2V3ULGbEBWDjrEzYjrgfbgbJc
        G+VP0WBP+EdV7aYS3s/9zyFkalkF
X-Google-Smtp-Source: AJdET5cjJ/pEdZd/wDVU5COAFRIj1AW1olx/UO+2rgHD+P+5+e4Zmjy0atf3QWezqndLzWZASQRhSw==
X-Received: by 2002:adf:e581:: with SMTP id l1-v6mr14166674wrm.253.1541933416018;
        Sun, 11 Nov 2018 02:50:16 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:f17a:46e3:af68:58f2? (p200300EA8BCFE300F17A46E3AF6858F2.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:f17a:46e3:af68:58f2])
        by smtp.googlemail.com with ESMTPSA id w11-v6sm14905280wrr.96.2018.11.11.02.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 02:50:15 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v2] PCI: add USR vendor id and use it in r8169 and
 w6692 driver
To:     Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Karsten Keil <isdn@linux-pingi.de>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <9af6abf5-ba01-155f-17d1-ca4b71b74fa6@gmail.com>
Message-ID: <f35fbe1d-b1f3-c0f8-82d6-18b0c7cda0b4@gmail.com>
Date:   Sun, 11 Nov 2018 11:50:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <9af6abf5-ba01-155f-17d1-ca4b71b74fa6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI vendor id of U.S. Robotics isn't defined in pci_ids.h so far,
only ISDN driver w6692 has a private definition. Move the definition
to pci_ids.h and use it also in the r8169 driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- The original patch caused a build failure in w6692 driver because
  it broke the private PCI device id definition.

I hope it's ok to submit this through the netdev tree.
---
 drivers/isdn/hardware/mISDN/w6692.c  | 5 -----
 drivers/net/ethernet/realtek/r8169.c | 2 +-
 include/linux/pci_ids.h              | 4 ++++
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/w6692.c b/drivers/isdn/hardware/mISDN/w6692.c
index 5acf6ab67..f6b4f4f11 100644
--- a/drivers/isdn/hardware/mISDN/w6692.c
+++ b/drivers/isdn/hardware/mISDN/w6692.c
@@ -52,11 +52,6 @@ static const struct w6692map  w6692_map[] =
 	{W6692_USR, "USR W6692"}
 };
 
-#ifndef PCI_VENDOR_ID_USR
-#define PCI_VENDOR_ID_USR	0x16ec
-#define PCI_DEVICE_ID_USR_6692	0x3409
-#endif
-
 struct w6692_ch {
 	struct bchannel		bch;
 	u32			addr;
diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 1fd01688d..366a690eb 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -224,7 +224,7 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK,	0x4300), 0, 0, RTL_CFG_0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK,	0x4302), 0, 0, RTL_CFG_0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AT,		0xc107), 0, 0, RTL_CFG_0 },
-	{ PCI_DEVICE(0x16ec,			0x0116), 0, 0, RTL_CFG_0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_USR,		0x0116), 0, 0, RTL_CFG_0 },
 	{ PCI_VENDOR_ID_LINKSYS,		0x1032,
 		PCI_ANY_ID, 0x0024, 0, 0, RTL_CFG_0 },
 	{ 0x0001,				0x8168,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 69f0abe1b..1fac231fe 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2359,6 +2359,10 @@
 
 #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
 
+#define PCI_VENDOR_ID_USR		0x16ec
+#define PCI_DEVICE_ID_USR_997902	0x0116
+#define PCI_DEVICE_ID_USR_6692		0x3409
+
 #define PCI_VENDOR_ID_VITESSE		0x1725
 #define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
 
-- 
2.19.1


