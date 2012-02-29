Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 09/39] x86, PCI: embed name acpi version pci_root_info struct
Date: Wed, 29 Feb 2012 15:07:08 -0800
Message-Id: <1330556858-11768-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now We allocate info, and keep that in during whole life of hostbridge.

So don't allocate info->name seperately, just put name into struct.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/pci/acpi.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index c7a230f..11c3ae7 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -9,7 +9,7 @@
 
 struct pci_root_info {
 	struct acpi_device *bridge;
-	char *name;
+	char name[16];
 	unsigned int res_num;
 	struct resource *res;
 	int busnum;
@@ -307,7 +307,6 @@ static void add_resources(struct pci_root_info *info,
 
 static void free_pci_root_info_res(struct pci_root_info *info)
 {
-	kfree(info->name);
 	kfree(info->res);
 	info->res = NULL;
 	info->res_num = 0;
@@ -360,9 +359,7 @@ probe_pci_root_info(struct pci_root_info *info, struct acpi_device *device,
 	if (!info->res)
 		return;
 
-	info->name = kasprintf(GFP_KERNEL, "PCI Bus %04x:%02x", domain, busnum);
-	if (!info->name)
-		return;
+	sprintf(info->name, "PCI Bus %04x:%02x", domain, busnum);
 
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS, setup_resource,
 				info);
-- 
1.7.7

