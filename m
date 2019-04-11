Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22724C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE3F20818
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="r5J7wAls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfDKRG3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:06:29 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11865 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfDKRG2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:06:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf74190000>; Thu, 11 Apr 2019 10:06:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:06:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:06:28 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:06:27 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:06:24 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 30/30] PCI: tegra: Change link retry log level to INFO
Date:   Thu, 11 Apr 2019 22:33:55 +0530
Message-ID: <20190411170355.6882-31-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002393; bh=350osw0rJ60LXM3hK1+l7MbBDkUZ6iNuH00cSZQwQ+M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=r5J7wAlsCjxg6JWbjy4vqmJxFQwcpbMNd6MuVSurhOtqYC7sHQL580vmgOBzWYN09
         JjYpqp2ytua/X8t6bRJRa222kPnDlRbCkvofzOp6BfIJIKnimQh7ZTljB0j+RMIRDq
         cvT4hZcSzILj8c4W3D/XJzk0Pyb9ppwO3qqGbQ+H90XeGo5mGLWDZNfS4zrbIaP7cF
         N6u2SHWV04wpUmtrf6w10tqi7NF4teBknojiB4dnbiksuh4Xk48wA+7HB2PP/zWvei
         ASKMGHcve91CFvhvnyq3oi5VG4mZoI2wPFQA7RHsaH59Aitg9rmHm+i4H++EwkzfxL
         4gYvkiUkdLuQQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Link retry log is info log not error, so change it to INFO log level.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 75873e6627f9..55f8ff4f3e07 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2461,7 +2461,7 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
 		} while (--timeout);
 
 		if (!timeout) {
-			dev_err(dev, "link %u down, retrying\n", port->index);
+			dev_info(dev, "link %u down, retrying\n", port->index);
 			goto retry;
 		}
 
-- 
2.17.1

