Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EE3C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 06:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8377D207E0
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 06:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uADts5J0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfBVGQN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 01:16:13 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46566 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfBVGQM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 01:16:12 -0500
Received: by mail-wr1-f46.google.com with SMTP id i16so1016603wrs.13
        for <linux-pci@vger.kernel.org>; Thu, 21 Feb 2019 22:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=WKPp4S+S6Qcx9kPhdJ9UW18YHyGmRi5jXvCTjjFUJWQ=;
        b=uADts5J0m3r7CwZe5vbjppPk1Yw+ra/eNOICcc8sTp/sBPmDKxhc2MyvDvXFPiy9wT
         8T/UcHbPSGXyHKd5CFQwGNldV20UJ5VABuFx/dtkm7wZtjgeM6Ir8YrnKfHzE7jFrqJh
         4IaBkA/Aa1bQr+aftx3x+zPAESkIBdzCefNosPh8luFXPhPgPNz2V3kOMXmOr7eZqqE5
         3+nA136iHbrIcLAsWJx6H8yMI9aFGvYDFMJ5V0UZcyd6k1czrWTZGyB5mIAsx9pDx2OC
         6ptjIvBzMDYOULH24OpqWClGwjmDEfuT9pyAjplrGiU5QjsFdzKGOUtxtDujL0vy2kAO
         9kMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=WKPp4S+S6Qcx9kPhdJ9UW18YHyGmRi5jXvCTjjFUJWQ=;
        b=cfB26g+j2enBfDC1Z10IQ4dnvkahvYXbQOcL2c66K2jCdatNImhXxR9osGxNNoacdb
         2bZD4Vzf1WLTjHHF+/JZQZItSPlsInAX4CZZMTyEZKi+LB8iiKgCKaFYI8DByh5jfiMl
         ZLF/KJ8yGy23ZhMMvCvBiwfLa4mL279KcvXr+V7pX7ocDl+MUtMBjzsasA5VrUhh50qD
         dhC2C+orb2eF174aWMJMzLHS+vMwnSnSRXIPxMckhgdX9AL3gmG/VVn70BtjMFDOQ1L1
         TjzYkWyu85+jlc6N4aLSOaH6hZzLJYT6/hMx+rJNk7aY2zhqSJNYMtNKY4dJmEv75Ov2
         57KA==
X-Gm-Message-State: AHQUAuap2Kfe7t4sjjXCdFr1JGsJShr+lsdD1ozaN16MeXOuIZYE2sXn
        86qprSrYvw5YCX9d1GMLzz5FHO8U
X-Google-Smtp-Source: AHgI3IbjwiJaPrMMyZckylnKDOdahq9W1R2/S8ZFL2ML2913CUsR+EzuMF68/IBiJefzbDXJcKsYsQ==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr1622088wrv.304.1550816170674;
        Thu, 21 Feb 2019 22:16:10 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:3cba:a200:8fc:79e4? (p200300EA8BF1E2003CBAA20008FC79E4.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:3cba:a200:8fc:79e4])
        by smtp.googlemail.com with ESMTPSA id x11sm2797094wrt.27.2019.02.21.22.16.09
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 22:16:09 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Disabling ASPM L1 sub-states selectively from drivers?
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <4d8bf501-e367-917d-c808-d1938edaf007@gmail.com>
Date:   Fri, 22 Feb 2019 07:16:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I face the issue that a PCIe network chip misses RX packets if ASPM L1
sub-states are enabled. It seems that the RX FIFO is too small to buffer
all incoming packets during ASPM exit latency.

So far pci_disable_link_state() only allows to disable L1 completely.
Would it make sense to extend this function to allow disabling
L1 sub-states selectively? Looking at pcie_config_aspm_link() this
seems to be possible.

