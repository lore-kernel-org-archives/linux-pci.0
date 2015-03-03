Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15334 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755037AbbCCEXK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 Mar 2015 23:23:10 -0500
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
Subject: [Debug 2/2] x86/PCI/ACPI: Relax ACPI resource descriptor checks to work around BIOS bugs
Date: Tue,  3 Mar 2015 12:25:41 +0800
Message-Id: <1425356741-26789-3-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1425356741-26789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1425356741-26789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some BIOSes report incorrect length for ACPI address space descriptors,
so relax the checks to avoid regressions.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
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

