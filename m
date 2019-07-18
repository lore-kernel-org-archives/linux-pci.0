Return-Path: <SRS0=3xIq=VP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2A2C76191
	for <linux-pci@archiver.kernel.org>; Thu, 18 Jul 2019 09:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1C520693
	for <linux-pci@archiver.kernel.org>; Thu, 18 Jul 2019 09:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="o/rsUssh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389863AbfGRJqC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:46:02 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:59912 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGRJqC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jul 2019 05:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563443161; x=1594979161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=c0w4B2FUQGPRXAvRw5cgS9W93te+n8egQX1yzR84ahs=;
  b=o/rsUsshfxfCamCMr5vAIT+RGL4iWrxOgbiNW0Niqu2QgvOaFOQ34JWU
   T/yxUfXZXhll+48ofS0kJQtQ9/3fHtaGaSfaYZfVg0nyNg0mHkDL4Y4yL
   RJRy5oSxUUpkx8aIdMlQ0SUdSJDdb+nR4ikAioH+zVtlPM8SsMqydbwYT
   c=;
X-IronPort-AV: E=Sophos;i="5.64,276,1559520000"; 
   d="scan'208";a="816920564"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 18 Jul 2019 09:45:59 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 45828A2099;
        Thu, 18 Jul 2019 09:45:55 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 18 Jul 2019 09:45:55 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.162.67) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 18 Jul 2019 09:45:49 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v2 1/8] PCI: Add Amazon's Annapurna Labs vendor ID
Date:   Thu, 18 Jul 2019 12:45:24 +0300
Message-ID: <20190718094531.21423-2-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718094531.21423-1-jonnyc@amazon.com>
References: <20190718094531.21423-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.67]
X-ClientProxiedBy: EX13P01UWA004.ant.amazon.com (10.43.160.127) To
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

