Received: from cstnet.cn (unknown [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105739E6D7;
	Fri, 23 Jan 2026 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769148503; cv=none; b=rVU49mzThjusUdBNofQkuaFVnuouUJcZIrFjoNv/zMgq5C3Rpt9HdNeT/LOZF/DfypwMndaNTYaXRP0+RJ3m7R8QdIwU4hSFkH6aG0oEYGVblH2m32rOA9hTKHsfPTM6lfWh8dMn7xKawdNTD0YzraNIjzQJO3iFdn91wAofCgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769148503; c=relaxed/simple;
	bh=nL5YkPZ0wTrRsXcHak8bE444tj5jtmzQhYeiixvWQ5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7M4oR29yUOsv6Fxbc8JK2GH17xm2XDytZdfppEc6+hsvFkQ3c/jpade5S+us+7a05wDC4aDHcdKYv4Mt/TJcQW6Fz4H4nWquMfV1H10Ly0qR/rpLuUiihTcmyhlt26wDg3sunLfYLjlIwMmc/51YsIX1pisa5rKthVrY/cGgCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowACnPBAiEHNp9tMuBg--.1678S3;
	Fri, 23 Jan 2026 14:07:32 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Fri, 23 Jan 2026 14:07:28 +0800
Subject: [PATCH v3 1/4] PCI/MSI: Conservatively generalize no_64bit_msi
 into msi_addr_mask
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-pci-msi-addr-mask-v3-1-9f9baa048524@iscas.ac.cn>
References: <20260123-pci-msi-addr-mask-v3-0-9f9baa048524@iscas.ac.cn>
In-Reply-To: <20260123-pci-msi-addr-mask-v3-0-9f9baa048524@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "Creeley, Brett" <bcreeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: Han Gao <gaohan@iscas.ac.cn>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 Thomas Gleixner <tglx@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-riscv@lists.infradead.org, sophgo@lists.linux.dev, 
 Takashi Iwai <tiwai@suse.de>
X-Mailer: b4 0.14.3
X-CM-TRANSID:zQCowACnPBAiEHNp9tMuBg--.1678S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtF17JryDZw4UKrykKr15Jwb_yoW3Wr45pa
	yDCFWfKrWrK3yUJayqy3WUuF13Xan093yfWrWUK3sa93ZIvFyUXFn7try7Jwn7XrsrCF1a
	vFyUKw4UWFnxX3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0pRVOJOUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Some PCI devices have PCI_MSI_FLAGS_64BIT in the MSI capability, but
implement less than 64 address bits. This breaks on platforms where such
a device is assigned an MSI address higher than what's reachable.

Currently, we deal with this with a single no_64bit_msi flag, and
(notably on powerpc) forces 32-bit MSI address for these devices.
However, on some platforms the MSI doorbell address is above 32-bit but
within device ability.

As a first step to enabling MSI on those combinations of devices and
platforms, conservatively generalize the single-bit flag no_64bit_msi
into msi_addr_mask. (The name msi_addr_mask is chosen to avoid confusion
with msi_mask.)

The translation is essentially:

- no_64bit_msi = 1    ->    msi_addr_mask = DMA_BIT_MASK(32)
- no_64bit_msi = 0    ->    msi_addr_mask = DMA_BIT_MASK(64)
- if (no_64bit_msi)   ->    if (msi_addr_mask < DMA_BIT_MASK(64))

Since no values other than DMA_BIT_MASK(32) and DMA_BIT_MASK(64) is
used, no functional change is intended. Future patches that make use of
intermediate values of msi_addr_mask will follow, allowing devices that
cannot use full 64-bit addresses for MSI to work on platforms with MSI
doorbell above 32-bit address space.

Acked-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
v3: Add Acked-by, no code changes

checkpatch complains about the comment include/linux/pci.h, which I have
formatted similarly with other comments in the vicinity.
---
 arch/powerpc/platforms/powernv/pci-ioda.c           | 2 +-
 arch/powerpc/platforms/pseries/msi.c                | 4 ++--
 drivers/gpu/drm/radeon/radeon_irq_kms.c             | 2 +-
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 2 +-
 drivers/pci/msi/msi.c                               | 2 +-
 drivers/pci/msi/pcidev_msi.c                        | 2 +-
 drivers/pci/probe.c                                 | 7 +++++++
 include/linux/pci.h                                 | 8 +++++++-
 sound/hda/controllers/intel.c                       | 2 +-
 9 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b0c1d9d16fb5..1c78fdfb7b03 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1666,7 +1666,7 @@ static int __pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 		return -ENXIO;
 
 	/* Force 32-bit MSI on some broken devices */
-	if (dev->no_64bit_msi)
+	if (dev->msi_addr_mask < DMA_BIT_MASK(64))
 		is_64 = 0;
 
 	/* Assign XIVE to PE */
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index a82aaa786e9e..7473c7ca1db0 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -383,7 +383,7 @@ static int rtas_prepare_msi_irqs(struct pci_dev *pdev, int nvec_in, int type,
 	 */
 again:
 	if (type == PCI_CAP_ID_MSI) {
-		if (pdev->no_64bit_msi) {
+		if (pdev->msi_addr_mask < DMA_BIT_MASK(64)) {
 			rc = rtas_change_msi(pdn, RTAS_CHANGE_32MSI_FN, nvec);
 			if (rc < 0) {
 				/*
@@ -409,7 +409,7 @@ static int rtas_prepare_msi_irqs(struct pci_dev *pdev, int nvec_in, int type,
 		if (use_32bit_msi_hack && rc > 0)
 			rtas_hack_32bit_msi_gen2(pdev);
 	} else {
-		if (pdev->no_64bit_msi)
+		if (pdev->msi_addr_mask < DMA_BIT_MASK(64))
 			rc = rtas_change_msi(pdn, RTAS_CHANGE_32MSIX_FN, nvec);
 		else
 			rc = rtas_change_msi(pdn, RTAS_CHANGE_MSIX_FN, nvec);
diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
index 9961251b44ba..d550554a6f3f 100644
--- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
@@ -252,7 +252,7 @@ static bool radeon_msi_ok(struct radeon_device *rdev)
 	 */
 	if (rdev->family < CHIP_BONAIRE) {
 		dev_info(rdev->dev, "radeon: MSI limited to 32-bit\n");
-		rdev->pdev->no_64bit_msi = 1;
+		rdev->pdev->msi_addr_mask = DMA_BIT_MASK(32);
 	}
 
 	/* force MSI on */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 70d86c5f52fb..0671deae9a28 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -331,7 +331,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 #ifdef CONFIG_PPC64
 	/* Ensure MSI/MSI-X interrupts lie within addressable physical memory */
-	pdev->no_64bit_msi = 1;
+	pdev->msi_addr_mask = DMA_BIT_MASK(32);
 #endif
 
 	err = ionic_setup_one(ionic);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 34d664139f48..48f5f03d1479 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -322,7 +322,7 @@ static int msi_verify_entries(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
 
-	if (!dev->no_64bit_msi)
+	if (dev->msi_addr_mask == DMA_BIT_MASK(64))
 		return 0;
 
 	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
diff --git a/drivers/pci/msi/pcidev_msi.c b/drivers/pci/msi/pcidev_msi.c
index 5520aff53b56..0b0346813092 100644
--- a/drivers/pci/msi/pcidev_msi.c
+++ b/drivers/pci/msi/pcidev_msi.c
@@ -24,7 +24,7 @@ void pci_msi_init(struct pci_dev *dev)
 	}
 
 	if (!(ctrl & PCI_MSI_FLAGS_64BIT))
-		dev->no_64bit_msi = 1;
+		dev->msi_addr_mask = DMA_BIT_MASK(32);
 }
 
 void pci_msix_init(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d..a2bff57176a3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2047,6 +2047,13 @@ int pci_setup_device(struct pci_dev *dev)
 	 */
 	dev->dma_mask = 0xffffffff;
 
+	/*
+	 * Assume 64-bit addresses for MSI initially. Will be changed to 32-bit
+	 * if MSI (rather than MSI-X) capability does not have
+	 * PCI_MSI_FLAGS_64BIT. Can also be overridden by driver.
+	 */
+	dev->msi_addr_mask = DMA_BIT_MASK(64);
+
 	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
 		     dev->bus->number, PCI_SLOT(dev->devfn),
 		     PCI_FUNC(dev->devfn));
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..0fe32fef0331 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -377,6 +377,13 @@ struct pci_dev {
 					   0xffffffff.  You only need to change
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
+	u64		msi_addr_mask;	/* Mask of the bits of bus address for
+					   MSI that this device implements.
+					   Normally set based on device
+					   capabilities. You only need to
+					   change this if your device claims
+					   to support 64-bit MSI but implements
+					   fewer than 64 address bits. */
 
 	struct device_dma_parameters dma_parms;
 
@@ -441,7 +448,6 @@ struct pci_dev {
 
 	unsigned int	is_busmaster:1;		/* Is busmaster */
 	unsigned int	no_msi:1;		/* May not use MSI */
-	unsigned int	no_64bit_msi:1;		/* May only use 32-bit MSIs */
 	unsigned int	block_cfg_access:1;	/* Config space access blocked */
 	unsigned int	broken_parity_status:1;	/* Generates false positive parity */
 	unsigned int	irq_reroute_variant:2;	/* Needs IRQ rerouting variant */
diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index 1e8e3d61291a..c9542ebdf7e2 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -1905,7 +1905,7 @@ static int azx_first_init(struct azx *chip)
 
 	if (chip->msi && chip->driver_caps & AZX_DCAPS_NO_MSI64) {
 		dev_dbg(card->dev, "Disabling 64bit MSI\n");
-		pci->no_64bit_msi = true;
+		pci->msi_addr_mask = DMA_BIT_MASK(32);
 	}
 
 	pci_set_master(pci);

-- 
2.52.0

