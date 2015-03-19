Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 19 Mar 2015 19:58:06 +0100
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH v2 2/4] pci: don't disable msi/msix at shutdown
Message-ID: <1426786724-22241-3-git-send-email-mst@redhat.com>
References: <1426786724-22241-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426786724-22241-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This partially reverts commit d52877c7b1afb8c37ebe17e2005040b79cb618b0:
	"pci/irq: let pci_device_shutdown to call pci_msi_shutdown v2"

It's un-necessary now that we disable msi at start, and it actually
turns out to cause problems: some device drivers don't register a level
interrupt handler when they detect msi/msix capability, switching off
msi while device is going causes device to assert a level interrupt
which is never de-asserted, causing a kernel hang.

In particular, this was observed with virtio.

Cc: Yinghai Lu <yhlu.kernel.send@gmail.com>
Cc: Ulrich Obergfell <uobergfe@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Reported-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/pci/pci-driver.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 2ebd2a8..c7566f1 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -456,8 +456,6 @@ static void pci_device_shutdown(struct device *dev)
 
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
-	pci_msi_shutdown(pci_dev);
-	pci_msix_shutdown(pci_dev);
 
 #ifdef CONFIG_KEXEC
 	/*
-- 
MST

