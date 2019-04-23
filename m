Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725B8C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4258220843
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KHGcVzUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfDWJaw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:30:52 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8007 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDWJaw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 05:30:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbedb510000>; Tue, 23 Apr 2019 02:30:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 02:30:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 02:30:51 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:30:51 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 09:30:48 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 23/28] dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
Date:   Tue, 23 Apr 2019 14:58:20 +0530
Message-ID: <20190423092825.759-24-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423092825.759-1-mmaddireddy@nvidia.com>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556011857; bh=Teql65wpz7JHVkNFzdKW5gExOlV39b72Jso7GRh4l8w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=KHGcVzUdQFRucrqy6387SCyf8HQ0xkXkK7KKTRitSc+1hccafHRJDfRaZC5c1fLAj
         1XwQKH/rAbKY6GV9oJ3gEeI4oQ62rr7R8f/51WgmY9goLNyzbDd39d9q4uPhof3OQg
         LDpGoFNXZ13NQ607l2Y5f1CPS8+fIiRSy7BA3Lvyu08enfwp8N+QqtXnmsQkfZ1lYb
         uQ2LXjeOfmJz4kzDkRYXmpHDG9DKMvOMLSjyYxmdFYaVE2kul4QKCWMyO3opmfjG1L
         Xnnup5DiZ5unVMj7VLwHq0xSBYZYJ8gm9r1VOpycu/CzX5smypup7MPqlyzKtShbzz
         B470aI/VyKyJQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document PCIe DPD pinctrl optional property to put PEX clk & BIAS pads
in low power mode.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2: Using standard pinctrl names, default and idle

 .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index 145a4f04194f..7939bca47861 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -65,6 +65,14 @@ Required properties:
   - afi
   - pcie_x
 
+Optional properties:
+- pinctrl-names: A list of pinctrl state names. Must contain the following
+  entries:
+  - "default": active state, puts PCIe I/O out of deep power down state
+  - "idle": puts PCIe I/O into deep power down state
+- pinctrl-0: phandle for the default/active state of pin configurations.
+- pinctrl-1: phandle for the idle state of pin configurations.
+
 Required properties on Tegra124 and later (deprecated):
 - phys: Must contain an entry for each entry in phy-names.
 - phy-names: Must include the following entries:
-- 
2.17.1

