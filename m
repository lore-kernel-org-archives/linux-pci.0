Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 25/37] PCI, ACPI: Add alloc_acpi_hp_work()
Date: Fri,  9 Mar 2012 23:00:25 -0800
Message-Id: <1331362837-10740-26-git-send-email-yinghai@kernel.org>
In-Reply-To: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Will use it with acpiphp and pci_root_hp events handling

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/osl.c      |   21 +++++++++++++++++++++
 include/acpi/acpiosxf.h |    9 +++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 412a1e0..fdcf4a5 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1641,3 +1641,24 @@ acpi_status acpi_os_terminate(void)
 
 	return AE_OK;
 }
+
+void alloc_acpi_hp_work(acpi_handle handle, u32 type, void *context,
+			void (*func)(struct work_struct *work))
+{
+	struct acpi_hp_work *hp_work;
+	int ret;
+
+	hp_work = kmalloc(sizeof(*hp_work), GFP_KERNEL);
+	if (!hp_work)
+		return;
+
+	hp_work->handle = handle;
+	hp_work->type = type;
+	hp_work->context = context;
+
+	INIT_WORK(&hp_work->work, func);
+	ret = queue_work(kacpi_hotplug_wq, &hp_work->work);
+	if (!ret)
+		kfree(hp_work);
+}
+EXPORT_SYMBOL(alloc_acpi_hp_work);
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 7c9aebe..62326ae 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -191,6 +191,15 @@ void acpi_os_fixed_event_count(u32 fixed_event_number);
  */
 extern struct workqueue_struct *kacpi_hotplug_wq;
 
+struct acpi_hp_work {
+	struct work_struct work;
+	acpi_handle handle;
+	u32 type;
+	void *context;
+};
+void alloc_acpi_hp_work(acpi_handle handle, u32 type, void *context,
+			void (*func)(struct work_struct *work));
+
 acpi_thread_id acpi_os_get_thread_id(void);
 
 acpi_status
-- 
1.7.7

