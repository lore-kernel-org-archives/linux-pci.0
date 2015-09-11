Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 05/12] drivers:hv: Export a function that maps Linux CPU num onto Hyper-V proc num
Date: Fri, 11 Sep 2015 00:01:04 +0000
Message-Id: <1441929670-10058-6-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch exposes the mapping between Linux CPU number and Hyper-V virtual
processor number.  This is necessary because the hypervisor needs to know which
virtual processors to target when making a mapping in the Interrupt Redirection
Table in the I/O MMU.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 17 +++++++++++++++++
 include/linux/hyperv.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index f19b6f7..c89d0e5 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1191,6 +1191,23 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 }
 EXPORT_SYMBOL_GPL(vmbus_allocate_mmio);
 
+/**
+ * vmbus_cpu_number_to_vp_number() - Map CPU to VP.
+ * @cpu_number: CPU number in Linux terms
+ *
+ * This function returns the mapping between the Linux processor
+ * number and the hypervisor's virtual processor number, useful
+ * in making hypercalls and such that talk about specific
+ * processors.
+ *
+ * Return: Virtual processor number in Hyper-V terms
+ */
+int vmbus_cpu_number_to_vp_number(int cpu_number)
+{
+	return hv_context.vp_index[cpu_number];
+}
+EXPORT_SYMBOL_GPL(vmbus_cpu_number_to_vp_number);
+
 static int vmbus_acpi_add(struct acpi_device *device)
 {
 	acpi_status result;
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 54733d5..02393b6 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -982,6 +982,8 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 			resource_size_t size, resource_size_t align,
 			bool fb_overlap_ok);
 
+int vmbus_cpu_number_to_vp_number(int cpu_number);
+
 /**
  * VMBUS_DEVICE - macro used to describe a specific hyperv vmbus device
  *
-- 
1.9.1

