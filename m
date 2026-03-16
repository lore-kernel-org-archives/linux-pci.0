Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE730358368;
	Mon, 16 Mar 2026 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773698896; cv=none; b=Zf2Nvt+TQvVu69RYv/RZysO9EAWG2dqs0nHIYIajuz4WA4QuKaYQ9PS2AojssA0EnYn+wmRG9b9v4ISqV2QE9VKpvSovLGU6UOepgeMK+nXnSPtjMnyjQCzHBir5xXp0V6/1iX1170o4qFxVU7kvDPW3sHQu44GqFd9MtWxCGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773698896; c=relaxed/simple;
	bh=DTWTB7lxSyL6vpOQKnliWW5kg0j+nId3t6eF0lkT/mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DM+P9wKFxrQ727KFCpjvREnXzJdsKp/3EU+9EhXM+xZ1AhB+CfODq+9nCAuDpf5D8XcGXqjaa9pEpiSQkdZemGbwj75sMvFz+FP6uF6+WyrnhECafOenYgOH2aYVMATQiozT6NEIjVAVvh8TOA2EAOikNtNR/JBhOlnTPOCS8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdyfwz+6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdyfwz+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773698894; x=1805234894;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DTWTB7lxSyL6vpOQKnliWW5kg0j+nId3t6eF0lkT/mg=;
  b=kdyfwz+6tu5nn/bp7ZRMPN8d0nM0/nvBmqHd/F6dMskVxkPe9f8Y3h8I
   xxbHi3oRFpxapBLkH+vaPZDFjhyh1f5MvlbvuD3BYUsoRYj4UrkiNhPT7
   UNTbGYZMglTLMCjE5rp5A8hJm25wC2gVjS859Qen/d/pL7ErdzCj04Y7x
   RaEPYXf7ptQivytWcBfqEd33AkftJPNEmxrMizMeLnJjGGZh6VvLyaJvC
   zX7S831cGFkGgQScqktC/xv31Nxt6gDUqVblBf00PEQq5fLjqE2QEPN0G
   bav/7ALcMUkDKH5IFIBN17SMooYXvPTsxOwosdpMuaqJhbQ8boUvtJ16l
   w==;
X-CSE-ConnectionGUID: 4wPXzExfTYu2DJ682ugMxQ==
X-CSE-MsgGUID: VVpigXx3Sn69uJhqDDkF+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="92110440"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="92110440"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 15:08:13 -0700
X-CSE-ConnectionGUID: MISg57uNQae9SLU7wCpxKQ==
X-CSE-MsgGUID: qdrXNUAlQ5Cq2h4OfDI6jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226742505"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 15:08:12 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with unreliable PME status
Date: Mon, 16 Mar 2026 15:08:06 -0700
Message-ID: <20260316220807.2433661-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

1. After a hot-remove event, the PCIe port runtime suspends to D3hot.
   pciehp_suspend() disables hotplug interrupts (HPIE) to rely on
   PME-based wakeup.

2. When a hot-add occurs while the port is in D3hot, a PME interrupt
   fires as expected to wake the port.

3. However, the PME interrupt handler finds the PME_Status and
   PME_Requester_ID registers unpopulated, preventing identification
   of which device triggered the PME. The handler returns IRQ_NONE,
   leaving the port in D3hot.

4. Because the port remains in D3hot with HPIE disabled, the hotplug
   event is lost and the newly inserted device is not recognized.

The PME interrupt delivery mechanism itself works correctly;
interrupts arrive reliably. The problem is purely the missing status
register updates. Verification via IOSF-SideBand (IOSF-SB) backdoor
reads confirms that these registers remain empty when the PME
interrupt fires. Neither BIOS nor kernel code is clearing these
registers.

This issue is present in all steppings of Catlow Lake PCH and affects
customers in production deployments. A public hardware errata document
is not yet available.

Work around this issue by introducing a PCI_DEV_FLAGS_PME_UNRELIABLE
flag for affected ports. When this flag is set, pciehp keeps hotplug
interrupts (HPIE) enabled during D3hot instead of disabling them and
relying on PME. This allows hotplug events to be delivered via direct
interrupts rather than through the broken PME status mechanism.

The port still enters D3hot for power savings during runtime suspend,
avoiding the power regression that would occur with pm_runtime_disable().
Testing confirms this approach does not impact PC6/PC10 package C-state
residency.

During system suspend/resume, the behavior is unchanged. Ports are
resumed unconditionally when coming out of system sleep due to
DPM_FLAG_SMART_SUSPEND set by pcie_portdrv_probe(), and pciehp
re-enables interrupts and checks slot occupation status during resume.

The quirk is applied only to Catlow PCH PCIe root ports (device IDs
0x7a30 through 0x7a4b). Catlow CPU PCIe ports are not affected as
they are not hotplug-capable.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v2:
 * Switched from pm_runtime_disable() to PCI_DEV_FLAGS_PME_UNRELIABLE
   flag approach to avoid power regression (feedback from Rafael and Lukas)
 * Keep hotplug interrupts (HPIE) enabled during D3hot instead of
   preventing D3hot entry entirely
 * Port still enters D3hot for power savings; testing confirms no impact
   on PC6 package C-state residency
 * Modified pciehp to check pme_is_broken() before disabling/enabling
   hotplug interrupts during suspend/resume
 * Made quirk comment generic to cover both PME notification and status
   update issues, with Catlow Lake specifics documented separately

Changes since v1:
 * Removed hack in hotplug driver and disabled runtime PM on affected ports.
 * Fixed the commit log and comments accordingly.

 drivers/pci/hotplug/pciehp_core.c | 11 ++++--
 drivers/pci/quirks.c              | 60 +++++++++++++++++++++++++++++++
 include/linux/pci.h               |  2 ++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 1e9158d7bac7..f854ef9551c3 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -260,13 +260,20 @@ static bool pme_is_native(struct pcie_device *dev)
 	return pcie_ports_native || host->native_pme;
 }
 
+static bool pme_is_broken(struct pcie_device *pcie)
+{
+	struct pci_dev *pdev = pcie->port;
+
+	return !!(pdev->dev_flags & PCI_DEV_FLAGS_PME_UNRELIABLE);
+}
+
 static void pciehp_disable_interrupt(struct pcie_device *dev)
 {
 	/*
 	 * Disable hotplug interrupt so that it does not trigger
 	 * immediately when the downstream link goes down.
 	 */
-	if (pme_is_native(dev))
+	if (pme_is_native(dev) && !pme_is_broken(dev))
 		pcie_disable_interrupt(get_service_data(dev));
 }
 
@@ -318,7 +325,7 @@ static int pciehp_resume(struct pcie_device *dev)
 {
 	struct controller *ctrl = get_service_data(dev);
 
-	if (pme_is_native(dev))
+	if (pme_is_native(dev) && !pme_is_broken(dev))
 		pcie_enable_interrupt(ctrl);
 
 	pciehp_check_presence(ctrl);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be7..bfb52735c4e3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6380,3 +6380,63 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * Some PCIe root ports have a hardware issue where PME-based wakeup
+ * from D3hot is unreliable. This can manifest as either PME interrupts
+ * not being delivered, or PME status registers (PME Status and PME
+ * Requester_ID in Root Status) not being reliably updated even when
+ * interrupts are delivered.
+ *
+ * When a hotplug event occurs while the port is in D3hot, the system
+ * relies on PME to wake the port back to D0. If PME notification or
+ * status updates are unreliable, the PME handler either doesn't get
+ * invoked or cannot identify the event source. This leaves the port in
+ * D3hot with hotplug interrupts disabled, causing hotplug events to be
+ * missed.
+ *
+ * Mark affected ports with PCI_DEV_FLAGS_PME_UNRELIABLE to keep
+ * hotplug interrupts (HPIE) enabled during D3hot instead of relying on
+ * PME-based wakeup. This allows hotplug events to be delivered via
+ * direct interrupts while still permitting the port to enter D3hot for
+ * power savings.
+ *
+ * Known affected hardware:
+ * - Intel Catlow Lake PCH PCIe root ports: PME status registers are
+ *   not updated during D3hot to D0 transitions, even though PME
+ *   interrupts are delivered correctly.
+ */
+static void quirk_pcie_pme_unreliable(struct pci_dev *dev)
+{
+	dev->dev_flags |= PCI_DEV_FLAGS_PME_UNRELIABLE;
+	pci_info(dev, "PME status unreliable, keeping hotplug interrupts enabled in D3hot\n");
+}
+/* Apply quirk to Catlow Lake PCH root ports (0x7a30 - 0x7a4b) */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a30, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a31, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a32, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a33, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a34, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a35, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a36, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a37, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a38, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a39, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3a, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3b, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3c, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3d, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3e, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3f, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a40, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a41, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a42, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a43, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a44, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a45, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a46, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a47, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a48, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a49, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4a, quirk_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4b, quirk_pcie_pme_unreliable);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..9761351c5d70 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -253,6 +253,8 @@ enum pci_dev_flags {
 	 * integrated with the downstream devices and doesn't use real PCI.
 	 */
 	PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIAS = (__force pci_dev_flags_t) (1 << 14),
+	/* Device PME is broken or unreliable */
+	PCI_DEV_FLAGS_PME_UNRELIABLE = (__force pci_dev_flags_t) (1 << 15),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.43.0

