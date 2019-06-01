Return-Path: <SRS0=Eazx=UA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704C0C28CC4
	for <linux-pci@archiver.kernel.org>; Sat,  1 Jun 2019 13:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD2826FAA
	for <linux-pci@archiver.kernel.org>; Sat,  1 Jun 2019 13:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395740;
	bh=8fTEMjsAL1VfuBszWz4/HDBO0iCno7HlZWDWipmdsJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=igsFlJ0WLmdgaHDRT98eZl3OECgxUUX9i9VDZvSFWNa3FPLJXz8T//wMI767jw4Sb
	 /GxgjShsFuTawtGT7bMIq7HNemgkDazMKt0D3K+rn8BDWLwIGRxlSwjQ/2cp8wNUu9
	 9Uil5+a8mpCZHbhml6dDdCHwgIQLXtn7EoIY4R7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfFAN1M (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbfFAN1K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 1 Jun 2019 09:27:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2473A273AD;
        Sat,  1 Jun 2019 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395630;
        bh=8fTEMjsAL1VfuBszWz4/HDBO0iCno7HlZWDWipmdsJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VerJNDvy3oIlC+GfxqFDTCV1UU0qBbIKsVw9/LifzyZMAbBQdru/AP2esRqsj6Ara
         SfWio0Htdqn7GyyVOCF9/PzFFJDC9AfkKe5FbQ8jZi/uYzfaahV6MoREWuG40jN8a3
         3hux/PYbvGyu5g1GHwdYWABX3T+pyXERHEgbOACU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 40/56] PCI: rcar: Fix a potential NULL pointer dereference
Date:   Sat,  1 Jun 2019 09:25:44 -0400
Message-Id: <20190601132600.27427-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132600.27427-1-sashal@kernel.org>
References: <20190601132600.27427-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit f0d14edd2ba43b995bef4dd5da5ffe0ae19321a1 ]

In case __get_free_pages() fails and returns NULL, fix the return
value to -ENOMEM and release resources to avoid dereferencing a
NULL pointer.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/host/pcie-rcar.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 414c336866218..b18cf12731ee0 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -737,6 +737,10 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 
 	/* setup MSI data target */
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
+	if (!msi->pages) {
+		err = -ENOMEM;
+		goto err;
+	}
 	base = virt_to_phys((void *)msi->pages);
 
 	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
-- 
2.20.1

