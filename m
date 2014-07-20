Return-Path: <linux-acpi-owner@vger.kernel.org>
From: weiyj_lk@163.com
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH -next] ACPI / hotplug / PCI: Fix sparse non static symbol warning
Date: Sun, 20 Jul 2014 13:34:43 +0800
Message-Id: <1405834483-7832-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warning:

drivers/pci/hotplug/acpiphp_glue.c:923:6: warning:
 symbol 'acpiphp_drop_bridge' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/pci/hotplug/acpiphp_glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 24a43d4..70741c8 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -920,7 +920,7 @@ void acpiphp_enumerate_slots(struct pci_bus *bus)
 	kfree(bridge);
 }
 
-void acpiphp_drop_bridge(struct acpiphp_bridge *bridge)
+static void acpiphp_drop_bridge(struct acpiphp_bridge *bridge)
 {
 	if (pci_is_root_bus(bridge->pci_bus)) {
 		struct acpiphp_root_context *root_context;

