Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4D3C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 07:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0C52085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 07:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhFq4Kam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0C52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbeKFQgG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:36:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42153 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbeKFQgG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 11:36:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so5397256pgq.9;
        Mon, 05 Nov 2018 23:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=19U5nnS+32OVLXwVWLlWkIemkFQKEnGuAOn8fC7twHs=;
        b=LhFq4KamDaWcGBJqYQG99l2SatgOSGNABwaQ0BSG7ku60dK+RkD0598Nx+yJtWKHpy
         Fq6ieC4FDtHZtcFnIoxhgXqJWyayaQd2CZO9uA1fwQBL/2UOJWxJ/1fO0yE1+VeXiWwt
         EZZrvGULW+Vy0hoW6ZEIkc2rjqEZLWNfY7Eacb9Sz8KTn7vKbu7RVjNyS6EI8xhWzfZF
         8040xoiZkF70K7UIJ1jRj/8TRFDCCACrzwmJvWbLssjYu3zQ9eTwVxQnrVZFNoOcSE4t
         q7FFO8u5p91WxQdezB0cCNYrvhFdB6ePenKElCiE9CXtvKuHq3LVWQRTZzLZojHrydvz
         RMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=19U5nnS+32OVLXwVWLlWkIemkFQKEnGuAOn8fC7twHs=;
        b=U0Pm0Ya7YHPkBNVhap59DxBzZmfPmmssjtEtoHwmpZGMrV4SgaamAAA1zGYyLSkBFc
         ISUZA2N1Sdi+GUdzssJ7mrbhGCD3n2g+ky579/+Ut13Q3rkcglKNJDlO7P6vxjBO3PEx
         VyM5Xss7dmXFJvs+EsD3Sv5vcy7rriNMhVaOvEwqb67fp8zRYgPwDwHIwAT5QpbnZ3Cy
         9cH51VYYYo3C8XHRnsPXdlsjs+11V4YaeH6YnUEB+m19JSSkREQzAN1ApP0LE9+sy12P
         YO5yER6pSt1iELGvVikb3s8oeLr7VoIU7Vi/Q8rhIwKY7wtMexrQFrBx224bB1kFVRLd
         S5nw==
X-Gm-Message-State: AGRZ1gLdIWo2C4xW90MqHTNwUHlAe2FEQBfh4Pc+ddNuO3PfHcsiLSpx
        YbZ9d/xAZCRpcekBr1DhbpI=
X-Google-Smtp-Source: AJdET5e9ZHtZd6Ng4JAXTVvw2HMd3uJwibhruC7v0Gn79a76iuspxWAwz/FunPd4xrY2daFxpJzDkA==
X-Received: by 2002:a63:4044:: with SMTP id n65mr16177157pga.90.1541488337122;
        Mon, 05 Nov 2018 23:12:17 -0800 (PST)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id g65-v6sm61184521pfg.98.2018.11.05.23.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 23:12:16 -0800 (PST)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 1/2] pci: prevent sk hynix nvme from entering D3
Date:   Tue,  6 Nov 2018 15:12:13 +0800
Message-Id: <20181106071214.12745-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It leads to the power consumption raises to 2.2W during s2idle, while
it consumes less than 1W during long idle if put SK hynix nvme to D3
and then enter s2idle.
From SK hynix FE, MS Windows doesn't put nvme to D3, and uses its own
APST feature to do the power management.
To leverage its APST feature during s2idle, we can't disable nvme
device while suspending, too.

BTW, prevent it from entering D3 will increase the power consumtion around
0.13W ~ 0.15W during short/long idle, and the power consumption during
s2idle becomes 0.77W.

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/pci/quirks.c    | 1 +
 include/linux/pci_ids.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4700d24e5d55..b7e6492e8311 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1332,6 +1332,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
    occur when mode detecting */
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
 				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SK_HYNIX, 0x1527, quirk_no_ata_d3);
 
 /*
  * This was originally an Alpha-specific thing, but it really fits here.
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 69f0abe1ba1a..5f5adda07de0 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3090,4 +3090,6 @@
 
 #define PCI_VENDOR_ID_NCUBE		0x10ff
 
+#define PCI_VENDOR_ID_SK_HYNIX		0x1c5c
+
 #endif /* _LINUX_PCI_IDS_H */
-- 
2.17.1

