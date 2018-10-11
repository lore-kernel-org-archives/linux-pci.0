Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD6EC677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 18:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07828204FD
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 18:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07828204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeJLCGD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:06:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:32882 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbeJLCGD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 22:06:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 11:37:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="80468709"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 11 Oct 2018 11:37:16 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 4/4] PCI/AER: Covertly inject errors with ftrace hooks
Date:   Thu, 11 Oct 2018 12:34:13 -0600
Message-Id: <20181011183413.13183-5-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181011183413.13183-1-keith.busch@intel.com>
References: <20181011183413.13183-1-keith.busch@intel.com>
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
call address with the error injection function. This discreet error
injection doesn't modify or track driver structures, fixing the issues
with the current method.

If either the kernel config or platform arch do not support the necessary
ftrace capabilities, the aer_inject module will fallback to the older
way so that it may continue to be used as before.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer_inject.c | 152 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 95d4759664b3..f08bd20e8907 100644
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
@@ -298,6 +304,9 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
 	struct pci_bus_ops *bus_ops;
 	unsigned long flags;
 
+	if (!legacy)
+		return 0;
+
 	bus_ops = kmalloc(sizeof(*bus_ops), GFP_KERNEL);
 	if (!bus_ops)
 		return -ENOMEM;
@@ -514,9 +523,148 @@ static struct miscdevice aer_inject_device = {
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
@@ -525,6 +673,8 @@ static void __exit aer_inject_exit(void)
 	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
+	if (!legacy)
+		aer_inject_remove_hooks(aer_hooks, ARRAY_SIZE(aer_hooks));
 	misc_deregister(&aer_inject_device);
 
 	while ((bus_ops = pci_bus_ops_pop())) {
-- 
2.14.4

