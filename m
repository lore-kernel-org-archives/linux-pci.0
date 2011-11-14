Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:52208 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644Ab1KNXm0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2011 18:42:26 -0500
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <garyhade@us.ibm.com>;
	Mon, 14 Nov 2011 16:42:26 -0700
Date: Mon, 14 Nov 2011 15:42:16 -0800
From: Gary Hade <garyhade@us.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Renninger <trenn@novell.com>,
	Gary Hade <garyhade@us.ibm.com>
Subject: [PATCH] x86/PCI: Ignore CPU non-addressable _CRS reserved memory
	resources
Message-ID: <20111114234216.GA16000@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


From: Gary Hade <garyhade@us.ibm.com>

This assures that a _CRS reserved host bridge window or 
window region is not used if it is not addressable by
the CPU.  The new code either trims the window to exclude
the non-addressable portion or totally ignores the window
if the entire window is non-addressable.

The current code has been shown to be problematic with
32-bit non-PAE kernels on systems where _CRS reserves
resources above 4GB.

Signed-off-by: Gary Hade <garyhade@us.ibm.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Renninger <trenn@novell.com>
Cc: linux-kernel@vger.kernel.org
Cc: stable@kernel.org
---

 arch/x86/pci/acpi.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 404f21a..3557af7 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -149,7 +149,7 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
 	struct acpi_resource_address64 addr;
 	acpi_status status;
 	unsigned long flags;
-	u64 start, end;
+	u64 start, orig_end, end;
 
 	status = resource_to_addr(acpi_res, &addr);
 	if (!ACPI_SUCCESS(status))
@@ -165,7 +165,21 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
 		return AE_OK;
 
 	start = addr.minimum + addr.translation_offset;
-	end = addr.maximum + addr.translation_offset;
+	orig_end = end = addr.maximum + addr.translation_offset;
+
+	/* Exclude non-addressable range or non-addressable portion of range */
+	end = min(end, (u64)iomem_resource.end);
+	if (end <= start) {
+		dev_info(&info->bridge->dev,
+			"host bridge window [%#llx-%#llx] "
+			"(ignored, not CPU addressable)\n", start, orig_end);
+		return AE_OK;
+	} else if (orig_end != end) {
+		dev_info(&info->bridge->dev,
+			"host bridge window [%#llx-%#llx] "
+			"([%#llx-%#llx] ignored, not CPU addressable)\n", 
+			start, orig_end, end + 1, orig_end);
+	}
 
 	res = &info->res[info->res_num];
 	res->name = info->name;

