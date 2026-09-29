Received: from mail.catnarok.net (mail.catnarok.net [167.99.87.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E56A4973AF
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.99.87.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695016; cv=none; b=UX5zvGhRBeCG1edwYz+fA3/AhdG8Z1YlsV3hjlEHUknviaVUtb6/3rNrkptgTg4YZBZNXsFi3V4y1CuLEQ3FX65bTIRP+pZauj4EXT1A90YLXS39jLp2Ih15aLRh/jhmCxr3ZEWqyBKXhDx9Fq+I9WxDI0+nCtwBzK600Z9rN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695016; c=relaxed/simple;
	bh=wLhWyewojJhFiX5NOdAyYoG2PtrTWePbkC8uas+9nlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdOscCVRXkJBF0gi5MtZ8ZBfE4pwzdaaAe1zM29zoLNiawmfW1s3vYFXNFPZRCHo3bSqgsSaLXpP8/9arS3u9DFvCuiBL6eHfon9Sx3cOqyEt4y46au/PqDIlzCw1N0Yo95CrLD8wOuj1dvYZZuXJ0z/LGoinoRvrd9Y3v67L7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catnarok.net; spf=pass smtp.mailfrom=catnarok.net; dkim=fail (2048-bit key) header.d=catnarok.net header.i=@catnarok.net header.b=jXzkr76P reason="signature verification failed"; arc=none smtp.client-ip=167.99.87.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catnarok.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catnarok.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=catnarok.net header.i=@catnarok.net header.b="jXzkr76P"
Received: from mail.catnarok.net (localhost [127.0.0.1])
	by mail.catnarok.net (Postfix) with ESMTP id B346B80449
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 15:09:26 +0000 (UTC)
Authentication-Results: mail.catnarok.net (amavisd-new);
	dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
	header.d=catnarok.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=catnarok.net; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1790694566; x=
	1793286567; bh=wLhWyewojJhFiX5NOdAyYoG2PtrTWePbkC8uas+9nlo=; b=j
	Xzkr76PgT7yMmPBo3KZgROn3dYXNjpSFHSBQ14pXuTsiHcxrKKBnWx6tK8E7D3Rv
	2CWUDEbizkKNBNu5Yi1F2q+2DMd1YDp4joN9A8gH88RW86S/q6OtDeWcRsR3HIGI
	J5kcJJHyv8YP96gjXY2CLgmuYSA9Xudbccs5I9L0VI//bmrAIWRbo3jiqCl7EERN
	yRRLaE3ugytVJti69SAfR5yZ6grRWzOS4a1N7mlukSZQ5/6YEJ0nvH+93NspNCB3
	q5k/nay9BTRw1P9uAq6SBnKU1NymrYO2K5CqpRd0BYmTHN3otiO/Mtqzz+TwaDIC
	JT7mzh6dXQnCNX0ph6fdQ==
X-Virus-Scanned: Debian amavisd-new at mail.catnarok.net
Received: from mail.catnarok.net ([127.0.0.1])
	by mail.catnarok.net (mail.catnarok.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DD9SE_dDzIab for <linux-pci@vger.kernel.org>;
	Tue, 29 Sep 2026 15:09:26 +0000 (UTC)
Received: from horse.private.catnarok.net (92-247-245-29.spectrumnet.bg [92.247.245.29])
	by mail.catnarok.net (Postfix) with ESMTPSA id 1CADE800EB;
	Tue, 29 Sep 2026 15:09:25 +0000 (UTC)
From: Michael Stolovitzsky <emestee@catnarok.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Stolovitzsky <emestee@catnarok.net>
Subject: [PATCH] PCI: Add function 1 DMA alias quirk for Toshiba AHCI SSD controller
Date: Tue, 29 Sep 2026 18:09:24 +0300
Message-ID: <20260929150924.2376309-1-emestee@catnarok.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Toshiba AHCI SATA controller [1179:010b] (subsystem [1b4b:9183])
used in 11-inch MacBook Air models (MacBookAir6,1 and MacBookAir7,1)
issues DMA with the requester ID of function 1, which does not exist.
With the Intel IOMMU enabled (intel_iommu=3Don, or
CONFIG_INTEL_IOMMU_DEFAULT_ON=3Dy), these DMA writes are blocked, IDENTIF=
Y
fails and the internal disk never appears:

  DMAR: [DMA Write NO_PASID] Request device [0000:04:00.1] fault addr 0xf=
ffe0000 [fault reason 0x02] Present bit in context entry is clear
  ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=3D0x80)

Add the controller to the quirk_dma_func1_alias() list. With it, the
SSD is identified and the system boots with the IOMMU enabled.

Link: https://github.com/omacom/omarchy/issues/12097
Link: https://github.com/omacom/omarchy/issues/13010
Cc: stable@vger.kernel.org
Assisted-by: Claude Opus 5.5
Signed-off-by: Michael Stolovitzsky <emestee@catnarok.net>
---
Tested on a MacBookAir6,1 (7.2.5-based kernel, intel_iommu=3Don);
build-tested on v7.3-rc5.

As far as I can tell, 1179:010b is specific to the Toshiba SSDs Apple
shipped in the 11-inch MacBook Air: pci.ids has no entry for it, and
every linux-hardware.org probe carrying it is a MacBookAir6,1 or 7,1.

 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda..9d2ca995b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4366,6 +4366,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
 DECLARE_PCI_FIXUP_HEADER(0x1c28, /* Lite-On */
 			 0x0122, /* Plextor M6E (Marvell 88SS9183)*/
 			 quirk_dma_func1_alias);
+/* Toshiba AHCI SSD controller in MacBookAir6,1 and MacBookAir7,1 */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA, 0x010b,
+			 quirk_dma_func1_alias);
=20
 /*
  * Some devices DMA with the wrong devfn, not just the wrong function.

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
--=20
2.55.0

