Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DA4C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 13:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F233A21855
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 13:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfAXNMb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:12:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:1083 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfAXNMb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 08:12:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 05:12:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,516,1539673200"; 
   d="scan'208";a="117080875"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jan 2019 05:12:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E6FA1D4; Thu, 24 Jan 2019 15:12:27 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>, Peter Wu <peter@lekensteyn.nl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v3] PCI: Blacklist power management of Gigabyte X299 DESIGNARE EX PCIe ports
Date:   Thu, 24 Jan 2019 16:12:27 +0300
Message-Id: <20190124131227.45612-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gigabyte X299 DESIGNARE EX motherboard has one PCIe root port that is
connected to an Alpine Ridge Thunderbolt controller. This port has slot
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

If there is nothing connected in any of the Thunderbolt ports the root
port will not have any runtime PM active children and is thus
automatically runtime suspended pretty soon after boot by PCI PM core.
Now, when a device is connected the BIOS SMI handler responsible for
enumerating newly added devices is not able to find anything because the
port is in D3.

Prevent this from happening by blacklisting PCI power management of this
particular Gigabyte system.

Reported-by: Kedar A Dongre <kedar.a.dongre@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
Hi,

This is pretty much the same as v1 but I added Rafael's tag and rebased it
on top of v5.0-rc3. The alternative approach in v2 breaks power management
of certain discrete graphics so use blacklist for now.

v2: https://patchwork.kernel.org/patch/10750549/
v1: https://patchwork.kernel.org/patch/10711553/

 drivers/pci/pci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c25acace7d91..47ceef050782 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2501,6 +2501,23 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
 		pm_runtime_put_sync(parent);
 }
 
+static const struct dmi_system_id bridge_d3_blacklist[] = {
+	{
+		/*
+		 * Gigabyte X299 root port is not marked as hotplug
+		 * capable which allows Linux to power manage it.
+		 * However, this confuses the BIOS SMI handler so don't
+		 * power manage root ports on that system.
+		 */
+		.ident = "X299 DESIGNARE EX-CF",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "X299 DESIGNARE EX-CF"),
+		},
+	},
+	{ }
+};
+
 /**
  * pci_bridge_d3_possible - Is it possible to put the bridge into D3
  * @bridge: Bridge to check
@@ -2546,6 +2563,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (bridge->is_hotplug_bridge)
 			return false;
 
+		if (dmi_check_system(bridge_d3_blacklist))
+			return false;
+
 		/*
 		 * It should be safe to put PCIe ports from 2015 or newer
 		 * to D3.
-- 
2.20.1

