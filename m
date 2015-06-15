Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org, pebolle@tiscali.nl,
	haiyangz@microsoft.com, mebersol@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 4/6] drivers:hv: Export a function that maps Linux proc num onto Hyper-V proc num
Date: Mon, 15 Jun 2015 17:06:37 +0000
Message-Id: <1434387999-1885-5-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1434387999-1885-1-git-send-email-jakeo@microsoft.com>
References: <1434387999-1885-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch exports a function which maps Linux processor number onto Hyper-V
virtual processor number.  This is necessary in order to map message-
signaled interrupts (MSIs) into a VM, as the hypervisor needs to know the
right target VP.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 16 ++++++++++++++++
 include/linux/hyperv.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 067a469..65e4eb6 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1158,6 +1158,22 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 }
 EXPORT_SYMBOL_GPL(vmbus_allocate_mmio);
 
+/**
+ * This function returns the mapping between the Linux processor
+ * number and
+ * the hypervisor's virtual processor number, useful in making
+ * hypercalls and such that talk about specific processors.
+ *
+ * @param procnum - in Linux terms
+ *
+ * @return int - in Hyper-V terms
+ */
+int vmbus_procnum_to_vpnum(int procnum)
+{
+	return hv_context.vp_index[procnum];
+}
+EXPORT_SYMBOL_GPL(vmbus_procnum_to_vpnum);
+
 static int vmbus_acpi_add(struct acpi_device *device)
 {
 	acpi_status result;
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index ffd98d7..6fec42d 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -987,6 +987,8 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 			resource_size_t size, resource_size_t align,
 			bool fb_overlap_ok);
 
+int vmbus_procnum_to_vpnum(int procnum);
+
 /**
  * VMBUS_DEVICE - macro used to describe a specific hyperv vmbus device
  *
-- 
1.9.1

