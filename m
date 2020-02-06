Return-Path: <SRS0=Eeyf=32=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B980C33CAC
	for <linux-pci@archiver.kernel.org>; Thu,  6 Feb 2020 11:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E52214AF
	for <linux-pci@archiver.kernel.org>; Thu,  6 Feb 2020 11:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgBFLD0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:03:26 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48892 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727060AbgBFLD0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Feb 2020 06:03:26 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AFDE1BB4214EF730C09E;
        Thu,  6 Feb 2020 19:03:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 6 Feb 2020 19:03:15 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH v2 4/6] PCI: Refactor bus_speed_read() with PCI_SPEED2STR macro
Date:   Thu, 6 Feb 2020 18:59:18 +0800
Message-ID: <1580986760-10182-5-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1580986760-10182-1-git-send-email-yangyicong@hisilicon.com>
References: <1580986760-10182-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use PCI_SPEED2STR macro to replace judgement statment in
bus_speed_read() function. Add "PCIe" suffix when decoding PCIe
speed for proper display.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/slot.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index fb7c172..871d598 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -51,14 +51,10 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 
 static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
 {
-	const char *speed_string;
+	if (speed <= PCI_SPEED_133MHz_PCIX_533)
+		return sprintf(buf, "%s\n", PCI_SPEED2STR(speed));
 
-	if (speed < pci_bus_speed_strings_size)
-		speed_string = pci_bus_speed_strings[speed];
-	else
-		speed_string = "Unknown";
-
-	return sprintf(buf, "%s\n", speed_string);
+	return sprintf(buf, "%s PCIe\n", PCI_SPEED2STR(speed));
 }
 
 static ssize_t max_speed_read_file(struct pci_slot *slot, char *buf)
-- 
2.8.1

