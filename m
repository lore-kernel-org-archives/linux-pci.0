Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7032471415;
	Fri,  2 Oct 2026 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932240; cv=none; b=Ik4YNZyoGQPStcRkFIKavmmPh+QekdQuzZ0g/fJuzceFh8DslKo0RJVY5jbizyU3B6x99z0hVYtIHniADfHgfUYSZu7TSYdLtnKeUyd37CmRUYpKIRDafVhush07ChP59j9NaKL9Fb/2tkVk6TwtV5Z5B3b/TOHyCQpXZd+1DgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932240; c=relaxed/simple;
	bh=P3dFuqokFcRFJmvWtaCyogMxVu9F1KbWv7Xfgy3YLzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvPHOtse4aqVvJPMb9/KknpgM7UoD+WqxaEqQgTxmn3jQk578eBe1lVnQ1mEEQJN+NRYzJzrVnV0QEB23B6ju2pN8c8FmsST3x5+luewyRhTE8iD/GreBFEIKka4DlYPetrgTgjLIEdFkpnCoJmpfwq0qnZuY4vq5qeqiW/xf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KNrN+Cr+; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KNrN+Cr+"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hx30V6pZPzKmLf;
	Fri, 02 Oct 2026 11:10:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790932235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pstzo5fvE0XliYeRXe0YCmtTnhlZI2TOqbAnlLY00ic=;
	b=KNrN+Cr+wCJ1IF385iGwrbpa1kb/2gWdc6YLitRDsZeZkyyjYdIm3nktmokuFaaZjwsJmK
	0ghWf0kD7khiw+2le8fnXNMHtW0oZsZDsJ+r9m4IqdGE0FCS0DSIgaRE3SdPP45ppb2jRD
	n3Xftx0w79GYRkRAklnw+tnBf0Kxk0IvBjUvkoOQZ7pRgW2ic76s6mu83tHI0zcnJMu3Er
	XVi/ZgoZDCcbOrv1wJ/Y3r61wv5wjN3ET73NEwpjrTdeHonGv33hWtVo4/TX3HJZiHul30
	nxcPPLgYWH+IRcr4rbkZgHtP+IkvH2pkjCQ+0S3ud8E1Hs0WQ6zDAk+0FNzEMQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 1/2] PCI/ASPM: Clear ASPM Control on links without common ASPM support
Date: Fri,  2 Oct 2026 11:10:28 +0200
Message-ID: <20261002091029.2225203-2-stefan.roese@mailbox.org>
In-Reply-To: <20261002091029.2225203-1-stefan.roese@mailbox.org>
References: <20261002091029.2225203-1-stefan.roese@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ph3a6epf6k9iasxf9pa1sn9i9emzwder
X-MBO-RS-ID: 8bb87f77e519f2ef341

pcie_aspm_cap_init() returns early when the two ends of a link share
no ASPM state. It then never touches Link Control, so ASPM Control
keeps whatever the device came out of reset with. Per PCIe r7.0, sec
5.4.1.4, the result is undefined when L0s or L1 is enabled although
the other end of the link does not support it.

The Renesas uPD720201 xHCI (1912:0014) resets with LnkCtl 0x0003 (L0s
and L1 enabled), as the Mini Card CEM and M.2 specs ask for. Behind the
CPM Root Port of AMD Versal, which supports no ASPM, it only works
because the chip clears ASPM Control itself during the firmware
download by xhci-pci-renesas. Once the host has written Link Control,
even with the unchanged value, it no longer does so. Since commit
1a6845aaa6de ("PCI: Initialize RCB from pci_configure_device()")
pci_configure_rcb() does such a write for every endpoint, ASPM stays
enabled, and the first access to the xHCI BAR runs into completion
timeouts that hang the system.

Clear ASPM Control on every function of such a link, downstream
component first, and only where it is set. Update the saved state as
well, like the other ASPM Control writes in this file do. This matters
for the upstream port, whose state may have been saved before, e.g.
when a device is hot-added: a later pci_restore_state() after an AER or
DPC reset must not enable ASPM again.

Before (lspci -vvv -s 01:00.0):
  LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes, LnkDisable- CommClk-

After:
  pci 0000:01:00.0: ASPM: link has no common ASPM support, clearing ASPM Control
  LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-

Fixes: 1a6845aaa6de ("PCI: Initialize RCB from pci_configure_device()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>
---
Changes in v2:
- Make this the first patch and the actual fix, with Fixes: and stable
  (was patch 2/2 without tags)
- Update the saved state after clearing ASPM Control, so that
  pci_restore_state() does not enable ASPM again on a port whose state
  was saved before (sashiko)
- Cite PCIe r7.0, sec 5.4.1.4, for the undefined state (Bjorn)
- Reword the message to "link has no common ASPM support", which also
  covers links where both ends support different ASPM states
- Explain the Renesas mechanism and the RCB write in the message
---
 drivers/pci/pcie/aspm.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index f8e64971c6c3..8920508c9a83 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -931,6 +931,19 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
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
+	pci_info(pdev, "ASPM: link has no common ASPM support, clearing ASPM Control\n");
+	pcie_capability_clear_word(pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC);
+	pci_update_aspm_saved_state(pdev);
+}
+
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
@@ -947,11 +960,17 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
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

