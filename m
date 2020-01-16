Return-Path: <SRS0=0+aG=3F=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D58CC33CAF
	for <linux-pci@archiver.kernel.org>; Thu, 16 Jan 2020 19:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0A32073A
	for <linux-pci@archiver.kernel.org>; Thu, 16 Jan 2020 19:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202259;
	bh=r1TXOJ5+im7ZtJxcLkK9fAtqlGOUDTNxoiKn4bdGoiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ajZ1jpUM5InIRaMLt0wggqe2jQMRF97g33udgfe4FReGODfFTxEPCSGRhbqEYthjP
	 BsrFSkdjk50fvEtHjpkivFtaL3sOHK1gtjFGIqcz/p9oUU5J8U9pH4OVsgemsujCSe
	 CCWZCtOz4leMX/hzJOj4tjE2vbKNqZasZ8XlJHz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437636AbgAPTR2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:17:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731458AbgAPQzS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jan 2020 11:55:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A59D422522;
        Thu, 16 Jan 2020 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193717;
        bh=r1TXOJ5+im7ZtJxcLkK9fAtqlGOUDTNxoiKn4bdGoiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAvlw/yfBXArpMHce8av4YhNQXGC7Biqy5lRJtvEqoRzZ4GsEbbnRZNQw0K4Xk11Q
         lsBjWr9A4J8f0yNsjJZcUSoo3xdORzZMlpYb8QaGKJegcR3UhSkBccQr4Yqs03Gq/i
         55RYxprIwZnZ53sZtxcAg18O6cuPNGhHUcrD1jKo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 012/671] PCI: iproc: Remove PAXC slot check to allow VF support
Date:   Thu, 16 Jan 2020 11:44:03 -0500
Message-Id: <20200116165502.8838-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jitendra Bhivare <jitendra.bhivare@broadcom.com>

[ Upstream commit 4da6b4480766e5bc9c4d7bc14bf1d0939a1a5fa7 ]

Fix previous incorrect logic that limits PAXC slot number to zero only.
In order for SRIOV/VF to work, we need to allow the slot number to be
greater than zero.

Fixes: 46560388c476c ("PCI: iproc: Allow multiple devices except on PAXC")
Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-iproc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 3160e9342a2f..c20fd6bd68fd 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -630,14 +630,6 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct iproc_pcie *pcie,
 			return (pcie->base + offset);
 	}
 
-	/*
-	 * PAXC is connected to an internally emulated EP within the SoC.  It
-	 * allows only one device.
-	 */
-	if (pcie->ep_is_internal)
-		if (slot > 0)
-			return NULL;
-
 	return iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, where);
 }
 
-- 
2.20.1

