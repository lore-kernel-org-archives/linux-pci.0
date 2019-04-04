Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8788FC4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9FA2183E
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WHAZpFXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfDDT4O (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:56:14 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13350 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDT4O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 15:56:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca661520000>; Thu, 04 Apr 2019 12:56:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 12:56:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 12:56:13 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 19:56:13 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Apr 2019 19:56:13 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca661570002>; Thu, 04 Apr 2019 12:56:12 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <lorenzo.pieralisi@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 09/16] Documentation/devicetree: Add PCIe supports-clkreq property
Date:   Fri, 5 Apr 2019 01:24:36 +0530
Message-ID: <1554407683-31580-10-git-send-email-vidyas@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554407762; bh=ToSv2CiE08XBJBiIccTQ2m4hajVViVTK2QFioc0fIQQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=WHAZpFXGQWem+Vd7HWxzouKdaYymwtZHScKBUngnL8VtPjhQzalliCiDpZpLbiGrD
         nOEwhEzmqriuJvDeSayP4pUu41DbjqEVqTUoRBhJWKlnsggCTcf5vb5Di95gBfc9JB
         y49fjrsJBHYK2dgGsUnWR+FN0fM9q/B1A4niYY0HiYlPpfXYgVtk4JeEa3LX48Ij5C
         FUWV/voC8KRCGnlAW2fU88Spg/lIOb0Gt+R8mT5kyGJsTWDme3RkyIDcwb7GvJC0yX
         tepN2MZEWvCvmIVwr7MG4/ele8bgOuyejU+GTT6LMHI+O7MgDZ4dmdaEMsw9jqg3Lp
         Y9noGFo7fWahA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some host controllers need to know the existence of clkreq signal routing to
downstream devices to be able to advertise low power features like ASPM L1
substates. Without clkreq signal routing being present, enabling ASPM L1 sub
states might lead to downstream devices falling off the bus. Hence a new device
tree property 'supports-clkreq' is added to make such host controllers
aware of clkreq signal routing to downstream devices.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes since [v1]:
* This is a new patch in v2 series

 Documentation/devicetree/bindings/pci/pci.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index c77981c5dd18..8ab574704c7a 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -24,3 +24,8 @@ driver implementation may support the following properties:
    unsupported link speed, for instance, trying to do training for
    unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
    for gen2, and '1' for gen1. Any other values are invalid.
+- supports-clkreq:
+   If present this property specifies that CLKREQ signal routing exists from
+   root port to downstream device and host bridge drivers can do programming
+   which depends on CLKREQ signal existence. For example, programming root port
+   not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
-- 
2.7.4

