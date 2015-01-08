Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Robert Moore <robert.moore@intel.com>,
	Lv Zheng <lv.zheng@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	devel@acpica.org
Subject: [RFC Patch 05/19] ACPI: Provide union for address_space64 and ext_address_space64
Date: Thu,  8 Jan 2015 10:32:52 +0800
Message-Id: <1420684386-5975-6-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com>
References: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

address_space64 and ext_address_space64 share substracts just at
different offsets. To unify the parsing functions implement the two
structs as unions of their substructs, so we can extract the shared
data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/acpi/acrestyp.h |   49 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index eb760ca0b2e0..307d5b2605c8 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -326,23 +326,46 @@ struct acpi_resource_address32 {
 	struct acpi_resource_source resource_source;
 };
 
-struct acpi_resource_address64 {
-	ACPI_RESOURCE_ADDRESS_COMMON u64 granularity;
-	u64 minimum;
-	u64 maximum;
-	u64 translation_offset;
+#define ACPI_RESOURCE_ADDRESS64_COMMON \
+	u64 granularity;	       \
+	u64 minimum;		       \
+	u64 maximum;		       \
+	u64 translation_offset;	       \
 	u64 address_length;
-	struct acpi_resource_source resource_source;
+
+struct acpi_resource_address64_common {
+ACPI_RESOURCE_ADDRESS64_COMMON};
+
+struct acpi_resource_address64 {
+	union {
+		struct {
+			ACPI_RESOURCE_ADDRESS_COMMON
+			ACPI_RESOURCE_ADDRESS64_COMMON
+			struct acpi_resource_source resource_source;
+		};
+		struct {
+			struct acpi_resource_address base;
+			struct acpi_resource_address64_common addr;
+			struct acpi_resource_source resource_source;
+		} common;
+	};
 };
 
 struct acpi_resource_extended_address64 {
-	ACPI_RESOURCE_ADDRESS_COMMON u8 revision_ID;
-	u64 granularity;
-	u64 minimum;
-	u64 maximum;
-	u64 translation_offset;
-	u64 address_length;
-	u64 type_specific;
+	union {
+		struct {
+			ACPI_RESOURCE_ADDRESS_COMMON
+			u8 revision_ID;
+			ACPI_RESOURCE_ADDRESS64_COMMON
+			u64 type_specific;
+		};
+		struct {
+			struct acpi_resource_address base;
+			u8 revision_ID;
+			struct acpi_resource_address64_common addr;
+			u64 type_specific;
+		} common;
+	};
 };
 
 struct acpi_resource_extended_irq {
-- 
1.7.10.4

