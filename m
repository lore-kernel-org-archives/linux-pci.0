Return-Path: <SRS0=dBQP=LC=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=dBQP=LC=wunner.de=lukas@kernel.org>
Message-Id: <3805ffe4d30d931084394b5eb3f1967be967d332.1534686485.git.lukas@wunner.de>
In-Reply-To: <cover.1534686484.git.lukas@wunner.de>
References: <cover.1534686484.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 19 Aug 2018 16:29:00 +0200
Subject: [PATCH 9/9] PCI: hotplug: Document TODOs
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Scott Murray <scott@spiteful.org>, Dan Zink <dan.zink@hpe.com>, Prarit Bhargava <prarit@redhat.com>
List-ID: <linux-pci.vger.kernel.org>

While refactoring the PCI hotplug core's API, I noticed a significant
amount of technical debt in some of the hotplug drivers.  Document the
issues that caught my eye for starters.

I do not have hardware at my disposal that utilizes the listed drivers
and I think that's a prerequisite to work on them to ensure that no
regressions sneak in.  But some of this hardware is so old that it may be
hard to come by.  Obviously, it is fine to support old hardware, but the
drivers need to be maintained.

If noone steps up, perhaps we should consider sunsetting a few drivers
by moving them to staging.  Based on my findings, ibmphp would be the
first candidate.  I've found it fairly difficult to apply my API
refactorings to it and have listed some obvious bugs in the driver.
cpqphp is also in need of a modernization and would be a second
candidate for relegation to staging.

shpchp was introduced in the same commit as pciehp but hasn't benefited
from the same amount of refactoring due to the decline of conventional
PCI's relevance.  Yet hardware supporting it may be more prevalent than
for the proprietary hotplug methods.

Per Documentation/process/2.Process.rst, "a TODO file should be present"
for drivers in staging.  The file introduced by the present commit may
serve as a basis for this.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Scott Murray <scott@spiteful.org>
Cc: Dan Zink <dan.zink@hpe.com>
Cc: Prarit Bhargava <prarit@redhat.com>
---
 drivers/pci/hotplug/TODO | 74 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 drivers/pci/hotplug/TODO

diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
new file mode 100644
index 000000000000..a32070be5adf
--- /dev/null
+++ b/drivers/pci/hotplug/TODO
@@ -0,0 +1,74 @@
+Contributions are solicited in particular to remedy the following issues:
+
+cpcihp:
+
+* There are no implementations of the ->hardware_test, ->get_power and
+  ->set_power callbacks in struct cpci_hp_controller_ops.  Why were they
+  introduced?  Can they be removed from the struct?
+
+cpqphp:
+
+* The driver spawns a kthread cpqhp_event_thread() which is woken by the
+  hardirq handler cpqhp_ctrl_intr().  Convert this to threaded IRQ handling.
+  The kthread is also woken from the timer pushbutton_helper_thread(),
+  convert it to call irq_wake_thread().  Use pciehp as a template.
+
+* A large portion of cpqphp_ctrl.c and cpqphp_pci.c concerns resource
+  management.  Doesn't this duplicate functionality in the core?
+
+ibmphp:
+
+* Implementations of hotplug_slot_ops callbacks such as get_adapter_present()
+  in ibmphp_core.c create a copy of the struct slot on the stack, then perform
+  the actual operation on that copy.  Determine if this overhead is necessary,
+  delete it if not.  The functions also perform a NULL pointer check on the
+  struct hotplug_slot, this seems superfluous.
+
+* Several functions access the pci_slot member in struct hotplug_slot even
+  though pci_hotplug.h declares it private.  See get_max_bus_speed() for an
+  example.  Either the pci_slot member should no longer be declared private
+  or ibmphp should store a pointer to its bus in struct slot.  Probably the
+  former.
+
+* The functions get_max_adapter_speed() and get_bus_name() are commented out.
+  Can they be deleted?  There are also forward declarations at the top of
+  ibmphp_core.c as well as pointers in ibmphp_hotplug_slot_ops, likewise
+  commented out.
+
+* ibmphp_init_devno() takes a struct slot **, it could instead take a
+  struct slot *.
+
+* The return value of pci_hp_register() is not checked.
+
+* iounmap(io_mem) is called in the error path of ebda_rsrc_controller()
+  and once more in the error path of its caller ibmphp_access_ebda().
+
+* The various slot data structures are difficult to follow and need to be
+  simplified.  A lot of functions are too large and too complex, they need
+  to be broken up into smaller, manageable pieces.  Negative examples are
+  ebda_rsrc_controller() and configure_bridge().
+
+* A large portion of ibmphp_res.c and ibmphp_pci.c concerns resource
+  management.  Doesn't this duplicate functionality in the core?
+
+sgi_hotplug:
+
+* Several functions access the pci_slot member in struct hotplug_slot even
+  though pci_hotplug.h declares it private.  See sn_hp_destroy() for an
+  example.  Either the pci_slot member should no longer be declared private
+  or sgi_hotplug should store a pointer to it in struct slot.  Probably the
+  former.
+
+shpchp:
+
+* There is only a single implementation of struct hpc_ops.  Can the struct be
+  removed and its functions invoked directly?  This has already been done in
+  pciehp with commit 82a9e79ef132 ("PCI: pciehp: remove hpc_ops").  Clarify
+  if there was a specific reason not to apply the same change to shpchp.
+
+* The ->get_mode1_ECC_cap callback in shpchp_hpc_ops is never invoked.
+  Why was it introduced?  Can it be removed?
+
+* The hardirq handler shpc_isr() queues events on a workqueue.  It can be
+  simplified by converting it to threaded IRQ handling.  Use pciehp as a
+  template.
-- 
2.18.0
