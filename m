Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E6FC37122
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 02:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01892085A
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 02:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/+cS+R3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfAVCX3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:23:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34232 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfAVCX3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 21:23:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so10315439pga.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Jan 2019 18:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=12IIWwmepBaZCIe2uhOf6Trqx1N24lyLdgm9cACvqGM=;
        b=n/+cS+R3i5Z2J5M9AxsM50hd4Pys+yrZ3qCZoYjTir1i/YQU6M899JhTHqYHFVa5n1
         EiEheFGRd5Q70gw0tgWfPWQ3Om8D8pXNAh+dKb/0MdRD5t7HPFofRUbVse66Ukgyv9XW
         Gs6oLOyru1ufQp7KQ1cb65nx1W1b44yf1qZeeD50bCxkVsbyHu9CvvQJMxDAn9d8LSrL
         oRFAL3oPJ5nLIqHJfxn6mqLbBc33ukPmqvnEU5PiYV84xeZCnPKrNUtP0NTMehzCqdZW
         WDgTrKh5OejGPLy1WXXrAtQZHBwrQ5mU2dZo+QsPZ9/YHaS9IazOOJLkQi7P2WYoMsRs
         q2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=12IIWwmepBaZCIe2uhOf6Trqx1N24lyLdgm9cACvqGM=;
        b=ihTTDENYOktdPRhZ7d4FdBp0sYzEgf93gVVCFWP8v9lRQPScOPId/J15khNweQJfix
         XFSBmAWGke0M8MA6uE0PEN/MfaV2UusfrKTVObrsKzybCk3pvqPJ3nxHsxO9k+hktc2R
         N9LEJjkf5jj9C/DI1M8gafoyq7fH6fQ3MOHxwCODJz5olYWLO0lFbTuMmwHom2ulzr6e
         HTCjOru7xmFkeN5N9jwCYXKaLScgJW0hFBtjiCeB4VfPUxDUU77eVkmiXzPysCLAlI6w
         sJjTm2rLKfUmGwijpLnoDscQBCOs1YQyqc/MZAqp5qNFr2SugmC7Ef8ETECcni7nEUYN
         z6RA==
X-Gm-Message-State: AJcUukdTde3onVqLyv47P3vuDsB4cUXsYyKJ7lL4uQG88pt6WpzrBuxM
        BQVIwwaXOIommvp1LKifEcJACxsOaVE=
X-Google-Smtp-Source: ALg8bN6MPsxVVTipqJCcBcW5APq7x1lDGI7aHwNWeqA7gkeDH0lTBMNf+nhRHoKpjwkHvKYmpBjUMg==
X-Received: by 2002:a63:4706:: with SMTP id u6mr28760443pga.95.1548123808329;
        Mon, 21 Jan 2019 18:23:28 -0800 (PST)
Received: from test-System-Product-Name.sunix.com.tw (114-25-192-120.dynamic-ip.hinet.net. [114.25.192.120])
        by smtp.gmail.com with ESMTPSA id e123sm25423818pgc.58.2019.01.21.18.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 18:23:27 -0800 (PST)
From:   saumah <saumah@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     morris_ku@sunix.com.tw, saumah <saumah@gmail.com>
Subject: [PATCH] pci_ids.h change for fix hanging problem while suspend machine. pci_ids.h has the same vendor id and device id definition as sunix multi-I/O board driver, when the sunix multi-io board driver is installed, it will cause operation error
Date:   Tue, 22 Jan 2019 10:22:37 +0800
Message-Id: <20190122022237.27871-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: saumah <saumah@gmail.com>
---
 ....-8250-16550-build-in-driver-conflic.patch | 28 -------------------
 1 file changed, 28 deletions(-)
 delete mode 100644 0001-pci_ids.h-change.-8250-16550-build-in-driver-conflic.patch

diff --git a/0001-pci_ids.h-change.-8250-16550-build-in-driver-conflic.patch b/0001-pci_ids.h-change.-8250-16550-build-in-driver-conflic.patch
deleted file mode 100644
index dd1b7bf..0000000
--- a/0001-pci_ids.h-change.-8250-16550-build-in-driver-conflic.patch
+++ /dev/null
@@ -1,28 +0,0 @@
-From 15a467e9bb45d76a9373cb21c499a0cb21df2dda Mon Sep 17 00:00:00 2001
-From: Morris Ku <morris_ku@sunix.com>
-Date: Tue, 8 Jan 2019 20:08:48 +0800
-Subject: [PATCH] pci_ids.h change. 8250/16550 build-in driver conflict with SUNIX Multi-I/O Borad Driver
-
-Signed-off-by: Morris Ku <morris_ku@sunix.com>
----
- pci_ids.h | 4 ++--
- 1 file changed, 2 insertions(+), 2 deletions(-)
-
-diff --git a/pci_ids.h b/pci_ids.h
-index 2950223..b681a66 100644
---- a/pci_ids.h
-+++ b/pci_ids.h
-@@ -2567,8 +2567,8 @@
- #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
- #define PCI_DEVICE_ID_TEHUTI_3014	0x3014
-
--#define PCI_VENDOR_ID_SUNIX		0x1fd4
--#define PCI_DEVICE_ID_SUNIX_1999	0x1999
-+//#define PCI_VENDOR_ID_SUNIX		0x1fd4
-+//#define PCI_DEVICE_ID_SUNIX_1999	0x1999
-
- #define PCI_VENDOR_ID_HINT             0x3388
- #define PCI_DEVICE_ID_HINT_VXPROII_IDE 0x8013
---
-2.17.1
-
--
2.17.1

