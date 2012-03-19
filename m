Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v3 08/11] x86, PCI: Embed name into pci_root_info struct
Date: Sun, 18 Mar 2012 22:40:21 -0700
Message-Id: <1332135624-13528-9-git-send-email-yinghai@kernel.org>
In-Reply-To: <1332135624-13528-1-git-send-email-yinghai@kernel.org>
References: <1332135624-13528-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we allocate info, and keep that in during whole life of host bridge.

So don't allocate info->name seperately, just put name into struct.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/pci/acpi.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 2b74a16..23e7361 100644
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
@@ -317,7 +317,6 @@ static void add_resources(struct pci_root_info *info,
 
 static void free_pci_root_info_res(struct pci_root_info *info)
 {
-	kfree(info->name);
 	kfree(info->res);
 	info->res = NULL;
 	info->res_num = 0;
@@ -370,9 +369,7 @@ probe_pci_root_info(struct pci_root_info *info, struct acpi_device *device,
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

