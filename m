Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D436138F629;
	Mon, 18 May 2026 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131560; cv=none; b=oM/Z9yLEpK5uC7xeIiaiaUriwS0vksA+rV62nLBw0jCQtAjp0GQIzsnb/grzuBw7cKg2IYMcRc661zrS9vsByjYja6i5zPhlYYNa2DBemwSDDDKU2p+JVeYun9IRf5bm13Wo2tThweMzvj/28igTxDdGaDTvhHtBNDFyDlVfKzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131560; c=relaxed/simple;
	bh=OVGv8aD9oXyZXd/JxYCzbnzBbcXTfxSshxXccMPVbbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knqChj7BmHZcvwlRX3yVLVzz99hoRzVftVtHJPu5Otk3sPCRiLN+0n/mTfWB77FgrH8lPJu0yzrJDPc9bLKfj8aw3nGGrC7smBf73wsr9x23oNfGuMcAlx8QLnnarwefrJHcJq6qDe8mps98Ryx4yPJq4s5MNyq61awn0h7jOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txn5EHUf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txn5EHUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FDBC2BCB7;
	Mon, 18 May 2026 19:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779131560;
	bh=OVGv8aD9oXyZXd/JxYCzbnzBbcXTfxSshxXccMPVbbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Txn5EHUfjGTcjZQHQhg1k0bOY2zDFe/gk8VFc1MhWr8MjUswp99fTOaHfz+SQSd7L
	 TGMbCl/Fyru7jVgWu9sH63Yjn3Mst0E4vvKMqblmX8gwiM151DOfXZAhHyODsWpZIJ
	 kRtNeAxJAYQEqs+UiyN3zbKhDoLz6RzPKy/5uRmTT7BOWbQe/zZn+vPMC91j4q43VE
	 rAlSMrrBL7gl37TXiD8LkRN4894rCl7qXDMcE9Om8jY9NBVi18NxigW1NLi6cvotiO
	 oNwFm/fu2keXpgTcvvJsELUjUKNuQ4EFk5ACnHKTArCbJz0FRl/EDmU7fojtmpcu7A
	 yeYY+Ag+D1XXA==
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
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/2] PCI: Wait for device readiness after D3hot -> D0uninitialized transition
Date: Mon, 18 May 2026 14:12:19 -0500
Message-ID: <20260518191220.636213-3-bhelgaas@google.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260518191220.636213-1-bhelgaas@google.com>
References: <20260518191220.636213-1-bhelgaas@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <helgaas@kernel.org>

For a device that advertises No_Soft_Reset == 0, a transition from D3hot to
D0uninitialized is a soft reset, and the resulting internal device state is
undefined.

Per PCIe r7.0, sec 2.3.1, a transition from D3hot to D0uninitialized
mandates a minimum 10 ms delay before accessing the device. Following this
delay, the device is permitted to respond to initial configuration requests
with a Request Retry Status (RRS) completion status if it needs more time
to initialize.

Call pci_dev_wait() after pci_power_up() performs a D3hot->D0uninitialized
transition to ensure the device is ready to accept config accesses, as is
done after the similar transition in pci_pm_reset().

If the device is already ready, this is essentially a no-op except for one
additional config read.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5a9af0bb2c71..8228d2782f95 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1300,7 +1300,18 @@ int pci_power_up(struct pci_dev *dev)
 	bool need_restore;
 	pci_power_t state;
 	u16 pmcsr;
+	int ret;
 
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
@@ -1341,10 +1352,19 @@ int pci_power_up(struct pci_dev *dev)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
 
 	/* Mandatory transition delays; see PCI PM 1.2. */
-	if (state == PCI_D3hot)
+	if (state == PCI_D3hot) {
 		pci_dev_d3_sleep(dev);
-	else if (state == PCI_D2)
+		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
+			ret = pci_dev_wait(dev, "power up D3hot->D0uninitialized",
+					   PCIE_RESET_READY_POLL_MS);
+			if (ret) {
+				dev->current_state = PCI_D3cold;
+				return -EIO;
+			}
+		}
+	} else if (state == PCI_D2) {
 		udelay(PCI_PM_D2_DELAY);
+	}
 
 end:
 	dev->current_state = PCI_D0;
-- 
2.51.0

