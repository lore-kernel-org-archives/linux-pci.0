Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB2BC04EBE
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 00:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CC0208E4
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 00:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CC0208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeJPInA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:43:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:26009 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbeJPIm7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 04:42:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 17:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,386,1534834800"; 
   d="scan'208";a="95512635"
Received: from unknown (HELO localhost.localdomain.localdomain) ([10.232.117.194])
  by fmsmga002.fm.intel.com with ESMTP; 15 Oct 2018 17:55:13 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 2/2] PCI/VMD: Set up firmware-first if capable
Date:   Mon, 15 Oct 2018 18:48:08 -0600
Message-Id: <1539650888-3792-3-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1539650888-3792-1-git-send-email-jonathan.derrick@intel.com>
References: <1539650888-3792-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The VMD endpoint device exposes a domain of root ports and any
downstream devices attached to that hierarchy. VMD domains consisting of
the root ports and downstream devices are not represented in the ACPI
tables and _OSC is unsupported. Because of this non-standard way of
signaling firmware-first enabling on the root ports, the VMD device
instead advertises support for firmware-first on the root ports by
setting its interface bit to 0x1.

When firmware-first is enabled on a VMD domain, the driver sets up the
root port control registers to generate SMI system interrupts to
firmware on errors. System firmware will handle the error as it sees
fit, then passes back control to VMD with a synthesized MSI message.

Because of this kernel pass-back, the driver does not disable the native
AER port service driver attached to the VMD root ports, allowing for
further kernel error handling if desired.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 46ed80f..9625dca 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -589,6 +589,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000, busn_start = 0;
+	u8 interface;
 
 	/*
 	 * Shadow registers may exist in certain VMD device ids which allow
@@ -718,6 +719,35 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
 	pci_rescan_bus(vmd->bus);
 
+	/*
+	 * Certain VMD devices may request firmware-first error handling
+	 * support on the domain. These domains are virtual and not described
+	 * by ACPI and must be configured manually. VMD domains which utilize
+	 * firmware-first may still require further kernel error handling, but
+	 * the domain is intended to first interrupt upon error to system
+	 * firmware before being passed back to the kernel. The system error
+	 * handling bits in the root port control register must be enabled
+	 * following the AER service driver configuration in order to generate
+	 * these system interrupts.
+	 *
+	 * Because the root ports are not described by ACPI and _OSC is
+	 * unsupported in VMD domains, the intent to use firmware-first error
+	 * handling in the root ports is instead described by the VMD device's
+	 * interface bit.
+	 */
+	pci_read_config_byte(vmd->dev, PCI_CLASS_PROG, &interface);
+	if (interface == 0x1) {
+		struct pci_dev *rpdev;
+
+		list_for_each_entry(rpdev, &vmd->bus->devices, bus_list) {
+			if (rpdev->aer_cap)
+				pcie_capability_set_word(rpdev, PCI_EXP_RTCTL,
+							 PCI_EXP_RTCTL_SECEE  |
+							 PCI_EXP_RTCTL_SENFEE |
+							 PCI_EXP_RTCTL_SEFEE);
+		}
+	}
+
 	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
 			       "domain"), "Can't create symlink to domain\n");
 	return 0;
-- 
1.8.3.1

