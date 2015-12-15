Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andy Lutomirski <luto@kernel.org>
To: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Yijing Wang <wangyijing@huawei.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 2/2] acpi: Show _OSC UUID when _OSC fails
Date: Tue, 15 Dec 2015 08:37:40 -0800
Message-Id: <bee26622c19d06b6f59f8bd994fadde2dc95a906.1450197207.git.luto@kernel.org>
In-Reply-To: <cover.1450197207.git.luto@kernel.org>
References: <cover.1450197207.git.luto@kernel.org>
In-Reply-To: <cover.1450197207.git.luto@kernel.org>
References: <cover.1450197207.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When _OSC fails and especially when it fails due to an invalid UUID,
it's helpful to show the UUID that we tried.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/acpi/bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 2177ef0b16e4..fcfdf6cbc6a8 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -180,9 +180,10 @@ static void acpi_print_osc_error(acpi_handle handle,
 	int i;
 
 	if (ACPI_FAILURE(acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer)))
-		printk(KERN_DEBUG "%s\n", error);
+		printk(KERN_DEBUG "%s: %s\n", context->uuid_str, error);
 	else {
-		printk(KERN_DEBUG "%s: %s\n", (char *)buffer.pointer, error);
+		printk(KERN_DEBUG "%s (%s): %s\n",
+		       (char *)buffer.pointer, context->uuid_str, error);
 		kfree(buffer.pointer);
 	}
 	printk(KERN_DEBUG "_OSC request data:");
-- 
2.5.0

