Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aaron Lu <aaron.lu@intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Lan Tianyu <tianyu.lan@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH 2/2] ACPI / bind: Use (put|get)_device() on ACPI device objects too
Date: Thu, 14 Nov 2013 00:26:47 +0100
Message-ID: <9712243.It8gvaRCs0@vostro.rjw.lan>
In-Reply-To: <1803808.ghCmmaO2Cj@vostro.rjw.lan>
References: <3268437.YsusHvklcv@vostro.rjw.lan> <1803808.ghCmmaO2Cj@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When associating a "physical" device with an ACPI device object
acpi_bind_one() only uses get_device() to increment the reference
counter of the former, but there is no reason not to do that with
the latter too.  Among other things, that may help to avoid
use-after-free when an ACPI device object is freed without calling
acpi_unbind_one() for all "physical" devices associated with it
(that only can happen in buggy code, but then it's better if the
kernel doesn't crash as a result of a bug).

For this reason, modify acpi_bind_one() to apply get_device() to
the ACPI device object too and update acpi_unbind_one() to drop
that reference using put_device() as appropriate.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -217,6 +217,7 @@ int acpi_bind_one(struct device *dev, ac
 	if (!acpi_dev)
 		return -EINVAL;
 
+	get_device(&acpi_dev->dev);
 	get_device(dev);
 	physical_node = kzalloc(sizeof(*physical_node), GFP_KERNEL);
 	if (!physical_node) {
@@ -243,6 +244,7 @@ int acpi_bind_one(struct device *dev, ac
 				goto err;
 
 			put_device(dev);
+			put_device(&acpi_dev->dev);
 			return 0;
 		}
 		if (pn->node_id == node_id) {
@@ -282,6 +284,7 @@ int acpi_bind_one(struct device *dev, ac
  err:
 	ACPI_COMPANION_SET(dev, NULL);
 	put_device(dev);
+	put_device(&acpi_dev->dev);
 	return retval;
 }
 EXPORT_SYMBOL_GPL(acpi_bind_one);
@@ -307,8 +310,9 @@ int acpi_unbind_one(struct device *dev)
 			sysfs_remove_link(&acpi_dev->dev.kobj, physnode_name);
 			sysfs_remove_link(&dev->kobj, "firmware_node");
 			ACPI_COMPANION_SET(dev, NULL);
-			/* acpi_bind_one() increase refcnt by one. */
+			/* Drop references taken by acpi_bind_one(). */
 			put_device(dev);
+			put_device(&acpi_dev->dev);
 			kfree(entry);
 			break;
 		}

