Return-Path: <SRS0=+Ccl=UQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF86C31E5B
	for <linux-pci@archiver.kernel.org>; Mon, 17 Jun 2019 17:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81692084D
	for <linux-pci@archiver.kernel.org>; Mon, 17 Jun 2019 17:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DcGwnOeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfFQRlY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:41:24 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17181 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbfFQRlX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:41:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d07d0c30003>; Mon, 17 Jun 2019 10:41:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 10:41:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 10:41:22 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:41:22 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Jun 2019 17:41:19 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 25/27] PCI: Add DT binding for "reset-gpios" property
Date:   Mon, 17 Jun 2019 23:09:50 +0530
Message-ID: <20190617173952.29363-26-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617173952.29363-1-mmaddireddy@nvidia.com>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560793283; bh=6/UJsS6y2Ynv2xJvx0rBQnO0mp43ymxQOhyrkpcxYgo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=DcGwnOeJSxwOC/FFNuyE1T/G6PrsHz0pUabwqNPEmcfpMRQLfTSjC9aXzT8bBe3de
         AxeoQ0Ch94qpEEVXmMFUnzj1Qaka/VC7YEUjmRxGhdpfYjWxrqQ3V1KT4mcTyyVDJ1
         icw7ugLz9DEc6f5fKX2SP2CyYg67wv6uFZrbu3rQtQKufptBWufBywGQpHdz6R0bYS
         hpdA8pqbs5suVcKhHpqUYqpMUzkhWQetyxfrlY9lMNbsvJAo9XasRXhdiuy2qFdECT
         730rtiZHbgXbwXj2lVhuDH8urpNITlrfKtMuDKM207uxEAWT9NouQZPShcfgLaNfYS
         5H4nStDNM2tYg==
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
V5: No change

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

