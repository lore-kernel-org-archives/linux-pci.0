Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D46830B529;
	Tue, 10 Feb 2026 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744158; cv=none; b=Jz2HhF90mTz6XUXKQpPvE/ymD6320Mu634me5VVaPwWux8ZBOySwx3L/9uBAS6oiskj7xtGJnW+yx0kpjoyZ/QvxYNcS5hLDjxVFaAfNu72iqBj1vv1ylGM9EbVRfZMf9j/rBASP0TKbfTl2KvHjUqITCeiMidwiEiVv3qXwEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744158; c=relaxed/simple;
	bh=VVlNz7tYeQ5WIseRbGYbp+7DNMt/gMdrva10TSLvSXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9eOrIVapKz7odM+q/yRbVbvyJTBTmgLn1BLdj7Ajvd6dMiy0lYiqj1I3UP71xULSR+3CZVKqBGv2okGpED4pmHMhqLoC8iH6scDY/0AyGEUQ2NLXMAE0Wvgrfxcfdv3bxXMH3GvHhlv6RaxdngEwtOlHxpfAosDZ+LnFZ5cMnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZKMdPYi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZKMdPYi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770744156; x=1802280156;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VVlNz7tYeQ5WIseRbGYbp+7DNMt/gMdrva10TSLvSXM=;
  b=VZKMdPYiSMmhfUmnYsJN4qpf+DJaP4kuCEWaIFTil3QZvhvOLP48IlKY
   Ob8jMJhqit1IDG3d6tXKVIEfasKwkzX7OCsayNe5aY3FdNQJf/uZAdHZA
   3QetnpNgBYvb53Ldf/aAC9HdF90YOFpZfImGz+uPBZA+4LMwMkLIwEFuL
   77X0l9++aWqlzr/KaYEvRhSsIwziZdIPVaue6/Yj/ih/E1jvMweqfvwea
   t3gXZuHy8HgNn4TsemS3Gyyi7uxdpT6ykc2lOSDQ3D46XPZVeWXL673BI
   yYmjV2BbNmlrF8yAILQevriwFjb4Nak06V3VV0UzRxTR6wtIwyq+VvPzv
   A==;
X-CSE-ConnectionGUID: TN9esrLvS+Ka+63kICjh3Q==
X-CSE-MsgGUID: ZqCZ2CdDQ1++cTKWpxjzYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75505383"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="75505383"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 09:22:36 -0800
X-CSE-ConnectionGUID: KfNcJ/zoT9CFxk6Yvuddhw==
X-CSE-MsgGUID: lNvkrqX2Ree5ScvOaQd6pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211081698"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 09:22:36 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] PCI: pciehp: Fix hotplug on Catlow Lake with unreliable PME status
Date: Tue, 10 Feb 2026 09:22:31 -0800
Message-ID: <20260210172231.1465275-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Intel Catlow Lake platforms, PCH PCIe root ports do not reliably
update PME status registers (PME Status and PME Requester_ID in the
Root Status register) during D3hot to D0 transitions, even though PME
interrupts are delivered correctly.

This issue manifests during PCIe hotplug operations as follows:

1. After a hot-remove event, the PCIe port transitions to D3hot and
   the hotplug interrupt enable (HPIE) flag is disabled as the port
   enters low power state.

2. When a hot-add occurs while the port is in D3hot, a PME interrupt
   fires as expected to wake the port.

3. However, the PME interrupt handler finds the PME_Status and
   PME_Requester_ID registers unpopulated, preventing identification
   of which device triggered the PME. The handler returns IRQ_NONE,
   leaving the port in D3hot.

4. Because the port remains in D3hot with HPIE disabled, the hotplug
   driver ignores the hot-add event, resulting in the newly inserted
   device not being recognized.

The PME interrupt delivery mechanism itself works correctly;
interrupts arrive reliably. The problem is purely the missing status
register updates. Verification via IOSF-SideBand (IOSF-SB) backdoor
reads confirms that these registers remain empty when the PME
interrupt fires. Neither BIOS nor kernel code is clearing these
registers.

This issue is present in all steppings of Catlow Lake PCH and affects
customers in production deployments. A public hardware errata document
is not yet available. While the document is being published, we need a
quirk to address the issue for existing customers.

Alternative approaches were considered to avoid modifying the pciehp
driver. We attempted to keep these ports in D0 state by calling
pm_runtime_disable() in the quirk. Although this approach works for
most cases, it fails to provide wakeup when the system enters suspend
state. Another option of modifying the PME configuration to force
pci_target_state() to select D0 also did not help, as runtime PM
still transitions the port to D3hot.

Add a PCI quirk (PCI_DEV_FLAGS_NO_PME_WAKEUP) for affected Catlow
Lake PCH PCIe root ports that allows the hotplug interrupt handler to
process events regardless of the port power state, bypassing the
broken PME-based wakeup dependency.

The quirk is applied only to Catlow PCH PCIe root ports (device IDs
0x7a30 through 0x7a4b). Catlow CPU PCIe ports are not affected as
they are not hotplug-capable. Systems with reliable PME signaling
continue to operate normally.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |  4 ++-
 drivers/pci/quirks.c             | 45 ++++++++++++++++++++++++++++++++
 include/linux/pci.h              |  2 ++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bcc51b26d03d..e5036bb79a08 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -631,7 +631,9 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	 * in the Slot Control register (PCIe r4.0, sec 6.7.3.4).
 	 */
 	if (pdev->current_state == PCI_D3cold ||
-	    (!(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE) && !pciehp_poll_mode))
+	    (!(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE) &&
+	     !pciehp_poll_mode &&
+	     !(pdev->dev_flags & PCI_DEV_FLAGS_NO_PME_WAKEUP)))
 		return IRQ_NONE;
 
 	/*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 280cd50d693b..b22eb8554ab0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6340,3 +6340,48 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * When a PCIe port is in D3hot, the hotplug driver depends on PME
+ * to wake the port back to D0 and then process any hotplug-related
+ * state changes. On Intel Catlow Lake platforms, PCH PCIe root ports
+ * do not reliably update PME state during D3hot to D0 transitions.
+ *
+ * Apply a quirk to disable PME-based wakeup requirements for these
+ * specific ports, allowing the hotplug driver to handle events
+ * independently of the port power state.
+ */
+static void quirk_intel_catlow_pcie_no_pme_wakeup(struct pci_dev *dev)
+{
+	dev->dev_flags |= PCI_DEV_FLAGS_NO_PME_WAKEUP;
+	pci_info(dev, "Catlow PCH port: PME unreliable, bypassing PME-based wakeup for hotplug\n");
+}
+/* Apply quirk to Catlow Lake PCH root ports (0x7a30 - 0x7a4b) */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a30, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a31, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a32, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a33, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a34, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a35, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a36, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a37, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a38, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a39, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3a, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3b, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3c, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3d, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3e, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3f, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a40, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a41, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a42, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a43, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a44, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a45, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a46, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a47, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a48, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a49, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4a, quirk_intel_catlow_pcie_no_pme_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4b, quirk_intel_catlow_pcie_no_pme_wakeup);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b5cc0c2b9906..e4a95b36e4a0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -248,6 +248,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
 	/* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX reads */
 	PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force pci_dev_flags_t) (1 << 13),
+	/* Device does not reliably update PME status to wakeup from D3 to D0 */
+	PCI_DEV_FLAGS_NO_PME_WAKEUP = (__force pci_dev_flags_t) (1 << 14),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.43.0

