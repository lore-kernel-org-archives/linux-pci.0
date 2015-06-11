Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	mebersol@microsoft.com, haiyangz@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH 3/6] arch:x86:hv: Add mechanism for Hyper-V paravirt drivers to hook msi message creation
Date: Thu, 11 Jun 2015 16:22:24 +0000
Message-Id: <1434039747-44535-4-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1434039747-44535-1-git-send-email-jakeo@microsoft.com>
References: <1434039747-44535-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h |  2 ++
 arch/x86/kernel/cpu/mshyperv.c  | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index c163215..bf7789e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -19,5 +19,7 @@ void hyperv_callback_vector(void);
 void hyperv_vector_handler(struct pt_regs *regs);
 void hv_setup_vmbus_irq(void (*handler)(void));
 void hv_remove_vmbus_irq(void);
+void hyperv_install_interrupt_translation(struct x86_msi_ops *new_ops);
+void hyperv_uninstall_interrupt_translation(void);
 
 #endif
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 939155f..816e329 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -69,6 +69,36 @@ void hv_remove_vmbus_irq(void)
 }
 EXPORT_SYMBOL_GPL(hv_setup_vmbus_irq);
 EXPORT_SYMBOL_GPL(hv_remove_vmbus_irq);
+
+struct x86_msi_ops old_msi_ops;
+
+void hyperv_install_interrupt_translation(struct x86_msi_ops *new_ops)
+{
+	old_msi_ops.setup_msi_irqs = xchg(&(x86_msi.setup_msi_irqs),
+					  new_ops->setup_msi_irqs);
+	old_msi_ops.compose_msi_msg = xchg(&(x86_msi.compose_msi_msg),
+					   new_ops->compose_msi_msg);
+	old_msi_ops.teardown_msi_irqs = xchg(&(x86_msi.teardown_msi_irqs),
+					     new_ops->teardown_msi_irqs);
+	old_msi_ops.restore_msi_irqs = xchg(&(x86_msi.restore_msi_irqs),
+					    new_ops->restore_msi_irqs);
+
+	new_ops->setup_msi_irqs = old_msi_ops.setup_msi_irqs;
+	new_ops->compose_msi_msg = old_msi_ops.compose_msi_msg;
+	new_ops->teardown_msi_irqs = old_msi_ops.teardown_msi_irqs;
+	new_ops->restore_msi_irqs = old_msi_ops.restore_msi_irqs;
+}
+EXPORT_SYMBOL_GPL(hyperv_install_interrupt_translation);
+
+void hyperv_uninstall_interrupt_translation(void)
+{
+	xchg(&(x86_msi.setup_msi_irqs), old_msi_ops.setup_msi_irqs);
+	xchg(&(x86_msi.compose_msi_msg), old_msi_ops.compose_msi_msg);
+	xchg(&(x86_msi.teardown_msi_irqs), old_msi_ops.teardown_msi_irqs);
+	xchg(&(x86_msi.restore_msi_irqs), old_msi_ops.restore_msi_irqs);
+}
+EXPORT_SYMBOL_GPL(hyperv_uninstall_interrupt_translation);
+
 #endif
 
 static uint32_t  __init ms_hyperv_platform(void)
-- 
1.9.1

