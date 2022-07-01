Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F18CCA48D
	for <linux-pci@archiver.kernel.org>; Fri,  1 Jul 2022 08:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbiGAIzH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Jul 2022 04:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbiGAIzD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 04:55:03 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5B571A83F;
        Fri,  1 Jul 2022 01:55:01 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,236,1650898800"; 
   d="scan'208";a="124761354"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Jul 2022 17:54:59 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7309443E0093;
        Fri,  1 Jul 2022 17:54:59 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3 05/13] PCI: dwc: endpoint: Read num-lanes property before ep_pre_init()
Date:   Fri,  1 Jul 2022 17:54:12 +0900
Message-Id: <20220701085420.870306-6-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701085420.870306-1-yoshihiro.shimoda.uh@renesas.com>
References: <20220701085420.870306-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Vendor-specific initialization needs this information so that
read it before ep_pre_init().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 439f92d7d284..3760857c1f81 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -717,6 +717,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		}
 	}
 
+	of_property_read_u32(np, "num-lanes", &pci->num_lanes);
+
 	if (ep->ops->ep_pre_init)
 		ep->ops->ep_pre_init(ep);
 
-- 
2.25.1

