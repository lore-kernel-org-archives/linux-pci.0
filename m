Return-Path: <SRS0=HNSb=UT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93711C48BE2
	for <linux-pci@archiver.kernel.org>; Thu, 20 Jun 2019 10:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739B5206E0
	for <linux-pci@archiver.kernel.org>; Thu, 20 Jun 2019 10:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbfFTKdf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:33:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726318AbfFTKdf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 06:33:35 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E76CD590D75BBE78D99E;
        Thu, 20 Jun 2019 18:33:32 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Thu, 20 Jun 2019 18:33:26 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <joe@perches.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 5/5] lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration
Date:   Thu, 20 Jun 2019 18:31:56 +0800
Message-ID: <1561026716-140537-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
References: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since the only LOGIC_PIO_INDIRECT host (hisi-lpc) now sets the ops prior
to registration, enforce this check at registration instead of in the IO
port accessors to simplify and marginally optimise the code.

A slight misalignment is also tidied.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 45eb57af2574..126593ed9049 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -39,7 +39,8 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 	resource_size_t iio_sz = MMIO_UPPER_LIMIT;
 	int ret = 0;
 
-	if (!new_range || !new_range->fwnode || !new_range->size)
+	if (!new_range || !new_range->fwnode || !new_range->size ||
+	    (new_range->flags == LOGIC_PIO_INDIRECT && !new_range->ops))
 		return -EINVAL;
 
 	start = new_range->hw_start;
@@ -237,7 +238,7 @@ type logic_in##bw(unsigned long addr)					\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-		if (entry && entry->ops)				\
+		if (entry)						\
 			ret = entry->ops->in(entry->hostdata,		\
 					addr, sizeof(type));		\
 		else							\
@@ -253,7 +254,7 @@ void logic_out##bw(type value, unsigned long addr)			\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-		if (entry && entry->ops)				\
+		if (entry)						\
 			entry->ops->out(entry->hostdata,		\
 					addr, value, sizeof(type));	\
 		else							\
@@ -261,7 +262,7 @@ void logic_out##bw(type value, unsigned long addr)			\
 	}								\
 }									\
 									\
-void logic_ins##bw(unsigned long addr, void *buffer,		\
+void logic_ins##bw(unsigned long addr, void *buffer,			\
 		   unsigned int count)					\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
@@ -269,7 +270,7 @@ void logic_ins##bw(unsigned long addr, void *buffer,		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-		if (entry && entry->ops)				\
+		if (entry)						\
 			entry->ops->ins(entry->hostdata,		\
 				addr, buffer, sizeof(type), count);	\
 		else							\
@@ -286,7 +287,7 @@ void logic_outs##bw(unsigned long addr, const void *buffer,		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-		if (entry && entry->ops)				\
+		if (entry)						\
 			entry->ops->outs(entry->hostdata,		\
 				addr, buffer, sizeof(type), count);	\
 		else							\
-- 
2.17.1

