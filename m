Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AAD50B435;
	Wed, 30 Sep 2026 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779633; cv=none; b=YVPUetzmEWi6dCkXNDcY2IRlEyI6TFRSNXRo8GpnrzNrPJYNFBVonXi4i1fzWwd1A5bI+KcvymmRb+p4cV2avYPO+2+8KwRMDttVrFdx+cJJe8U3HVhc5+2EG77xFKIYCAL47gRmZX/4jbIBhOxJ76F5xCdpVPfe0i+HBMXa85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779633; c=relaxed/simple;
	bh=xLaWugtGaL5V+YjiA1ZObsRg1NBjZeHZ+OWSjIgpcB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsEt21ZVrERU4ciE+3JurY+JfnTJSMbiaI9BmhusRKOUp5LqANAtPlmFlN5YqpY0MZ78dm9wvPYnW4nDsgQ3xt51lLtSqUvS97PFCsqg6fojC4DJUZU/x4qr2+8uG/ecbUndOdmZvDBtBOWjwemlvTVFBu6DU0yaWoBu4zz8c5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=i2YhaRLG; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i2YhaRLG"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hvyYW4CcdzKmy5;
	Wed, 30 Sep 2026 16:46:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790779615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mONE5Z4yykxdHO0aIpNw/R01NrY2zchyszmmvZjcC0I=;
	b=i2YhaRLGyxe+FUrYBAasuLnxbtkHslVM5T8GiUnoAz4Qh6CISajlY9bRbLP2DBEuN5HjP1
	WHjtq41/7GhyBwKE/5O4KSzDzUIK3rU482ViP5fINiiZjs/XVy0uqo1VDvuOQ3WFjqRRbw
	W28rgKVdL9q0fH0DLHrQKolLU+9jLI+D/B3XoWSwFqQK2OIMtdXWFrbro1EvCU4ikI90XL
	TAY7SNpeMCgH4S6nWk/30wtlDCBsOnGZC5TfKGtunY1W4hF90pag9M0uHXD7hmV+egCawq
	N6aesABbAClVMjZEdQeDtutk1q2qZehYnTntEgm94xzYUDHM34EL693/qeFaDQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 2/2] PCI/ASPM: Clear ASPM Control on links without common ASPM support
Date: Wed, 30 Sep 2026 16:46:50 +0200
Message-ID: <20260930144650.3701516-3-stefan.roese@mailbox.org>
In-Reply-To: <20260930144650.3701516-1-stefan.roese@mailbox.org>
References: <20260930144650.3701516-1-stefan.roese@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 761cddb35362e1cf6e7
X-MBO-RS-META: 5rzdgd48i49hncxc5fc4x3aqqoyh18n5

pcie_aspm_cap_init() returns early when the two ends of a link share
no ASPM state. It then never touches Link Control, so ASPM Control
keeps whatever the device came out of reset with. A device that
enables ASPM by default, against a port that cannot do it, keeps ASPM
enabled, which the spec does not allow.

The Renesas uPD720201 xHCI (1912:0014) is such a device: it resets
with LnkCtl 0x0003 (L0s and L1 enabled) and sits behind the CPM Root
Port of AMD Versal, which supports no ASPM. It only works because the
chip clears ASPM Control itself during its firmware download, and it
stops doing so once the host has written Link Control.

Clear ASPM Control on every function of such a link, downstream
component first, and only where it is set.

Before (lspci -vvv -s 01:00.0):
  LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes, LnkDisable- CommClk-

After:
  pci 0000:01:00.0: ASPM: link supports no ASPM, clearing ASPM Control
  LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>
---
 drivers/pci/pcie/aspm.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index f8e64971c6c3..13d7a6d3f6ad 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -931,6 +931,18 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 	}
 }
 
+static void pcie_aspm_clear_aspmc(struct pci_dev *pdev)
+{
+	u16 lnkctl;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnkctl);
+	if (!(lnkctl & PCI_EXP_LNKCTL_ASPMC))
+		return;
+
+	pci_info(pdev, "ASPM: link supports no ASPM, clearing ASPM Control\n");
+	pcie_capability_clear_word(pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC);
+}
+
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
@@ -947,11 +959,17 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/*
 	 * If ASPM not supported, don't mess with the clocks and link,
-	 * bail out now.
+	 * bail out now. A device may still come out of reset with ASPM
+	 * Control set, which the rest of this code never touches for
+	 * such a link. Clear it, downstream component first.
 	 */
 	if (!(parent->aspm_l0s_support && child->aspm_l0s_support) &&
-	    !(parent->aspm_l1_support && child->aspm_l1_support))
+	    !(parent->aspm_l1_support && child->aspm_l1_support)) {
+		list_for_each_entry(fn, &linkbus->devices, bus_list)
+			pcie_aspm_clear_aspmc(fn);
+		pcie_aspm_clear_aspmc(parent);
 		return;
+	}
 
 	/* Configure common clock before checking latencies */
 	pcie_aspm_configure_common_clock(link);
-- 
2.56.0

