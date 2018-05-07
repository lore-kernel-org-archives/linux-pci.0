Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        robh+dt@kernel.org, dan.j.williams@intel.com,
        nicolas.pitre@linaro.org, josh@joshtriplett.org,
        fengguang.wu@intel.com, bp@suse.de
Cc: patrik.r.jakobsson@gmail.com, airlied@linux.ie, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        dmitry.torokhov@gmail.com, frowand.list@gmail.com,
        keith.busch@intel.com, jonathan.derrick@intel.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, tglx@linutronix.de,
        brijesh.singh@amd.com, jglisse@redhat.com, thomas.lendacky@amd.com,
        gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, devel@linuxdriverproject.org,
        linux-input@vger.kernel.org, linux-nvdimm@lists.01.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
        yinghai@kernel.org, kexec@lists.infradead.org, monstr@monstr.eu,
        davem@davemloft.net, chris@zankel.net, jcmvbkbc@gmail.com,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, linux-parisc@vger.kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 2/3] resource: add walk_system_ram_res_rev()
Date: Mon,  7 May 2018 14:32:23 +0800
Message-Id: <20180507063224.24229-3-bhe@redhat.com>
In-Reply-To: <20180507063224.24229-1-bhe@redhat.com>
References: <20180507063224.24229-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This function, being a variant of walk_system_ram_res() introduced in
commit 8c86e70acead ("resource: provide new functions to walk through
resources"), walks through a list of all the resources of System RAM
in reversed order, i.e., from higher to lower.

It will be used in kexec_file code.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/ioport.h |  3 +++
 kernel/resource.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 225d13d3500a..5f2cfb460a14 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -278,6 +278,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(struct resource *, void *));
 extern int
+walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+			int (*func)(struct resource *, void *));
+extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
diff --git a/kernel/resource.c b/kernel/resource.c
index 4f560991c130..6c519b06e3d6 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -23,6 +23,8 @@
 #include <linux/pfn.h>
 #include <linux/mm.h>
 #include <linux/resource_ext.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
 #include <asm/io.h>
 
 
@@ -475,6 +477,44 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 }
 
 /*
+ * This function, being a variant of walk_system_ram_res(), calls the @func
+ * callback against all memory ranges of type System RAM which are marked as
+ * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
+ * higher to lower.
+ */
+int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+				int (*func)(struct resource *, void *))
+{
+	unsigned long flags;
+	struct resource *res;
+	int ret = -1;
+
+	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+	read_lock(&resource_lock);
+	list_for_each_entry_reverse(res, &iomem_resource.child, sibling) {
+		if (start >= end)
+			break;
+		if ((res->flags & flags) != flags)
+			continue;
+		if (res->desc != IORES_DESC_NONE)
+			continue;
+		if (res->end < start)
+			break;
+
+		if ((res->end >= start) && (res->start < end)) {
+			ret = (*func)(res, arg);
+			if (ret)
+				break;
+		}
+		end = res->start - 1;
+
+	}
+	read_unlock(&resource_lock);
+	return ret;
+}
+
+/*
  * This function calls the @func callback against all memory ranges, which
  * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
  */
-- 
2.13.6
