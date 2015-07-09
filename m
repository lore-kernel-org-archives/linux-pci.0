Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34928 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbbGIVVY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2015 17:21:24 -0400
Received: by pactm7 with SMTP id tm7so156495284pac.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2015 14:21:23 -0700 (PDT)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Tanmay Inamdar <tinamdar@apm.com>, patches@apm.com,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v3 2/2] pci: xgene: Fix driver to handle multiple memory ranges
Date: Thu,  9 Jul 2015 14:20:12 -0700
Message-Id: <844cb76fe55ce4ce45411281500bdb93e0d6932a.1436476100.git.dhdang@apm.com>
In-Reply-To: <cover.1436476099.git.dhdang@apm.com>
References: <cover.1436476099.git.dhdang@apm.com>
In-Reply-To: <cover.1436476099.git.dhdang@apm.com>
References: <1481643.dA4ocqzitg@wuerfel> <cover.1436476099.git.dhdang@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

X-Gene PCIe controller has registers to support multiple memory ranges.
This patch implement addtional register configuration required for the
driver to support 1 additional huge 64-bit prefetch memory window.

Signed-off-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 drivers/pci/host/pci-xgene.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index a9dfb70..55fe865 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -321,8 +321,16 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *port,
 				return ret;
 			break;
 		case IORESOURCE_MEM:
-			xgene_pcie_setup_ob_reg(port, res, OMR1BARL, res->start,
-						res->start - window->offset);
+			if (res->flags & IORESOURCE_PREFETCH)
+				xgene_pcie_setup_ob_reg(port, res, OMR2BARL,
+							res->start,
+							res->start -
+							window->offset);
+			else
+				xgene_pcie_setup_ob_reg(port, res, OMR1BARL,
+							res->start,
+							res->start -
+							window->offset);
 			break;
 		case IORESOURCE_BUS:
 			break;
-- 
1.9.1

