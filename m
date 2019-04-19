Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C97FC282DF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B7920652
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+/oC/tF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfDSS1y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:27:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37743 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfDSS1x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2019 14:27:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so7866718wrm.4;
        Fri, 19 Apr 2019 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6l7S7SPWYGQuKR+ZqqxXg1trUc0LGvi+gxvCn6r7RQo=;
        b=s+/oC/tFa2nx876SBSbvLQeGa90Nepk/794jBYOv1F/IP0MCnHeu0uKc4e7WJHfpZE
         xkyrkPNoqt+1GCsKAYzeInH6MJbBtQ2NWZSWjLYfmtsw732KwPhnmtuOx4Q/HAi4ioGE
         SQDJbvzlIaYC8B/jnQTr4qMz3yOP9F46Lx9k8ldCLVAfk2QK106yc/PAQMmAhj9RWOwO
         MsKFJU5ZrkQBSYjY/QkasDY+/BPMN8h5KSfS7ezhGBCso1A7ix6a/w9lNnfg4ZUy+h3D
         KtghJnbVfr3IJCE8212bfu4JZBV0cINWvf35mdmBOEk0xjuUrj/JcngavOTZk7p+FxHD
         2jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6l7S7SPWYGQuKR+ZqqxXg1trUc0LGvi+gxvCn6r7RQo=;
        b=jtnLGYwhBpLvO+/z0RhP8xgUv7C/ChiI0t+tbgJbDBP6Taqsoa93JaNygS1TLVoIpg
         c+LpWsynCakvtZe+bqR6vqZZigCcM7xvPNH2gtHjDepbL6FXUaKvlfaKrOEp2FJTYMyE
         TpdTSBVXwwwfetx0slI/x/3hg++4+BOhNqsmhyCtWFUZtirEMhLeMLaxDzDhqhqpt7nq
         Tcwt4yCqgNJuwruWv6rVmiihbxn1/rSBCn88Im+/9R3Qc0JFDyLS++Q9OCBoc4rdssv4
         qg8HQdiYpYxauSdGpfP3E3m7bGIeS+eBu4Tv3T+prxbBxCbnaIzgUspdp2hN1CPrJXzV
         AuiA==
X-Gm-Message-State: APjAAAW7MUggGKk2eLrM1JuXrHH64sK0xbXqxdDo5gDUemJl1hg50I7M
        qOIVBl5txQzX+tTbZwFvAA2asMSH
X-Google-Smtp-Source: APXvYqz4z6hyO18fny4aFEUxWr8QH+ylPQ/D6zcnZhP523SRwKWmUbRWy1yqqqRJdywrdHgVzoFDcw==
X-Received: by 2002:adf:f488:: with SMTP id l8mr3912230wro.213.1555698471638;
        Fri, 19 Apr 2019 11:27:51 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:584:3262:bfe6:7518? (p200300EA8BD4570005843262BFE67518.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:584:3262:bfe6:7518])
        by smtp.googlemail.com with ESMTPSA id l19sm10320072wrf.35.2019.04.19.11.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 11:27:50 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/3] PCI: add help pci_dev_id
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <b193514c-23d1-e090-7ddb-40371595f3a7@gmail.com>
Date:   Fri, 19 Apr 2019 20:27:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
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

Heiner Kallweit (3):
  PCI: add helper pci_dev_id
  PCI: use helper pci_dev_id
  r8169: use new helper pci_dev_id

 drivers/net/ethernet/realtek/r8169.c |  3 +--
 drivers/pci/msi.c                    |  6 +++---
 drivers/pci/search.c                 | 10 +++-------
 include/linux/pci.h                  |  5 +++++
 4 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.21.0

