Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 1/9] PCI/portdrv: Rename resume_iter() to prevent name
 collision
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:07 -0500
Message-ID: <152848872711.14051.2066441875532387495.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Rename resume_iter() to prevent a name collision in a future patch.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 973f1b80a038..b8b99dd07c0c 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -173,7 +173,7 @@ static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static int resume_iter(struct device *device, void *data)
+static int err_resume_iter(struct device *device, void *data)
 {
 	struct pcie_device *pcie_device;
 	struct pcie_port_service_driver *driver;
@@ -193,7 +193,7 @@ static int resume_iter(struct device *device, void *data)
 
 static void pcie_portdrv_err_resume(struct pci_dev *dev)
 {
-	device_for_each_child(&dev->dev, NULL, resume_iter);
+	device_for_each_child(&dev->dev, NULL, err_resume_iter);
 }
 
 /*
