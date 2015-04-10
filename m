Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34193 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932681AbbDJWzK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 18:55:10 -0400
Received: by iget9 with SMTP id t9so22720683ige.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 15:55:09 -0700 (PDT)
Subject: [PATCH v6 07/10] ntb: Drop pci_msi_off() call during probe
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>, Yinghai Lu <yinghai@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 10 Apr 2015 17:55:07 -0500
Message-ID: <20150410225507.20848.32713.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
 drivers/ntb/ntb_hw.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ntb/ntb_hw.c b/drivers/ntb/ntb_hw.c
index cd29b1038c5e..8225cbcd6eb8 100644
--- a/drivers/ntb/ntb_hw.c
+++ b/drivers/ntb/ntb_hw.c
@@ -1313,8 +1313,6 @@ static int ntb_setup_intx(struct ntb_device *ndev)
 	struct pci_dev *pdev = ndev->pdev;
 	int rc;
 
-	pci_msi_off(pdev);
-
 	/* Verify intx is enabled */
 	pci_intx(pdev, 1);
 

