Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:46246 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab3LSJIM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2013 04:08:12 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so853491pde.6
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2013 01:08:12 -0800 (PST)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-pci@vger.kernel.org
Cc: jason@lakedaemon.net, bhelgaas@google.com, sachin.kamat@linaro.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH Resend 1/1] PCI: mvebu: Remove redundant of_match_ptr
Date: Thu, 19 Dec 2013 14:34:59 +0530
Message-Id: <1387443899-7149-1-git-send-email-sachin.kamat@linaro.org>
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
index 533e0df02718..bedc0b1562b9 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1012,8 +1012,7 @@ static struct platform_driver mvebu_pcie_driver = {
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

