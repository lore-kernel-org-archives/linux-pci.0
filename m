Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E841C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E128320811
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OdQrQZSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfDWJbG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:31:06 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8039 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfDWJbG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 05:31:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbedb5f0000>; Tue, 23 Apr 2019 02:31:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 02:31:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 02:31:05 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:31:04 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 09:31:01 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 26/28] dt-bindings: pci: tegra: Document reset-gpio optional prop
Date:   Tue, 23 Apr 2019 14:58:23 +0530
Message-ID: <20190423092825.759-27-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423092825.759-1-mmaddireddy@nvidia.com>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556011871; bh=Ojsl0iuXhU9L++SmEji54gyyE6mkPvvGCPdEd2igDvw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=OdQrQZSUL4mwoDX9A+BPKECrcDtDXKXOjihcvjnABy4zrca2M8RMP3oQ6L9x1MeYZ
         RRGTwIE+tfbELouIbO1s7ghm39xYjt99BGyqKUbdyFYaTQ3wUEG2V63EUKqXp/dQjQ
         InhFXNV+aY0azLBFjvqShvXD8inOM9MLzsE0WSFOhdm6EV1R3beJ6rgcvJqfdo9FAX
         oAA6wwPqSuzDD2lkLTfeBFe/lgMSmzsepm71x90HzbQJuJWmPaS5sP0iTsUpoGaHKK
         hQr2g9U3AnG8YRC54IViLDuRhMVjOdifwxCRnqHw7Vnyj1HqV44jhJsW0fKBAyC5Bq
         noWEjbo7F4FlQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document "reset-gpio" optional property which supports GPIO based PERST#
signal.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2: Using standard "reset-gpio" property

 .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index 7939bca47861..4e75e017f660 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -162,6 +162,10 @@ Required properties:
   - Root port 0 uses 4 lanes, root port 1 is unused.
   - Both root ports use 2 lanes.
 
+Optional properties:
+- reset-gpio: If GPIO is used as PERST# signal instead of available
+  SFIO, add this property with phandle to GPIO controller and GPIO number.
+
 Required properties for Tegra124 and later:
 - phys: Must contain an phandle to a PHY for each entry in phy-names.
 - phy-names: Must include an entry for each active lane. Note that the number
@@ -626,6 +630,7 @@ SoC DTSI:
 			ranges;
 
 			nvidia,num-lanes = <2>;
+			reset-gpio = <&gpio TEGRA_GPIO(A, 3) 0>;
 		};
 
 		pci@2,0 {
-- 
2.17.1

