Return-Path: <SRS0=IRj4=B7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6154C433E1
	for <linux-pci@archiver.kernel.org>; Fri, 21 Aug 2020 16:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A9522B47
	for <linux-pci@archiver.kernel.org>; Fri, 21 Aug 2020 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598027590;
	bh=lhPzxAMtGiGwqFgokTYuR2htwCTnKmFaZukK5H3J0RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n79UvgIkkEwWJF4pCgqTwKXjoyVygjbD6IjFrWJcDBTU5Ni7tcfqkgc91amabUVXV
	 bJqgSvd/P0eKpXZlBrNq0+FK/2K+z+Y3zqTZf41VVtNau7/2h25EHgx8bP6GqsT69e
	 CzG/nrjN2ZRGXw1ibXU3YntAMScyUH86svqrasNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgHUQdI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgHUQVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Aug 2020 12:21:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F7FC207BB;
        Fri, 21 Aug 2020 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026831;
        bh=lhPzxAMtGiGwqFgokTYuR2htwCTnKmFaZukK5H3J0RU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N7FXC1o0yxNcLIkolrPkLoD37W14+I9u3cnoEg4nHd6MQbBrLRI+Hq477SpzCER62
         enMwmRWDHe7cx75OHxV84YjqN1clrAryd8XGyMY3btr5V0LhgTBmRNMwgcr2qQypIe
         bRYC//T0YvXYNp+DT4oDU7GS1Hw+1Q893fE1Fndk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>, Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 13/22] PCI: Fix pci_create_slot() reference count leak
Date:   Fri, 21 Aug 2020 12:20:05 -0400
Message-Id: <20200821162014.349506-13-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821162014.349506-1-sashal@kernel.org>
References: <20200821162014.349506-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit 8a94644b440eef5a7b9c104ac8aa7a7f413e35e5 ]

kobject_init_and_add() takes a reference even when it fails.  If it returns
an error, kobject_put() must be called to clean up the memory associated
with the object.

When kobject_init_and_add() fails, call kobject_put() instead of kfree().

b8eb718348b8 ("net-sysfs: Fix reference count leak in
rx|netdev_queue_add_kobject") fixed a similar problem.

Link: https://lore.kernel.org/r/20200528021322.1984-1-wu000273@umn.edu
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/slot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 429d34c348b9f..01a343ad7155c 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -303,13 +303,16 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	slot_name = make_slot_name(name);
 	if (!slot_name) {
 		err = -ENOMEM;
+		kfree(slot);
 		goto err;
 	}
 
 	err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, NULL,
 				   "%s", slot_name);
-	if (err)
+	if (err) {
+		kobject_put(&slot->kobj);
 		goto err;
+	}
 
 	INIT_LIST_HEAD(&slot->list);
 	list_add(&slot->list, &parent->slots);
@@ -328,7 +331,6 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	mutex_unlock(&pci_slot_mutex);
 	return slot;
 err:
-	kfree(slot);
 	slot = ERR_PTR(err);
 	goto out;
 }
-- 
2.25.1

