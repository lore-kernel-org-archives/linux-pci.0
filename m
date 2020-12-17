Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE27AC4361B
	for <linux-pci@archiver.kernel.org>; Thu, 17 Dec 2020 21:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D39323A31
	for <linux-pci@archiver.kernel.org>; Thu, 17 Dec 2020 21:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbgLQU7y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Dec 2020 15:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731629AbgLQU7x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Dec 2020 15:59:53 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49749C061794
        for <linux-pci@vger.kernel.org>; Thu, 17 Dec 2020 12:59:13 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cw27so127039edb.5
        for <linux-pci@vger.kernel.org>; Thu, 17 Dec 2020 12:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=3HgbgiPyvA0hgsUWM8bqJmOYDze0YQt5cpjjXm9ijCI=;
        b=KHPZgyqlli37NPfeZO998rYRjMdd1mk5wQatQGl5p/QuC4Y4HMxf2YSknHOhqBCLMb
         n1Fi0ZwesOlnLxLqMSq9fGCHRSIEz5QM7sucVD6vT02QcSts8lzTONYX6D+zIWseR7vd
         eZhdBxvXBmnXKf4if8ZA/tWxls58ckSuwsl+3Of9c7CXFxz9RdgHPwC2dql/ePzk+6YZ
         /g3Hm6fKXzWRoH7Ji4TCu5pB88aHj+GyZUHQxPlNWx3OVS083pjdSv5nC7PyIO9c3jnA
         uZwQzFHUoI/24KCBFG1k5+9D8W9UQ29ub40cuVu0y+o7E4VgTkiwv5JbkcBCNJEoq6jE
         dvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=3HgbgiPyvA0hgsUWM8bqJmOYDze0YQt5cpjjXm9ijCI=;
        b=uSvpHso8gOrLB2W1pdTv4NqkSTenoAFCIpfyNEmz8xknVcy2w6pkjbthoclUmXJxeH
         Sw/ER0MLAA9JTXXJYbU/yD8XghwQeqqIKAsgXAa3/dykwrNCICOl2iCwG7DPSbMClk0M
         q8mB2IgVzMNSRTYXxPw7twKes8wo7oVK8ArMQjwHMtdj6xWNv5/j9V88cElv2M8GciEV
         swdr+F+2sT0DPLHAUg/IXO1uM4szn9fy3LYeBkUvw0BQVM29nJxYeYr8mHEj43ctYkWe
         03lg5AISOuMh/LMVvrrT1Dg107i0nQTUx7g6SM7qJgYG0czWWYLQO+Z2Us6BDmLAFHE8
         e8Hw==
X-Gm-Message-State: AOAM531IbFGhXtPidWSiMOTmIFchPPfbBO92GhbkwS83bOqLcvFa3xSx
        jOJ18n+K+8FML5D5yOZ3B3Tu4W4f+3g=
X-Google-Smtp-Source: ABdhPJxbHtTX0C2Q0N27b6KTzWsGxXuxrzP0Me5KiCKJ8FPkmIjrE4ajY7czMbJxR8dHmwqS6ifLzw==
X-Received: by 2002:aa7:c151:: with SMTP id r17mr1257005edp.106.1608238751749;
        Thu, 17 Dec 2020 12:59:11 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:c095:d389:734d:8e2a? (p200300ea8f065500c095d389734d8e2a.dip0.t-ipconnect.de. [2003:ea:8f06:5500:c095:d389:734d:8e2a])
        by smtp.googlemail.com with ESMTPSA id rl7sm4527440ejb.107.2020.12.17.12.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 12:59:11 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] PCI/VPD: Remove not any longer needed Broadcom NIC quirk
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <daa6acdf-5027-62c8-e3fb-125411b018f5@gmail.com>
Date:   Thu, 17 Dec 2020 21:59:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This quirk was added in 2008 [0] when we didn't have the logic yet to
determine VPD size based on checking for the VPD end tag. Now that we
have this logic [1] and don't read beyond the end tag this quirk can
be removed.

[0] 99cb233d60cb ("PCI: Limit VPD read/write lengths for Broadcom 5706, 5708, 5709 rev.")
[1] 104daa71b396 ("PCI: Determine actual VPD size on first access")

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
This is basically the same as what you're currently discussing
for the Marvell / QLogic 1077 quirk.
---
 drivers/pci/vpd.c | 46 ----------------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 7915d10f9..ef5165eb3 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -578,52 +578,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QLOGIC, 0x2261, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
 
-/*
- * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
- * VPD end tag will hang the device.  This problem was initially
- * observed when a vpd entry was created in sysfs
- * ('/sys/bus/pci/devices/<id>/vpd').   A read to this sysfs entry
- * will dump 32k of data.  Reading a full 32k will cause an access
- * beyond the VPD end tag causing the device to hang.  Once the device
- * is hung, the bnx2 driver will not be able to reset the device.
- * We believe that it is legal to read beyond the end tag and
- * therefore the solution is to limit the read/write length.
- */
-static void quirk_brcm_570x_limit_vpd(struct pci_dev *dev)
-{
-	/*
-	 * Only disable the VPD capability for 5706, 5706S, 5708,
-	 * 5708S and 5709 rev. A
-	 */
-	if ((dev->device == PCI_DEVICE_ID_NX2_5706) ||
-	    (dev->device == PCI_DEVICE_ID_NX2_5706S) ||
-	    (dev->device == PCI_DEVICE_ID_NX2_5708) ||
-	    (dev->device == PCI_DEVICE_ID_NX2_5708S) ||
-	    ((dev->device == PCI_DEVICE_ID_NX2_5709) &&
-	     (dev->revision & 0xf0) == 0x0)) {
-		if (dev->vpd)
-			dev->vpd->len = 0x80;
-	}
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5706,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5706S,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5708,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5708S,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5709,
-			quirk_brcm_570x_limit_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
-			PCI_DEVICE_ID_NX2_5709S,
-			quirk_brcm_570x_limit_vpd);
-
 static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 {
 	int chip = (dev->device & 0xf000) >> 12;
-- 
2.29.2

