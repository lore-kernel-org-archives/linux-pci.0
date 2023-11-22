Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF532156DF
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UigE2PLb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D956C433CA;
	Wed, 22 Nov 2023 06:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633059;
	bh=8eQyWYUksEgtJePWJFrjrGwzZQU8VhshlTpr/ZFKaS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UigE2PLboE0/TFtOk3N95hWEzGbqWwhhJFSNTQgcPq1ELvVubMPGv9YHg1RPdjus6
	 rsh1eLv/La4kpIflyRsu+rHWwBMtb8ck7uixaw7gP4/G0ReI1KpkzSRIBc+AuAt4Ai
	 O+mW4xOYLCIYLbe7b4JVVlRUUuFTcuT0kcOT3HeAAkMNhYNR+uc6RWshyYQpH5zAiC
	 6vopVKKMGhpIN1e7HDqXZz3f5CmTX1inzY+dk2nrwMUMIzwaEG5L1aqywtiEsdTFSu
	 yQ6mJSuSf46TxwykNk0Pmtg5G7VHYEz6xseAySTEhmnFcqPvXbhTR10UeYc+r4yZoD
	 jjBn8wPgS7G8A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 06/16] PCI: portdrv: Use PCI_IRQ_INTX
Date: Wed, 22 Nov 2023 15:03:56 +0900
Message-ID: <20231122060406.14695-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the PCI Express Port Bus Driver, use the macro PCI_IRQ_INTX instead
of the now deprecated PCI_IRQ_LEGACY macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/pcie/portdrv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..bb65dfe43409 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -187,15 +187,15 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	 * interrupt.
 	 */
 	if ((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi())
-		goto legacy_irq;
+		goto intx_irq;
 
 	/* Try to use MSI-X or MSI if supported */
 	if (pcie_port_enable_irq_vec(dev, irqs, mask) == 0)
 		return 0;
 
-legacy_irq:
-	/* fall back to legacy IRQ */
-	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
+intx_irq:
+	/* fall back to INTX IRQ */
+	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_INTX);
 	if (ret < 0)
 		return -ENODEV;
 
-- 
2.42.0

