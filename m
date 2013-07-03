Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Yinghai Lu <yinghai@kernel.org>, john.ronciak@intel.com,
	miles.j.penner@intel.com, bruce.w.allan@intel.com,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 7/8] PCI: acpiphp: get rid of unused constants in acpiphp.h
Date: Wed,  3 Jul 2013 17:04:54 +0300
Message-Id: <1372860295-8306-8-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1372860295-8306-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1372860295-8306-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are not used anywhere so kill them.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/acpiphp.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
index ecc61b7..5fc9977 100644
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -142,9 +142,6 @@ struct acpiphp_attention_info
 	struct module *owner;
 };
 
-/* PCI bus bridge HID */
-#define ACPI_PCI_HOST_HID		"PNP0A03"
-
 /* ACPI _STA method value (ignore bit 4; battery present) */
 #define ACPI_STA_ALL			(0x0000000f)
 
@@ -154,7 +151,6 @@ struct acpiphp_attention_info
 /* slot flags */
 
 #define SLOT_POWEREDON		(0x00000001)
-#define SLOT_MULTIFUNCTION	(0x00000004)
 
 /* function flags */
 
-- 
1.8.3.2

