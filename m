Return-Path: <SRS0=2i2g=4M=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A880EC38BF9
	for <linux-pci@archiver.kernel.org>; Mon, 24 Feb 2020 21:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6C321927
	for <linux-pci@archiver.kernel.org>; Mon, 24 Feb 2020 21:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYdR5fWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgBXV3v (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:29:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41709 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgBXV3v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 16:29:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so12178390wrw.8;
        Mon, 24 Feb 2020 13:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JL4Q1l1W07XAcq8S0r/D3xLT9kgasro6XokOt1NtSiI=;
        b=BYdR5fWu5PM7sPeiZNrXvPjplX9eI95U0p1mvnSV2rx+HATPRQSiRSCKdo7CCa4Pcw
         ZtezCeaS7PWljCDQT7JFNssRaTxbzgDdMunmzfeG21KHdchGXf6fGugvEpAQzMSjD8hf
         FT6LrSfl8xr8RIy/o8AoHRWr1eJEE0rt2O0GXAJNHFJGm7bni6b2Gmz/AzKBCbxQ6XOd
         ejPljkC1LLv/qfzK3GBTitRaXIhliVH9MOtOqyQ4Fxd/zf4ob8lhEWy9YkSw7+3TScJZ
         T+67+cjFwIEUcpWh4qGf2L/vDh6hZp0sk/W2TMyESohKqjuW4YtsurhAcxdFZKvSJxXb
         M6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JL4Q1l1W07XAcq8S0r/D3xLT9kgasro6XokOt1NtSiI=;
        b=CFLf4PnhqGbPd/Y4C5rFUcaPDfvrEhqoVMRST4xZicgpN63UEwBuYNlRXXFI4f4hgv
         42Tor8mhhbj8tLRaedsqGZ/UUQwOtPpCmFMT6AlaJbCFlpm3Y8xZUEDzlJU4F5cCGkg8
         TR0zUaMT57IwkkvsVSvbZRQKCq9UY4SmULnGg0yga6BevOC6IsQkqGuAREnFQAu10PTo
         Fmr02hMtbTBOyfS4/Wx3ynMtMT0IZtnsjw0JkH8kyCAaRNNtcaGeVp0ympH3vOxkAakK
         tDXBblfmGa7L9i1xrwsMSIpsWnHZHSE++45ZyLpUKqq1wMamOtt4H1vdyg63YiGu1D1A
         rX4A==
X-Gm-Message-State: APjAAAUhHsEAzNGoGdP+N/iV6RQVoFaYBWG52ifQAzrQoK4KbP2ronH/
        RDyvAAoRiOntwCq3h4q4FEM=
X-Google-Smtp-Source: APXvYqzhDp5TJC5JQqwkRjCAfqOnTlJie7Wi/L1pFK3MbgQg2xK0sgSg68Wkn91IsnZr0MWo1hm5Jw==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr6032121wrv.48.1582579789183;
        Mon, 24 Feb 2020 13:29:49 -0800 (PST)
Received: from ?IPv6:2003:ea:8f29:6000:3d90:eff:31bc:c6a9? (p200300EA8F2960003D900EFF31BCC6A9.dip0.t-ipconnect.de. [2003:ea:8f29:6000:3d90:eff:31bc:c6a9])
        by smtp.googlemail.com with ESMTPSA id a26sm979781wmm.18.2020.02.24.13.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 13:29:48 -0800 (PST)
Subject: [PATCH 6/8] net: skfp: use PCI_STATUS_ERROR_BITS
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        David Miller <davem@davemloft.net>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        alsa-devel@alsa-project.org
References: <5939f711-92aa-e7ed-2a26-4f1e4169f786@gmail.com>
Message-ID: <9f708ee4-6ff9-9af0-bb3a-6ad0b48a3f5e@gmail.com>
Date:   Mon, 24 Feb 2020 22:27:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5939f711-92aa-e7ed-2a26-4f1e4169f786@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use new constant PCI_STATUS_ERROR_BITS to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/fddi/skfp/drvfbi.c  | 2 +-
 drivers/net/fddi/skfp/h/skfbi.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/fddi/skfp/drvfbi.c b/drivers/net/fddi/skfp/drvfbi.c
index 9c8aa3a95..d5937aff5 100644
--- a/drivers/net/fddi/skfp/drvfbi.c
+++ b/drivers/net/fddi/skfp/drvfbi.c
@@ -112,7 +112,7 @@ static void card_start(struct s_smc *smc)
 	 */
 	outp(ADDR(B0_TST_CTRL), TST_CFG_WRITE_ON) ;	/* enable for writes */
 	word = inpw(PCI_C(PCI_STATUS)) ;
-	outpw(PCI_C(PCI_STATUS), word | PCI_ERRBITS) ;
+	outpw(PCI_C(PCI_STATUS), word | PCI_STATUS_ERROR_BITS) ;
 	outp(ADDR(B0_TST_CTRL), TST_CFG_WRITE_OFF) ;	/* disable writes */
 
 	/*
diff --git a/drivers/net/fddi/skfp/h/skfbi.h b/drivers/net/fddi/skfp/h/skfbi.h
index 480795681..ccee00b71 100644
--- a/drivers/net/fddi/skfp/h/skfbi.h
+++ b/drivers/net/fddi/skfp/h/skfbi.h
@@ -33,11 +33,6 @@
  */
 #define I2C_ADDR_VPD	0xA0	/* I2C address for the VPD EEPROM */ 
 
-
-#define PCI_ERRBITS	(PCI_STATUS_DETECTED_PARITY | PCI_STATUS_SIG_SYSTEM_ERROR | PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_SIG_TARGET_ABORT | PCI_STATUS_PARITY)
-
-
-
 /*
  *	Control Register File:
  *	Bank 0
-- 
2.25.1


