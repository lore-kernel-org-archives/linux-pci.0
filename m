Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E368DC43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEEF21736
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfAGNB5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:01:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:49058 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbfAGNB4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jan 2019 08:01:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 05:01:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="308170903"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jan 2019 05:01:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8D837141; Mon,  7 Jan 2019 15:01:52 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2] PCI: Block power management of certain ports with slot implemented bit set
Date:   Mon,  7 Jan 2019 16:01:52 +0300
Message-Id: <20190107130152.83350-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gigabyte X299 DESIGNARE EX motherboard has one PCIe root port that is
connected to Alpine Ridge Thunderbolt controller. This port has slot
implemented bit set in the config space but other than that it is not
hotplug capable in the sense we are expecting in Linux (it has
dev->is_hotplug_bridge set to 0):

00:1c.4 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port #5
        Bus: primary=00, secondary=05, subordinate=46, sec-latency=0
        Memory behind bridge: 78000000-8fffffff [size=384M]
        Prefetchable memory behind bridge: 00003800f8000000-00003800ffffffff [size=128M]
        ...
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        ...
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                        Slot #8, PowerLimit 25.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                        Changed: MRL- PresDet+ LinkState+

This system is using ACPI based hotplug to notify the OS that it needs
to rescan the PCI bus (ACPI hotplug).

If there is nothing connected to any of the Thunderbolt ports the root
port will not have any runtime PM active children and is thus
automatically runtime suspended pretty soon after boot by PCI PM core.
Now, when a device is connected the BIOS SMI handler responsible for
enumerating newly added devices is not able to find anything because the
port is in D3.

For this reason we block power management of PCIe root and downstream
ports that have slot implemented set and have node in ACPI namespace.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202031
Reported-by: Kedar A Dongre <kedar.a.dongre@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Changes from v1:

 - Block PM for all root and downstream ports with slot implemented bit set
   and has an ACPI companion.

The previous version can be found here:

  https://patchwork.kernel.org/patch/10711553/

 drivers/pci/pci.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c9d8e3c837de..04bdbcf1dfb7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2510,10 +2510,14 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
+	int type;
+
 	if (!pci_is_pcie(bridge))
 		return false;
 
-	switch (pci_pcie_type(bridge)) {
+	type = pci_pcie_type(bridge);
+
+	switch (type) {
 	case PCI_EXP_TYPE_ROOT_PORT:
 	case PCI_EXP_TYPE_UPSTREAM:
 	case PCI_EXP_TYPE_DOWNSTREAM:
@@ -2546,6 +2550,18 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (bridge->is_hotplug_bridge)
 			return false;
 
+		/*
+		 * Some systems such as Gigabyte X299 the root port is
+		 * not marked hotplug capable but ACPI based hotplug is
+		 * still used to bring in the Thunderbolt controller. To
+		 * make sure those ports do not enter D3 and possibly
+		 * confuse the BIOS SMI handler, block D3 for them.
+		 */
+		if (has_acpi_companion(&bridge->dev) &&
+		    type != PCI_EXP_TYPE_UPSTREAM &&
+		    pcie_caps_reg(bridge) & PCI_EXP_FLAGS_SLOT)
+			return false;
+
 		/*
 		 * It should be safe to put PCIe ports from 2015 or newer
 		 * to D3.
-- 
2.19.2

