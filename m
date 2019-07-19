Return-Path: <SRS0=+Ydv=VQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046B2C76195
	for <linux-pci@archiver.kernel.org>; Fri, 19 Jul 2019 04:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A3D2173B
	for <linux-pci@archiver.kernel.org>; Fri, 19 Jul 2019 04:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510255;
	bh=BO1bGut20As8jNX+DGaiQdpEzVB0+FJBl+NFQzCeV8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yRo2kmBd4GAK4wsez5qQTokU87327UdxufOYb0ffMRG+mUj2Z3HtKrr/4IbAX5vfz
	 cmRBT/x0pRoOVYJsyB3LwFVhNnQqOi7LjNDluiJVTlxqFLn8O4cOGRR0df4up7zgRS
	 klDb4OZv+jPqEQ5I4ZcVkETOn7uv2yuNm4kTiluE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfGSEYK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbfGSEJp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jul 2019 00:09:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7CB0218C3;
        Fri, 19 Jul 2019 04:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509384;
        bh=BO1bGut20As8jNX+DGaiQdpEzVB0+FJBl+NFQzCeV8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6c0uf/8LTepU7B6iRoAQJdM2AWvHDEfLwpfOk6v3XOGC5AP5rhr3FJjl26LsDzXr
         +d0adEv2ucVWsx6542XTJTRi3dXUbVh7ciWTSME6KcAEGZExdc2hdiew6t09lDfmXQ
         GSBqXjPLImnAx5cJHEkQpRsQmN5T0et0Kjs6nliQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 066/101] PCI: mobiveil: Fix PCI base address in MEM/IO outbound windows
Date:   Fri, 19 Jul 2019 00:06:57 -0400
Message-Id: <20190719040732.17285-66-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040732.17285-1-sashal@kernel.org>
References: <20190719040732.17285-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

[ Upstream commit f99536e9d2f55996038158a6559d4254a7cc1693 ]

The outbound memory windows PCI base addresses should be taken
from the 'ranges' property of DT node to setup MEM/IO outbound
windows decoding correctly instead of being hardcoded to zero.

Update the code to retrieve the PCI base address for each range
and use it to program the outbound windows address decoders

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mobiveil.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index a939e8d31735..d9f2d0f2d602 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -559,8 +559,9 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 		if (type) {
 			/* configure outbound translation window */
 			program_ob_windows(pcie, pcie->ob_wins_configured,
-				win->res->start, 0, type,
-				resource_size(win->res));
+					   win->res->start,
+					   win->res->start - win->offset,
+					   type, resource_size(win->res));
 		}
 	}
 
-- 
2.20.1

