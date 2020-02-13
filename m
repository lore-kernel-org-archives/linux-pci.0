Return-Path: <SRS0=VRgs=4B=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F23C3F68F
	for <linux-pci@archiver.kernel.org>; Thu, 13 Feb 2020 11:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1134D24676
	for <linux-pci@archiver.kernel.org>; Thu, 13 Feb 2020 11:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgBMLko (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:40:44 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729544AbgBMLko (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Feb 2020 06:40:44 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 79CFB50A2F46B9348ACF;
        Thu, 13 Feb 2020 19:40:42 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Feb 2020 19:40:33 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH v3 7/9] PCI: Add PCIe suffix when display PCIe slot bus speed
Date:   Thu, 13 Feb 2020 19:36:31 +0800
Message-ID: <1581593793-23589-8-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1581593793-23589-1-git-send-email-yangyicong@hisilicon.com>
References: <1581593793-23589-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"PCIe" suffix of PCIe speed strings in pci_bus_speed_strings[]
is removed in previous patch. Add "PCIe" suffix when display
PCIe slot bus speed to userspace like before.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/slot.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 1c7e83f2..871d598 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -51,7 +51,10 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)

 static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
 {
-	return sprintf(buf, "%s\n", PCI_SPEED2STR(speed));
+	if (speed <= PCI_SPEED_133MHz_PCIX_533)
+		return sprintf(buf, "%s\n", PCI_SPEED2STR(speed));
+
+	return sprintf(buf, "%s PCIe\n", PCI_SPEED2STR(speed));
 }

 static ssize_t max_speed_read_file(struct pci_slot *slot, char *buf)
--
2.8.1

