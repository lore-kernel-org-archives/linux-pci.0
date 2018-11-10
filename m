Return-Path: <SRS0=66QY=NV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E5CC43441
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 23:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C23220989
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 23:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvG7HTLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C23220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeKKJeE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 11 Nov 2018 04:34:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44451 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeKKJeE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Nov 2018 04:34:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id j17-v6so5536390wrq.11;
        Sat, 10 Nov 2018 15:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gzeQEmjg21C3zotdRTcb6xI5d1u3pfEGHj14X0Dhlig=;
        b=hvG7HTLyhDVZhaZgwUDD25fHd8z9E4zgKNW25HEBcPJx1ZLAMRmJDgtNcDskNWTr+8
         GyUk043gJPufh1TGo6XtVn7nfFEIfVkYkht0M813CxkfidL7bOaMyHenqOMr6h1BO/7d
         tZ8ZIZx/hqFgXWcTebwYHVJN1mrxXKqsSTEoZd1s1gZrAMhjUxzAsQSx0IBohAdtLRrf
         HIxXM9qOlf2C2Xc+QjliYvtzuxWlPJ+Kvf57WvVRbdzw2bbzKzY3ApNMmaR6+FFBwgah
         zyukAAQsVh1lDZx89Jgy+FpG2hUHpLe16YTCkAznwmizVjHquxGdV5SPxtWFF07J+/ah
         /Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gzeQEmjg21C3zotdRTcb6xI5d1u3pfEGHj14X0Dhlig=;
        b=obBuiUG+QrS1HPFpdn2S05UWmWk+9cS3StXrSqYj34isIZqpUG4sUUt1whZdyVdjC7
         Y6VFYGMAYIV4yOv2tifHLrzrEAXDahhEpF0Sa2dZ5qitO+U75wuYR8tsG8aOZqUpLyy8
         Q7t2CbY5JocKhKRfIukvNOjy/5ZxE3IEXorRa5iA+9MBDq+D1d7bVfTy7++oM3MENCKn
         u/CBsIee6zCct8ePDKfVi4KGUn/YrPbWwFSBudCHqri8rOemAl6YCP7ko9iZJ0lougeP
         FdsiMvtlvmofHf52vz9f0L67FEmxELVeAyestVCzU8k2ld4X3c5fmGp6rZigf7oGHiv/
         NBqA==
X-Gm-Message-State: AGRZ1gLM12Zil391h3J8ubrjlYaIAwPDbT6nL9Cp7M3DqjizZPbCPbm3
        wkZXYYKVTks7f5xigWht2HSRAEv5
X-Google-Smtp-Source: AJdET5c3+pKlAC/xIWtTHPk/GBAUOU/4wMTPFP/UBsr8c7G8o2GRnxp+OgY8gGkYipCALlsdJzFw/Q==
X-Received: by 2002:adf:dc87:: with SMTP id r7-v6mr13704572wrj.143.1541893638683;
        Sat, 10 Nov 2018 15:47:18 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:d9f3:aa7:2f30:4a3a? (p200300EA8BCFE300D9F30AA72F304A3A.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:d9f3:aa7:2f30:4a3a])
        by smtp.googlemail.com with ESMTPSA id r19-v6sm4653748wmh.0.2018.11.10.15.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 15:47:18 -0800 (PST)
Subject: [PATCH net-next 2/2] r8169: use proper constant for PCI vendor USR
 instead of numerical id
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <9af6abf5-ba01-155f-17d1-ca4b71b74fa6@gmail.com>
Message-ID: <ab53d128-b19f-ca87-f13d-ba034f020cd0@gmail.com>
Date:   Sun, 11 Nov 2018 00:47:10 +0100
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

Use proper constant for PCI vendor USR instead of numerical id.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.19.1


