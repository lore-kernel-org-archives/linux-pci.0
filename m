Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33049 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbbF3SXS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jun 2015 14:23:18 -0400
Received: by pacws9 with SMTP id ws9so9420107pac.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 11:23:16 -0700 (PDT)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [PATCH v2 2/2] pci: xgene: Fix driver to handle multiple memory ranges
Date: Tue, 30 Jun 2015 11:22:28 -0700
Message-Id: <67452792cee2b4275702fda8db9b9f59c7d5aa55.1435688121.git.dhdang@apm.com>
In-Reply-To: <cover.1435688121.git.dhdang@apm.com>
References: <cover.1435688121.git.dhdang@apm.com>
In-Reply-To: <cover.1435688121.git.dhdang@apm.com>
References: <46305464.n5SOjGAhJb@wuerfel> <cover.1435688121.git.dhdang@apm.com>
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

