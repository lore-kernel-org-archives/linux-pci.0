Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33251 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434AbbDJWyt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 18:54:49 -0400
Received: by ignm3 with SMTP id m3so22743843ign.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 15:54:48 -0700 (PDT)
Subject: [PATCH v6 04/10] PCI/MSI: Don't disable MSI/MSI-X at shutdown
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fam Zheng <famz@redhat.com>, linux-pci@vger.kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>
Date: Fri, 10 Apr 2015 17:54:47 -0500
Message-ID: <20150410225446.20848.51279.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Michael S. Tsirkin <mst@redhat.com>

d52877c7b1af ("pci/irq: let pci_device_shutdown to call pci_msi_shutdown
v2") disabled MSI/MSI-X at device shutdown to address a kexec problem.

The problem is that after we disable MSI, the device may assert INTx, and
if the driver hasn't registered an interrupt handler for it, the interrupt
is never deasserted and causes a kernel hang.  In particular, this was
observed with virtio.

We now disable MSI/MSI-X for all devices during enumeration regardless of
CONFIG_PCI_MSI.  This solves the kexec problem in the new kernel, not the
old one.

Stop disabling MSIs at shutdown to avoid the kernel hang.

XXX bugzilla reference, details about how the hang happens?

[bhelgaas: changelog]
Reported-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yhlu.kernel.send@gmail.com>
CC: Ulrich Obergfell <uobergfe@redhat.com>
CC: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/pci/pci-driver.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3cb2210de553..38a602cb9fb7 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -450,8 +450,6 @@ static void pci_device_shutdown(struct device *dev)
 
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
-	pci_msi_shutdown(pci_dev);
-	pci_msix_shutdown(pci_dev);
 
 #ifdef CONFIG_KEXEC
 	/*

