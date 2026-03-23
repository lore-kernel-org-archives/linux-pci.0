Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B503043B2;
	Mon, 23 Mar 2026 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305067; cv=none; b=TO5YcMVoRUDW//swSxjH+SUptNPbHQU1fHAEHiEkPxceXe56Fk5ZRAg0XWVrAibaZHON2C+fUVZsAr4KFIz75ii9+arJTWkSHHCLloNjfbNo0oGO9S1i65hbX0vanrgOG4k5vtIj8aMSYbI8/bkexqLb3u7qLuZfvQHviPcrCWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305067; c=relaxed/simple;
	bh=ZStGS8oUUnLu4O3f6NbH3i5dbB3mOi41Qf2CgLTzWq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKN6RZyJFCyiobDsgw9ncVDyvM3v5w1wSl/N6caRfryKxhx/D4ACDQd7+kZ+r+m8KCfH8qodj0Z1UD01rgjavE1MHB9E5pAaXKCmZNw8AfCUMDqWALZ8tSxcJHa2R+qUrcDdWdHi3CnRzWUX1iOd5GDcsweZ96oYwyQBsAgy3eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2ZOrbXv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2ZOrbXv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774305065; x=1805841065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZStGS8oUUnLu4O3f6NbH3i5dbB3mOi41Qf2CgLTzWq0=;
  b=Y2ZOrbXv7r2Gdo92RvcWx5kC/RXMFRuKLdWAPSgLwZpMfcIE0KGxInDy
   ADKlcCgr9iprQlbTwCoqAb7YAS5/ymjxUyK/CdgqjOlW9laASaFHxAnz6
   H5tJOxHXMVd2DC++ZxZgTICxzAUfdmuctm6YhA4mC77s//62YhgPPqqd7
   BQKyhnVqTMuFmdIyQQ52WFS6R7zyFIkuA650cluDStyPWI0JVk6uA5HKW
   sW4xqyzFZ9UqWqVTr961KZfOoEnK1LoGFOR4hhLbSbyNmqwk20nGU3Ach
   qZVYU/WEgvoGP91sNCxZK6d+6/+6jfoaQp9OZcN4R99cSfG8ZqeRGkaTe
   A==;
X-CSE-ConnectionGUID: b+EKM/S+Sze6Qsc/xT/b+A==
X-CSE-MsgGUID: HI3DcfqnS9W5QJLmC66FZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="79168752"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="79168752"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:31:04 -0700
X-CSE-ConnectionGUID: xaq4ULihQ8yIwJm5esGgrA==
X-CSE-MsgGUID: 9RfZJCPTTvK3RzrTM2tB/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228643971"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:31:04 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] PCI: pciehp: Fix hotplug on Catlow Lake with unreliable PME status
Date: Mon, 23 Mar 2026 15:30:56 -0700
Message-ID: <20260323223056.3119060-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---

Changes since v3:
 * Moved quirk from drivers/pci/quirks.c to arch/x86/pci/fixup.c (Lukas)
 * Renamed function to intel_pcie_pme_unreliable for x86-specific context.
 * Added Reviewed-by tag from Lukas

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

 arch/x86/pci/fixup.c              | 60 +++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_core.c | 11 ++++--
 include/linux/pci.h               |  2 ++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b301c6c8df75..e62a653b07c4 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -1081,3 +1081,63 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
 #endif /* CONFIG_SUSPEND */
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
+static void intel_pcie_pme_unreliable(struct pci_dev *dev)
+{
+	dev->dev_flags |= PCI_DEV_FLAGS_PME_UNRELIABLE;
+	pci_info(dev, "PME status unreliable, keeping hotplug interrupts enabled in D3hot\n");
+}
+/* Apply quirk to Catlow Lake PCH root ports (0x7a30 - 0x7a4b) */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a30, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a31, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a32, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a33, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a34, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a35, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a36, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a37, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a38, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a39, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3a, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3b, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3c, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3d, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3e, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3f, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a40, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a41, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a42, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a43, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a44, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a45, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a46, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a47, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a48, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a49, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4a, intel_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4b, intel_pcie_pme_unreliable);
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

