Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC002C04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 11:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0B220660
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 11:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0B220660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbeKZWJW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:09:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:35461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730325AbeKZWJV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Nov 2018 17:09:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 03:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,281,1539673200"; 
   d="scan'208";a="103207562"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 26 Nov 2018 03:15:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CC0251E9; Mon, 26 Nov 2018 13:15:26 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
Date:   Mon, 26 Nov 2018 14:15:23 +0300
Message-Id: <20181126111526.56340-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recent systems with Thunderbolt ports may support IOMMU natively. This
means that the platform utilizes IOMMU to prevent DMA attacks over
externally exposed PCIe root ports (typically Thunderbolt ports)

The system BIOS marks these PCIe root ports as being externally facing
ports by implementing following ACPI _DSD [1] under the root port in
question:

  Name (_DSD, Package () {
      ToUUID ("efcc06cc-73ac-4bc3-bff0-76143807c389"),
      Package () {
          Package () {"ExternalFacingPort", 1},
	  Package () {"UID", 0 }
      }
  })

To make it possible for IOMMU code to identify these devices, we look up
for this property and mark all children devices (including the root port
itself) with a new flag (->is_untrusted). This flag is meant to be used
with all PCIe devices (not just Thunderbolt) that cannot be trusted in
the same level than integrated devices and may need to put behind full
IOMMU protection.

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 18 ++++++++++++++++++
 drivers/pci/probe.c     | 22 ++++++++++++++++++++++
 include/linux/pci.h     |  8 ++++++++
 4 files changed, 51 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8c7c4583b52d..4bdad32f62c8 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -31,6 +31,9 @@ static const guid_t prp_guids[] = {
 	/* Hotplug in D3 GUID: 6211e2c0-58a3-4af3-90e1-927a4e0c55a4 */
 	GUID_INIT(0x6211e2c0, 0x58a3, 0x4af3,
 		  0x90, 0xe1, 0x92, 0x7a, 0x4e, 0x0c, 0x55, 0xa4),
+	/* External facing port GUID: efcc06cc-73ac-4bc3-bff0-76143807c389 */
+	GUID_INIT(0xefcc06cc, 0x73ac, 0x4bc3,
+		  0xbf, 0xf0, 0x76, 0x14, 0x38, 0x07, 0xc3, 0x89),
 };
 
 static const guid_t ads_guid =
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 921db6f80340..84233cf46fc2 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -789,6 +789,23 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
+static void pci_acpi_set_untrusted(struct pci_dev *dev)
+{
+	u8 val;
+
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
+		return;
+	if (device_property_read_u8(&dev->dev, "ExternalFacingPort", &val))
+		return;
+
+	/*
+	 * These root ports expose PCIe (including DMA) outside of the
+	 * system so make sure we treat them and everything behind as
+	 * untrusted.
+	 */
+	dev->is_untrusted = val == 1;
+}
+
 static void pci_acpi_setup(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -798,6 +815,7 @@ static void pci_acpi_setup(struct device *dev)
 		return;
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
+	pci_acpi_set_untrusted(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
 	if (!adev->wakeup.flags.valid)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b1c05b5054a0..144623ae2e68 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1378,6 +1378,26 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 	}
 }
 
+static void set_pcie_untrusted(struct pci_dev *dev)
+{
+	struct pci_dev *parent;
+
+	/*
+	 * Walk up the device hierarchy and check for any upstream bridge
+	 * that has is_untrusted set to true. In that case treat this one
+	 * untrusted as well.
+	 */
+	parent = pci_upstream_bridge(dev);
+	while (parent) {
+		if (parent->is_untrusted) {
+			dev->is_untrusted = true;
+			break;
+		}
+
+		parent = pci_upstream_bridge(parent);
+	}
+}
+
 /**
  * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
  * @dev: PCI device
@@ -1638,6 +1658,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
+	set_pcie_untrusted(dev);
+
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 11c71c4ecf75..3fa73cc6cf68 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -396,6 +396,14 @@ struct pci_dev {
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	/*
+	 * Devices marked being untrusted are the ones that can potentially
+	 * execute DMA attacks and similar. They are typically connected
+	 * through external ports such as Thunderbolt but not limited to
+	 * that. When an IOMMU is enabled they should be getting full
+	 * mappings to make sure they cannot access arbitrary memory.
+	 */
+	unsigned int	is_untrusted:1;
 	unsigned int	__aer_firmware_first_valid:1;
 	unsigned int	__aer_firmware_first:1;
 	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
-- 
2.19.1

