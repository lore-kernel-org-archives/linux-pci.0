Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAFB3290BA
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762020; cv=none; b=rnvN9LAkOVmqL/kq1iYnha64lwqguP/wgjUr8hzy/qA8hE0se2dNKb5+hxFU1bN3nFXzSgA5GMZ3wbyHGV5KkvoUL7+R8W7tNPCgfRBaRONAtqFFlmjhhNRODsj20F2M5GWj0F4RQ8SGYm8E6xwlpX43NVspm7DTaYt2ffXZ8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762020; c=relaxed/simple;
	bh=UvZsCO1GmPNqzk7wzdyGpdQ11lkDL/idmR9vFBMt9ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c70+i7N8AvFEw/sEUbw5IQVugDJNTYRSkADzMt52HUatbjBz4xC3L1smRxLodFfwld8zVx6snyN7KNFKHWhveUit559zCyHsPRSm3U4L+I96FFuXD6gAYhp/CSKGwnQ+bmBtl93UA+NozqHhFsSF4nixSO4GRDOY4zFOJcolQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UcR4281s; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UcR4281s"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38deea72eebso15901a91.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784762017; x=1785366817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T8SbK/NCKyIaBwC1Thbd7+4CLdIOgq9KZMPr78i26/Y=;
        b=UcR4281swcGqQDX7RM8G0GiSweW0/XOWK5YE2HFboR66fIKXd1wx3cb4Dax1n/FXRh
         Y54RmdROIrOMOzsqYUntIPxJmlXTAQwI/xaTc4yhj50W3lFcDOirTteBHNXDmPrbvkCX
         9vKAj3ws1mpNaS21TlL3aG/wnil5EiYcTSPYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762017; x=1785366817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8SbK/NCKyIaBwC1Thbd7+4CLdIOgq9KZMPr78i26/Y=;
        b=dPTCq9ZtC0RwusNdiXvFn+pZpKaYzyWg5kt8FCdQrB7pEv+K3NBHvC4g3+vkXbiucj
         rNKRh1p1S9nLrCqgaOpt+3TOEcd6wfosi+WKJyhonNPYIydZPrdaKvAwfn/kKlhUX+7K
         v5CfE+xpEC6+NRdIxLE1fif4RPFg/T+7wSd2EQZUuKFDUhIK+7NxhR859u2dceVVFsx6
         3Pdn5RdYbP3FlTrBD0LyCrQtEi8nldBQQIFDFk35vvMZQO8blntlPcTR51vL5Wf21Nne
         k0aJsPBjUTlT5pc7XktNiODCNkCK0QaDdGMWRbUGiq6CpyaNuK5sb98Xp9O0WamjMprj
         x72w==
X-Forwarded-Encrypted: i=1; AHgh+RoUYaLLwC97va4SqCTWbUG3f6xc0+jUWzlFMIJMpxyi3nW7ccIvnHbItqJyPt3GDHjyNexPUxW1tm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0NHBGmfK7kf9dOKt4vFVOTVo5Lkp1SyPlbeziuz8xT6F4qI79
	TgfLfnlqqiV4y9EPDQceu5cwezQ02lPv9NzhY0CXN2OsN+jLz5nObkz75IPhlTWO/JfgpkN9H+d
	H0l/gCQ==
X-Gm-Gg: AR+sD11u0PWwyeMXibBeGug8N6PTAiz1rxdDXryawh55RYKQtn5dZZtt56sBMIZQao9
	nQLsjirkZUWjfE8NJrfKNO+cSjSiFjNKCVWIkWeO4K7a52Z/C42PM7DMcTGdxdjkFdE0bmIOK8L
	lLxafs7C3OejPjAf537Ck8/n1k2S5v4oCrO64tNz7GNkEe1+JsHCx5N9UMbKXvuKtaHaIRexWti
	vCQgz4fH1hpiYs0MKHYDGvAkGU/rl0zfrJxLMdKN/QQsehVKeEp8eDyFfhBq+497+bL6On6e9a/
	k45jdh4N5kZfTFn43Q0S1OFhor8mtlUmKEq1BfvowLQNnXPE4UFU99dVO4eN/jatz5O8dHHuGnv
	H0LvrvgDsu7uFZpep5RUmEOtnTNUgfFjhAFpBSnHoKCdDbUvPK6dcdEVD2xROSXCuHOyKM9wFhc
	YDrxKv9JjtybhYGy9+8nxjH+3geBgUQ8STTcvgaM+G7UW0kNa/91U=
X-Received: by 2002:a05:6a21:7a96:b0:3c0:9c19:65b9 with SMTP id adf61e73a8af0-3c44b26f282mr511168637.65.1784762017184;
        Wed, 22 Jul 2026 16:13:37 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f3fd:a899:78ad:64d4])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3147df09ac0sm11650219eec.16.2026.07.22.16.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 16:13:36 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4] PCI/portdrv: Allow probing even without child services
Date: Wed, 22 Jul 2026 16:09:42 -0700
Message-ID: <20260722160942.v4.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe port driver fails to probe if it finds no child services,
presumably under the assumption that the driver is not useful in that case.
However, the driver *can* still be useful for power management support --
namely, it still configures the port for runtime PM / D3, which may be
important for allowing a bridge to enter low power modes.

Thus, allow probe to succeed even if no IRQs and no child services are
available. This also mirrors existing behavior for ports that don't support
any portdrv services (PCIe hotplug, AER, DPC, PME, bwctrl), where we'd also
probe successfully.

This change is a bit more important after commit f5cd8a929c82 ("PCI: dwc:
Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI
controller"), because it's common for some DWC-based systems to:

  1. have only the "aer" and "pcie_pme" port services available and

  2. not define legacy INTx interrupts properly in their device tree.

After commit f5cd8a929c82, such systems may fail pcie_init_service_irqs()
and so exit with -ENODEV.

Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v4:
 * Between sashiko-bot / Mani / me / Bjorn, we agreed that deferring
   pci_set_master() may cause us to drop some MSIs:
     https://lore.kernel.org/all/af574zaysKnXjx15@google.com/
   So we revert to the v2 approach, with some small changes
 * Address some of Lukas's review comments:
     https://lore.kernel.org/all/al68lFtbq_Q4RCL2@google.com/
   Specifically:
     - ensure pcie_device_init() return code is checked
     - release IRQs (pci_free_irq_vectors()) when no services registered
       properly
 * Borrow some of Bjorn's commit message tweaks

Changes in v3:
 * Defer pci_set_master() until we really know we have some child
   service

Changes in v2:
 * Clear master when we have no child services

 drivers/pci/pcie/portdrv.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 2d6aa488fe7b..18ee190acc6e 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -330,7 +330,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
  */
 static int pcie_port_device_register(struct pci_dev *dev)
 {
-	int status, capabilities, i, nr_service;
+	int status, capabilities, i;
 	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
 
 	/* Enable PCI Express port device */
@@ -355,29 +355,29 @@ static int pcie_port_device_register(struct pci_dev *dev)
 	if (status) {
 		capabilities &= PCIE_PORT_SERVICE_HP;
 		if (!capabilities)
-			goto error_disable;
+			goto out;
 	}
 
 	/* Allocate child services if any */
-	status = -ENODEV;
-	nr_service = 0;
 	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
 		int service = 1 << i;
 		if (!(capabilities & service))
 			continue;
-		if (!pcie_device_init(dev, service, irqs[i]))
-			nr_service++;
+		if (pcie_device_init(dev, service, irqs[i]))
+			capabilities &= ~service;
 	}
-	if (!nr_service)
-		goto error_cleanup_irqs;
 
-	return 0;
+out:
+	/*
+	 * With no child services, we shouldn't need bus mastering or any IRQ
+	 * vectors we allocated.
+	 */
+	if (!capabilities) {
+		pci_free_irq_vectors(dev);
+		pci_clear_master(dev);
+	}
 
-error_cleanup_irqs:
-	pci_free_irq_vectors(dev);
-error_disable:
-	pci_disable_device(dev);
-	return status;
+	return 0;
 }
 
 typedef int (*pcie_callback_t)(struct pcie_device *);
-- 
2.55.0.229.g6434b31f56-goog

