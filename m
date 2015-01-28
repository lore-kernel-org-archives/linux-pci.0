Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v2 02/22] ACPI: Remove redundant check in function acpi_dev_resource_address_space()
Date: Wed, 28 Jan 2015 18:57:20 +0800
Message-Id: <1422442660-455-3-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1422442660-455-1-git-send-email-jiang.liu@linux.intel.com>
References: <1422442660-455-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

The ACPI type is checked in acpi_resource_to_address64() anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index d0a4d90c6bcc..1c616a56e007 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -189,15 +189,6 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
 	u64 len;
 	u8 io_decode;
 
-	switch (ares->type) {
-	case ACPI_RESOURCE_TYPE_ADDRESS16:
-	case ACPI_RESOURCE_TYPE_ADDRESS32:
-	case ACPI_RESOURCE_TYPE_ADDRESS64:
-		break;
-	default:
-		return false;
-	}
-
 	status = acpi_resource_to_address64(ares, &addr);
 	if (ACPI_FAILURE(status))
 		return false;
-- 
1.7.10.4

