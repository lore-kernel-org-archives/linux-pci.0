Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ED4C677FF
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771B82085B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771B82085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbeJLAXO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:23:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:17763 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbeJLAXO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 20:23:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 09:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="87599227"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Oct 2018 09:55:09 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCH 3/3] PCI/AER: Covertly inject errors with ftrace hooks
Date:   Thu, 11 Oct 2018 10:52:07 -0600
Message-Id: <20181011165207.12782-4-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181011165207.12782-1-keith.busch@intel.com>
References: <20181011165207.12782-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The aer_inject module had been intercepting config requests by overwriting
the config accessor operations in the pci_bus ops.  This has several
issues.

First, the module was tracking kernel objects unbeknownst to the drivers
that own them.  The kernel may free those devices, leaving the AER inject
module holding stale references and no way to know that happened.

Second, the PCI enumeration has child devices inherit pci_bus ops from
the parent bus.  Since errors may lead to link resets that trigger
re-enumeration, the child devices would inherit operations that don't
know about the devices using them, causing kernel crashes.

Finally, CONFIG_PCI_LOCKLESS_CONFIG doesn't block accessing the pci_bus
ops, so it's racing with potential in-flight config requests.

This patch uses a different error injection approach leveraging ftrace
to thunk the config space functions.  If the kernel and architecture
are capable, the ftrace hook will overwrite the processor's function
call address with the address of the error injecting function. This way
doesn't modify or track driver structures, fixing the issues with the
current method.

If either the kernel config or platform arch do not support the necessary
ftrace capabilities, the aer_inject module will fallback to the older
way so that it may continue to be used as before.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer_inject.c | 218 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 189 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 726987f8d53c..4825fa465b60 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -15,6 +15,10 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/ftrace.h>
+#include <linux/kallsyms.h>
+#include <linux/kernel.h>
+#include <linux/linkage.h>
 #include <linux/miscdevice.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -65,6 +69,8 @@ struct pci_bus_ops {
 	struct pci_ops *ops;
 };
 
+static bool legacy;
+
 static LIST_HEAD(einjected);
 
 static LIST_HEAD(pci_bus_ops_list);
@@ -176,14 +182,48 @@ static u32 *find_pci_config_dword(struct aer_error *err, int where,
 	return target;
 }
 
+static int aer_inj_legacy_read(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 *val)
+{
+	struct pci_ops *ops, *my_ops;
+	int rv;
+
+	ops = __find_pci_bus_ops(bus);
+	if (!ops)
+		return -1;
+
+	my_ops = bus->ops;
+	bus->ops = ops;
+	rv = ops->read(bus, devfn, where, size, val);
+	bus->ops = my_ops;
+
+	return rv;
+}
+
+static int aer_inj_legacy_write(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 val)
+{
+	struct pci_ops *ops, *my_ops;
+	int rv;
+
+	ops = __find_pci_bus_ops(bus);
+	if (!ops)
+		return -1;
+
+	my_ops = bus->ops;
+	bus->ops = ops;
+	rv = ops->write(bus, devfn, where, size, val);
+	bus->ops = my_ops;
+
+	return rv;
+}
+
 static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 			       int where, int size, u32 *val)
 {
 	u32 *sim;
 	struct aer_error *err;
 	unsigned long flags;
-	struct pci_ops *ops;
-	struct pci_ops *my_ops;
 	int domain;
 	int rv;
 
@@ -204,18 +244,7 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
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
+	rv = aer_inj_legacy_read(bus, devfn, where, size, val);
 	spin_unlock_irqrestore(&inject_lock, flags);
 	return rv;
 }
@@ -227,8 +256,6 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 	struct aer_error *err;
 	unsigned long flags;
 	int rw1cs;
-	struct pci_ops *ops;
-	struct pci_ops *my_ops;
 	int domain;
 	int rv;
 
@@ -252,18 +279,7 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 		return 0;
 	}
 out:
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
+	rv = aer_inj_legacy_write(bus, devfn, where, size, val);
 	spin_unlock_irqrestore(&inject_lock, flags);
 	return rv;
 }
@@ -288,6 +304,9 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
 	struct pci_bus_ops *bus_ops;
 	unsigned long flags;
 
+	if (!legacy)
+		return 0;
+
 	bus_ops = kmalloc(sizeof(*bus_ops), GFP_KERNEL);
 	if (!bus_ops)
 		return -ENOMEM;
@@ -504,9 +523,148 @@ static struct miscdevice aer_inject_device = {
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
+	if (!aer_inj_read_config(bus, devfn, where, sizeof(u32), (u32 *)val))
+		return 0;
+	return read_config_dword(bus, devfn, where, val);
+}
+
+static int asmlinkage ainj_write_config_dword(struct pci_bus *bus,
+			unsigned int devfn, int where, u32 val)
+{
+	if (!aer_inj_write_config(bus, devfn, where, sizeof(u32), val))
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
+
+	return 0;
+}
+
+static void notrace aer_inject_ftrace_thunk(unsigned long ip, unsigned long parent_ip,
+		struct ftrace_ops *ops, struct pt_regs *regs)
+{
+	struct aer_hook *hook = ops->private;
+	instruction_pointer_set(regs, (unsigned long)hook->function);
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
+	hook->ops.private = hook;
+	hook->ops.func = aer_inject_ftrace_thunk;
+	hook->ops.flags = FTRACE_OPS_FL_SAVE_REGS |
+			  FTRACE_OPS_FL_RECURSION_SAFE |
+			  FTRACE_OPS_FL_IPMODIFY;
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
+	for (i--; i >= 0; i--)
+		aer_inject_remove_hook(&hooks[i]);
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
+	if (err) {
+		pr_info("aer_inject: using legacy error inject method\n");
+		legacy = true;
+	}
+	return 0;
 }
 
 static void __exit aer_inject_exit(void)
@@ -515,6 +673,8 @@ static void __exit aer_inject_exit(void)
 	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
+	if (!legacy)
+		aer_inject_remove_hooks(aer_hooks, ARRAY_SIZE(aer_hooks));
 	misc_deregister(&aer_inject_device);
 
 	while ((bus_ops = pci_bus_ops_pop())) {
-- 
2.14.4

