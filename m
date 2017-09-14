Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jork Loeser <jloeser@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH] ACPI / PCI: Bail early in acpi_pci_add_bus() if there is no ACPI handle
Date: Thu, 14 Sep 2017 16:50:14 +0200
Message-Id: <20170914145014.2834-1-vkuznets@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hyper-V instances support PCI pass-through which is implemented through
PV pci-hyperv driver. When a device is passed through a new root PCI bus
is created in the guest. The bus sits on top of VMBus and has no
associated information in ACPI. acpi_pci_add_bus() in this case proceeds
all the way to acpi_evaluate_dsm() with reports

    ACPI: \: failed to evaluate _DSM (0x1001)

While acpi_pci_slot_enumerate() and acpiphp_enumerate_slots() are protected
against ACPI_HANDLE() being NULL and do nothing acpi_evaluate_dsm() is not
and gives us the error. It seems the correct fix is to not do anything in
acpi_pci_add_bus() in such cases.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/pci/pci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a8da543b3814..4708eb9df71b 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -624,7 +624,7 @@ void acpi_pci_add_bus(struct pci_bus *bus)
 	union acpi_object *obj;
 	struct pci_host_bridge *bridge;
 
-	if (acpi_pci_disabled || !bus->bridge)
+	if (acpi_pci_disabled || !bus->bridge || !ACPI_HANDLE(bus->bridge))
 		return;
 
 	acpi_pci_slot_enumerate(bus);
-- 
2.13.5

