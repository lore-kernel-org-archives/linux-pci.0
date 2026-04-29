Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9886C3CE495;
	Wed, 29 Apr 2026 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486020; cv=none; b=RDryy15t1fta6vq0+fs6JIL+h1DMDKHdkWUjQDnyDq5v1iMNgyCUU9Uec9dmwntzBf6IcoPQndFASpeUFdHzyMYjX/cHihrrBLqoS7t8hDWeKBTvIrmkm98laOrZ+MLrurc6bpx1O/UC8sOgW0AK/Oz/LqCzNr28eWuT/Dudeuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486020; c=relaxed/simple;
	bh=R3M1Wd/Iys/ZSh84oAQZ8j5ob1LKTDhbBg/wAEZStYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPHNo3ad8wFB4wgzQdN1KZ/5j1cI05XqA0GF9sLgpPKQs/1tabnem2Iou/V51fum7WF/Fu0JlTXEsd+vCao2Tior8cZ3zXTdxpRw87SPdJeOosqR37vai3MmbQ4fuP7hws9scCj0NLGHpPj+ujS+MTEo83C3n7KxUmgNlsIqK98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcEfI34o; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcEfI34o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777486017; x=1809022017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R3M1Wd/Iys/ZSh84oAQZ8j5ob1LKTDhbBg/wAEZStYU=;
  b=FcEfI34oAewrquGu/atRxUKOTyxfPOY1evkliLbtErSH1nRLIN0y6u6V
   vBQkoTtt26TFRV51MXYI+M/IDjueodIjwrjF4I2yjkE1BMOjOkHq862Y8
   aJrlB1DVX8gtvlaHJvE6GPdes3ZWTX2LFVnDjMDIT9+evGSsjiuILfuH6
   owTUk+Imp9BJn73iOytzEYLCpx3GUFVnIESt46Ma08YpROkDW6IKk5lpG
   T/9VDlfbNPB9XU0OKrvKiPPI8T8R3yTcWOaPipNBHfRmkP+C9f6kEkoaF
   ja+NMiZ8eM0ggIzFrTqXKme1Vyyx6T4oLRwOS3fFwO9T/GeRnStomNe03
   g==;
X-CSE-ConnectionGUID: U+CjtDMNTsuQ7UXH47hLVQ==
X-CSE-MsgGUID: 3p4y/EbGQRuWuYmD/WglcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78532274"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78532274"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:06:55 -0700
X-CSE-ConnectionGUID: mR8rcttgQ56FZ9VCwOI0gw==
X-CSE-MsgGUID: ng0XwoOFRSCNLdXC0cwaMw==
X-ExtLoop1: 1
Received: from iherna2-mobl4.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.221.251])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:06:53 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: "David E . Box" <david.e.box@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [RFC PATCH 1/4] pcie/aspm: Add debug logging for aspm policy config
Date: Wed, 29 Apr 2026 13:06:43 -0500
Message-ID: <20260429180647.197072-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429180647.197072-1-thomas.falcon@intel.com>
References: <20260429180647.197072-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include additional logging for ASPM and Clock PM state changes
keeping track of code flow and enabled power saving states.

Example output after enabling powersupersave policy:

[  130.179249] pcieport 0000:80:1b.0: Updating ASPM state
[  130.179256] igc 0000:81:00.0: ASPM: Disabling ASPM on this device before disabling parent
[  130.179368] pcieport 0000:80:1b.0: ASPM: Disabling ASPM before applying configuration
[  130.179373] pcieport 0000:80:1b.0: ASPM: Configure L1 substates
[  130.179391] pcieport 0000:80:1b.0: ASPM: Configure ASPM state on upstream device
[  130.179395] igc 0000:81:00.0: ASPM: Configure ASPM state on downstream device
[  130.179401] pcieport 0000:80:1b.0: ASPM: enabled states: L1 ASPM-L1.1 PCI-PM-L1.1 PCI-PM-L1.2
[  130.179416] pcieport 0000:00:06.0: Updating ASPM state
[  130.179418] nvme 0000:01:00.0: ASPM: Disabling ASPM on this device before disabling parent
[  130.179422] pcieport 0000:00:06.0: ASPM: Disabling ASPM before applying configuration
[  130.179425] pcieport 0000:00:06.0: ASPM: Configure L1 substates
[  130.179435] pcieport 0000:00:06.0: ASPM: Configure ASPM state on upstream device
[  130.179438] nvme 0000:01:00.0: ASPM: Configure ASPM state on downstream device
[  130.179442] pcieport 0000:00:06.0: ASPM: enabled states: L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2

Suggested-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 drivers/pci/pcie/aspm.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 925373b98dff..cd23c1462502 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -372,6 +372,9 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 	/* Need nothing if the specified equals to current state */
 	if (link->clkpm_enabled == enable)
 		return;
+
+	pci_dbg(link->pdev, "%s Clock PM\n",
+		enable ? "Enabling" : "Disabling");
 	pcie_set_clkpm_nocheck(link, enable);
 }
 
@@ -961,11 +964,14 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 	state &= (link->aspm_capable & ~link->aspm_disable);
 
 	/* Can't enable any substates if L1 is not enabled */
-	if (!(state & PCIE_LINK_STATE_L1))
+	if (!(state & PCIE_LINK_STATE_L1)) {
+		pci_dbg(parent, "ASPM: L1 not enabled, disabling L1 substates\n");
 		state &= ~PCIE_LINK_STATE_L1SS;
+	}
 
 	/* Spec says both ports must be in D0 before enabling PCI PM substates*/
 	if (parent->current_state != PCI_D0 || child->current_state != PCI_D0) {
+		pci_dbg(parent, "ASPM: Both ports are not in D0, disable PCI PM L1 substates unless explicitly enabled\n");
 		state &= ~PCIE_LINK_STATE_L1_SS_PCIPM;
 		state |= (link->aspm_enabled & PCIE_LINK_STATE_L1_SS_PCIPM);
 	}
@@ -973,6 +979,8 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 	/* Nothing to do if the link is already in the requested state */
 	if (link->aspm_enabled == state)
 		return;
+	pci_dbg(parent, "Updating ASPM state\n");
+
 	/* Convert ASPM state to upstream/downstream ASPM register state */
 	if (state & PCIE_LINK_STATE_L0S_UP)
 		dwstream |= PCI_EXP_LNKCTL_ASPM_L0S;
@@ -997,16 +1005,34 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 	 * Sec 7.5.3.7 also recommends programming the same ASPM Control
 	 * value for all functions of a multi-function device.
 	 */
-	list_for_each_entry(child, &linkbus->devices, bus_list)
+	list_for_each_entry(child, &linkbus->devices, bus_list) {
+		pci_dbg(child, "ASPM: Disabling ASPM on this device before disabling parent\n");
 		pcie_config_aspm_dev(child, 0);
+	}
+	pci_dbg(parent, "ASPM: Disabling ASPM before applying configuration\n");
 	pcie_config_aspm_dev(parent, 0);
 
-	if (link->aspm_capable & PCIE_LINK_STATE_L1SS)
+	if (link->aspm_capable & PCIE_LINK_STATE_L1SS) {
+		pci_dbg(parent, "ASPM: Configure L1 substates\n");
 		pcie_config_aspm_l1ss(link, state);
+	}
 
+	pci_dbg(parent, "ASPM: Configure ASPM state on upstream device\n");
 	pcie_config_aspm_dev(parent, upstream);
-	list_for_each_entry(child, &linkbus->devices, bus_list)
+	list_for_each_entry(child, &linkbus->devices, bus_list) {
+		pci_dbg(child, "ASPM: Configure ASPM state on downstream device\n");
 		pcie_config_aspm_dev(child, dwstream);
+	}
+
+	pci_dbg(parent, "ASPM: enabled states:%s%s%s%s%s%s%s%s\n",
+		FLAG(state, L0S_UP, " L0s-Upstream"),
+		FLAG(state, L0S_DW, " L0s-Downstream"),
+		FLAG(state, L1, " L1"),
+		FLAG(state, L1_1, " ASPM-L1.1"),
+		FLAG(state, L1_2, " ASPM-L1.2"),
+		FLAG(state, L1_1_PCIPM, " PCI-PM-L1.1"),
+		FLAG(state, L1_2_PCIPM, " PCI-PM-L1.2"),
+		FLAG(state, CLKPM, " ClockPM"));
 
 	link->aspm_enabled = state;
 
-- 
2.43.0

