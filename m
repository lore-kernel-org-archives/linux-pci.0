Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] PCI/ASPM: Allow drivers to disable ASPM even without OS
 ASPM control
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: Mathias Koehrer <mathias.koehrer@etas.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Joe Lawrence <joe.lawrence@stratus.com>,
        linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@coreos.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        Myron Stowe <myron.stowe@redhat.com>
Date: Tue, 24 Jan 2017 14:23:01 -0600
Message-ID: <20170124202301.20248.7452.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ACPI FADT has a "PCIe ASPM Controls" bit (ACPI 5.0, sec 5.2.9.3), which
means "If set, indicates to OSPM that it must not enable ASPM control on
this platform."  We have historically interpreted that to mean that the OS
should not touch ASPM configuration at all: we leave it as the firmware
configured it.

However, a driver may know that its device has issues with ASPM and should
not have it enabled.  The platform firmware, which cannot be expected to
know this, may have enabled ASPM.  The driver should be able to use
pci_disable_link_state() to disable ASPM for its device, even if the
firmware set the ACPI_FADT_NO_ASPM bit.

Remove the check that prevents pci_disable_link_state() from disabling ASPM
for a device.

In cases where we previously emitted a message like this and did nothing:

  e1000e 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control

we'll instead actually disable ASPM on the device.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=189951
Reported-by: Mathias Koehrer <mathias.koehrer@etas.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Matthew Garrett <mjg59@coreos.com>
CC: stable@vger.kernel.org
---
 drivers/pci/pcie/aspm.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 17ac1dce3286..9253ae48d777 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -736,18 +736,10 @@ static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	if (!parent || !parent->link_state)
 		return;
 
-	/*
-	 * A driver requested that ASPM be disabled on this device, but
-	 * if we don't have permission to manage ASPM (e.g., on ACPI
-	 * systems we have to observe the FADT ACPI_FADT_NO_ASPM bit and
-	 * the _OSC method), we can't honor that request.  Windows has
-	 * a similar mechanism using "PciASPMOptOut", which is also
-	 * ignored in this situation.
-	 */
-	if (aspm_disabled) {
-		dev_warn(&pdev->dev, "can't disable ASPM; OS doesn't have ASPM control\n");
-		return;
-	}
+	dev_info(&pdev->dev, "disabling %sASPM%s%s\n",
+		 (state & PCIE_LINK_STATE_CLKPM) ? "Clock PM " : "",
+		 (state & PCIE_LINK_STATE_L0S) ? " L0s" : "",
+		 (state & PCIE_LINK_STATE_L1) ? " L1" : "");
 
 	if (sem)
 		down_read(&pci_bus_sem);
