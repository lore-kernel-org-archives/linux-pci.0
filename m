Return-Path: <SRS0=v2Vw=SP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2AAC10F11
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 09:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D2120850
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 09:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSjtQ8tI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfDMJKr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Apr 2019 05:10:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33474 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfDMJKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Apr 2019 05:10:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so2131348wmi.0
        for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2019 02:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Lz+S74TQ3JzftUjOGEN3NVlIl60DbMqT7jeAoniguhE=;
        b=dSjtQ8tIW6ZejR1//t15ejx9sYYpqB0Pi52/gMEg9/KgZs9ih7no7D6WxicIc4+rQc
         cehEgOzGTYaw60/AEgfQIjOWrWnwk/dEwa4OaE4wWiRzAa/C0KRwXG1aeaJa0Mz5zpd/
         78NY6BueRDpC+qcQd5kwqw3LfIOrkNhOblFuCCYNhxXybnGu8TC1QH0r9R0f1OKdZRG7
         6Xgu4tdZTCqQtxUeYMWHqqLoEbaY+GFgsnQUQvKmidrOFyq2YN0xYgW2Al1BIGnGNhMm
         vIGU9TFcnRPjmEe32F3Pf1TJuyAnxbawijwm2ihvAMiCU4wStl49p+ICOLULpnYu4ES8
         5VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Lz+S74TQ3JzftUjOGEN3NVlIl60DbMqT7jeAoniguhE=;
        b=Is8eo760Vzvt8nR9BAGT+29utWzZjrxS04pMld6Huqofy8sPFp3svGw6IB3iuUklmo
         E21ZpWwpz3qkaAiKYe0/EcMGHeYex99pC3smNthjcJbE96jrYIQPM+qxbpCxDeikZPwN
         hwW1H+E5T41uxrubx2OUAjPBIkawy3KUO/nX+F2FEKFAEjPPShB+HUwULcxwqhe+iaRS
         0Al1wk26spEPxEIq0WugYICy+hBhc1WzdQA1mYuo5EBT3TDNKpUyiCgc260sfxvIHNgL
         S5FstRHb6keJ+kvisT0+s4iOMrYnQzuGZeC6hC+K87ut88g+eEedQMrHUCoA06+Y/U8O
         b5ng==
X-Gm-Message-State: APjAAAVSPGdY0MfFxKdkhJu/Bf7mBkcNt9t3HpvYKlPBEPJvhNWm3jeH
        pBA5lG8zC2Vx9eZKP96v/L08mSpW
X-Google-Smtp-Source: APXvYqzJrtS3mGjxxdbj/wJnvU7g2u3Rgxyn854T7l7+DPRFhA7rLjexW523uc8oKPQ8mVJpRZXxBQ==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr14692096wmb.39.1555146644995;
        Sat, 13 Apr 2019 02:10:44 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:6509:80dd:f4f:5628? (p200300EA8BD45700650980DD0F4F5628.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:6509:80dd:f4f:5628])
        by smtp.googlemail.com with ESMTPSA id u14sm38028022wrr.1.2019.04.13.02.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 02:10:44 -0700 (PDT)
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RFC 0/3] PCI/ASPM: add sysfs attribute for controlling ASPM
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <e63cec92-cfb1-d0c4-f21e-350b4b289849@gmail.com>
Date:   Sat, 13 Apr 2019 11:10:38 +0200
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

Background of this extension is a problem with the r8169 network driver.
Several combinations of board chipsets and network chip versions have
problems if ASPM is enabled, therefore we have to disable ASPM per
default. However especially on notebooks ASPM can provide significant
power-saving, therefore we want to give users the option to enable
ASPM. With the new sysfs attribute users can control which ASPM
link-states are disabled.

This is a first RFC version, therefore documentation of attribute is
still missing. The attribute handling was inspired by the protocol
attribute handling in drivers/media/rc/rc-main.c.
Attribute syntax in a few words:
none: allow all supported ASPM states
all: disable all ASPM states
+<state>: add state to list of disabled ASPM states
-<state>: re-enable ASPM state if supported

Heiner Kallweit (3):
  PCI/ASPM: add L1 sub-state support to pci_disable_link_state
  PCI/ASPM: allow to re-enable Clock PM
  PCI/ASPM: add sysfs attribute for controlling ASPM

 drivers/pci/pci.h        |   8 +-
 drivers/pci/pcie/aspm.c  | 204 ++++++++++++++++++++++++++++++++++++---
 include/linux/pci-aspm.h |   8 +-
 3 files changed, 199 insertions(+), 21 deletions(-)

-- 
2.21.0

