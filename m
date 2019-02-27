Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD72FC43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 23:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F4221783
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 23:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfB0X6R (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:58:17 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44682 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB0X6Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2019 18:58:16 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id b2b9c462b15c26e4; Thu, 28 Feb 2019 00:58:14 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dongdong Liu <liudongdong3@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: PCIe: PME: Fix pcie_pme_remove()
Date:   Thu, 28 Feb 2019 00:56:41 +0100
Message-ID: <1943648.NMEmlssb0J@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is incorrect to call pcie_pme_suspend() from pcie_pme_remove() for
two reasons.

First, pcie_pme_suspend() calls synchronize_irq() that will wait for
the native hotplug interrupt handler as well as for the PME one,
because they share one IRQ (as per the spec).  That may deadlock if
hotplug is signaled while pcie_pme_remove() is running and the latter
calls pci_lock_rescan_remove() before the former.

Second, if pcie_pme_suspend() figures out that wakeup needs to be
enabled for the port, it will return without disabling the interrupt
as expected by pcie_pme_remove() which was overlooked by commit
c7b5a4e6e8fb ("PCI / PM: Fix native PME handling during system
suspend/resume").

To fix that, rework pcie_pme_remove() to disable the PME interrupt,
clear its status and prevent the PME worker function from re-enabling it
before calling free_irq() on it which should be sufficient.

Fixes: c7b5a4e6e8fb ("PCI / PM: Fix native PME handling during system suspend/resume")
Reported-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pcie/pme.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/pci/pcie/pme.c
===================================================================
--- linux-pm.orig/drivers/pci/pcie/pme.c
+++ linux-pm/drivers/pci/pcie/pme.c
@@ -363,6 +363,16 @@ static bool pcie_pme_check_wakeup(struct
 	return false;
 }
 
+static void pcie_pme_disable_interrupt(struct pci_dev *port,
+				       struct pcie_pme_service_data *data)
+{
+	spin_lock_irq(&data->lock);
+	pcie_pme_interrupt_enable(port, false);
+	pcie_clear_root_pme_status(port);
+	data->noirq = true;
+	spin_unlock_irq(&data->lock);
+}
+
 /**
  * pcie_pme_suspend - Suspend PCIe PME service device.
  * @srv: PCIe service device to suspend.
@@ -387,11 +397,7 @@ static int pcie_pme_suspend(struct pcie_
 			return 0;
 	}
 
-	spin_lock_irq(&data->lock);
-	pcie_pme_interrupt_enable(port, false);
-	pcie_clear_root_pme_status(port);
-	data->noirq = true;
-	spin_unlock_irq(&data->lock);
+	pcie_pme_disable_interrupt(port, data);
 
 	synchronize_irq(srv->irq);
 
@@ -427,9 +433,11 @@ static int pcie_pme_resume(struct pcie_d
  */
 static void pcie_pme_remove(struct pcie_device *srv)
 {
-	pcie_pme_suspend(srv);
+	struct pcie_pme_service_data *data = get_service_data(srv);
+
+	pcie_pme_disable_interrupt(srv->port, data);
 	free_irq(srv->irq, srv);
-	kfree(get_service_data(srv));
+	kfree(data);
 }
 
 static int pcie_pme_runtime_suspend(struct pcie_device *srv)

