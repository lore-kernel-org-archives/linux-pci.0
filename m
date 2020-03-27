Return-Path: <SRS0=7Auq=5M=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C90C2D0EE
	for <linux-pci@archiver.kernel.org>; Fri, 27 Mar 2020 09:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CAB20705
	for <linux-pci@archiver.kernel.org>; Fri, 27 Mar 2020 09:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgC0J1L (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:27:11 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:20769 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726002AbgC0J1K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Mar 2020 05:27:10 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 27 Mar
 2020 17:11:56 +0800
Received: from raymond-pc.zhaoxin.com (10.29.28.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 27 Mar
 2020 17:11:55 +0800
From:   Raymond Pang <RaymondPang-oc@zhaoxin.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <TonyWWang-oc@zhaoxin.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] PCI: Add Zhaoxin Vendor ID
Date:   Fri, 27 Mar 2020 17:11:46 +0800
Message-ID: <20200327091148.5190-2-RaymondPang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327091148.5190-1-RaymondPang-oc@zhaoxin.com>
References: <20200327091148.5190-1-RaymondPang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.29.28.62]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Zhaoxin Vendor ID to pci_ids.h

Signed-off-by: Raymond Pang <RaymondPang-oc@zhaoxin.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 352c0d708720..6693cf561cd1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2583,6 +2583,8 @@
 
 #define PCI_VENDOR_ID_AMAZON		0x1d0f
 
+#define PCI_VENDOR_ID_ZHAOXIN		0x1d17
+
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
 #define PCI_VENDOR_ID_HXT		0x1dbf
-- 
2.26.0

