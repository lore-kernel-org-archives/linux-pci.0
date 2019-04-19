Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB99FC282DF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A082420449
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+dOyYZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfDSS35 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50341 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfDSS35 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2019 14:29:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so7114223wmi.0;
        Fri, 19 Apr 2019 11:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vWfV/uLxHlKTCY8jgaOm/hsQsubaADZJKJWfjxs7Npo=;
        b=F+dOyYZ0RsbzbIGK213VkRKGrvxxyCo0hDe4wwlXFEyOoA8BQfqtWFdOnPOINJTfwq
         49WAvwvzlBCfBJjN/pIP9vUidpJcXA0nt+K3R59jnH/BNnjFGJ2Gt8RZg5BMnNb2jTdW
         1GTL8Jzeg0HjCHc8uiVaMBX8sEMcFavCsHP5SwYxV7IDU31QFAv0/tJ42EBVbj+OhiUr
         CJrMbot1naJpPmOV3z8saT1JnGk7wT4YpiVcG0ZArfhmFP2WRWwJvaFfn+4jczOA2G5C
         JZhKEPBdw6y3uLZxJtH9GMlZfdDbFMYs8jMHjhaX0BR9OPRQahBr0WWumdu0ocWkjZY/
         zHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vWfV/uLxHlKTCY8jgaOm/hsQsubaADZJKJWfjxs7Npo=;
        b=T6FfjSPi7vRqzJZTB1QM1CUkKQMsmlcy4bHOGTeR4aAoSQVAlzbHndQtQMFfdXu9U3
         E7C2bJB5hJI3taZ7XC+Z39SkGVoXUkS+k2qVXfDo/aFheRQAEUWa+tLmexeds6Mw9U6I
         KPdpIZjLG7A1FP4MDlkdDvpQX7Bulwt9r5rWzJTz3hNzUG8a4soPZoKU9STLL6MnKkoO
         1/O96M7f/jQOLPi9aPbStBCQX5u4qn1F2eGhc7MF71um51Q2kdgOzcV4OJ2NvKurQkhR
         srNjTHnBanWP4cIhHJMhL7o9vrRmyVsxeZV1hLETE0qY3IwxYF9BoLTCaF8mWERZk9tg
         zz9A==
X-Gm-Message-State: APjAAAV13ZhGDLw2iU1d9mYVkHGzAbEbM9YjWQmtff6H3UHlH0jsx/6Q
        FsLl/GwNE2Ce67A3yqAhy2qpVEiD
X-Google-Smtp-Source: APXvYqytvq0t1KzkgSvYQe/aYcAhCgEYXXHfJOi5u6oXlsRp31Alc7egojH4H+s/wTo4ldu+lmOu9g==
X-Received: by 2002:a1c:7a03:: with SMTP id v3mr3337683wmc.58.1555698594976;
        Fri, 19 Apr 2019 11:29:54 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:584:3262:bfe6:7518? (p200300EA8BD4570005843262BFE67518.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:584:3262:bfe6:7518])
        by smtp.googlemail.com with ESMTPSA id l12sm6061342wrt.31.2019.04.19.11.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 11:29:54 -0700 (PDT)
Subject: [PATCH 1/3] PCI: add helper pci_dev_id
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b193514c-23d1-e090-7ddb-40371595f3a7@gmail.com>
Message-ID: <b3967e98-31a4-7471-e5d1-4a7ca544c208@gmail.com>
Date:   Fri, 19 Apr 2019 20:28:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b193514c-23d1-e090-7ddb-40371595f3a7@gmail.com>
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



