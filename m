Return-Path: <SRS0=agHd=77=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3A3C433DF
	for <linux-pci@archiver.kernel.org>; Thu, 18 Jun 2020 02:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF5220885
	for <linux-pci@archiver.kernel.org>; Thu, 18 Jun 2020 02:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446774;
	bh=+99deZvNUdOtLha3jEqtpkcnyY0AVONasx7hLFe4Fyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qyb6U8kAdv0+LF6a27Dzx6pzNyXeGv2ebEUUPXgiLF9GBet7Am1YOHzHixSLcKZvE
	 4xLB9RF5Fd76I+xNRFV8j9c0KOYEISoIv+MVJKUGwwNd0H2klHFCc66QlKY2BMbsTv
	 /3cGFLzN2eAeHa7zoJnVeDE7J6TNaOTcUUVPnGPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgFRBTS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbgFRBTS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 21:19:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1B1721D7E;
        Thu, 18 Jun 2020 01:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443157;
        bh=+99deZvNUdOtLha3jEqtpkcnyY0AVONasx7hLFe4Fyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19sPFlpWZ2jatJpjA6B1h0R/SeWkDmv1uk8h6lsnvNVtzuTd0NCC22MVvB/ZVlsC/
         YqrOvAO6scGhWtiKpdoggIp2C4nZL15Lu5hYLY3bXsfyFl5VKirfaNLZUdWLk7ZRUd
         x2rHl+vNVJzVZ/QuqPsr97XHcDiMlm2EZyhl35cM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 124/266] PCI: rcar: Fix incorrect programming of OB windows
Date:   Wed, 17 Jun 2020 21:14:09 -0400
Message-Id: <20200618011631.604574-124-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Andrew Murray <andrew.murray@arm.com>

[ Upstream commit 2b9f217433e31d125fb697ca7974d3de3ecc3e92 ]

The outbound windows (PCIEPAUR(x), PCIEPALR(x)) describe a mapping between
a CPU address (which is determined by the window number 'x') and a
programmed PCI address - Thus allowing the controller to translate CPU
accesses into PCI accesses.

However the existing code incorrectly writes the CPU address - lets fix
this by writing the PCI address instead.

For memory transactions, existing DT users describe a 1:1 identity mapping
and thus this change should have no effect. However the same isn't true for
I/O.

Link: https://lore.kernel.org/r/20191004132941.6660-1-andrew.murray@arm.com
Fixes: c25da4778803 ("PCI: rcar: Add Renesas R-Car PCIe driver")
Tested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-rcar.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 1ad0b56f11b4..04114352d0e7 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -335,11 +335,12 @@ static struct pci_ops rcar_pcie_ops = {
 };
 
 static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
-				   struct resource *res)
+				   struct resource_entry *window)
 {
 	/* Setup PCIe address space mappings for each resource */
 	resource_size_t size;
 	resource_size_t res_start;
+	struct resource *res = window->res;
 	u32 mask;
 
 	rcar_pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
@@ -353,9 +354,9 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
 	rcar_pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
 
 	if (res->flags & IORESOURCE_IO)
-		res_start = pci_pio_to_address(res->start);
+		res_start = pci_pio_to_address(res->start) - window->offset;
 	else
-		res_start = res->start;
+		res_start = res->start - window->offset;
 
 	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPAUR(win));
 	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
@@ -384,7 +385,7 @@ static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
 		case IORESOURCE_MEM:
-			rcar_pcie_setup_window(i, pci, res);
+			rcar_pcie_setup_window(i, pci, win);
 			i++;
 			break;
 		case IORESOURCE_BUS:
-- 
2.25.1

