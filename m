Return-Path: <SRS0=pntK=W6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1467C3A5A5
	for <linux-pci@archiver.kernel.org>; Tue,  3 Sep 2019 16:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD3D215EA
	for <linux-pci@archiver.kernel.org>; Tue,  3 Sep 2019 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528344;
	bh=VdilDWcuzsVVqy1xSRAXyAiXDXeSNGwCwiyBUksGKcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XYI8hWPrqJkEqdEepR7hS07a9wgbgfAa8FsYZOB01aN8D0iYBUkl38L1dw1mRNzmh
	 xg0iRheoV0DD1/TWD9VDoin/lVZkDpJBfZfr8saV6Ui50XojLcU7JZ+4l8SCdgp3rA
	 YAe0eB11pryNsWdAK3KviJVtRz+ldNUA5ymTCrQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfICQcT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731304AbfICQcT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Sep 2019 12:32:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CFAC238C5;
        Tue,  3 Sep 2019 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567528338;
        bh=VdilDWcuzsVVqy1xSRAXyAiXDXeSNGwCwiyBUksGKcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/7Bc1Bwa7ewAtqfeuhjYSz2KvJdqiyWDiXRhbpc7QsWzNBvojbLma6+0DaooH9Ym
         kXdim2N0tQyIkWy2omFVU78de4IczZjMWc5l6jR2qdo8w/j4XCCd5Ab2Oo/kfMpkz4
         6ccYk8343tkVw8Pn5yFaziHsi3efiUZj1HU/d6jg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lyude Paul <lyude@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Daniel Drake <drake@endlessm.com>,
        Aaron Plattner <aplattner@nvidia.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Karol Herbst <kherbst@redhat.com>,
        Maik Freudenberg <hhfeuer@gmx.de>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 167/167] PCI: Reset both NVIDIA GPU and HDA in ThinkPad P50 workaround
Date:   Tue,  3 Sep 2019 12:25:19 -0400
Message-Id: <20190903162519.7136-167-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Lyude Paul <lyude@redhat.com>

[ Upstream commit ad54567ad5d8e938ee6cf02e4f3867f18835ae6e ]

quirk_reset_lenovo_thinkpad_50_nvgpu() resets NVIDIA GPUs to work around
an apparent BIOS defect.  It previously used pci_reset_function(), and
the available method was a bus reset, which was fine because there was
only one function on the bus.  After b516ea586d71 ("PCI: Enable NVIDIA
HDA controllers"), there are now two functions (the HDA controller and
the GPU itself) on the bus, so the reset fails.

Use pci_reset_bus() explicitly instead of pci_reset_function() since it's
OK to reset both devices.

[bhelgaas: commit log, add e0547c81bfcf]
Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers")
Fixes: e0547c81bfcf ("PCI: Reset Lenovo ThinkPad P50 nvgpu at boot if necessary")
Link: https://lore.kernel.org/r/20190801220117.14952-1-lyude@redhat.com
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Ben Skeggs <bskeggs@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Aaron Plattner <aplattner@nvidia.com>
Cc: Peter Wu <peter@lekensteyn.nl>
Cc: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Maik Freudenberg <hhfeuer@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 311f8a33e62ff..06be52912dcdb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5162,7 +5162,7 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
 	 */
 	if (ioread32(map + 0x2240c) & 0x2) {
 		pci_info(pdev, FW_BUG "GPU left initialized by EFI, resetting\n");
-		ret = pci_reset_function(pdev);
+		ret = pci_reset_bus(pdev);
 		if (ret < 0)
 			pci_err(pdev, "Failed to reset GPU: %d\n", ret);
 	}
-- 
2.20.1

