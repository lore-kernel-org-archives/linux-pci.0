Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: [RFC Patch V2 04/16] ACPI: Make map_mat_entry handle x2apic entry
Date: Tue, 17 Jun 2014 13:29:43 +0800
Message-Id: <1402982995-13747-5-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1402982995-13747-1-git-send-email-jiang.liu@linux.intel.com>
References: <1402982995-13747-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yinghai Lu <yinghai@kernel.org>

Now we have map_madt_entry/MADT to handle x2apic, but does not do
that with map_mat_entry _MAT.

For hotplug on system with x2apic only support, we need to add
support for x2apic map in _MAT.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/processor_core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 71e2065639a6..c8a991e9d257 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -133,6 +133,8 @@ static int map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 	header = (struct acpi_subtable_header *)obj->buffer.pointer;
 	if (header->type == ACPI_MADT_TYPE_LOCAL_APIC) {
 		map_lapic_id(header, acpi_id, &apic_id);
+	} else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC) {
+		map_x2apic_id(header, type, acpi_id, &apic_id);
 	} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
 		map_lsapic_id(header, type, acpi_id, &apic_id);
 	}
-- 
1.7.10.4

