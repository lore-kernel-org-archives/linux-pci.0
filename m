Return-Path: <SRS0=j3vk=TQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B7EC04AB4
	for <linux-pci@archiver.kernel.org>; Thu, 16 May 2019 05:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AC62087B
	for <linux-pci@archiver.kernel.org>; Thu, 16 May 2019 05:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="k9z3Eenb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfEPFyr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 16 May 2019 01:54:47 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15105 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfEPFyr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:54:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfb220000>; Wed, 15 May 2019 22:54:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:54:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:54:46 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:46 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:46 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:54:43 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 26/28] PCI: Add DT binding for "reset-gpios" property
Date:   Thu, 16 May 2019 11:23:05 +0530
Message-ID: <20190516055307.25737-27-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986082; bh=9Yh2mACL+MOGmIJxW8SMsZtwk4AnOrCl24CNTfgUNro=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=k9z3EenbINt+xmdtZDAvhI/2cTBxQQe6gUjdtyyjQvDsjZNtZUftZeIaCRMZhvXNU
         eV1vUKASopwJOm1JbQAqnsr57IbbVqHhir0AMr65C7o2OG014UWAut3flKFjk6vJXv
         WgidspBlUD+ZC0BoDfM7dc8P2q53RqlOJnBON4YvixV6YYenpATV4TB13TOaZ7DTPd
         sVnQDISO3tkCqmO4fDcOC3XkaJfsFnTqnxr8jK4J76TVlAZmIN5qmIIo+xMB3STJSW
         tS8fbLX7H4mBEifM91ZyuTpSP4SqUVK5EzG3nyi6GNiMkp8i+ReBjsdfSWTVeNFksZ
         ByQxZiyXzPKRw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add DT binding for "reset-gpios" property which supports GPIO based PERST#
signal.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4: No change

V3: Moved to common pci binding doc

V2: Using standard "reset-gpio" property

 Documentation/devicetree/bindings/pci/pci.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index c77981c5dd18..79124898aa5b 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -24,3 +24,6 @@ driver implementation may support the following properties:
    unsupported link speed, for instance, trying to do training for
    unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
    for gen2, and '1' for gen1. Any other values are invalid.
+- reset-gpios:
+   If present this property specifies PERST# GPIO. Host drivers can parse the
+   GPIO and apply fundamental reset to endpoints.
-- 
2.17.1

