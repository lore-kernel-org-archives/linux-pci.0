Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18024C282DF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCDB222C5
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsyPOtzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfDSS3C (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37600 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfDSS3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2019 14:29:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so7213614wmf.2;
        Fri, 19 Apr 2019 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6l7S7SPWYGQuKR+ZqqxXg1trUc0LGvi+gxvCn6r7RQo=;
        b=UsyPOtzVHm3I0UkOBszzQ77Omi2U5u8BdxakDn+AV/t8dVImxap9jXETQmpHUOnSsD
         W0wysgaMnV3MiyEU/I3oO8eWKrXhdxDEkvL6WCPE3g3ueVkX4XICMSk0D521sXgQJx9j
         +12oG20xlPjJbr97oUMelIbHRxJlwUCaOIBFPldTYIGz5pKCIQWg2c0PofA7Q9FoaIsU
         SJLxLUS6zXBz2MqpCJOsBa/3Agasq0xfNy+aaaNlW7OX8N75oNmnYyxBA6B5Xz1NgW6I
         RJC5gVOiy2Zz4PKD2yZsijnwrIVWxZq/UnZDVTCYFngG0CRw+i4WR8P0TiWZbCJE75Re
         RTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6l7S7SPWYGQuKR+ZqqxXg1trUc0LGvi+gxvCn6r7RQo=;
        b=mFLKX7Bw29Kxo3kUBiH+mLDJDFIM34tGYoznwzcQmQWlCAETKKqcsjGltLZttljLHj
         6cxA1P9slMLTRru1srzeZbrCSwniM7p0BP6w3G6WMX+ThTXnsaZApQ4Q9PtOHbd/Rc8P
         0g7Lvf0QblMQq3ddWJpW5lHnpB/bmJx5MOwlQ9SjJNj495j9xc1yXghpp2amkVf43AQ5
         DpkAvFgz6Y3EtyHT1SmdItNG+2GKClGK2pVSvxpKHl7j20hNZhNcPTQfR6o0roGeVOqu
         /5fHRP2EHAGAv3zW6OSxZW0ax3azsmrnxBqypmYIpshG9RfNR3A1Mzm1OTE2Acemb/+W
         2CqA==
X-Gm-Message-State: APjAAAXvQcEf3uU87t52T37MVcFLAKRw5VW9EKmybkrWDvQANv+oYF3/
        8NB5ntDiug9Z87qOCg/9SqiDSn74
X-Google-Smtp-Source: APXvYqzC9imXLsRBzLzeVssgCL09Jp9D+gRNGdu4XqROWul+O3QEWx0Y+nlXb9EFelRvq4wXJ+UEog==
X-Received: by 2002:a1c:9ec7:: with SMTP id h190mr2433106wme.105.1555672089918;
        Fri, 19 Apr 2019 04:08:09 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:584:3262:bfe6:7518? (p200300EA8BD4570005843262BFE67518.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:584:3262:bfe6:7518])
        by smtp.googlemail.com with ESMTPSA id h10sm6821422wrs.27.2019.04.19.04.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 04:08:08 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/3] PCI: add help pci_dev_id
Message-ID: <b352964f-a9a4-c8eb-520c-19b4dca4fba1@gmail.com>
Date:   Fri, 19 Apr 2019 13:08:03 +0200
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

