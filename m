Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23688 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760564AbbCDIol (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Mar 2015 03:44:41 -0500
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Thomas Voegtle <tv@lio96.de>, Hudd <hedede.l@gmail.com>,
	Prakash Punnoor <prakash@punnoor.de>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Dave Airlie <airlied@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Lv Zheng <lv.zheng@intel.com>
Subject: [Bugfix 2/2] x86/PCI/ACPI: Relax ACPI resource descriptor checks to work around BIOS bugs
Date: Wed,  4 Mar 2015 16:47:12 +0800
Message-Id: <1425458832-28777-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1425458832-28777-1-git-send-email-jiang.liu@linux.intel.com>
References: <1425458832-28777-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some BIOSes report incorrect length for ACPI address space descriptors,
so relax the checks to avoid regressions. This issue has appeared several
times as:
3162b6f0c5e1 ("PNPACPI: truncate _CRS windows with _LEN > _MAX - _MIN + 1")
d558b483d5a7 ("x86/PCI: truncate _CRS windows with _LEN > _MAX - _MIN + 1")
f238b414a74a ("PNPACPI: compute Address Space length rather than using _LEN")
48728e077480 ("x86/PCI: compute Address Space length rather than using _LEN")

Please refer to https://bugzilla.kernel.org/show_bug.cgi?id=94221
for more details and example malformed ACPI resource descriptors.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Tested-by: Dave Airlie <airlied@redhat.com>
Tested-by: Prakash Punnoor <prakash@punnoor.de>
---
 drivers/acpi/resource.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index c723668e3e27..5589a6e2a023 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -42,8 +42,10 @@ static bool acpi_dev_resource_len_valid(u64 start, u64 end, u64 len, bool io)
 	 * CHECKME: len might be required to check versus a minimum
 	 * length as well. 1 for io is fine, but for memory it does
 	 * not make any sense at all.
+	 * Note: some BIOSes report incorrect length for ACPI address space
+	 * descriptor, so remove check of 'reslen == len' to avoid regression.
 	 */
-	if (len && reslen && reslen == len && start <= end)
+	if (len && reslen && start <= end)
 		return true;
 
 	pr_debug("ACPI: invalid or unassigned resource %s [%016llx - %016llx] length [%016llx]\n",
-- 
1.7.10.4

