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
Subject: [PATCH v2 29/37] PCI, ACPI: Add acpi_pci_root_rescan()
Date: Fri,  9 Mar 2012 23:00:29 -0800
Message-Id: <1331362837-10740-30-git-send-email-yinghai@kernel.org>
In-Reply-To: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It will rescan all acpi pci root if related pci root bus get removed before.

Signed-off-by: Yinghai <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/pci_root_hp.c |   17 +++++++++++++++++
 include/linux/pci-acpi.h   |    7 +++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/pci_root_hp.c b/drivers/acpi/pci_root_hp.c
index b453181..ca73d51 100644
--- a/drivers/acpi/pci_root_hp.c
+++ b/drivers/acpi/pci_root_hp.c
@@ -268,3 +268,20 @@ static int __init acpi_pci_root_hp_init(void)
 }
 
 subsys_initcall(acpi_pci_root_hp_init);
+
+static acpi_status
+rescan_root_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	if (!acpi_is_root_bridge(handle))
+		return AE_OK;
+
+	handle_root_bridge_insertion(handle);
+
+	return AE_OK;
+}
+
+void acpi_pci_root_rescan(void)
+{
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+		ACPI_UINT32_MAX, rescan_root_bridge, NULL, NULL, NULL);
+}
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 4462350..ac93634 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -35,6 +35,13 @@ static inline acpi_handle acpi_pci_get_bridge_handle(struct pci_bus *pbus)
 	return acpi_get_pci_rootbridge_handle(pci_domain_nr(pbus),
 					      pbus->number);
 }
+
+void acpi_pci_root_rescan(void);
+
+#else
+
+static inline void acpi_pci_root_rescan(void) { }
+
 #endif
 
 #ifdef CONFIG_ACPI_APEI
-- 
1.7.7

