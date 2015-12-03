Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:32420 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbbLCUZ3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2015 15:25:29 -0500
From: Babu Moger <babu.moger@oracle.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	babu.moger@oracle.com
Subject: [PATCH v4] pci: Limit VPD length for megaraid_sas adapter
Date: Thu,  3 Dec 2015 12:25:19 -0800
Message-Id: <1449174319-52798-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1447957102-184860-1-git-send-email-babu.moger@oracle.com>
References: <1447957102-184860-1-git-send-email-babu.moger@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reading or Writing of PCI VPD data causes system panic.
We saw this problem by running "lspci -vvv" in the beginning.
However this can be easily reproduced by running
 cat /sys/bus/devices/XX../vpd

VPD length has been set as 32768 by default. Accessing vpd
will trigger read/write of 32k. This causes problem as we
could read data beyond the VPD end tag. Behaviour is un-
predictable when this happens. I see some other adapter doing
similar quirks(commit bffadffd43d4 ("PCI: fix VPD limit quirk
for Broadcom 5708S"))

I see there is an attempt to fix this right way.
https://patchwork.ozlabs.org/patch/534843/ or
https://lkml.org/lkml/2015/10/23/97

Tried to fix it this way, but problem is I dont see the proper
start/end TAGs(at least for this adapter) at all. The data is
mostly junk or zeros. This patch fixes the issue by setting the
vpd length to 0x80.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Tested-by: Dmitry Klochkov <dmitry.klochkov@oracle.com>

Orabug: 22104511

Changes since v3 -> v4
We found some options of the lspci does not work very well if
it cannot find the valid vpd tag(Example command "lspci -s 10:00.0 -vv").
It displays the error message and exits right away. Setting the length
back to 0 fixes the problem.

Changes since v2 -> v3
Changed the vpd length from 0 to 0x80 which leaves the
option open for someone to read first few bytes.

Changes since v1 -> v2
Removed the changes in pci_id.h. Kept all the vendor
ids in quirks.c
---
 drivers/pci/quirks.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b03373f..f739e47 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2123,6 +2123,44 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_caching);
 
 /*
+ * A read/write to sysfs entry ('/sys/bus/pci/devices/<id>/vpd')
+ * will dump 32k of data. The default length is set as 32768.
+ * Reading a full 32k will cause an access beyond the VPD end tag.
+ * The system behaviour at that point is mostly unpredictable.
+ * Also I dont believe vendors have implemented this VPD headers properly.
+ * Atleast I dont see it in following megaraid sas controller.
+ * That is why adding the quirk here.
+ */
+static void quirk_megaraid_sas_limit_vpd(struct pci_dev *dev)
+{
+	if (dev->vpd)
+		dev->vpd->len = 0;
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d,
+		quirk_megaraid_sas_limit_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f,
+		quirk_megaraid_sas_limit_vpd);
+
+/*
  * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
  * VPD end tag will hang the device.  This problem was initially
  * observed when a vpd entry was created in sysfs
-- 
1.7.1

