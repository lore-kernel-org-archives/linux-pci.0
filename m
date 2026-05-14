Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6093FFAB4;
	Thu, 14 May 2026 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772694; cv=none; b=OvfhM27CV4uWX86WBFmlWyVl4obqVPCzegelwJYlxRWx/pYay3rpXctV/BGClPIHiaLZC3pdrdk5rO0uSgIP+LJZiL3gvltSnSswn3uKgHWJ0d2XtT4M2hU4TfZTL6TxnIDvjzcmmAANJYcHqfdqXpLV2NPQZBR9NFWllsuFxt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772694; c=relaxed/simple;
	bh=LiYaJOmBKU1FAMC6RdffSt+hxtJlS5cM7eTKtw5eDWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJDXka+HTXvcwimB1+6F6xsOrNXpZLfJ6e3SrAmcaR91+MbvD7mwHVP4qmWn3E49784vtWLRoQiz9wcWyqFGTJGfUCOVxtqFRIgqbM4OBhL3UZavXMb7DVMkvnvC9TQvm8K0zUtq49jDunXzooSG8eWlfpoJ5SW+sX3ScSdFH2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opsu9bxc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opsu9bxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2F5C2BCB3;
	Thu, 14 May 2026 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778772694;
	bh=LiYaJOmBKU1FAMC6RdffSt+hxtJlS5cM7eTKtw5eDWI=;
	h=From:To:Cc:Subject:Date:From;
	b=opsu9bxc48ChHYwfeRDyx8+YWq2rRN6rJmtKNdpeI5MNnoZtjjsjlMR7cABM0FnR+
	 cpJMRAmol3Ina24CuW8KamIentVElZ1Ps1rfFgWiFQan/87EsMMiyhMBf3du85pZPh
	 E5uFfJhXUrH/wTZfgKcekiWca9/SOI/5+HZqA5nPLDqO9jVEv5TLDgPFCT6m7p/1eF
	 xtqbPgQ7p4fvwCI83UVkzxDbirmHeX8lwuG06yVFV7jAsK3In6uzlwore4zNN7rNtC
	 bexmMQObxFCIV95qzp62InlYIk8JE50G2rE3tSs76zNJWlf94OE/kj9JxXnYGjnjKp
	 y8KJeED+2ZMcw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>,
	Sinan Kaya <okaya@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1] PCI: Wait for device readiness after D3hot -> D0uninitialized transition
Date: Thu, 14 May 2026 10:31:24 -0500
Message-ID: <20260514153124.404060-1-bhelgaas@google.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a device that advertises No_Soft_Reset == 0, a transition from D3hot to
D0uninitialized is a soft reset, and the resulting internal device state is
undefined.

A transition from D3hot to D0uninitialized requires a minimum delay of
10 msec before accessing the device, but after that delay, the device is
permitted to respond to config requests with RRS completion status if it
needs more time to initialize (PCIe r7.0, sec 2.3.1).

Call pci_dev_wait() after pci_power_up() performs a D3hot->D0uninitialized
transition to ensure the device is ready to accept config accesses, as is
done after the similar transition in pci_pm_reset().

If the device is already ready, this is essentially a no-op except for one
additional config read.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc00090..9d0fc9fbb76a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1301,6 +1301,16 @@ int pci_power_up(struct pci_dev *dev)
 	pci_power_t state;
 	u16 pmcsr;
 
+	/*
+	 * When setting power state to D0, platform_pci_set_power_state()
+	 * ensures main power is on.  If it puts the device in D0, it also
+	 * completes any required delays after the transition; if it leaves
+	 * the device in D1, D2, or D3hot, we use the PM Capability to
+	 * transition to D0.
+	 *
+	 * In all cases, the device is either Configuration-Ready or
+	 * inaccessible upon return.
+	 */
 	platform_pci_set_power_state(dev, PCI_D0);
 
 	if (!dev->pm_cap) {
@@ -1341,10 +1351,14 @@ int pci_power_up(struct pci_dev *dev)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
 
 	/* Mandatory transition delays; see PCI PM 1.2. */
-	if (state == PCI_D3hot)
+	if (state == PCI_D3hot) {
 		pci_dev_d3_sleep(dev);
-	else if (state == PCI_D2)
+		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
+			pci_dev_wait(dev, "power up D3hot->D0uninitialized",
+				     PCIE_RESET_READY_POLL_MS);
+	} else if (state == PCI_D2) {
 		udelay(PCI_PM_D2_DELAY);
+	}
 
 end:
 	dev->current_state = PCI_D0;
-- 
2.51.0

