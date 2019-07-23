Return-Path: <SRS0=S0fB=VU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E56C7618B
	for <linux-pci@archiver.kernel.org>; Tue, 23 Jul 2019 09:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B27223BA
	for <linux-pci@archiver.kernel.org>; Tue, 23 Jul 2019 09:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jfLp8S1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387820AbfGWJZ4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:25:56 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:59453 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfGWJZy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2019 05:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563873953; x=1595409953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=c0w4B2FUQGPRXAvRw5cgS9W93te+n8egQX1yzR84ahs=;
  b=jfLp8S1wAkKnWy+HKPWRd+4Sixe0A8gKM6SGuwLesdfSGeBEoP2BoBkC
   PJ2RclM2hxx2HWtHmILHW6T3x7HuapkXohChESrVFoCTRHUg1ccDGsRsD
   YvPs++io2T4jhB/82fSuJ2lwHSlq7WmUuhheYWahLeOZMkrVCDgQrx5Cf
   w=;
X-IronPort-AV: E=Sophos;i="5.64,298,1559520000"; 
   d="scan'208";a="406177491"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 23 Jul 2019 09:25:51 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id B10B4A2629;
        Tue, 23 Jul 2019 09:25:50 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 23 Jul 2019 09:25:50 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.160.245) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 23 Jul 2019 09:25:45 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v3 1/8] PCI: Add Amazon's Annapurna Labs vendor ID
Date:   Tue, 23 Jul 2019 12:25:26 +0300
Message-ID: <20190723092529.11310-2-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723092529.11310-1-jonnyc@amazon.com>
References: <20190723092529.11310-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.245]
X-ClientProxiedBy: EX13D24UWB004.ant.amazon.com (10.43.161.4) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Amazon's Annapurna Labs vendor ID to pci_ids.h.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 40015609c4b5..63dfa4bace57 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2569,6 +2569,8 @@
 
 #define PCI_VENDOR_ID_ASMEDIA		0x1b21
 
+#define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
+
 #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
 #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD	0x0001
 
-- 
2.17.1

