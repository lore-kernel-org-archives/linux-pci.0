Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31319DF62;
	Fri, 13 Feb 2026 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771024472; cv=none; b=FmkBijFCdryG1P+MuL+TG0ZoWFNOh7cvw9/hfT3k9FS0cvUo8uXymzK3l1dQpGhFfR6Sn+cNQWp7TLKl/leBQ6vwJs7XuQs+X+yBhJZmxj4EZYTFsbyHBCEbgLvjTSP8WkLWEY2msfrQMifevqlr9jVX9ESaELhjVcyLYvccRmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771024472; c=relaxed/simple;
	bh=wYGNF1nxZpoaf6dMmtzaubZAynCAXw+s8xnmxfQcypQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/sb83OQowGIF3TFCLe4jV+fr8T0JiVmGpxJOZvrO/bCIMvlZGRoltYDh/lNqjm5Z6L4NaVShlm7UNEXIbAR/plhoxu37sIUoaRFHqBp3M8dIFFl+puQd7+MFdZtYLvxce97fNaLbKNbOPPI0CctKGkZ09LLGh8DUO9H+//E4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4yRTrTM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4yRTrTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771024471; x=1802560471;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wYGNF1nxZpoaf6dMmtzaubZAynCAXw+s8xnmxfQcypQ=;
  b=M4yRTrTM/E+/vB34UhxOM7DRo9L5JLEOLXGqr4jo5JeQ2dooa24GK7p0
   RcQBgck7Sdh5b/BGOP9CiUaN4PQiO7GUG3nDnKOI8/k6xR0vS/A1+SoQy
   tCifXVnLWvs2MqmVA5FCgwD6gYs9x/H1FWH/OtAF7t7gW+226rUyvQpCG
   KTI9rBKBCQJ/o0j6mphSyIflRQjhHbHB+3XT0e4uInXM9eswPmcIbArIy
   IACCEGzmKhfq6EExVUXKu4A5fpEE5vyNW/eNMA3kkZlFmWXon//MLfwXe
   IEmTH2Df5jiH4SdqrrsKQzTPiuDYst25H+kxtwQwftY5vMtsnGsTwTiy5
   Q==;
X-CSE-ConnectionGUID: AgQPIBd2R4WkvZunmNIvTQ==
X-CSE-MsgGUID: xnbdjfRaTs6VnpPKgind2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="72257492"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="72257492"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 15:14:31 -0800
X-CSE-ConnectionGUID: v+MC8pHkQHO7xp1b6b84hA==
X-CSE-MsgGUID: CI8nFKoyQAmVDojyjI/uaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="211713511"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 15:14:30 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with unreliable PME status
Date: Fri, 13 Feb 2026 15:14:28 -0800
Message-ID: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
is not yet available.

Work around this issue by disabling runtime PM for affected ports,
keeping them in D0 during runtime operation. This ensures hotplug
events are handled via direct interrupts rather than relying on
unreliable PME-based wakeup.

During system suspend/resume, PCIe ports are resumed unconditionally
when coming out of system sleep due to DPM_FLAG_SMART_SUSPEND set by
pcie_portdrv_probe(), and pciehp re-enables interrupts and checks slot
occupation status during resume.

The quirk is applied only to Catlow PCH PCIe root ports (device IDs
0x7a30 through 0x7a4b). Catlow CPU PCIe ports are not affected as
they are not hotplug-capable.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Removed hack in hotplug driver and disabled runtime PM on affected ports.
 * Fixed the commit log and comments accordingly.

 drivers/pci/quirks.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 280cd50d693b..779cd65b1a8a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6340,3 +6340,52 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * Intel Catlow Lake PCH PCIe root ports have a hardware issue where
+ * PME status registers (PME Status and PME Requester_ID in Root Status)
+ * are not reliably updated during D3hot to D0 transitions, even though
+ * PME interrupts are delivered correctly.
+ *
+ * When a hotplug event occurs while the port is in D3hot, the PME
+ * interrupt fires but the status registers remain empty. This prevents
+ * the PME handler from identifying the event source, leaving the port
+ * in D3hot and causing the hotplug driver to miss the event.
+ *
+ * Disable runtime PM to keep these ports in D0, ensuring hotplug events
+ * are handled via direct interrupts.
+ */
+static void quirk_intel_catlow_pcie_no_pme_wakeup(struct pci_dev *dev)
+{
+	pm_runtime_disable(&dev->dev);
+	pci_info(dev, "Catlow PCH port: PME status unreliable, disabling runtime PM\n");
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
-- 
2.43.0

