Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFEB40DFD3;
	Tue, 28 Apr 2026 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348871; cv=none; b=iGGU/duC5Wv7zH/b4SefTFGuf7+fQLwkDDvauriZQ9DNhl/kLE8zLCVIjzl2oPzdbigF4xpYuM5CYXyzhpV+ZVjYiDynu5KLgqu7kilXnJ0ynqwk7wZKN8pi6Xr36E1/JLFbrokLhA11KLlUUTgNgtZoWgfaTXJiE9T94mTc84M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348871; c=relaxed/simple;
	bh=6yJDQrFYOnSimHYpjK9gZ6lZp3jY/9xvbZuj1IWjkWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Im+ib5GJ4wNvKKAJNm4po8IqLeZGK9SPJLhp6WlpTrK2gyM/MnZLnPei8ph3eAIC36OQXze99vukRpX+czN+P4efCmX0DlA+nMdY72SW9q18QcaQ6tbCQfnZZkCV0tVS+ddaF3m755ho8h7oMKeaiciUv58BG5ifqYMYWA3cFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeoHnv+/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeoHnv+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1C5C2BCAF;
	Tue, 28 Apr 2026 04:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777348871;
	bh=6yJDQrFYOnSimHYpjK9gZ6lZp3jY/9xvbZuj1IWjkWE=;
	h=From:To:Cc:Subject:Date:From;
	b=aeoHnv+/fK/IjbEEmCfCOIYlwLOzgRnqb6yUYHIwx3hc8aLdXi6iypqDi/R6K+PrI
	 Dlj7A68pqvo1SAiEYzMJvZXkt5CcSyHohtUe5jhjfIOV3TFCtkU93RO8I/vrjPHFSN
	 2KOR4JSSIGmVez3Jlghd4MQ1U+02WTCnxPi1pIWv1l/CCFC7vrjZ/FTdbckU5hWq7t
	 4h3+wlPeSrxrKr345oGkg4YaxkiCmHRbLE0LIctAUA26DLGcBMAWpIaza+jIvXj/zc
	 K2PclFDbOAgD1Cc0xrtpSzvut1y8KkmPMyXs+DCbwc6SP3zQiANDTgZtpdAQf2eK9u
	 GxbQqKWCwpTVw==
From: "Carlos Bilbao (Lambda)" <carlos.bilbao@kernel.org>
To: bhelgaas@google.com
Cc: eduardo.habkost@lambdal.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bilbao@vt.edu,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: [PATCH] PCI/ASPM: Don't reconfigure ASPM entering low-power state
Date: Mon, 27 Apr 2026 21:01:04 -0700
Message-ID: <20260428040104.78524-1-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <carlos.bilbao@kernel.org>

Reconfiguring ASPM when a device transitions to low-power state can enable
L1.1/L1.2 substates on the PCIe link at a time when the device is sleeping
and may be unable to exit them. ASPM should be reconfigured on D0 entry
(resume), not on the way down.

pci_set_low_power_state() calls pcie_aspm_pm_state_change() after writing
D3hot to PCI_PM_CTRL. pcie_aspm_pm_state_change() resets link->aspm_capable
to link->aspm_support and then calls pcie_config_aspm_path(), which can
enable ASPM L1.1/L1.2 substates on the PCIe link. If the device cannot
recover the link from L1.2 while in D3hot, subsequent config space reads
return 0xFFFF ("device inaccessible") and pci_power_up() fails with message
"Unable to change power state from D3hot to D0, device inaccessible".

This was observed on NVIDIA H100 SXM5 GPUs bound to vfio-pci when Linux
runtime PM suspends them to D3hot: the GPU becomes permanently inaccessible
and disappears from the PCIe bus.

The call to pcie_aspm_pm_state_change() in pci_set_low_power_state() was
restored by commit f93e71aea6c6 ("Revert "PCI/ASPM: Remove
pcie_aspm_pm_state_change()""), which reverted
commit 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()").
The revert was necessary because the
removal broke suspend/resume on certain platforms that required ASPM to be
reconfigured on D0 entry. However, the revert restored the call in both
pci_set_full_power_state() (D0 entry) and pci_set_low_power_state()
(low-power entry).

Only the D0-entry call is needed to fix the suspend/resume regression. The
low-power-entry call is harmful: reconfiguring ASPM immediately after
putting a device into D3hot can enable link substates that the device or
platform cannot exit while the device is sleeping.

Remove the pcie_aspm_pm_state_change() call from pci_set_low_power_state().
ASPM will still be reconfigured correctly when the device returns to D0 via
pci_set_full_power_state().

Fixes: f93e71aea6c6 ("Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"")
Link: https://lore.kernel.org/r/20240102232550.1751655-1-helgaas@kernel.org
Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
---
 drivers/pci/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2ccb8e122f2..8b47887019f9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1542,9 +1542,6 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
 				     pci_power_name(dev->current_state),
 				     pci_power_name(state));
 
-	if (dev->bus->self)
-		pcie_aspm_pm_state_change(dev->bus->self, locked);
-
 	return 0;
 }
 
-- 
2.50.1 (Apple Git-155)

