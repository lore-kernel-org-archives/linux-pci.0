Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750939AbeBPWuO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Feb 2018 17:50:14 -0500
Subject: [PATCH v1 1/2] PCI: Probe for device reset support before driver
 claim
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jayachandran Nair <Jayachandran.Nair@cavium.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Robert Richter <Robert.Richter@cavium.com>,
        Tom Vaden <tom.vaden@hpe.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        George Cherian <george.cherian@cavium.com>
Date: Fri, 16 Feb 2018 16:50:11 -0600
Message-ID: <20180216225010.67295.92539.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180216224213.67295.2251.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180216224213.67295.2251.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Previously we called pci_probe_reset_function() in this path:

  pci_sysfs_init                              # late_initcall
    for_each_pci_dev(dev)
      pci_create_sysfs_dev_files(dev)
	pci_create_capabilities_sysfs(dev)
	  pci_probe_reset_function
	    pci_dev_specific_reset
	    pcie_has_flr
              pcie_capability_read_dword

pci_sysfs_init() is a late_initcall, and a driver may have already claimed
one of these devices and enabled runtime power management for it, so the
device could already be in D3hot by the time we get to pci_sysfs_init().

The device itself should respond to the config read even while it's in
D3hot, but if an upstream bridge is also in D3hot, the read won't even
reach the device because the bridge won't forward it downstream to the
device.  If the bridge is a PCIe port, it should complete the read as an
Unsupported Request, which may be reported to the CPU as an exception or as
invalid data.

Avoid this case by probing for reset support from pci_init_capabilities(),
before a driver can claim the device.  The device should be in D0 and fully
accessible at that point.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-sysfs.c |    3 +--
 drivers/pci/probe.c     |    3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index eb6bee8724cc..4933f0270471 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1542,11 +1542,10 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 	/* Active State Power Management */
 	pcie_aspm_create_sysfs_dev_files(dev);
 
-	if (!pci_probe_reset_function(dev)) {
+	if (dev->reset_fn) {
 		retval = device_create_file(&dev->dev, &reset_attr);
 		if (retval)
 			goto error;
-		dev->reset_fn = 1;
 	}
 	return 0;
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ef5377438a1e..489660d0d384 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2121,6 +2121,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	/* Advanced Error Reporting */
 	pci_aer_init(dev);
+
+	if (pci_probe_reset_function(dev) == 0)
+		dev->reset_fn = 1;
 }
 
 /*
