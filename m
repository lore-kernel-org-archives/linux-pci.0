Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43A0C10F00
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 18:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C7B2184C
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709817;
	bh=wuNY7ljoIS1ZD31d45BkhQfHoi82zPOiPMuDdesqbJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TllPsAxqYikk12Gx9oPqNYfey/13ZuRNE+Z5f7g0pxv3dQt+gruzqXx9g9WCxBA/P
	 JA5m5hPRtpy2ljiFI0SUkFJ1MDCx0xU+SlGadpeN3VJK2RfCwrGSyclSNibBIeppqb
	 oFd68sC4sS14/5e8I4jXBTh6/zAZ78Yp8h70tPb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbfC0SDg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729164AbfC0SDg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Mar 2019 14:03:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32128217D9;
        Wed, 27 Mar 2019 18:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709815;
        bh=wuNY7ljoIS1ZD31d45BkhQfHoi82zPOiPMuDdesqbJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zxqOrdxXqogK+s4zVm1WrAQmaKM4W14i6Zt/7HEYKUKondByXoxQ4D3S610e/YK6
         Oxo7moihOYrNi/VpXm61AdnmJs1GlcS9hEl8vU6/xRZeq1Y7jRUpWCxzI+UeeXZZsv
         iFohT/9JMVUpieT2JwW0Izaeild6Jzqfut00pDgw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Honghui Zhang <honghui.zhang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.0 054/262] PCI: mediatek: Fix memory mapped IO range size computation
Date:   Wed, 27 Mar 2019 13:58:29 -0400
Message-Id: <20190327180158.10245-54-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

[ Upstream commit c61df57343bf05743f8abbb31eec9a6f05820dd1 ]

Mediatek's HW assigns a MMIO address range (typically starts from
0x20000000 to 0x2fffffff for both mt2712 and mt7622) for PCI usage.

This MMIO address space represents the address space that can
be allocated to PCI devices through Base Address Registers.

Even though the full MMIO address range is available to be allocated, it
should be enabled by the PCIE_AHB_TRANS_BASE register in the host
controller and the size that is enabled is determined by AHB2PCIE_SIZE
bits in this register.

Owing to a bug in the MMIO window size computation, current code does
not enable the full size of the available MMIO address range in the
PCI host controller; if the PCI devices BARs requested size exceeds the
size enabled through the PCIE_AHB_TRANS_BASE register the requests
targeting the disabled address address space will be blocked by the root
complex causing a system error.

Existing code has never run into a system error in production because
even half of the enabled MMIO range (128MB) is big enough for typical
devices BAR requests (4MB) but the full MMIO address range should
be enabled regardless.

Fix the MMIO window size computation by using resource_size(mem) instead
of mem->end - mem->start.

Since the MMIO window size for both MT2712 and MT7622 is 0x10000000,
this change will update the parameter passed to fls() from 0xfffffff to
0x10000000 and calculate the whole memory mapped IO range size
correctly.

Detected through coccinelle semantic patch (and related warning):

scripts/coccinelle/api/resource_size.cocci:

pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
[lorenzo.pieralisi@arm.com: rewrote the commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mediatek.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 55e471c18e8d..c42fe5c4319f 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -654,7 +654,6 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	struct resource *mem = &pcie->mem;
 	const struct mtk_pcie_soc *soc = port->pcie->soc;
 	u32 val;
-	size_t size;
 	int err;
 
 	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
@@ -706,8 +705,8 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		mtk_pcie_enable_msi(port);
 
 	/* Set AHB to PCIe translation windows */
-	size = mem->end - mem->start;
-	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
+	val = lower_32_bits(mem->start) |
+	      AHB2PCIE_SIZE(fls(resource_size(mem)));
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
 
 	val = upper_32_bits(mem->start);
-- 
2.19.1

