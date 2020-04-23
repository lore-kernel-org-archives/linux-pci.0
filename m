Return-Path: <SRS0=NHSM=6H=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC73DC55195
	for <linux-pci@archiver.kernel.org>; Thu, 23 Apr 2020 18:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D76220776
	for <linux-pci@archiver.kernel.org>; Thu, 23 Apr 2020 18:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgDWS0p (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:26:45 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:56242 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730074AbgDWS0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Apr 2020 14:26:45 -0400
X-IronPort-AV: E=Sophos;i="5.73,307,1583161200"; 
   d="scan'208";a="45332054"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Apr 2020 03:26:44 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id CD4B740C860A;
        Fri, 24 Apr 2020 03:26:39 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v9 3/8] PCI: rcar: Fix calculating mask for PCIEPAMR register
Date:   Thu, 23 Apr 2020 19:22:34 +0100
Message-Id: <1587666159-6035-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587666159-6035-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1587666159-6035-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The mask value was calculated incorrectly for PCIEPAMR register if the
size was less than 128 bytes. Fix this issue by adding a check on size.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/pcie-rcar.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index b82f200985ec..b46c69ac62f2 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -75,7 +75,10 @@ void rcar_pcie_set_outbound(struct rcar_pcie *pcie, int win,
 	 * keeps things pretty simple.
 	 */
 	size = resource_size(res);
-	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
+	if (size > 128)
+		mask = (roundup_pow_of_two(size) / SZ_128) - 1;
+	else
+		mask = 0x0;
 	rcar_pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
 
 	if (res->flags & IORESOURCE_IO)
-- 
2.17.1

