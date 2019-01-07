Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC99C43444
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 14:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4827A2173C
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 14:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbfAGOkG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:40:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:29365 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfAGOkE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jan 2019 09:40:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 06:40:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="106229152"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Jan 2019 06:40:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A4E452AA; Mon,  7 Jan 2019 16:39:59 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: pciehp: Disable Data Link Layer State Changed event on suspend
Date:   Mon,  7 Jan 2019 17:39:59 +0300
Message-Id: <20190107143959.75267-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190107143959.75267-1-mika.westerberg@linux.intel.com>
References: <20190107143959.75267-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 0e157e528604 ("PCI/PME: Implement runtime PM callbacks") tried to
solve an issue where the hierarchy immediately wakes up when it is
transitioned into D3cold. It turns out preventing PME propagation in
some PCIe hierarchies not supporting D3cold.

I looked more closely what might cause the immediate wakeup. It happens
when the ACPI power resource of the root port is turned off. The AML
code associated with the _OFF() method of the ACPI power resource
executes PCIe L2/3 ready transition and waits it to complete. Right
after the L2/3 ready transition is started the root port receives PME
from the downstream port.

The simplest hierarchy where this happens looks like this:

  00:1d.0 PCIe Root port
    ^
    |
    v
    05:00.0 PCIe switch #1 upstream port
      06:01.0 PCIe switch #1 downstream hotplug port
        ^
        |
        v
        08:00.0 Pcie switch #2 upstream port

It seems that the PCIe link between the two switches, before
PME_Turn_Off/PME_TO_Ack is complete for the whole hierarchy, goes
inactive and triggers PME towards the root port bringing it back to D0.
Disabling Data Link Layer State Changed event (DLLSCE) prevents the
issue and still allows the downstream hotplug port to notice when a
device is plugged/unplugged.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202103
Fixes: 0e157e528604 ("PCI/PME: Implement runtime PM callbacks")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index cd9eae650aa5..6fdaa8d48ebe 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -736,12 +736,18 @@ void pcie_clear_hotplug_events(struct controller *ctrl)
 
 void pcie_enable_interrupt(struct controller *ctrl)
 {
-	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_HPIE, PCI_EXP_SLTCTL_HPIE);
+	u16 mask;
+
+	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
+	pcie_write_cmd(ctrl, mask, mask);
 }
 
 void pcie_disable_interrupt(struct controller *ctrl)
 {
-	pcie_write_cmd(ctrl, 0, PCI_EXP_SLTCTL_HPIE);
+	u16 mask;
+
+	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
+	pcie_write_cmd(ctrl, 0, mask);
 }
 
 /*
-- 
2.19.2

