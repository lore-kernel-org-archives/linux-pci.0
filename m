Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 06/12] drivers:hv: Export do_hypercall()
Date: Fri, 11 Sep 2015 00:01:05 +0000
Message-Id: <1441929670-10058-7-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch exposes the function that hv_vmbus.ko uses to make hypercalls.  This
is necessary for retargeting an interrupt when it is given a new affinity.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/hv/hv.c        | 3 ++-
 include/linux/hyperv.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 6341be8..6d01649 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -91,7 +91,7 @@ static int query_hypervisor_info(void)
 /*
  * do_hypercall- Invoke the specified hypercall
  */
-static u64 do_hypercall(u64 control, void *input, void *output)
+u64 do_hypercall(u64 control, void *input, void *output)
 {
 	u64 input_address = (input) ? virt_to_phys(input) : 0;
 	u64 output_address = (output) ? virt_to_phys(output) : 0;
@@ -132,6 +132,7 @@ static u64 do_hypercall(u64 control, void *input, void *output)
 	return hv_status_lo | ((u64)hv_status_hi << 32);
 #endif /* !x86_64 */
 }
+EXPORT_SYMBOL_GPL(do_hypercall);
 
 #ifdef CONFIG_X86_64
 static cycle_t read_hv_clock_tsc(struct clocksource *arg)
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 02393b6..033fe59 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -983,6 +983,7 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 			bool fb_overlap_ok);
 
 int vmbus_cpu_number_to_vp_number(int cpu_number);
+u64 do_hypercall(u64 control, void *input, void *output);
 
 /**
  * VMBUS_DEVICE - macro used to describe a specific hyperv vmbus device
-- 
1.9.1

