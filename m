Return-Path: <SRS0=Q0Wt=UX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCDAC48BE9
	for <linux-pci@archiver.kernel.org>; Mon, 24 Jun 2019 14:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8040B20820
	for <linux-pci@archiver.kernel.org>; Mon, 24 Jun 2019 14:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfFXOg6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:36:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19070 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbfFXOgk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 10:36:40 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 15FFA7B77114539C2EC5;
        Mon, 24 Jun 2019 22:36:37 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Jun 2019 22:36:29 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 6/6] lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration
Date:   Mon, 24 Jun 2019 22:35:08 +0800
Message-ID: <1561386908-31884-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1561386908-31884-1-git-send-email-john.garry@huawei.com>
References: <1561386908-31884-1-git-send-email-john.garry@huawei.com>
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
index 905027574e5d..52831a85293a 100644
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

