Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4219C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 22:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA264218DA
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 22:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfDWWme (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:42:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfDWWme (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 18:42:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4790E3022FAF;
        Tue, 23 Apr 2019 22:42:33 +0000 (UTC)
Received: from gimli.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37894600C2;
        Tue, 23 Apr 2019 22:42:29 +0000 (UTC)
Subject: [PATCH] PCI: Add link_change error handler and vfio-pci user
From:   Alex Williamson <alex.williamson@redhat.com>
To:     bhelgaas@google.com, helgaas@kernel.org, mr.nuke.me@gmail.com,
        linux-pci@vger.kernel.org
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 23 Apr 2019 16:42:28 -0600
Message-ID: <155605909349.3575.13433421148215616375.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 23 Apr 2019 22:42:33 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe bandwidth notification service generates logging any time a
link changes speed or width to a state that is considered downgraded.
Unfortunately, it cannot differentiate signal integrity related link
changes from those intentionally initiated by an endpoint driver,
including drivers that may live in userspace or VMs when making use
of vfio-pci.  Therefore, allow the driver to have a say in whether
the link is indeed downgraded and worth noting in the log, or if the
change is perhaps intentional.

For vfio-pci, we don't know the intentions of the user/guest driver
either, but we do know that GPU drivers in guests actively manage
the link state and therefore trigger the bandwidth notification for
what appear to be entirely intentional link changes.

Fixes: e8303bb7a75c PCI/LINK: Report degraded links via link bandwidth notification
Link: https://lore.kernel.org/linux-pci/155597243666.19387.1205950870601742062.stgit@gimli.home/T/#u
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

Changing to pci_dbg() logging is not super usable, so let's try the
previous idea of letting the driver handle link change events as they
see fit.  Ideally this might be two patches, but for easier handling,
folding the pci and vfio-pci bits together.  Comments?  Thanks,

Alex

 drivers/pci/probe.c         |   13 +++++++++++++
 drivers/vfio/pci/vfio_pci.c |   10 ++++++++++
 include/linux/pci.h         |    3 +++
 3 files changed, 26 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7e12d0163863..233cd4b5b6e8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2403,6 +2403,19 @@ void pcie_report_downtraining(struct pci_dev *dev)
 	if (PCI_FUNC(dev->devfn) != 0 || dev->is_virtfn)
 		return;
 
+	/*
+	 * If driver handles link_change event, defer to driver.  PCIe drivers
+	 * can call pcie_print_link_status() to print current link info.
+	 */
+	device_lock(&dev->dev);
+	if (dev->driver && dev->driver->err_handler &&
+	    dev->driver->err_handler->link_change) {
+		dev->driver->err_handler->link_change(dev);
+		device_unlock(&dev->dev);
+		return;
+	}
+	device_unlock(&dev->dev);
+
 	/* Print link status only if the device is constrained by the fabric */
 	__pcie_print_link_status(dev, false);
 }
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index cab71da46f4a..c9ffc0ccabb3 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1418,8 +1418,18 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
 	return PCI_ERS_RESULT_CAN_RECOVER;
 }
 
+/*
+ * Ignore link change notification, we can't differentiate signal related
+ * link changes from user driver power management type operations, so do
+ * nothing.  Potentially this could be routed out to the user.
+ */
+static void vfio_pci_link_change(struct pci_dev *pdev)
+{
+}
+
 static const struct pci_error_handlers vfio_err_handlers = {
 	.error_detected = vfio_pci_aer_err_detected,
+	.link_change = vfio_pci_link_change,
 };
 
 static struct pci_driver vfio_pci_driver = {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27854731afc4..e9194bc03f9e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -763,6 +763,9 @@ struct pci_error_handlers {
 
 	/* Device driver may resume normal operations */
 	void (*resume)(struct pci_dev *dev);
+
+	/* PCIe link change notification */
+	void (*link_change)(struct pci_dev *dev);
 };
 
 

