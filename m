Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734312;
	b=i3RMBrvaz0czBPR6bMW09Jgq/IhIxZz/lgCrbo5OaBWkaxsdTOoKnq9Td6KpbAUgAfVN
	 gFlgCKkIHy2k2tzkqA0rbKROB1aUqVErgp3QTaZ0qpiE0PtNwb6rdvfZ/VBB0YJYsMTf3
	 Wb2jgcagPu/VD9RilMgn5T6qiOM1F6ca42hM/5vthtBeLZy4lL8VH0e74SoQi8RCBXD8u
	 zpyLQMjSXZnzFd6iXpi+sp/239h77uNImQNwooZUWIF6UqukR3Bgpcr+56BIT+3nB8BLU
	 j/P340jpnj299nPvqU+YCMT2JSHivhefKD1Pe30BhFlKZKbej1pnsY9YJ0BsT/9xcjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734312;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fpRHSy5Wk90abinShF8DYIzGLjDiD1Fzayizm0ssOZQ=;
	b=QRU41IqW+9QyEmPfy+Ey6iezs/OXnUKMN1B9LrFEafJ9xstUiFLOaN+3odv8V0I+jsVl
	 5/lOQER1LmKcnMno1LJxeqyqJu7Lid7ED62snLWrxiLS0IOx3L43GJ+a8bsRykn6s3Sh6
	 7BEMoiE8mrcKvdONA4lV/+WiGfNIz+HORzGSjypPp3vWLomUq03NEsJczO5s8ui2T2cUR
	 cnAp3eBsoQzesXY2caR56BpY4pZ2Am6JCBydnmyhYzXROc2KlnOCvFj2UBi0PxxMREX+y
	 A0+k/yLwQGmbgamXim8kNM0Zqd+jxez1rCPUuOz01p35fBVIc2tazACeE5z+YRsek8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UDy3LsgX;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A92606A326;
	Tue,  3 Nov 2026 19:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5A92606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UDy3LsgX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793734312; x=1825270312;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XjVGroLiUUxQlsJNr0Xwqj1gJt2JP8//Ek+2bWlmDNc=;
  b=UDy3LsgXuRVmQycVPW6x6C+H2DQrpgRU7Bdvnss7tY4mAV88XKejZe4g
   v0nFIbujdVR2tq1+kkdf73NCToyrUMNgNLCo+otw6gs8fNmM+8mKSF5XP
   SZMm2O9wwaM5lLhyBm5GsJhoG3Mc9ka6yIThx7zOPZEdww/+576GreeCz
   VNsyCgmEKsPS8VTyrCHfmO3bVn+rXFMBHsMvTGXEE6761d0bftTip4ySz
   mklzFdSKC8EQRnBi1Sn4msMSxGtAfhSV7dxsKI1shwQFpHZ6My4wzQAnc
   cTWOFsnPC+EzJrfVULhpgGXilbYOMEmQElrZ7nUV7iMbmEcfKbnQLbEoU
   g==;
X-CSE-ConnectionGUID: KQyAYsNWRdWxOFrOPjG35g==
X-CSE-MsgGUID: E9tJAlakQqu5sc5ePl5lRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2481815"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2481815"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 11:31:50 -0800
X-CSE-ConnectionGUID: QkkO/JOtRf2gdTzWVY78NA==
X-CSE-MsgGUID: OYZudGdzTTyQZUpgElIIAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6416203"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 11:31:49 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] PCI/PME: Resume Catlow Lake Root Ports on PME with PME Status clear
Date: Tue,  3 Nov 2026 11:31:36 -0800
Message-ID: <20261103193136.2410148-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Catlow Lake PCH Root Ports do not set PME Status in the Root
Status register when they generate a PME for their own hotplug event.
The PME interrupt itself is delivered.  PMEs from devices below the Root
Port are reported correctly.

PME and hotplug share the same interrupt.  When a hotplug Root Port
runtime suspends to D3hot, pciehp disables hotplug interrupts and relies
on PME to resume the Port.  On a hot-add the Port signals PME, but Root
Status stays clear.  pcie_pme_irq() then returns IRQ_NONE.  pciehp_isr()
also returns IRQ_NONE because hotplug interrupts are disabled.  The Port
stays in D3hot and the new device is never enumerated.

Mark the affected Root Ports with a new PCI_DEV_FLAGS_PME_UNRELIABLE
flag.  If such a Port interrupts while not in D0 and PME Status is
clear, pcie_pme_irq() resumes the Port.  pciehp re-enables hotplug
interrupts on runtime resume, and pciehp_check_presence() finds the new
device.  pciehp itself is unchanged.

The workaround only applies to quirked Ports that are not in D0.  AER,
DPC and bandwidth notification also share the interrupt and stay enabled
in D3hot.  If one of them fires while a quirked Port is in D3hot, the
Port is resumed without need and runtime suspends again later.

This affects all steppings of the Catlow Lake PCH.  A public erratum is
not available yet.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Link: https://lore.kernel.org/linux-pci/ara-_IPXV_i90if1@wunner.de/
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Changes since v4:
 * Moved the workaround from pciehp to the PME driver (Lukas). pciehp
   now keeps clearing HPIE on suspend as before (Bjorn).
 * Noted in the commit log and in pcie_pme_irq() that PME and hotplug
   share the same interrupt (Bjorn).
 * Dropped the PME Requester ID reference, since the code doesn't use
   it (Bjorn).
 * Dropped the "D3hot to D0 transitions" wording (Bjorn).
 * Updated the quirk comment and message for the PME driver approach.
 * Dropped Reviewed-by from Lukas since the approach changed.
 * The v4 approach in pciehp also fixes the issue on Catlow Lake. I am
   happy to go back to it if that is preferred.

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

v4: https://lore.kernel.org/linux-pci/20260323223056.3119060-1-sathyanarayanan.kuppuswamy@linux.intel.com/
v3: https://lore.kernel.org/linux-pci/20260316220807.2433661-1-sathyanarayanan.kuppuswamy@linux.intel.com/
v2: https://lore.kernel.org/linux-pci/20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com/
v1: https://lore.kernel.org/linux-pci/20260210172231.1465275-1-sathyanarayanan.kuppuswamy@linux.intel.com/

 arch/x86/pci/fixup.c   | 46 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/pme.c | 24 +++++++++++++++++++++-
 include/linux/pci.h    |  2 ++
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 795d81c7a4de..eb3703e1cdbe 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -1180,3 +1180,49 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
 #endif /* CONFIG_SUSPEND */
+
+/*
+ * Intel Catlow Lake PCH Root Ports do not set PME Status in the Root
+ * Status register for a PME they generate for their own hotplug events,
+ * although the PME interrupt is delivered.  PMEs from devices below the
+ * Port are reported correctly.
+ *
+ * pciehp disables hotplug interrupts when the Port runtime suspends and
+ * relies on PME to resume it.  With PME Status clear, pcie_pme_irq()
+ * ignores the interrupt, the Port stays in D3hot and the hot-add is
+ * lost.  Mark these Ports so that the PME driver resumes them instead.
+ */
+static void intel_pcie_pme_unreliable(struct pci_dev *dev)
+{
+	dev->dev_flags |= PCI_DEV_FLAGS_PME_UNRELIABLE;
+	pci_info(dev, "PME status unreliable, resuming port on PME interrupt in D3hot\n");
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
diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 4996cc4789f3..56c22e416788 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -276,11 +276,33 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
 	spin_lock_irqsave(&data->lock, flags);
 	pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
 
-	if (PCI_POSSIBLE_ERROR(rtsta) || !(rtsta & PCI_EXP_RTSTA_PME)) {
+	if (PCI_POSSIBLE_ERROR(rtsta)) {
 		spin_unlock_irqrestore(&data->lock, flags);
 		return IRQ_NONE;
 	}
 
+	if (!(rtsta & PCI_EXP_RTSTA_PME)) {
+		spin_unlock_irqrestore(&data->lock, flags);
+
+		/*
+		 * Some Root Ports don't set PME Status for a PME they
+		 * generate for their own hotplug events.  PME shares its
+		 * interrupt with hotplug and the other Port services, so
+		 * only do this while the Port is not in D0.  Then PME is
+		 * the only interrupt it can signal for such events, so
+		 * resume it and let pciehp pick up the event.
+		 */
+		if ((port->dev_flags & PCI_DEV_FLAGS_PME_UNRELIABLE) &&
+		    port->current_state != PCI_D0) {
+			pci_dbg(port, "PME Status clear in %s, resuming Port\n",
+				pci_power_name(port->current_state));
+			pci_wakeup_event(port);
+			pm_request_resume(&port->dev);
+			return IRQ_HANDLED;
+		}
+		return IRQ_NONE;
+	}
+
 	pcie_pme_interrupt_enable(port, false);
 	spin_unlock_irqrestore(&data->lock, flags);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..d3915a3d59b9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -266,6 +266,8 @@ enum pci_dev_flags {
 	 * integrated with the downstream devices and doesn't use real PCI.
 	 */
 	PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIAS = (__force pci_dev_flags_t) (1 << 14),
+	/* Root Port does not set PME Status for its own hotplug PMEs */
+	PCI_DEV_FLAGS_PME_UNRELIABLE = (__force pci_dev_flags_t) (1 << 15),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.43.0

