Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE48C282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 17:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6981E2184D
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 17:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfA2Rrn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:47:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbfA2Rrn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 12:47:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BDFEC0753CE;
        Tue, 29 Jan 2019 17:47:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38BF05D98E;
        Tue, 29 Jan 2019 17:47:40 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
Subject: [RFC PATCH 2/5] drivers/base: add a function to test peer to peer capability
Date:   Tue, 29 Jan 2019 12:47:25 -0500
Message-Id: <20190129174728.6430-3-jglisse@redhat.com>
In-Reply-To: <20190129174728.6430-1-jglisse@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 29 Jan 2019 17:47:42 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

device_test_p2p() return true if two devices can peer to peer to
each other. We add a generic function as different inter-connect
can support peer to peer and we want to genericaly test this no
matter what the inter-connect might be. However this version only
support PCIE for now.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org
---
 drivers/base/core.c    | 20 ++++++++++++++++++++
 include/linux/device.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0073b09bb99f..56023b00e108 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -26,6 +26,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/sysfs.h>
+#include <linux/pci-p2pdma.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -3167,3 +3168,22 @@ void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
 	dev->of_node_reused = true;
 }
 EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);
+
+/**
+ * device_test_p2p - test if two device can peer to peer to each other
+ * @devA: device A
+ * @devB: device B
+ * Returns: true if device can peer to peer to each other, false otherwise
+ */
+bool device_test_p2p(struct device *devA, struct device *devB)
+{
+	/*
+	 * For now we only support PCIE peer to peer but other inter-connect
+	 * can be added.
+	 */
+	if (pci_test_p2p(devA, devB))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(device_test_p2p);
diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640b6160..0d532d7f0779 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1250,6 +1250,7 @@ extern int device_online(struct device *dev);
 extern void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 extern void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
+bool device_test_p2p(struct device *devA, struct device *devB);
 
 static inline int dev_num_vf(struct device *dev)
 {
-- 
2.17.2

