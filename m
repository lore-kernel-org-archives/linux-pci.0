Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EECDC10F14
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A3F2082E
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EXnHKuSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfDKRGN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:06:13 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7234 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKRGM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:06:12 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf74010000>; Thu, 11 Apr 2019 10:06:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:06:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:06:12 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:06:11 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:06:11 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:06:08 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 26/30] dt-bindings: pci: tegra: Document nvidia,plat-gpios optional prop
Date:   Thu, 11 Apr 2019 22:33:51 +0530
Message-ID: <20190411170355.6882-27-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002369; bh=x6AFYJHJmekxo4o32awxOqVaz60w3YtG/3hIhuIE/KY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=EXnHKuSNaGM8YQDj4klmqmKAk/v+DU2q1jO4zmhpETL4iAG/RJ6h2UppBkylaXf9s
         S3bYIlRioFANrVp5lv8gCfwWUCmzoRYhsqzJKx3M032toxGPl5CussFyhjSE6MGBBQ
         hyVQ7KTEIOGUFa7pMmTfRkdvVrUNwYu7CG2bqNyOmGMQRZVS9yUf8E16lS0emvRY1G
         6H19RygFrZxXeWdBsv8sONglJ81u5grM7l3+Um+MsNgaMsnUOMtGaFCyL+7ho4nZBb
         C+huc/bz0iLkybQEKMo7VEMVcJR14bGjwjorPmS5GdVtSuv9uYplHWY/u+BNDjsN+8
         fF9aRhKxNIVSw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document "nvidia,plat-gpios" optional property which supports configuring
of platform specific gpios.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index fbbd3bcb3435..dca8393b86d1 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -73,6 +73,8 @@ Optional properties:
   pinctrl phandle to allow driver to explicitly put PCIe IO in DPD state.
 - pinctrl-1: PCIe IO(bias & REFCLK) deep power down(DPD) enable state.
   Pass pinctrl phandle to allow driver bring PCIe IO out of DPD state.
+- nvidia,plat-gpios: A list of platform specific gpios which controls
+  endpoint's internal regulator or PCIe logic.
 
 Required properties on Tegra124 and later (deprecated):
 - phys: Must contain an entry for each entry in phy-names.
@@ -567,6 +569,7 @@ Board DTS:
 		pci@2,0 {
 			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
 			phy-names = "pcie-0";
+			nvidia,plat-gpios = <&gpio TEGRA_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
 			status = "okay";
 		};
 	};
-- 
2.17.1

