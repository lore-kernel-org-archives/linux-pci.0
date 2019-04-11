Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D584CC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5027217D4
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="W++Lmiqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfDKRGV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:06:21 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7245 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKRGU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:06:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf74090000>; Thu, 11 Apr 2019 10:06:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:06:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:06:20 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:06:19 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:06:19 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:06:16 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 28/30] dt-bindings: pci: tegra: Document nvidia,rst-gpio optional prop
Date:   Thu, 11 Apr 2019 22:33:53 +0530
Message-ID: <20190411170355.6882-29-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002377; bh=wQ7UEUDOdwq/fRnKEQzSHuLOlmEe/J5abtWcbK20KxQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=W++LmiqjGI3fkrChzCgiZT7P0CKbScL5ZtmtH9PvEw026w2LwuaGQ6sTiroyjjR/3
         sKpd2zHTAB9MwGHzAT95/vWAOTZaVhwt1zdCN5fs+Cp+yjpmLksZpYAyOUJ0XiSYKn
         f6LI+33rdILws5Ia4nlQKkt+QiHgrYsArQ0iJi7qat6csUgMLfyuFRU1ANCYZqccvy
         WCeqVxmJfgeoADRbFOH8r0RPplXI7O+pRQAr6nrTe6bfUzZSqAfcNoYiirzQFQ61Gy
         UPDmqBw7O5QwME38j7Jz+IyBVrQSA+h2oCCajEA138t4/JzH7bLrYrMCg1rNTyH6T2
         zr5ufhuED2IjA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document "nvidia,rst-gpio" optional property which supports GPIO based
PERST# signal.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index dca8393b86d1..23928fd59538 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -75,6 +75,8 @@ Optional properties:
   Pass pinctrl phandle to allow driver bring PCIe IO out of DPD state.
 - nvidia,plat-gpios: A list of platform specific gpios which controls
   endpoint's internal regulator or PCIe logic.
+- nvidia,rst-gpio: If GPIO is used as PERST# signal instead of available
+  SFIO, add this property with phandle to GPIO controller and GPIO number.
 
 Required properties on Tegra124 and later (deprecated):
 - phys: Must contain an entry for each entry in phy-names.
@@ -671,6 +673,7 @@ Board DTS:
 
 		pci@1,0 {
 			nvidia,num-lanes = <4>;
+			nvidia,rst-gpio = <&tegra_main_gpio TEGRA_MAIN_GPIO(A, 3) 0>;
 			status = "okay";
 		};
 
-- 
2.17.1

