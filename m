Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40070 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067AbbC2PEu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 29 Mar 2015 11:04:50 -0400
Date: Sun, 29 Mar 2015 17:04:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Nikhil Rao <nikhil.rao@intel.com>,
	Siva Yerramreddy <yshivakrishna@gmail.com>,
	Sudeep Dutt <sudeep.dutt@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 08/10] mic: drop pci_msi_off call on probe
Message-ID: <1427641227-7574-9-git-send-email-mst@redhat.com>
References: <1427641227-7574-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427641227-7574-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci core now disables msi on probe automatically,
drop this from device-specific code.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/misc/mic/host/mic_intr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/mic/host/mic_intr.c b/drivers/misc/mic/host/mic_intr.c
index d686f28..b4ca6c8 100644
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
-- 
MST

