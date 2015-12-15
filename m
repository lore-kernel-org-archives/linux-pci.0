Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Andy Lutomirski <luto@kernel.org>
To: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Yijing Wang <wangyijing@huawei.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 1/2] acpi: Tidy up _OSC error spacing
Date: Tue, 15 Dec 2015 08:37:39 -0800
Message-Id: <a330d9ae4e086f4d55931cbc247d083ece1e43f6.1450197207.git.luto@kernel.org>
In-Reply-To: <cover.1450197207.git.luto@kernel.org>
References: <cover.1450197207.git.luto@kernel.org>
In-Reply-To: <cover.1450197207.git.luto@kernel.org>
References: <cover.1450197207.git.luto@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The whitespace in _OSC error reports is weird.  Improve it.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/acpi/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a212cefae524..2177ef0b16e4 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -182,12 +182,12 @@ static void acpi_print_osc_error(acpi_handle handle,
 	if (ACPI_FAILURE(acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer)))
 		printk(KERN_DEBUG "%s\n", error);
 	else {
-		printk(KERN_DEBUG "%s:%s\n", (char *)buffer.pointer, error);
+		printk(KERN_DEBUG "%s: %s\n", (char *)buffer.pointer, error);
 		kfree(buffer.pointer);
 	}
-	printk(KERN_DEBUG"_OSC request data:");
+	printk(KERN_DEBUG "_OSC request data:");
 	for (i = 0; i < context->cap.length; i += sizeof(u32))
-		printk("%x ", *((u32 *)(context->cap.pointer + i)));
+		printk(" %x", *((u32 *)(context->cap.pointer + i)));
 	printk("\n");
 }
 
-- 
2.5.0

