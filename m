Return-Path: <SRS0=66QY=NV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE000C43441
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 23:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED6C208A3
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 23:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urW6gz4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED6C208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeKKJal (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 11 Nov 2018 04:30:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50647 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeKKJal (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Nov 2018 04:30:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id 124-v6so5195490wmw.0;
        Sat, 10 Nov 2018 15:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bJsukULvC9Sdzp709I9Fk1xhrTO7DmzaoF4pg7I8+4Y=;
        b=urW6gz4VCNvFOqotb4of1GfWa59UC+DzAkB1WKG3PR1WVpav02is2LACdTEubIfG/d
         GnLnycObTMp++IVIvfiMI84NoXQ1LjshUsy95rRwjO7S+ptH+UTqjXo6KsKTse+tPH6G
         wX0bSyKnqeiOC0ZkYuNTdCb+unEtt0sgx1EFZpOz64TuT5g8boxXUyEAalqzF2dSLrBZ
         Ch3qisAoT5C2o7a3kNLbNWbCplECQDHy3AKgm2rz0Zlq+OoZfSLzn7LcoluDWWv+8/WF
         GGCYqjSlM1ViZCXfS4Fvefc6tJRAkPQb7arHZ5QZrDwB7T/WfSkwJVAhoHmI5bC171Zw
         Yz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bJsukULvC9Sdzp709I9Fk1xhrTO7DmzaoF4pg7I8+4Y=;
        b=a7MwZNXL/xoiZfBBi6iFyFTIRfOanl+NpUK9vwjhBCWr0JH77NLDN87BHL5dOOFfeN
         aYc1uQWZYen7rn58rqdEHUgJKI0URSnYtwsNhB03ABoQBpKua9YZncNbrs79VD0CmxS8
         KFyFwzUKAALFLF5t2J0p5OaEpPmOrDtcPXliH5TVisR4DtFq2CAhMMhRWA12QvJIV+H/
         o2056RYJalbbWbjt6ajSLYvpaK6W+V7c44bMjnauqElcGtRJ1kHRjai1gA+nQHYjGlXk
         X2yww4FwpnFuuIZvmhbhQCyXOtnLiiYS4lEMxfi86sgLukdMsQSM0SwhJidZTGZws89V
         cInw==
X-Gm-Message-State: AGRZ1gIN2/CcMskxabXL9bE8eiQkDRATNpJ09lUqz3FKpCjFYHgV6RgH
        MujRqepkID1x1Bh/7fJvW//3aMtD
X-Google-Smtp-Source: AJdET5eKPlrAQPtFlTAIEcE8tTInPT3rMolTMLF/PdL9eeilzsg9cAoBzoU6IaKD+Dp3zaaJX7Nteg==
X-Received: by 2002:a1c:13d2:: with SMTP id 201-v6mr3452981wmt.58.1541893436819;
        Sat, 10 Nov 2018 15:43:56 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:d9f3:aa7:2f30:4a3a? (p200300EA8BCFE300D9F30AA72F304A3A.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:d9f3:aa7:2f30:4a3a])
        by smtp.googlemail.com with ESMTPSA id r188-v6sm7212695wmg.19.2018.11.10.15.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 15:43:56 -0800 (PST)
To:     Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] r8169: add USR PCI vendor id
Message-ID: <9af6abf5-ba01-155f-17d1-ca4b71b74fa6@gmail.com>
Date:   Sun, 11 Nov 2018 00:43:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add constant for U.S. Robotics (USR) PCI id and use it in the r8169
driver. Alternatively this change could go thorugh the PCI tree,
up to Bjorn/David.

Heiner Kallweit (2):
  PCI: add USR vendor id
  r8169: use proper constant for PCI vendor USR instead of id

 drivers/net/ethernet/realtek/r8169.c | 2 +-
 include/linux/pci_ids.h              | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.19.1

