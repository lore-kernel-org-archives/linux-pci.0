Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Message-Id: <5a2cea3d2fd2f3cdaa30d3a78016c3e5800a32a6.1486913733.git.lukas@wunner.de>
In-Reply-To: <cover.1486913733.git.lukas@wunner.de>
References: <cover.1486913733.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 12 Feb 2017 17:07:45 +0100
Subject: [PATCH v6 5/8] PM: Make requirements of dev_pm_domain_set() more
 precise
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Since commit 989561de9b51 ("PM / Domains: add setter for dev.pm_domain")
a PM domain may only be assigned to unbound devices.

The motivation was not made explicit in the changelog other than "in the
general case that can cause problems and also [...] we can simplify code
quite a bit if we can always assume that".  Rafael J. Wysocki elaborated
in a mailing list conversation that "setting a PM domain generally
changes the set of PM callbacks for the device and it may not be safe to
call it after the driver has been bound".

The concern seems to be that if a device is put to sleep and its PM
callbacks are changed, the device may end up in an undefined state or
not resume at all.  The real underlying requirement is thus to ensure
that the device is awake and execution of its PM callbacks is prevented
while the PM domain is assigned.  Unbound devices happen to fulfill this
requirement, but bound devices can be made to satisfy it as well:
The caller can prevent execution of PM ops with lock_system_sleep() and
by holding a runtime PM reference to the device.

Accordingly, adjust dev_pm_domain_set() to WARN only if the device is in
the midst of a system sleep transition, or runtime PM is enabled and the
device is either not active or may become inactive imminently (because
it has no active children or its refcount is zero).

The change is required to support runtime PM for Thunderbolt on the Mac,
which poses the unique issue that a child device (the NHI) needs to
assign a PM domain to its grandparent (the upstream bridge).  Because
the grandparent's driver is built-in and the child's driver is a module,
the grandparent is usually already bound when the child probes,
resulting in a WARN splat when calling dev_pm_domain_set().  However the
PM core guarantees both that the grandparent is active and that system
sleep is not commenced until the child has finished probing.  So in this
case it is safe to call dev_pm_domain_set() from the child's ->probe
hook and the WARN splat is entirely gratuitous.

Note that commit e79aee49bcf9 ("PM: Avoid false-positive warnings in
dev_pm_domain_set()") modified the WARN to not apply if a PM domain is
removed.  This is unsafe as it allows removal of the PM domain while
the device is asleep.  The present commit rectifies this.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/base/power/common.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index f6a9ad52cbbf..d02c1e08a7ed 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -13,6 +13,7 @@
 #include <linux/pm_clock.h>
 #include <linux/acpi.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 
 #include "power.h"
 
@@ -136,8 +137,10 @@ EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
  * @dev: Device whose PM domain is to be set.
  * @pd: PM domain to be set, or NULL.
  *
- * Sets the PM domain the device belongs to. The PM domain of a device needs
- * to be set before its probe finishes (it's bound to a driver).
+ * Sets the PM domain the device belongs to.  The PM domain of a device needs
+ * to be set while the device is awake.  This is guaranteed during ->probe.
+ * Otherwise the caller is responsible for ensuring wakefulness, e.g. by
+ * holding a runtime PM reference as well as invoking lock_system_sleep().
  *
  * This function must be called with the device lock held.
  */
@@ -146,8 +149,12 @@ void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
 	if (dev->pm_domain == pd)
 		return;
 
-	WARN(pd && device_is_bound(dev),
-	     "PM domains can only be changed for unbound devices\n");
+	WARN(dev->power.is_prepared || dev->power.is_suspended ||
+	     (pm_runtime_enabled(dev) &&
+	      (dev->power.runtime_status != RPM_ACTIVE ||
+	       (pm_children_suspended(dev) &&
+		!atomic_read(&dev->power.usage_count)))),
+	     "PM domains can only be changed for awake devices\n");
 	dev->pm_domain = pd;
 	device_pm_check_callbacks(dev);
 }
-- 
2.11.0
