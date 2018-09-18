Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7927 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbeISFd7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:33:59 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 02/12] PCI/AER: Covertly inject errors
Date: Tue, 18 Sep 2018 17:58:38 -0600
Message-Id: <20180918235848.26694-3-keith.busch@intel.com>
In-Reply-To: <20180918235848.26694-1-keith.busch@intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The aer_inject module was intercepting config requests by overwriting
the config accessor operations in the pci_bus. This has several issues.

First, the module was tracking kernel objects unbeknownst to the drivers
that own them. The kernel may free those devices, leaving the AER inject
module holding stale references and no way to know that happened.

Second, the pci enumeration has child devices inherit the pci_bus ops
from its parent bus. Since errors may lead to link resets that trigger
re-enuemration, the child devices have now inherited operations that
don't know about the devices using them, causing kernel crashes.

Finally, CONFIG_PCI_LOCKLESS_CONFIG doesn't block accessing the pci_bus
ops, so it's racing with potential in flight config requests.

It's just a bad idea to muck with kernel objects out from under the
drivers depending on them.

This patch uses a more discreet approach to intercept config requests
using ftrace for thunking the config space accessors to inject the desired
errors, and removing any need for aer_inject to track pci structuresh.

Inspired-by: https://github.com/ilammy/ftrace-hook
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/Kconfig      |   2 +-
 drivers/pci/pcie/aer_inject.c | 276 +++++++++++++++++++++++-------------------
 2 files changed, 152 insertions(+), 126 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 0a1e9d379bc5..87bcf40f415d 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -35,7 +35,7 @@ config PCIEAER
 
 config PCIEAER_INJECT
 	tristate "PCI Express error injection support"
-	depends on PCIEAER
+	depends on PCIEAER && DYNAMIC_FTRACE_WITH_REGS
 	default n
 	help
 	  This enables PCI Express Root Port Advanced Error Reporting
diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 0eb24346cad3..6f8b96499f44 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -14,6 +14,10 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/ftrace.h>
+#include <linux/kallsyms.h>
+#include <linux/kernel.h>
+#include <linux/linkage.h>
 #include <linux/miscdevice.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -58,17 +62,9 @@ struct aer_error {
 	u32 source_id;
 };
 
-struct pci_bus_ops {
-	struct list_head list;
-	struct pci_bus *bus;
-	struct pci_ops *ops;
-};
-
 static LIST_HEAD(einjected);
 
-static LIST_HEAD(pci_bus_ops_list);
-
-/* Protect einjected and pci_bus_ops_list */
+/* Protect einjected */
 static DEFINE_SPINLOCK(inject_lock);
 
 static void aer_error_init(struct aer_error *err, u32 domain,
@@ -82,7 +78,6 @@ static void aer_error_init(struct aer_error *err, u32 domain,
 	err->pos_cap_err = pos_cap_err;
 }
 
-/* inject_lock must be held before calling */
 static struct aer_error *__find_aer_error(u32 domain, unsigned int bus,
 					  unsigned int devfn)
 {
@@ -97,7 +92,6 @@ static struct aer_error *__find_aer_error(u32 domain, unsigned int bus,
 	return NULL;
 }
 
-/* inject_lock must be held before calling */
 static struct aer_error *__find_aer_error_by_dev(struct pci_dev *dev)
 {
 	int domain = pci_domain_nr(dev->bus);
@@ -106,32 +100,6 @@ static struct aer_error *__find_aer_error_by_dev(struct pci_dev *dev)
 	return __find_aer_error(domain, dev->bus->number, dev->devfn);
 }
 
-/* inject_lock must be held before calling */
-static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
-{
-	struct pci_bus_ops *bus_ops;
-
-	list_for_each_entry(bus_ops, &pci_bus_ops_list, list) {
-		if (bus_ops->bus == bus)
-			return bus_ops->ops;
-	}
-	return NULL;
-}
-
-static struct pci_bus_ops *pci_bus_ops_pop(void)
-{
-	unsigned long flags;
-	struct pci_bus_ops *bus_ops;
-
-	spin_lock_irqsave(&inject_lock, flags);
-	bus_ops = list_first_entry_or_null(&pci_bus_ops_list,
-					   struct pci_bus_ops, list);
-	if (bus_ops)
-		list_del(&bus_ops->list);
-	spin_unlock_irqrestore(&inject_lock, flags);
-	return bus_ops;
-}
-
 static u32 *find_pci_config_dword(struct aer_error *err, int where,
 				  int *prw1cs)
 {
@@ -176,19 +144,14 @@ static u32 *find_pci_config_dword(struct aer_error *err, int where,
 }
 
 static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
-			       int where, int size, u32 *val)
+			       int where, u32 *val)
 {
 	u32 *sim;
 	struct aer_error *err;
 	unsigned long flags;
-	struct pci_ops *ops;
-	struct pci_ops *my_ops;
 	int domain;
-	int rv;
 
 	spin_lock_irqsave(&inject_lock, flags);
-	if (size != sizeof(u32))
-		goto out;
 	domain = pci_domain_nr(bus);
 	if (domain < 0)
 		goto out;
@@ -203,37 +166,20 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 		return 0;
 	}
 out:
-	ops = __find_pci_bus_ops(bus);
-	/*
-	 * pci_lock must already be held, so we can directly
-	 * manipulate bus->ops.  Many config access functions,
-	 * including pci_generic_config_read() require the original
-	 * bus->ops be installed to function, so temporarily put them
-	 * back.
-	 */
-	my_ops = bus->ops;
-	bus->ops = ops;
-	rv = ops->read(bus, devfn, where, size, val);
-	bus->ops = my_ops;
 	spin_unlock_irqrestore(&inject_lock, flags);
-	return rv;
+	return -1;
 }
 
 static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
-				int where, int size, u32 val)
+				int where, u32 val)
 {
 	u32 *sim;
 	struct aer_error *err;
 	unsigned long flags;
 	int rw1cs;
-	struct pci_ops *ops;
-	struct pci_ops *my_ops;
 	int domain;
-	int rv;
 
 	spin_lock_irqsave(&inject_lock, flags);
-	if (size != sizeof(u32))
-		goto out;
 	domain = pci_domain_nr(bus);
 	if (domain < 0)
 		goto out;
@@ -250,57 +196,9 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 		spin_unlock_irqrestore(&inject_lock, flags);
 		return 0;
 	}
-out:
-	ops = __find_pci_bus_ops(bus);
-	/*
-	 * pci_lock must already be held, so we can directly
-	 * manipulate bus->ops.  Many config access functions,
-	 * including pci_generic_config_write() require the original
-	 * bus->ops be installed to function, so temporarily put them
-	 * back.
-	 */
-	my_ops = bus->ops;
-	bus->ops = ops;
-	rv = ops->write(bus, devfn, where, size, val);
-	bus->ops = my_ops;
-	spin_unlock_irqrestore(&inject_lock, flags);
-	return rv;
-}
-
-static struct pci_ops aer_inj_pci_ops = {
-	.read = aer_inj_read_config,
-	.write = aer_inj_write_config,
-};
-
-static void pci_bus_ops_init(struct pci_bus_ops *bus_ops,
-			     struct pci_bus *bus,
-			     struct pci_ops *ops)
-{
-	INIT_LIST_HEAD(&bus_ops->list);
-	bus_ops->bus = bus;
-	bus_ops->ops = ops;
-}
-
-static int pci_bus_set_aer_ops(struct pci_bus *bus)
-{
-	struct pci_ops *ops;
-	struct pci_bus_ops *bus_ops;
-	unsigned long flags;
-
-	bus_ops = kmalloc(sizeof(*bus_ops), GFP_KERNEL);
-	if (!bus_ops)
-		return -ENOMEM;
-	ops = pci_bus_set_ops(bus, &aer_inj_pci_ops);
-	spin_lock_irqsave(&inject_lock, flags);
-	if (ops == &aer_inj_pci_ops)
-		goto out;
-	pci_bus_ops_init(bus_ops, bus, ops);
-	list_add(&bus_ops->list, &pci_bus_ops_list);
-	bus_ops = NULL;
 out:
 	spin_unlock_irqrestore(&inject_lock, flags);
-	kfree(bus_ops);
-	return 0;
+	return -1;
 }
 
 static int find_aer_device_iter(struct device *device, void *data)
@@ -457,13 +355,6 @@ static int aer_inject(struct aer_error_inj *einj)
 				       uncor_mask_orig);
 	}
 
-	ret = pci_bus_set_aer_ops(dev->bus);
-	if (ret)
-		goto out_put;
-	ret = pci_bus_set_aer_ops(rpdev->bus);
-	if (ret)
-		goto out_put;
-
 	if (find_aer_device(rpdev, &edev)) {
 		if (!get_service_data(edev)) {
 			dev_warn(&edev->device,
@@ -518,24 +409,159 @@ static struct miscdevice aer_inject_device = {
 	.fops = &aer_inject_fops,
 };
 
+static asmlinkage int (*read_config_dword)(struct pci_bus *bus,
+					   unsigned int devfn,
+					   int where, u32 *val);
+static asmlinkage int (*write_config_dword)(struct pci_bus *bus,
+					    unsigned int devfn,
+					    int where, u32 val);
+struct aer_hook {
+	struct ftrace_ops ops;
+	const char *name;
+	void *function;
+	void *original;
+	unsigned long address;
+};
+
+static int asmlinkage ainj_read_config_dword(struct pci_bus *bus,
+			unsigned int devfn, int where, u32 *val)
+{
+	if (!aer_inj_read_config(bus, devfn, where, (u32 *)val))
+		return 0;
+	return read_config_dword(bus, devfn, where, val);
+}
+
+static int asmlinkage ainj_write_config_dword(struct pci_bus *bus,
+			unsigned int devfn, int where, u32 val)
+{
+	if (!aer_inj_write_config(bus, devfn, where, val))
+		return 0;
+	return write_config_dword(bus, devfn, where, val);
+}
+
+static int aer_inject_resolve_hook_address(struct aer_hook *hook)
+{
+	hook->address = kallsyms_lookup_name(hook->name);
+
+	if (!hook->address) {
+		pr_warn("unresolved symbol: %s\n", hook->name);
+		return -ENOENT;
+	}
+	*((unsigned long*) hook->original) = hook->address + MCOUNT_INSN_SIZE;
+	return 0;
+}
+
+static void notrace aer_inject_ftrace_thunk(unsigned long ip, unsigned long parent_ip,
+		struct ftrace_ops *ops, struct pt_regs *regs)
+{
+	struct aer_hook *hook = container_of(ops, struct aer_hook, ops);
+	regs->ip = (unsigned long) hook->function;
+}
+
+static int aer_inject_install_hook(struct aer_hook *hook)
+{
+	int err;
+
+	err = aer_inject_resolve_hook_address(hook);
+	if (err)
+		return err;
+
+	hook->ops.func = aer_inject_ftrace_thunk;
+	hook->ops.flags = FTRACE_OPS_FL_SAVE_REGS |
+			  FTRACE_OPS_FL_RECURSION_SAFE |
+			  FTRACE_OPS_FL_IPMODIFY;
+
+	err = ftrace_set_filter_ip(&hook->ops, hook->address, 0, 0);
+	if (err) {
+		pr_warn("ftrace_set_filter_ip() failed: %d\n", err);
+		return err;
+	}
+
+	err = register_ftrace_function(&hook->ops);
+	if (err) {
+		pr_warn("register_ftrace_function() failed: %d\n", err);
+		ftrace_set_filter_ip(&hook->ops, hook->address, 1, 0);
+		return err;
+	}
+
+	return 0;
+}
+
+static void aer_inject_remove_hook(struct aer_hook *hook)
+{
+	int err;
+
+	err = unregister_ftrace_function(&hook->ops);
+	if (err)
+		pr_warn("unregister_ftrace_function() failed: %d\n", err);
+
+	err = ftrace_set_filter_ip(&hook->ops, hook->address, 1, 0);
+	if (err)
+		pr_warn("ftrace_set_filter_ip() failed: %d\n", err);
+}
+
+static int aer_inject_install_hooks(struct aer_hook *hooks, size_t count)
+{
+	int err, i;
+
+	for (i = 0; i < count; i++) {
+		err = aer_inject_install_hook(&hooks[i]);
+		if (err)
+			goto error;
+	}
+	return 0;
+error:
+	while (i != 0)
+		aer_inject_remove_hook(&hooks[--i]);
+	return err;
+}
+
+static void aer_inject_remove_hooks(struct aer_hook *hooks, size_t count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		aer_inject_remove_hook(&hooks[i]);
+}
+
+static struct aer_hook aer_hooks[] = {
+	{
+		.name = "pci_bus_read_config_dword",
+		.function = ainj_read_config_dword,
+		.original = &read_config_dword,
+	},
+	{
+		.name = "pci_bus_write_config_dword",
+		.function = ainj_write_config_dword,
+		.original = &write_config_dword,
+	},
+};
+
 static int __init aer_inject_init(void)
 {
-	return misc_register(&aer_inject_device);
+	int err;
+
+	err = misc_register(&aer_inject_device);
+	if (err)
+		return err;
+
+	err = aer_inject_install_hooks(aer_hooks, ARRAY_SIZE(aer_hooks));
+	if (err)
+		goto out;
+	return 0;
+ out:
+	misc_deregister(&aer_inject_device);
+	return err;
 }
 
 static void __exit aer_inject_exit(void)
 {
 	struct aer_error *err, *err_next;
 	unsigned long flags;
-	struct pci_bus_ops *bus_ops;
 
+	aer_inject_remove_hooks(aer_hooks, ARRAY_SIZE(aer_hooks));
 	misc_deregister(&aer_inject_device);
 
-	while ((bus_ops = pci_bus_ops_pop())) {
-		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
-		kfree(bus_ops);
-	}
-
 	spin_lock_irqsave(&inject_lock, flags);
 	list_for_each_entry_safe(err, err_next, &einjected, list) {
 		list_del(&err->list);
-- 
2.14.4
