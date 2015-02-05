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
Subject: [Patch v4 05/23] ACPI: Let the parser return false for disabled resources
Date: Thu,  5 Feb 2015 13:44:31 +0800
Message-Id: <1423115089-12904-6-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
References: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

If the parser disables a resource during parsing, let it return false,
so the calling code does not need to implement further checks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 16d291c60277..cdb1a3c4a0b9 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -219,10 +219,10 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
 		res->flags = IORESOURCE_BUS;
 		break;
 	default:
-		res->flags = 0;
+		return false;
 	}
 
-	return true;
+	return !(res->flags & IORESOURCE_DISABLED);
 }
 EXPORT_SYMBOL_GPL(acpi_dev_resource_address_space);
 
@@ -268,10 +268,10 @@ bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
 		res->flags = IORESOURCE_BUS;
 		break;
 	default:
-		res->flags = 0;
+		return false;
 	}
 
-	return true;
+	return !(res->flags & IORESOURCE_DISABLED);
 }
 EXPORT_SYMBOL_GPL(acpi_dev_resource_ext_address_space);
 
-- 
1.7.10.4

