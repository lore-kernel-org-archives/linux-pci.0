Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC87C10F0E
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 11:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9960A217FA
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 11:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJcwrAwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbfDRL7D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:59:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44720 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388686AbfDRL7C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Apr 2019 07:59:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id w18so2608455wrv.11
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2019 04:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btrdTwIXzLTrssNuLj0WEfBF5qjmswkpq/7mfNOagxY=;
        b=EJcwrAwXvMSO7YbrR0qfNWaEn+QZhwBVct/1KYVZ7F7toNzmCc2Cef77+1cNzx5KYJ
         /FUsyRBMhxM/Eawe3c47mksPUQlDUwnDgEb6tqf/VRE9qyisuZZFL7N6RNkv+skpWJA7
         rsuR6EpGk/FJYo9cPK0EFAlKFyoW1xShtXjYHfrawFQRVjXwn8XktrPKFVjQENydJBwH
         aJwB9Mgx6PEWc7c7a6bzweQXySC6v7bZE/61+cobh+9RCYvdQEyU4Wnq1Hsy/C0unBTY
         VyC9aRLHsc4S64tySeIptETQtqfnyrDsld0UB3OgWsISCgVxh8GO3Xp//pP1Mq8G9Z6+
         qSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btrdTwIXzLTrssNuLj0WEfBF5qjmswkpq/7mfNOagxY=;
        b=Rj1P/dvgU4s4Jz3dN9Wna4hqDtuQFGo0us01JnNYmQ+eDfzpMoYfGJ/dar6Xvlwn56
         eTdPuuIJhTAQJUcB9oVMQfnQzgjrjSUBU0WbNioQjWgqvOnXH+0TNuiUAyfk/EjPbogE
         6/k8cLlZancaUvU1nvjOHYYW9L44KJKzL7kirBXhrCi5dQf6nQaf+ynRj8ZqYuHXiQMj
         Z/ycwwZxZTHWBi/1qD4gsA9roSpyYOlLS3C5mi61rRLW3MXY44r/a9XKu/Ej/27C1/if
         6TMSKu2bYMK+ZN7XIHF9+OvIcKJODGOWwRMLmO/4H9CSNi5zQ7qE0FYgVvMgJWpdHXIE
         3/RQ==
X-Gm-Message-State: APjAAAXX1OMXAg0SgRW8qWAnMxR4KIGr5bvyktBKF1NV6M4KxPRhRivF
        uMgSYwfN346jzFs2hMYJQEY=
X-Google-Smtp-Source: APXvYqzlZsC+YFY6ZzpJT6L9IsN1G3PP0kwlzchf6PqDve1hY4X6aG8E5inFk30QA4IBMWStWVZ1ew==
X-Received: by 2002:adf:e74f:: with SMTP id c15mr11646491wrn.23.1555588741273;
        Thu, 18 Apr 2019 04:59:01 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:5116:b6a9:b3b5:773e])
        by smtp.gmail.com with ESMTPSA id o6sm1110670wre.60.2019.04.18.04.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 04:59:00 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     logang@deltatee.com, rdunlap@infradead.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/P2PDMA: start with a whitelist for root complexes
Date:   Thu, 18 Apr 2019 13:58:59 +0200
Message-Id: <20190418115859.2394-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A lot of root complexes can still do P2P even when PCI devices
don't share a common upstream bridge.

Start adding a whitelist and allow P2P if both participants are
attached to known good root complex.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/p2pdma.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index c52298d76e64..212baaa7f93b 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -274,6 +274,31 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
 }
 
+/*
+ * If we can't find a common upstream bridge take a look at the root complex and
+ * compare it to a whitelist of known good hardware.
+ */
+static bool root_complex_whitelist(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
+	unsigned short vendor, device;
+
+	if (!root)
+		return false;
+
+	vendor = root->vendor;
+	device = root->device;
+	pci_dev_put(root);
+
+	/* AMD ZEN host bridges can do peer to peer */
+	if (vendor == PCI_VENDOR_ID_AMD && device == 0x1450)
+		return true;
+
+	/* TODO: Extend that to a proper whitelist */
+	return false;
+}
+
 /*
  * Find the distance through the nearest common upstream bridge between
  * two PCI devices.
@@ -317,13 +342,13 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
  * In this case, a list of all infringing bridge addresses will be
  * populated in acs_list (assuming it's non-null) for printk purposes.
  */
-static int upstream_bridge_distance(struct pci_dev *a,
-				    struct pci_dev *b,
+static int upstream_bridge_distance(struct pci_dev *provider,
+				    struct pci_dev *client,
 				    struct seq_buf *acs_list)
 {
+	struct pci_dev *a = provider, *b = client, *bb;
 	int dist_a = 0;
 	int dist_b = 0;
-	struct pci_dev *bb = NULL;
 	int acs_cnt = 0;
 
 	/*
@@ -354,6 +379,13 @@ static int upstream_bridge_distance(struct pci_dev *a,
 		dist_a++;
 	}
 
+	/* Allow the connection if both devices are on a whitelisted root
+	 * complex, but add an arbitary large value to the distance.
+	 */
+	if (root_complex_whitelist(provider) &&
+	    root_complex_whitelist(client))
+		return 0x1000 + dist_a + dist_b;
+
 	return -1;
 
 check_b_path_acs:
-- 
2.17.1

