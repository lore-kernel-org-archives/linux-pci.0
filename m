Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v4 15/23] ACPI: Add field offset to struct resource_list_entry
Date: Thu,  5 Feb 2015 13:44:41 +0800
Message-Id: <1423115089-12904-16-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
References: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add field offset to struct resource_list_entry to host address space
translation offset so it could be used to represent bridge resources.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    1 +
 include/linux/acpi.h    |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 4dc8cfb2e94e..1c3abae6f2fa 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -472,6 +472,7 @@ static acpi_status acpi_dev_new_resource_entry(struct resource_win *win,
 		return AE_NO_MEMORY;
 	}
 	rentry->res = win->res;
+	rentry->offset = win->offset;
 	list_add_tail(&rentry->node, c->list);
 	c->count++;
 	return AE_OK;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index be9eaee8f4ae..21dac3cb62d2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -303,6 +303,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 struct resource_list_entry {
 	struct list_head node;
 	struct resource res;
+	resource_size_t offset;
 };
 
 void acpi_dev_free_resource_list(struct list_head *list);
-- 
1.7.10.4

