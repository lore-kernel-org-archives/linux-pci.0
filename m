Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62564 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756371AbbBEFmq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 Feb 2015 00:42:46 -0500
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
Subject: [Patch v4 09/23] ACPI: Fix a bug in parsing ACPI Memory24 resource
Date: Thu,  5 Feb 2015 13:44:35 +0800
Message-Id: <1423115089-12904-10-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
References: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to ACPI spec 5, section 6.4.3.1 "24-Bit Memory Range Descriptor",
minimum, maximum and address_length field in struct acpi_resource_memory24
is in granularity of 256-bytes. So shift 8-bit left to get correct address.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 7ce00a63f695..5544c6d26f32 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -90,8 +90,8 @@ bool acpi_dev_resource_memory(struct acpi_resource *ares, struct resource *res)
 	switch (ares->type) {
 	case ACPI_RESOURCE_TYPE_MEMORY24:
 		memory24 = &ares->data.memory24;
-		acpi_dev_get_memresource(res, memory24->minimum,
-					 memory24->address_length,
+		acpi_dev_get_memresource(res, memory24->minimum << 8,
+					 memory24->address_length << 8,
 					 memory24->write_protect);
 		break;
 	case ACPI_RESOURCE_TYPE_MEMORY32:
-- 
1.7.10.4

