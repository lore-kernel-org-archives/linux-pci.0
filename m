Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57543 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3GIQ2V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2013 12:28:21 -0400
From: Luis Henriques <luis.henriques@canonical.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Luis Henriques <luis.henriques@canonical.com>,
	kernel-team@lists.ubuntu.com
Subject: [ 3.8.y.z extended stable ] Patch "xen/pcifront: Deal with toolstack missing" has been added to staging queue
Date: Tue,  9 Jul 2013 17:28:17 +0100
Message-Id: <1373387297-21297-1-git-send-email-luis.henriques@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a note to let you know that I have just added a patch titled

    xen/pcifront: Deal with toolstack missing

to the linux-3.8.y-queue branch of the 3.8.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.8.y-queue

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.8.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From f38e00dc2b9d24dce95f39b490561f262b03e714 Mon Sep 17 00:00:00 2001
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Mon, 10 Jun 2013 16:48:09 -0400
Subject: [PATCH] xen/pcifront: Deal with toolstack missing
 'XenbusStateClosing' state.

commit 098b1aeaf4d6149953b8f1f8d55c21d85536fbff upstream.

There are two tool-stack that can instruct the Xen PCI frontend
and backend to change states: 'xm' (Python code with a daemon),
and 'xl' (C library - does not keep state changes).

With the 'xm', the path to disconnect a single PCI device (xm pci-detach
<guest> <BDF>) is:

4(Connected)->7(Reconfiguring*)-> 8(Reconfigured)-> 4(Connected)->5(Closing*).

The * is for states that the tool-stack sets. For 'xl', it is similar:

4(Connected)->7(Reconfiguring*)-> 8(Reconfigured)-> 4(Connected)

Both of them also tear down the XenBus structure, so the backend
state ends up going in the 3(Initialised) and calls pcifront_xenbus_remove.

When a PCI device is plugged back in (xm pci-attach <guest> <BDF>)
both of them follow the same pattern:

2(InitWait*), 3(Initialized*), 4(Connected*)->4(Connected).

[xen-pcifront ignores the 2,3 state changes and only acts when
4 (Connected) has been reached]

Note that this is for a _single_ PCI device. If there were two
PCI devices and only one was disconnected 'xm' would show the same
state changes.

The problem is that git commit 3d925320e9e2de162bd138bf97816bda8c3f71be
("xen/pcifront: Use Xen-SWIOTLB when initting if required") introduced
a mechanism to initialize the SWIOTLB when the Xen PCI front moves to
Connected state. It also had some aggressive seatbelt code check that
would warn the user if one tried to change to Connected state without
hitting first the Closing state:

 pcifront pci-0: PCI frontend already installed!

However, that code can be relaxed and we can continue on working
even if the frontend is instructed to be the 'Connected' state with
no devices and then gets tickled to be in 'Connected' state again.

In other words, this 4(Connected)->5(Closing)->4(Connected) state
was expected, while 4(Connected)->.... anything but 5(Closing)->4(Connected)
was not. This patch removes that aggressive check and allows
Xen pcifront to work with the 'xl' toolstack (for one or more
PCI devices) and with 'xm' toolstack (for more than two PCI
devices).

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
[v2: Added in the description about two PCI devices]
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/pci/xen-pcifront.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 966abc6..f7197a7 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -678,10 +678,9 @@ static int pcifront_connect_and_init_dma(struct pcifront_device *pdev)
 	if (!pcifront_dev) {
 		dev_info(&pdev->xdev->dev, "Installing PCI frontend\n");
 		pcifront_dev = pdev;
-	} else {
-		dev_err(&pdev->xdev->dev, "PCI frontend already installed!\n");
+	} else
 		err = -EEXIST;
-	}
+
 	spin_unlock(&pcifront_dev_lock);

 	if (!err && !swiotlb_nr_tbl()) {
@@ -848,7 +847,7 @@ static int pcifront_try_connect(struct pcifront_device *pdev)
 		goto out;

 	err = pcifront_connect_and_init_dma(pdev);
-	if (err) {
+	if (err && err != -EEXIST) {
 		xenbus_dev_fatal(pdev->xdev, err,
 				 "Error setting up PCI Frontend");
 		goto out;
--
1.8.1.2

