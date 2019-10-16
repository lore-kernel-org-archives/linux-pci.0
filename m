Return-Path: <SRS0=vJ1S=YJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ABDFA372A
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 12:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9803C21848
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 12:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfJPMDW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:03:22 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:60972 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbfJPMDV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 08:03:21 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 744E725AD78;
        Wed, 16 Oct 2019 23:03:19 +1100 (AEDT)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 577F0E2248D; Wed, 16 Oct 2019 14:03:17 +0200 (CEST)
From:   Simon Horman <horms@verge.net.au>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>
Subject: [PATCH] MAINTAINERS: Add Marek and Shimoda-san as R-Car PCIE co-maintainers
Date:   Wed, 16 Oct 2019 14:02:49 +0200
Message-Id: <20191016120249.16776-1-horms@verge.net.au>
X-Mailer: git-send-email 2.11.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

At the end of the v5.3 upstream development cycle I stepped down
from my role at Renesas.

Pass maintainership of the R-Car PCIE to Marek and Shimoda-san.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e3c4b4..b61ade7afd64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12337,7 +12337,8 @@ F:	Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
 F:	drivers/pci/controller/pci-tegra.c
 
 PCI DRIVER FOR RENESAS R-CAR
-M:	Simon Horman <horms@verge.net.au>
+M:	Marek Vasut <marek.vasut+renesas@gmail.com>
+M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Maintained
-- 
2.11.0

