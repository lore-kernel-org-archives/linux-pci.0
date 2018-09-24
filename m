Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D50DECE561
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 14:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D661F204EC
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 14:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmrJjx1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D661F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeIXUD3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:03:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46326 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeIXUD3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Sep 2018 16:03:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so9176255pga.13
        for <linux-pci@vger.kernel.org>; Mon, 24 Sep 2018 07:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ojyvpWWSeJB4VoUIPeiyczueKf/+h0TMp7tohw8Zp/k=;
        b=CmrJjx1tv7qxifaXfJgMXdEn4jqfI1lmJzFEWepJbZ4bHhl22MdeERP+HQnVQ2XSpH
         a+mZDzw1baJLRqK0ms5CUGstGKqOOka6ZX9oDOMgiGjeCs7OVof+DBOH3aLPLDJuzO5m
         2KPTKVlC+mx9bOQGibhQh92twzR4sj4TVary5o/0IngXG6+UvQom6+Jv2GSsQZBpjafi
         qbouGvHhPlHk+jlrXXNzYx7fPuI3rZ2OwBcTnsT4Dvz3ffRPIFZXKr6kC2+WWYN2H27t
         eiyvTDVe90PAsx27peL11kPyPNoUuQ6t+5heq8ZZKDvAR1H802OkIykp+PwMnwhKLYJv
         943g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ojyvpWWSeJB4VoUIPeiyczueKf/+h0TMp7tohw8Zp/k=;
        b=p1BkR/HT5hkq0uV+JsOc0rRYZghmaPZJJOeAzhXP5E4rDzoSLVlZI3J9ci9ovzt402
         uRPpYLl2Jv1cn6nLi5D/jFzMlk9mC6DbzmjCsDgvtp9zJ7R+7PhvgVvYsDqFAfrrb62W
         Z3t4XZlB2thXXoepFMzzflY7/t5tWwgYmq7Q0I7l4Zx1mfkgi1A5Dq9q+Jw+kvI07/C/
         l5Uf0etsueoBtp65imHZWNil714MAk/ix/Ls6K0NKrR1M85D7Ct78dSt006IyqQpyxKw
         JrF0jCybpdiXH9DtDvLiRIs3sfSwCmsqUiOkbQu5cWNh4V3qwYb5p2Y0rqgvOG4Ubn3I
         ObJw==
X-Gm-Message-State: ABuFfoiQmZzYg/KqD/1KHL+ZwN91FUFUuy99IrINVnECEBMmw9rXdq1N
        o3ssh1HlnYpDVlC+dSVlVxY=
X-Google-Smtp-Source: ACcGV62n9Ahv5y/IUlRGTkaU7SoxfSC+T5dDnQxHqUwNTKCiAD1hbpX5YutEP1JE23JASL0f72eO3A==
X-Received: by 2002:a63:6c89:: with SMTP id h131-v6mr9547452pgc.237.1537797671007;
        Mon, 24 Sep 2018 07:01:11 -0700 (PDT)
Received: from local.opencloud.tech.localdomain ([183.134.52.144])
        by smtp.gmail.com with ESMTPSA id j5-v6sm44659058pff.139.2018.09.24.07.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 07:01:10 -0700 (PDT)
From:   xiangxia.m.yue@gmail.com
To:     helgaas@kernel.org, hch@lst.de
Cc:     linux-pci@vger.kernel.org, Tonghao Zhang <xiangxia.m.yue@gmail.com>
Subject: [PATCH] pci: msi: return error code instead of only warn
Date:   Mon, 24 Sep 2018 07:00:41 -0700
Message-Id: <1537797641-6868-1-git-send-email-xiangxia.m.yue@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

The drivers may enable the msi/msix more than once.
Actually, this is the driver bug. But the bug may panic
the kernel and should be fixed. We can return the error
code instead of WARN_ON, to tell the drivers that the
msi/msix is already enabled.

When enable them again, the call tree is shown on kernel
3.10.0, but linux upstream in the same way.

Call Trace:
	dump_stack+0x19/0x1b
	warn_slowpath_common+0x70/0xb0
	warn_slowpath_null+0x1a/0x20
	pci_enable_msix+0x3c9/0x3e0
	igbuio_pci_open+0x72/0x300 [igb_uio]
	uio_open+0xcc/0x120 [uio]
	chrdev_open+0xa1/0x1e0
	[...]
	do_sys_open+0xf3/0x1f0
	SyS_open+0x1e/0x20
	system_call_fastpath+0x16/0x1b
	------------[ cut here ]------------
	WARNING: at fs/sysfs/dir.c:526 sysfs_add_one+0xa5/0xd0()
	sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:03.0/0000:01:00.1/msi_irqs'

Call Trace:
	dump_stack+0x19/0x1b
	warn_slowpath_common+0x70/0xb0
	warn_slowpath_fmt+0x5c/0x80
	sysfs_add_one+0xa5/0xd0
	create_dir+0x7c/0xe0
	sysfs_create_subdir+0x1c/0x20
	internal_create_group+0x6d/0x290
	sysfs_create_groups+0x4a/0xa0
	populate_msi_sysfs+0x1cd/0x210
	pci_enable_msix+0x31c/0x3e0
	igbuio_pci_open+0x72/0x300 [igb_uio]
	uio_open+0xcc/0x120 [uio]
	chrdev_open+0xa1/0x1e0
	[...]
	do_sys_open+0xf3/0x1f0
	SyS_open+0x1e/0x20
	system_call_fastpath+0x16/0x1b
	---[ end trace 11042e2848880209 ]---
	Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ffffffffa056b4fa

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
 drivers/pci/msi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4d88afd..4326e27 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -958,7 +958,6 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 			}
 		}
 	}
-	WARN_ON(!!dev->msix_enabled);
 
 	/* Check whether driver already requested for MSI irq */
 	if (dev->msi_enabled) {
@@ -1028,8 +1027,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (!pci_msi_supported(dev, minvec))
 		return -EINVAL;
 
-	WARN_ON(!!dev->msi_enabled);
-
 	/* Check whether driver already requested MSI-X irqs */
 	if (dev->msix_enabled) {
 		pci_info(dev, "can't enable MSI (MSI-X already enabled)\n");
@@ -1039,6 +1036,9 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	if (WARN_ON_ONCE(!!dev->msi_enabled))
+		return  -EINVAL;
+
 	nvec = pci_msi_vec_count(dev);
 	if (nvec < 0)
 		return nvec;
@@ -1087,6 +1087,9 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	if (WARN_ON_ONCE(!!dev->msix_enabled))
+		return  -EINVAL;
+
 	for (;;) {
 		if (affd) {
 			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
-- 
1.8.3.1

