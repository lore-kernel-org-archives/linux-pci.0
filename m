Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37387 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932205AbbDJWzQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 18:55:16 -0400
Received: by igblo3 with SMTP id lo3so9501632igb.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 15:55:15 -0700 (PDT)
Subject: [PATCH v6 08/10] mic: Drop pci_msi_off() call during probe
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>, Yinghai Lu <yinghai@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 10 Apr 2015 17:55:14 -0500
Message-ID: <20150410225514.20848.44500.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
 drivers/misc/mic/host/mic_intr.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/mic/host/mic_intr.c b/drivers/misc/mic/host/mic_intr.c
index d686f2846ac7..b4ca6c884d19 100644
--- a/drivers/misc/mic/host/mic_intr.c
+++ b/drivers/misc/mic/host/mic_intr.c
@@ -363,8 +363,6 @@ static int mic_setup_intx(struct mic_device *mdev, struct pci_dev *pdev)
 {
 	int rc;
 
-	pci_msi_off(pdev);
-
 	/* Enable intx */
 	pci_intx(pdev, 1);
 	rc = mic_setup_callbacks(mdev);

