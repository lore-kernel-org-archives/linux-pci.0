Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 05/12] PCI / PM: Drop unnecessary invocations of pcibios_pm_ops callbacks
Date: Mon, 16 Oct 2017 03:29:39 +0200
Message-ID: <2094189.3ZuY7TBjup@aspire.rjw.lan>
In-Reply-To: <3806130.B2KCK0tvef@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The only user of non-empty pcibios_pm_ops is s390 and it only uses
"noirq" callbacks, so drop the invocations of the other pcibios_pm_ops
callbacks from the PCI PM code.

That will allow subsequent changes to be somewhat simpler.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-driver.c |   18 ------------------
 1 file changed, 18 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -918,9 +918,6 @@ static int pci_pm_freeze(struct device *
 			return error;
 	}
 
-	if (pcibios_pm_ops.freeze)
-		return pcibios_pm_ops.freeze(dev);
-
 	return 0;
 }
 
@@ -982,12 +979,6 @@ static int pci_pm_thaw(struct device *de
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int error = 0;
 
-	if (pcibios_pm_ops.thaw) {
-		error = pcibios_pm_ops.thaw(dev);
-		if (error)
-			return error;
-	}
-
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume(dev);
 
@@ -1032,9 +1023,6 @@ static int pci_pm_poweroff(struct device
  Fixup:
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
 
-	if (pcibios_pm_ops.poweroff)
-		return pcibios_pm_ops.poweroff(dev);
-
 	return 0;
 }
 
@@ -1107,12 +1095,6 @@ static int pci_pm_restore(struct device
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int error = 0;
 
-	if (pcibios_pm_ops.restore) {
-		error = pcibios_pm_ops.restore(dev);
-		if (error)
-			return error;
-	}
-
 	/*
 	 * This is necessary for the hibernation error path in which restore is
 	 * called without restoring the standard config registers of the device.


