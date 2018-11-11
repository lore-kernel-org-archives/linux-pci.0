Return-Path: <SRS0=P2LY=NW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81198C43441
	for <linux-pci@archiver.kernel.org>; Sun, 11 Nov 2018 19:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F6C214E0
	for <linux-pci@archiver.kernel.org>; Sun, 11 Nov 2018 19:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6nSlkCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F6C214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeKLFUz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:20:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32959 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeKLFUz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2018 00:20:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id u9-v6so7061168wrr.0;
        Sun, 11 Nov 2018 11:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fTXrcxPGhOwvLbQIKch1/lWVLEpF3+zBUaTfcsmQYHM=;
        b=T6nSlkCklFgIhJUVE3A2Jxr1c6111dS4mB4qW8W+/8P2mfaEctMKg6TBlKIirGHsZ7
         80WbkVuP3gVJrRNtnpnk3cN2cJcfT9cF3xWzQhPUlDRbOvz2DQcQQyXW/UvAF3RJTcTj
         nwPJmhP6dQp0A1sghFyUVp8/Zz8CI8PUO5L0f07vjDMONQuT9vbW8VT8IXnSsuMrOWWN
         fb7l60539mSKouYRjVLGm1Ewwe3pi7GMaxpCqeFrFhO4YcFFXIp4WgFnmEWdVljiAmpH
         yPr4kDSrgaNbLUezcabohfZHnoU4acUuk3pWWB5S/2hlKcbjvmseZ4c49D5RewTgdPOe
         NaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fTXrcxPGhOwvLbQIKch1/lWVLEpF3+zBUaTfcsmQYHM=;
        b=gLyBvDMMfxOcvStuxQIt7z21LfZA++iJkhmU9zBWmysI3prYUAmpVUsnRv3ZPnw6XE
         Qc9ZkSLZTivU3zaAc0lH4lC3kfwxYTv7OxHNqUwyaxUz5jHTSW+jOHRqFhiY+zxYCZji
         osAO8kyx1K+YVdcSl7sdXD4IQmyw+pWAlV4OHldLb6+Cgxrd05DGRMdoaFPrjXJSw3Bm
         4WgqkdUM1cHE7+2kmntQQm1hbd71+k0NDsgaKwrwO96obq2oyXWlF9ZHwjY942Pa7Ryz
         G3bWtQiAWvWYJh7UwxcL0L27JQPW0xvzCJDfvmu7oJrz9tPGAbV1d7V+86juYZWHXQXV
         vjeg==
X-Gm-Message-State: AGRZ1gJCiZgIME7cDR03WBXWeXGStXIK5axxEAgjrYCXwtYmHn5vIG1f
        0nKvxXIUpiYxHXgEmTVV3itCU1Y2
X-Google-Smtp-Source: AJdET5c1yWiqDlluIeaLKaijxCmSkIMcRPqDi1paZFqIWMoA2flSi/BFmH/Hv2lkM6hySpdTZVu07A==
X-Received: by 2002:a5d:4a11:: with SMTP id m17-v6mr14309235wrq.259.1541964689904;
        Sun, 11 Nov 2018 11:31:29 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:f00f:a30e:a742:e444? (p200300EA8BCFE300F00FA30EA742E444.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:f00f:a30e:a742:e444])
        by smtp.googlemail.com with ESMTPSA id p17-v6sm5340389wmc.16.2018.11.11.11.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 11:31:29 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v3] PCI: add USR vendor id and use it in r8169 and
 w6692 driver
To:     Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Karsten Keil <isdn@linux-pingi.de>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <9af6abf5-ba01-155f-17d1-ca4b71b74fa6@gmail.com>
Message-ID: <a1c56e9d-b427-af43-840e-c527c79feadc@gmail.com>
Date:   Sun, 11 Nov 2018 20:31:21 +0100
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
to pci_ids.h and use it in the r8169 driver too.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- The original patch caused a build failure in w6692 driver because
  it broke the private PCI device id definition.
v3:
- Don't move device id's to pci_ids.h because they are used in
  one module only respectively.
---
 drivers/isdn/hardware/mISDN/w6692.c  | 3 ---
 drivers/net/ethernet/realtek/r8169.c | 2 +-
 include/linux/pci_ids.h              | 2 ++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/w6692.c b/drivers/isdn/hardware/mISDN/w6692.c
index 5acf6ab67..6f60aced1 100644
--- a/drivers/isdn/hardware/mISDN/w6692.c
+++ b/drivers/isdn/hardware/mISDN/w6692.c
@@ -52,10 +52,7 @@ static const struct w6692map  w6692_map[] =
 	{W6692_USR, "USR W6692"}
 };
 
-#ifndef PCI_VENDOR_ID_USR
-#define PCI_VENDOR_ID_USR	0x16ec
 #define PCI_DEVICE_ID_USR_6692	0x3409
-#endif
 
 struct w6692_ch {
 	struct bchannel		bch;
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
index 69f0abe1b..144de2e89 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2359,6 +2359,8 @@
 
 #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
 
+#define PCI_VENDOR_ID_USR		0x16ec
+
 #define PCI_VENDOR_ID_VITESSE		0x1725
 #define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
 
-- 
2.19.1

