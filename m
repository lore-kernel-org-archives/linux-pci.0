Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57470509F19;
	Wed, 30 Sep 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779631; cv=none; b=Y46ZXvcY7raRx5o6nA3WSOhWSs6nSho79f4QW6UiDzY3qH5ej6SoDWwe658KGCe8/ImRLV6skSPewEFdCi5/XJ+pWdTaIAofy83FsAQH0tfQQ1pLu1G01A6IRnhrYTqKcU6L3nfTTXLJ5PbP9eYKqbdF3/HISCE71pcmDa8Fv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779631; c=relaxed/simple;
	bh=P0gYmt5B7UIuIhXQRAa97rh/C9fF+F6OpSajoGILOPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMrTb+6BWSl0Au+ZcL7okqJcI/7d/oDM536klG4PMpQjem8f0PM8jSu2cr5YbbGc97c/f7eaRAAsVyjb9Uh7QCCUpDMOa15EaFDl8iKJlqh9R+dnysS2OwEHE31uIHJEPY6E6JH4i5RkBoKj5/gQo3VTEqjy5pBrOeCd4yqrXQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gACvY/G1; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gACvY/G1"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hvyYT6QZKz8tx2;
	Wed, 30 Sep 2026 16:46:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790779613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UhMwutnBrljFXZgJ3lBP0GFIcwnWhOBYqHu1M3eDO8=;
	b=gACvY/G1Z67DjQ9ayEWDQdo+P/d90e5RBkbvhfcajqsLpXgNcdYLTBDcWwwtvv8NM8gWG6
	SGaTKjyDgM0yeRIwvVcrZBpW8MEFPKrxd1JxZtVIEMAV6FCEPpGphUauiG1rJ0u7CgN3Iy
	giaDtXZm/VNXyNDu2KaJo6lf+vUxEgnIu8O1Rkcd66oaAzt2tUapxFwbWWdLp7cVhT43dR
	sMGcN5vgZJFmOpknDeOAfQCTolFXygKaMbuWe4inM3/DM/h8yyPO54g1owzkd079sdt7Gq
	M9vs1eSpwqnSSXjWCBiTYSGhNXQ4xJILSIMjUWystASpJ1qNPKyI9DEqq5hGHA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 1/2] PCI: Write RCB only when it changes
Date: Wed, 30 Sep 2026 16:46:49 +0200
Message-ID: <20260930144650.3701516-2-stefan.roese@mailbox.org>
In-Reply-To: <20260930144650.3701516-1-stefan.roese@mailbox.org>
References: <20260930144650.3701516-1-stefan.roese@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0bad432e0277a7f6722
X-MBO-RS-META: 3dsc7d4bdxnzon9fu64n1co73kk5fb79

pci_configure_rcb() does a read-modify-write of the Link Control
register of every endpoint at enumeration, even when RCB already has
the right value. Some devices react to any write of this register.

The Renesas uPD720201 xHCI (1912:0014) comes out of reset with ASPM L0s
and L1 enabled in Link Control. On a link whose Root Port supports no
ASPM, nothing else writes that register before the driver loads, and
the chip clears ASPM Control itself during the firmware download. After
a host write, even of the unchanged value 0x0003, it no longer does
so. ASPM stays enabled, and the first access to the xHCI BAR runs into
PCIe completion timeouts that hang the system.

Seen on an AMD Versal board (CPM Root Port without ASPM support): the
hang bisects to this commit, reverting it fixes it, and on a kernel
without it a single setpci write of the unchanged value reproduces it.

Read Link Control first and write it only when RCB has to change.

Fixes: 1a6845aaa6de ("PCI: Initialize RCB from pci_configure_device()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>
---
 drivers/pci/probe.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 721daf5c5184..35e794df3be4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2426,7 +2426,7 @@ static void pci_configure_serr(struct pci_dev *dev)
 static void pci_configure_rcb(struct pci_dev *dev)
 {
 	struct pci_dev *rp;
-	u16 rp_lnkctl;
+	u16 rp_lnkctl, lnkctl, rcb;
 
 	/*
 	 * Per PCIe r7.0, sec 7.5.3.7, RCB is only meaningful in Root Ports
@@ -2448,10 +2448,17 @@ static void pci_configure_rcb(struct pci_dev *dev)
 		return;
 
 	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &rp_lnkctl);
-	pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_RCB,
-					   (rp_lnkctl & PCI_EXP_LNKCTL_RCB) ?
-					   PCI_EXP_LNKCTL_RCB : 0);
+	rcb = rp_lnkctl & PCI_EXP_LNKCTL_RCB;
+
+	/*
+	 * Write Link Control only when RCB actually changes. Some devices
+	 * react to any write of this register, even one with an unchanged
+	 * value.
+	 */
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
+	if ((lnkctl & PCI_EXP_LNKCTL_RCB) != rcb)
+		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_RCB, rcb);
 }
 
 static void pci_configure_device(struct pci_dev *dev)
-- 
2.56.0

