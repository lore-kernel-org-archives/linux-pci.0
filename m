Return-Path: <SRS0=XYt1=NG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410E6ECDE47
	for <linux-pci@archiver.kernel.org>; Fri, 26 Oct 2018 20:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF8D207DD
	for <linux-pci@archiver.kernel.org>; Fri, 26 Oct 2018 20:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF8D207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeJ0FFA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:05:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:16267 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbeJ0FFA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 27 Oct 2018 01:05:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 13:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,429,1534834800"; 
   d="scan'208";a="102998745"
Received: from unknown (HELO localhost.localdomain.localdomain) ([10.232.117.194])
  by orsmga001.jf.intel.com with ESMTP; 26 Oct 2018 13:26:33 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 3/3] PCI/VMD: Enable firmware-first combined model
Date:   Fri, 26 Oct 2018 14:19:06 -0600
Message-Id: <1540585146-31876-3-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
References: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The VMD endpoint acts as a host bridge for a nested PCIe segment. This
segment and its ports and endpoints are not represented in ACPI tables
such as DSDT and HEST, so "firmware first" error handling is currently
unsupported in the driver in favor of OS native error handling.

VMD does support firmware error handling where errors are signaled to
host firmware via SMI. VMD supports a "combined model" [1] where
OS-native error handling is used in addition to firmware. Because of
this combined model, this patch does not subscribe to the kernel
firmware-first architecture which would prevent OS native error
handling.

The VMD segment does not support NMI callbacks from firmware to the OS.
After error handling, firmware instead causes VMD to issue an interrupt
via MSI vector 0, which is the same interrupt already used to signal
PCIe errors for OS native handling in the VMD PCIe segment.

In order to generate SMI on PCIe errors, BIOS is responsible for setting
the System Error bits pre-boot in the Root Control register for the root
ports in the VMD segment.

BIOS signals its intent to use firmware first in the VMD segment by
setting the Programming Interface to 0x1 in VMD's Class Code register.
This patch checks for this value, and if set, prevents the native AER
driver from clearing the System Error bits for root ports in the VMD
segment.

[1]
https://firmware.intel.com/sites/default/files/resources/A_Tour_beyond_BIOS_Implementing_APEI_with_UEFI_White_Paper.pdf
p. 10.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 46ed80f..7269081 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -589,6 +589,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000, busn_start = 0;
+	u8 interface;
 
 	/*
 	 * Shadow registers may exist in certain VMD device ids which allow
@@ -716,8 +717,40 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	vmd_attach_resources(vmd);
 	vmd_setup_dma_ops(vmd);
 	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
-	pci_rescan_bus(vmd->bus);
 
+	/*
+	 * Certain VMD devices may request firmware-first error handling
+	 * support on the VMD domain. These domains are not described by ACPI
+	 * tables such as DSDT and HEST, so "firmware first" error handling is
+	 * currently unsupported in the driver in favor of OS native error
+	 * handing.
+	 *
+	 * VMD does support firmware error handling where errors are signaled
+	 * to firmware via SMI. It also supports a "combined model" where the
+	 * OS native error handling may be used in addition to firmware error
+	 * handling.
+	 *
+	 * Because of the lack of ACPI support on the domain and the capability
+	 * to use the 'combined model', the typical firmware-first architecture
+	 * is not used because it would disable OS native error handling.
+	 *
+	 * VMD domains do not support NMI callbacks to the OS. Pass-back to the
+	 * kernel from firmware is handled with a synthesized MSI on VMD device
+	 * vector 0, which is the same interrupt already used to signal PCIe
+	 * errors for OS native handling in the VMD domain and will trigger any
+	 * remaining required OS native error handling.
+	 *
+	 * Because the VMD domain is not described by ACPI, the intent to use
+	 * firmware-first error handling in the root ports is instead described
+	 * by the VMD device's programming interface bit being set to 0x1.
+	 */
+	pci_read_config_byte(vmd->dev, PCI_CLASS_PROG, &interface);
+	if (interface == 0x1) {
+		struct pci_host_bridge *host = pci_find_host_bridge(vmd->bus);
+		host->no_disable_sys_err = 1;
+	}
+
+	pci_rescan_bus(vmd->bus);
 	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
 			       "domain"), "Can't create symlink to domain\n");
 	return 0;
-- 
1.8.3.1

