Return-Path: <SRS0=66QY=NV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F036C43441
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 23:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FA8208A3
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 23:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUP5E1LJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FA8208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeKKJeC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 11 Nov 2018 04:34:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53257 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeKKJeC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Nov 2018 04:34:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id f10-v6so5140237wme.3;
        Sat, 10 Nov 2018 15:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HWWOCCepgSXHQgzfE415oC1PwWSbKWO9Ub+fR7s9QAo=;
        b=DUP5E1LJyWJrFUOtaotH4280muYOqoLqflRA/hL8JH18MpMm0NIFx5Hrr6owNluZhj
         KBsefViRsWKMQoDkniqMxrs8Y/tdpcRD89BTRyjAcndI7C5r606cKsk2EaP/8AdMmp9j
         whvoSoD0R5XmAa3HYcuETVnJqrSpwYPXET4KzidF4cA/qKiodSZ8M4UhbpRiBjKIgjDh
         9P5a4aqtGH8ZLxIjGFu2hRatVcSyf6CPOi1ufnghaT04O38tMmY6jiPw1uGoyMsZedex
         qbOBHDimTsbYw/qLZ0JF7v8EoG+UeLtu5lbS/kzaksjEjo3smWzB+5XqnbB4IUKtV3kA
         rJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HWWOCCepgSXHQgzfE415oC1PwWSbKWO9Ub+fR7s9QAo=;
        b=XgGXqV2AN1RtU5keEuSmaQOYOrKPo3HRP+VewFuXEE8S71x7AB3XDvJITZxu0HtZTQ
         Z7JgnPtnwEb3lqyTj7USk2eLNtWfPi50/HYOsQ8q9jUJAbE2a694xFSERbR0bzo4XhC5
         fdJvXnBNDMZcq59pmgYKtLJvkEVCKG7/DQdDkPxtoeCq0Vvvrf1gXFy5lDu9vmKTPPf9
         aRxX5Bz5YWqx/fCCrywK9EA5sW5vY2K0iJ1KRGyaW/Qkt8BOVSrME1p8zfdEzGRxiblU
         36w4fV/JGpvw0S2jQdYoIMFsgao3WnJURdrvqjq59PCFKjfwCH1BPTxOu3H3u4eA4UN9
         qmkQ==
X-Gm-Message-State: AGRZ1gLyfxxBu3MPGD0ibCoqEoVUfgoYTI9NHAk/6E/iM9uzuiqqsvaQ
        wQ7r22CC0CjOKEYujFqSJojh1+3+
X-Google-Smtp-Source: AJdET5eUVc/YsMsl70ZmRQRIAdwWPMBtdg1d7vscX0c+br0WHjnoRO+E4EMf+MxI1LyHuQb5tS7nLg==
X-Received: by 2002:a1c:be0a:: with SMTP id o10-v6mr3773046wmf.111.1541893637256;
        Sat, 10 Nov 2018 15:47:17 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:d9f3:aa7:2f30:4a3a? (p200300EA8BCFE300D9F30AA72F304A3A.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:d9f3:aa7:2f30:4a3a])
        by smtp.googlemail.com with ESMTPSA id z17-v6sm10296706wrm.65.2018.11.10.15.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 15:47:16 -0800 (PST)
Subject: [PATCH net-next 1/2] PCI: add USR vendor id
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <9af6abf5-ba01-155f-17d1-ca4b71b74fa6@gmail.com>
Message-ID: <71caf048-3f24-6241-b39c-ad1f5bd086c9@gmail.com>
Date:   Sun, 11 Nov 2018 00:45:35 +0100
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

Add U.S. Robotics (USR) PCI vendor id.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

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


