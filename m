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
Subject: [Patch v2 12/22] ACPI: Enforce stricter checks for address space descriptors
Date: Wed, 28 Jan 2015 18:57:30 +0800
Message-Id: <1422442660-455-13-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1422442660-455-1-git-send-email-jiang.liu@linux.intel.com>
References: <1422442660-455-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enforce stricter checks for address space descriptors according to
ACPI spec.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 5bf73a9f26d9..57891a621b96 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -192,6 +192,15 @@ static bool acpi_decode_space(struct resource *res,
 	bool wp = addr->info.mem.write_protect;
 	u64 len = attr->address_length;
 
+	/*
+	 * Filter out invalid descriptor according to ACPI Spec 5.0, section
+	 * 6.4.3.5 Address Space Resource Descriptors.
+	 */
+	if ((addr->min_address_fixed != addr->max_address_fixed && len) ||
+	    (addr->min_address_fixed && addr->max_address_fixed && !len))
+		pr_debug("ACPI: Invalid address space min_addr_fix %d, max_addr_fix %d, len %llx\n",
+			 addr->min_address_fixed, addr->max_address_fixed, len);
+
 	res->start = attr->minimum;
 	res->end = attr->maximum;
 
-- 
1.7.10.4

