Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4B4C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 16:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C6721508
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 16:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C6721508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbeIYWbI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:31:08 -0400
Received: from ale.deltatee.com ([207.54.116.67]:42684 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729660AbeIYWbI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 18:31:08 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1g4q6p-0002fG-OI; Tue, 25 Sep 2018 10:22:51 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1g4q6c-00019E-CX; Tue, 25 Sep 2018 10:22:34 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jens Axboe <axboe@kernel.dk>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 25 Sep 2018 10:22:20 -0600
Message-Id: <20180925162231.4354-3-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925162231.4354-1-logang@deltatee.com>
References: <20180925162231.4354-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, linux-block@vger.kernel.org, sbates@raithlin.com, hch@lst.de, sagi@grimberg.me, bhelgaas@google.com, jgg@mellanox.com, maxg@mellanox.com, keith.busch@intel.com, dan.j.williams@intel.com, benh@kernel.crashing.org, jglisse@redhat.com, alex.williamson@redhat.com, christian.koenig@amd.com, axboe@kernel.dk, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v7 02/13] PCI/P2PDMA: Add sysfs group to display p2pmem stats
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a sysfs group to display statistics about P2P memory that is
registered in each PCI device.

Attributes in the group display the total amount of P2P memory, the
amount available and whether it is published or not.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 24 +++++++++++
 drivers/pci/p2pdma.c                    | 54 +++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 44d4b2be92fd..8bfee557e50e 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -323,3 +323,27 @@ Description:
 
 		This is similar to /sys/bus/pci/drivers_autoprobe, but
 		affects only the VFs associated with a specific PF.
+
+What:		/sys/bus/pci/devices/.../p2pmem/size
+Date:		November 2017
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:
+		If the device has any Peer-to-Peer memory registered, this
+	        file contains the total amount of memory that the device
+		provides (in decimal).
+
+What:		/sys/bus/pci/devices/.../p2pmem/available
+Date:		November 2017
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:
+		If the device has any Peer-to-Peer memory registered, this
+	        file contains the amount of memory that has not been
+		allocated (in decimal).
+
+What:		/sys/bus/pci/devices/.../p2pmem/published
+Date:		November 2017
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:
+		If the device has any Peer-to-Peer memory registered, this
+	        file contains a '1' if the memory has been published for
+		use outside the driver that owns the device.
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index d9616522c1fc..d61389945da2 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -24,6 +24,54 @@ struct pci_p2pdma {
 	bool p2pmem_published;
 };
 
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	size_t size = 0;
+
+	if (pdev->p2pdma->pool)
+		size = gen_pool_size(pdev->p2pdma->pool);
+
+	return snprintf(buf, PAGE_SIZE, "%zd\n", size);
+}
+static DEVICE_ATTR_RO(size);
+
+static ssize_t available_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	size_t avail = 0;
+
+	if (pdev->p2pdma->pool)
+		avail = gen_pool_avail(pdev->p2pdma->pool);
+
+	return snprintf(buf, PAGE_SIZE, "%zd\n", avail);
+}
+static DEVICE_ATTR_RO(available);
+
+static ssize_t published_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			pdev->p2pdma->p2pmem_published);
+}
+static DEVICE_ATTR_RO(published);
+
+static struct attribute *p2pmem_attrs[] = {
+	&dev_attr_size.attr,
+	&dev_attr_available.attr,
+	&dev_attr_published.attr,
+	NULL,
+};
+
+static const struct attribute_group p2pmem_group = {
+	.attrs = p2pmem_attrs,
+	.name = "p2pmem",
+};
+
 static void pci_p2pdma_percpu_release(struct percpu_ref *ref)
 {
 	struct pci_p2pdma *p2p =
@@ -53,6 +101,7 @@ static void pci_p2pdma_release(void *data)
 	percpu_ref_exit(&pdev->p2pdma->devmap_ref);
 
 	gen_pool_destroy(pdev->p2pdma->pool);
+	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
 	pdev->p2pdma = NULL;
 }
 
@@ -83,9 +132,14 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 
 	pdev->p2pdma = p2p;
 
+	error = sysfs_create_group(&pdev->dev.kobj, &p2pmem_group);
+	if (error)
+		goto out_pool_destroy;
+
 	return 0;
 
 out_pool_destroy:
+	pdev->p2pdma = NULL;
 	gen_pool_destroy(p2p->pool);
 out:
 	devm_kfree(&pdev->dev, p2p);
-- 
2.19.0

