Return-Path: <SRS0=mfjy=D6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46355C5517A
	for <linux-pci@archiver.kernel.org>; Fri, 23 Oct 2020 19:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D795022210
	for <linux-pci@archiver.kernel.org>; Fri, 23 Oct 2020 19:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MUPvimuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750069AbgJWT5L (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Oct 2020 15:57:11 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17013 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755224AbgJWT5L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 15:57:11 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9335820001>; Fri, 23 Oct 2020 12:56:50 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Oct
 2020 19:57:08 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 23 Oct 2020 19:57:04 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 1/3] PCI: of: Warn if non-prefetchable memory aperture size is > 32-bit
Date:   Sat, 24 Oct 2020 01:26:53 +0530
Message-ID: <20201023195655.11242-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023195655.11242-1-vidyas@nvidia.com>
References: <20201023195655.11242-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603483010; bh=dZDk41IQVmye1tm/HGRwkE9LdTLqCSACL+m5qHhAk84=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=MUPvimuPnqr3XPUjB4q6/Dj7ubZaHhEo0+gV52RMHfZ4mYxdou9Zqu5NgiqjRHMuS
         FXaHoyWLhYg5ehKsTCM1IPfbDoPskyW8it7uf78Rr6m7b8yJkWHAeDB358HKOD+I4/
         5mmb6v7pHFH7GPFUlMuZxx6LjIeZ5ztneBe9u6sfYgJlTSqvi9stNYUW++rnw2Xula
         C9FKqzGpWq2PRyPziAshq+DYdbP26/jtJ1uzkTfd1IzAfitSPjPyVA+AelpnvW0YTA
         Wq61YOuYyP+K7xzDTXXsaf6X0Qz7GUqUXMzffgJNHaq05ZxgJ32RhL+QIiy3w+lanK
         ZWgt4uOWwtKDQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As per PCIe spec r5.0, sec 7.5.1.3.8 only 32-bit BAR registers are defined
for non-prefetchable memory and hence a warning should be reported when
the size of them go beyond 32-bits.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/of.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index ac24cd5439a9..5ea472ae22ac 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -556,6 +556,11 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 			break;
 		case IORESOURCE_MEM:
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
+
+			if (!(res->flags & IORESOURCE_PREFETCH))
+				if (upper_32_bits(resource_size(res)))
+					dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
+
 			break;
 		}
 	}
-- 
2.17.1

