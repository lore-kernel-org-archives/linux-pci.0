Return-Path: <SRS0=dA88=2D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503AFC34992
	for <linux-pci@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9046D246A2
	for <linux-pci@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLMLsJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 13 Dec 2019 06:48:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbfLMLsI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 06:48:08 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BEF87B0C00308F293E16;
        Fri, 13 Dec 2019 19:48:06 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Fri, 13 Dec 2019 19:48:05 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
Subject: [Patch]PCI:AER:Notify which device has no error_detected callback
Date:   Fri, 13 Dec 2019 19:44:34 +0800
Message-ID: <1576237474-32021-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI error recovery will fail if any device under
root port doesn't have an error_detected callback.
Currently only failure result is printed, which is
not enough to determine which device leads to the
failure and the detailed failure reason.

Add print information if certain device under root
port has no error_detected callback.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pcie/err.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index b0e6048..ec37c33 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -61,8 +61,10 @@ static int report_error_detected(struct pci_dev *dev,
 		 * error callbacks of "any" device in the subtree, and will
 		 * exit in the disconnected error state.
 		 */
-		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
+		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
 			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
+			pci_info(dev, "AER: Device has no error_detected callback\n");
+		}
 		else
 			vote = PCI_ERS_RESULT_NONE;
 	} else {
--
2.8.1

