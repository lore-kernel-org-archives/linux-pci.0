Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 1/3] PCI: Check device_attach() return value always
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org
Date: Tue, 02 Feb 2016 13:20:36 -0600
Message-ID: <20160202192036.7887.10644.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160202191658.7887.28475.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160202191658.7887.28475.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously we checked the device_attach() return value only when
CONFIG_BUG=y.  That caused this warning in builds where CONFIG_BUG is not
set:

  drivers/pci/bus.c:237:6: warning: variable 'retval' set but not used [-Wunused-but-set-variable]

Check the return value of device_attach() always and clean up after
failure.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/bus.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 89b3bef..f2187d4 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -291,7 +291,12 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	dev->match_driver = true;
 	retval = device_attach(&dev->dev);
-	WARN_ON(retval < 0);
+	if (retval < 0) {
+		dev_warn(&dev->dev, "device attach failed (%d)\n", retval);
+		pci_proc_detach_device(dev);
+		pci_remove_sysfs_dev_files(dev);
+		return;
+	}
 
 	dev->is_added = 1;
 }
