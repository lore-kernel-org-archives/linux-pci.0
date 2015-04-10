Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34143 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932681AbbDJWzD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 18:55:03 -0400
Received: by iget9 with SMTP id t9so22719430ige.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 15:55:02 -0700 (PDT)
Subject: [PATCH v6 06/10] virtio_pci: drop pci_msi_off() call during probe
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>, Yinghai Lu <yinghai@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 10 Apr 2015 17:55:00 -0500
Message-ID: <20150410225500.20848.97595.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Michael S. Tsirkin <mst@redhat.com>

The PCI core now disables MSI and MSI-X for all devices during enumeration
regardless of CONFIG_PCI_MSI.  Remove device-specific code to disable
MSI/MSI-X.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/virtio/virtio_pci_common.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index e894eb278d83..806bb2c2e382 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -501,9 +501,6 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 	INIT_LIST_HEAD(&vp_dev->virtqueues);
 	spin_lock_init(&vp_dev->lock);
 
-	/* Disable MSI/MSIX to bring device to a known good state. */
-	pci_msi_off(pci_dev);
-
 	/* enable the device */
 	rc = pci_enable_device(pci_dev);
 	if (rc)

