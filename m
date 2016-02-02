Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 2/3] PCI/PME: Remove redundant port lookup
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org
Date: Tue, 02 Feb 2016 13:20:43 -0600
Message-ID: <20160202192043.7887.90333.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160202191658.7887.28475.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160202191658.7887.28475.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We've already looked up srv->port a few lines earlier, and there's no need
to do it again.  Remove the redundant lookup.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/pme.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 63fc639..5695861 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -412,8 +412,6 @@ static int pcie_pme_suspend(struct pcie_device *srv)
 		data->suspend_level = PME_SUSPEND_WAKEUP;
 	}
 	if (!wakeup || ret) {
-		struct pci_dev *port = srv->port;
-
 		pcie_pme_interrupt_enable(port, false);
 		pcie_clear_root_pme_status(port);
 		data->suspend_level = PME_SUSPEND_NOIRQ;
