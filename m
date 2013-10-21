Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:47030 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab3JUJHt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2013 05:07:49 -0400
Received: by mail-pa0-f50.google.com with SMTP id fa1so7601374pad.23
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2013 02:07:49 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, sachin.kamat@linaro.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 2/3] PCI: mvebu: Remove redeundant of_match_ptr
Date: Mon, 21 Oct 2013 14:36:42 +0530
Message-Id: <1382346403-29576-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382346403-29576-1-git-send-email-sachin.kamat@linaro.org>
References: <1382346403-29576-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

mvebu_pcie_of_match_table is always compiled in. Hence of_match_ptr is
not required.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 20c470c..7adae6e 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1016,8 +1016,7 @@ static struct platform_driver mvebu_pcie_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "mvebu-pcie",
-		.of_match_table =
-		   of_match_ptr(mvebu_pcie_of_match_table),
+		.of_match_table = mvebu_pcie_of_match_table,
 		/* driver unloading/unbinding currently not supported */
 		.suppress_bind_attrs = true,
 	},
-- 
1.7.9.5

