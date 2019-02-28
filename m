Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BBAC10F00
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 20:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4312084F
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 20:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbfB1UwV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:52:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:16411 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733234AbfB1UwU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Feb 2019 15:52:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 12:52:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,424,1544515200"; 
   d="scan'208";a="130192189"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga003.jf.intel.com with ESMTP; 28 Feb 2019 12:52:19 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
        robert.moore@intel.com, erik.schmauss@intel.com, ruscur@russell.cc
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        keith.busch@intel.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v1 1/3] PCI/ACPI: Add _OSC based negotiation support for DPC
Date:   Thu, 28 Feb 2019 12:49:47 -0800
Message-Id: <54b368cc00409d00b57208c33808c49cc97fa6f1.1551382061.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1551382061.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1551382061.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per PCI Firmware Specification, r3.2 ECN
(https://members.pcisig.com/wg/PCI-SIG/document/12614), OS can use
bit 7 of _OSC Control Field to negotiate control over Downstream Port
Containment (DPC) configuration of PCIe port.

After _OSC negotiation, firmware will Set this bit to grant OS control
over PCIe DPC configuration and Clear it if this feature was requested
and denied, or was not requested.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/pci_root.c         | 6 ++++++
 drivers/pci/pcie/portdrv_core.c | 3 ++-
 drivers/pci/probe.c             | 1 +
 include/linux/acpi.h            | 3 ++-
 include/linux/pci.h             | 1 +
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 707aafc7c2aa..a60261e50b08 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -154,6 +154,7 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
 	{ OSC_PCI_EXPRESS_AER_CONTROL, "AER" },
 	{ OSC_PCI_EXPRESS_CAPABILITY_CONTROL, "PCIeCapability" },
 	{ OSC_PCI_EXPRESS_LTR_CONTROL, "LTR" },
+	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
 };
 
 static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
@@ -499,6 +500,9 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 			control |= OSC_PCI_EXPRESS_AER_CONTROL;
 	}
 
+	if (IS_ENABLED(CONFIG_PCIE_DPC))
+		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
+
 	requested = control;
 	status = acpi_pci_osc_control_set(handle, &control,
 					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
@@ -927,6 +931,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		host_bridge->native_pme = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
 		host_bridge->native_ltr = 0;
+	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
+		host_bridge->native_dpc = 0;
 
 	pci_scan_child_bus(bus);
 	pci_set_host_bridge_release(host_bridge, acpi_pci_root_release_info,
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index f458ac9cb70c..9d510bbbaf1b 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -247,7 +247,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
+	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER &&
+	    (pcie_ports_native || host->native_dpc))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	return services;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 257b9f6f2ebb..ca8dbd280deb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -557,6 +557,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
+	bridge->native_dpc = 1;
 
 	return bridge;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 87715f20b69a..d42dae820410 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -517,7 +517,8 @@ extern bool osc_pc_lpi_support_confirmed;
 #define OSC_PCI_EXPRESS_AER_CONTROL		0x00000008
 #define OSC_PCI_EXPRESS_CAPABILITY_CONTROL	0x00000010
 #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
-#define OSC_PCI_CONTROL_MASKS			0x0000003f
+#define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
+#define OSC_PCI_CONTROL_MASKS			0x000000ff
 
 #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
 #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c2f082..f024508c3456 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -499,6 +499,7 @@ struct pci_host_bridge {
 	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
 	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
+	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
-- 
2.20.1

