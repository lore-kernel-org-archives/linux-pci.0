Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54979 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965557AbcBBTUx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Feb 2016 14:20:53 -0500
Subject: [PATCH 3/3] PCI/PME: Restructure pcie_pme_suspend() to prevent
 compiler warning
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org
Date: Tue, 02 Feb 2016 13:20:50 -0600
Message-ID: <20160202192050.7887.34876.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160202191658.7887.28475.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160202191658.7887.28475.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously we had this:

  if (wakeup)
    ret = enable_irq_wake(...);
  if (!wakeup || ret)
    ...

"ret" is only evaluated when "wakeup" is true, and it is always initialized
in that case, but gcc isn't smart enough to figure that out and warns:

  drivers/pci/pcie/pme.c:414:14: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]

Restructure the code slightly to make it easier for gcc (and maybe for
humans as well).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/pme.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 5695861..1ae4c73 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -396,7 +396,7 @@ static int pcie_pme_suspend(struct pcie_device *srv)
 {
 	struct pcie_pme_service_data *data = get_service_data(srv);
 	struct pci_dev *port = srv->port;
-	bool wakeup;
+	bool wakeup, wake_irq_enabled = false;
 	int ret;
 
 	if (device_may_wakeup(&port->dev)) {
@@ -409,9 +409,12 @@ static int pcie_pme_suspend(struct pcie_device *srv)
 	spin_lock_irq(&data->lock);
 	if (wakeup) {
 		ret = enable_irq_wake(srv->irq);
-		data->suspend_level = PME_SUSPEND_WAKEUP;
+		if (ret == 0) {
+			data->suspend_level = PME_SUSPEND_WAKEUP;
+			wake_irq_enabled = true;
+		}
 	}
-	if (!wakeup || ret) {
+	if (!wake_irq_enabled) {
 		pcie_pme_interrupt_enable(port, false);
 		pcie_clear_root_pme_status(port);
 		data->suspend_level = PME_SUSPEND_NOIRQ;

