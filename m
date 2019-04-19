Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2B5C282DA
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 19:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A2E21736
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 19:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2OXgmVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfDSTlG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:41:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38817 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfDSTlF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2019 15:41:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so7353689wmc.3;
        Fri, 19 Apr 2019 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vWfV/uLxHlKTCY8jgaOm/hsQsubaADZJKJWfjxs7Npo=;
        b=t2OXgmVFbBh0Y1EuHpno5rs+bEy8/NT4sQpbVkXbZhdnpPL/4pORRl5gKSQRYp9b/3
         MwlvwiYNq5i8tzwMESnUoWDyGhieiBMCgAjvdc/xib8LXe0Qsnr3fbRIngnj3MnX6aHX
         lesDND0C91IxOV5V1xS+v80lVbRg1v4bC/eOM77xPR7ryoBGX0HCDQ2IEpfFKaVSg6nG
         VXaWkQW4XYmD6J5+jSOL0nROlNk0yY16JUMV/hSjFF0ceIpBWKFfhYf4HRQ3AXdM6dHI
         H6hGwnPPfK80HboSTaxyXdnO6F75SmPI8NAYFkGFM41FBxlHliS05FOrdoPWxTXOzItm
         cjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vWfV/uLxHlKTCY8jgaOm/hsQsubaADZJKJWfjxs7Npo=;
        b=DQGodinMqGQMQC3YHVb24g/UVnChsx1MAsWCcvNdblgf85sDgob2gmtrPgDmtyrD+1
         oW2KKO8eZqKok8Awnft91wqtOXNodZTQQcInpb0GUlofnZjcqJk4ugNh0QhgJ+MRbdvw
         tBXam02j0Dy2pxVqsr8fXltJpN2DroQY/pWl20WSUAsueUZJ6KOZDy9dmvIAUIuLX83m
         8T4HbrtExZm364F/Bzx+aHIoFzRmOszF42nJsJbB8bYWPvK9aeYmN8cEsm4xmMB5DfWF
         VJpwk/VR2teNAwgCzMuuZcX8RFRkKn+JEul78sFe4SezA9D/dZ+GPkRQnbqHwoqMABR6
         PNrw==
X-Gm-Message-State: APjAAAX2OzpvW2CTOKn15l+5PukYXmh4CP0QSlMmGbZgO/vDcIgPJAph
        aL3OMC1gdrNm0s3iSYVvtJG0mrri
X-Google-Smtp-Source: APXvYqwJj5NC0zkNsl/Atrn2tJbWzRyFSf+v3WICQ6F0yeHaqLbcujdUsIG2uFo7AHDnntcbzaPbBQ==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr2289251wme.4.1555672231669;
        Fri, 19 Apr 2019 04:10:31 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:584:3262:bfe6:7518? (p200300EA8BD4570005843262BFE67518.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:584:3262:bfe6:7518])
        by smtp.googlemail.com with ESMTPSA id b134sm7324314wmd.26.2019.04.19.04.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 04:10:31 -0700 (PDT)
Subject: [PATCH 1/3] PCI: add helper pci_dev_id
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b352964f-a9a4-c8eb-520c-19b4dca4fba1@gmail.com>
Message-ID: <8e0ebcd1-e448-67a1-d4e8-bc955d895feb@gmail.com>
Date:   Fri, 19 Apr 2019 13:08:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b352964f-a9a4-c8eb-520c-19b4dca4fba1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In several places in the kernel we find PCI_DEVID used like this:
PCI_DEVID(dev->bus->number, dev->devfn) Therefore create a helper
for it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/pci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c056a7a7..28d0313a3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -598,6 +598,11 @@ struct pci_bus {
 
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
 
+static inline u16 pci_dev_id(struct pci_dev *dev)
+{
+	return PCI_DEVID(dev->bus->number, dev->devfn);
+}
+
 /*
  * Returns true if the PCI bus is root (behind host-PCI bridge),
  * false otherwise
-- 
2.21.0


