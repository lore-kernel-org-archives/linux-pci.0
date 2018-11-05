Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA39C0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 23:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B7D20862
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 23:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX6C8qej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B7D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbeKFIrS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:47:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33877 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeKFIrR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 03:47:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id f1-v6so7482054wmg.1;
        Mon, 05 Nov 2018 15:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3XCO7P5FWCHRNFc55rpR1NNXWKHmhwb46/s8mgDKOYI=;
        b=RX6C8qejlmRklqjnBTgag2EmeRn1s/Gfh2ny5lVxTxabVRezSjSg8EYZcEpL6z0c8u
         tPAfTSg9Uj3Q7v1XLiagtWwJMENheqhFeh+7/goCjbuIflB0qiE2AnbPz/9j49okHyQo
         Qp7nUfQGnk0NS3NAUDiv919T45g+d9NwAwCNrYMytPyz7CgZJOhod52zg9ZvMciSSWGc
         5WcvoNM8y3PILfRK4rgl8ybiOAuiIlaMFjvnL6KdLDADDsxOihlgfqRIFRwLIVtXR1IM
         Oit6PRbOXdNnrXqKVyS8b3HqOvxoidWtj/dI2OBV4zTKXK9tlPxM4XjOHyNHPZNtv9aI
         qCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3XCO7P5FWCHRNFc55rpR1NNXWKHmhwb46/s8mgDKOYI=;
        b=CwKYjAs5hrSczTW9Gi0ZEfxWrvQ7AhTzXy1dzVQyaOld4nT856e/LaXOSYZTDpx5A3
         mMSSUWZu5RZVNEvDrbrDb7gx8G9lgcAuhBmcGHR1fh8V0jNSVpWLL/wW1foSJX4eIJRI
         YEV4DGTCJfDUSd3WacZD3sAnvaNlDTGKH/vVUXvRzduKZAYsCy/yjp6QO7sd+zoQhw/N
         OfRv/KMnIn/EdR+mqgLdR7hLDkJzMTRpqit9kivq3DkxCD7J61dvyqWv1Vmqo1/mXeff
         wmrpYDOABGfYeSJFH7HaCAdHHrOvD2y+qn+7Bn8HbEeiFLrYYF0vsy4TA/OBbueBY1nK
         iwqg==
X-Gm-Message-State: AGRZ1gLYER771VJoXkiBoRBOCncj6PMVW9xEYqyAB7vPy1De75M/o1NB
        rIRm6JQmrz5RFLTD0uTrS8C78oWr
X-Google-Smtp-Source: AJdET5cQwuZclwsV+c+Tpf3XfK9YRbpaddgTut9+MQutWyocRla6pP9XXL57/onpa5Vxqsrsmulcbg==
X-Received: by 2002:a1c:f313:: with SMTP id q19-v6mr102079wmq.87.1541460306316;
        Mon, 05 Nov 2018 15:25:06 -0800 (PST)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id o18-v6sm6827309wrp.31.2018.11.05.15.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 15:25:05 -0800 (PST)
From:   Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Tho Vu <tho.vu.wh@rvc.renesas.com>
Subject: [RFC][PATCH] PCI: Avoid PCI device removing/rescanning through sysfs triggers a deadlock
Date:   Tue,  6 Nov 2018 00:25:00 +0100
Message-Id: <20181105232500.19146-1-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Tho Vu <tho.vu.wh@rvc.renesas.com>

This patch fixes deadlock warning in removing/rescanning through sysfs
when CONFIG_PROVE_LOCKING is enabled.

The issue can be reproduced by these steps:
1. Enable CONFIG_PROVE_LOCKING via defconfig or menuconfig
2. Insert Ethernet card into PCIe CH0 and start up.
   After kernel starting up, execute the following command.
   echo 1 > /sys/class/pci_bus/0000\:00/device/0000\:00\:00.0/remove
3. Rescan PCI device by this command
   echo 1 > /sys/class/pci_bus/0000\:00/rescan

The deadlock warnings will occur.
============================================
WARNING: possible recursive locking detected
4.14.70-ltsi-yocto-standard #27 Not tainted
--------------------------------------------
sh/3402 is trying to acquire lock:
 (kn->count#78){++++}, at: kernfs_remove_by_name_ns+0x50/0xa8

but task is already holding lock:
 (kn->count#78){++++}, at: kernfs_remove_self+0xe0/0x130

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(kn->count#78);
  lock(kn->count#78);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by sh/3402:
 #0:  (sb_writers#4){.+.+}, at: vfs_write+0x198/0x1b0
 #1:  (&of->mutex){+.+.}, at: kernfs_fop_write+0x108/0x210
 #2:  (kn->count#78){++++}, at: kernfs_remove_self+0xe0/0x130
 #3:  (pci_rescan_remove_lock){+.+.}, at: pci_lock_rescan_remove+0x1c/0x28

stack backtrace:
CPU: 3 PID: 3402 Comm: sh Not tainted 4.14.70-ltsi-yocto-standard #27
Hardware name: Renesas Salvator-X 2nd version board based on r8a7795
ES3.0+ with 8GiB (4 x 2 GiB) (DT)
Call trace:
dump_backtrace+0x0/0x3d8
show_stack+0x14/0x20
dump_stack+0xbc/0xf4
__lock_acquire+0x930/0x18a8
lock_acquire+0x48/0x68
__kernfs_remove+0x280/0x2f8
kernfs_remove_by_name_ns+0x50/0xa8
remove_files.isra.0+0x38/0x78
sysfs_remove_group+0x4c/0xa0
sysfs_remove_groups+0x38/0x60
device_remove_attrs+0x54/0x78
device_del+0x1ac/0x308
pci_remove_bus_device+0x78/0xf8
pci_remove_bus_device+0x34/0xf8
pci_stop_and_remove_bus_device_locked+0x24/0x38
remove_store+0x6c/0x78
dev_attr_store+0x18/0x28
sysfs_kf_write+0x4c/0x78
kernfs_fop_write+0x138/0x210
__vfs_write+0x18/0x118
vfs_write+0xa4/0x1b0
SyS_write+0x48/0xb0

This warning occurs due to a self-deletion attribute using in the sysfs
PCI device directory. This kind of attribute is really tricky,
it does not allow pci framework drop this attribute until all active
.show() and .store() callbacks have finished unless
sysfs_break_active_protection() is called.
Hence this patch avoids writing into this attribute triggers a deadlock.

Referrence commit 5b55b24cec4c ("scsi: core: Avoid that SCSI device
removal through sysfs triggers a deadlock")
of scsi driver

Signed-off-by: Tho Vu <tho.vu.wh@rvc.renesas.com>
---
 drivers/pci/pci-sysfs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ecfe13157c0..d522bd8368d9 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -470,12 +470,22 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	unsigned long val;
+	struct kernfs_node *kn;
+
+	kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+	WARN_ON_ONCE(!kn);
 
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
-	if (val && device_remove_file_self(dev, attr))
+	if (val) {
+		device_remove_file(dev, attr);
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
+	}
+
+	if (kn)
+		sysfs_unbreak_active_protection(kn);
+
 	return count;
 }
 static struct device_attribute dev_remove_attr = __ATTR(remove,
@@ -487,11 +497,15 @@ static ssize_t dev_bus_rescan_store(struct device *dev,
 				    const char *buf, size_t count)
 {
 	unsigned long val;
+	struct kernfs_node *kn;
 	struct pci_bus *bus = to_pci_bus(dev);
 
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
+	kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+	WARN_ON_ONCE(!kn);
+
 	if (val) {
 		pci_lock_rescan_remove();
 		if (!pci_is_root_bus(bus) && list_empty(&bus->devices))
@@ -500,6 +514,10 @@ static ssize_t dev_bus_rescan_store(struct device *dev,
 			pci_rescan_bus(bus);
 		pci_unlock_rescan_remove();
 	}
+
+	if (kn)
+		sysfs_unbreak_active_protection(kn);
+
 	return count;
 }
 static DEVICE_ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_bus_rescan_store);
-- 
2.18.0

