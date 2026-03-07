Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBEF2DA76A
	for <linux-pci@vger.kernel.org>; Sat,  7 Mar 2026 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772905405; cv=none; b=tWEID1sROQqFxo15mpFndsCMU+LWlWUJFqLmsO1Mx6HJla9X9Xry+woRizc1QjrptDHN7NnbEqZN32OLcucU8JsnhOWK+cAY1vgXZWKGJ+FuL/Eg5KWmVFcjRGmC3WTCKb+ef/LtB00FXYsB09OJJzpxfBZSBCquoI6QGR4KtGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772905405; c=relaxed/simple;
	bh=G5WsmddvWG770Z9Qqd4ArFucwz1eW5RE848O30DlOuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZLC9bxqHleCS5rhG8W7wWOHwkHuKuP1DMO6KdjcmLO3dVmavC3TQNJeTTkUn5ukAcurS2eJOBIsHdSLVelIwmfMpwVuPFbWFjjLyX3QTKcT2j8TUNyvXp5LIvz35VsEVUsVbKKvcTM9yx9eCq6QHv9boAQOnsrVBuafdQPj77M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 7E3633F51E;
	Sat,  7 Mar 2026 18:35:57 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-pci@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH v3 2/5] vgaarb: pass errors from pci_set_vga_state() up
Date: Sun,  8 Mar 2026 02:35:35 +0900
Message-ID: <20260307173538.763188-3-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307173538.763188-1-Simon.Richter@hogyros.de>
References: <20260307173538.763188-1-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_set_vga_state() returns an error code, which so far has been ignored by
the only caller, __vga_tryget(), so forward it to the caller. As the return
type of __vga_tryget() is a pointer, wrap the error in ERR_PTR().

Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
---
 drivers/pci/vgaarb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 22b2b6ebdefd..c360eee11dd9 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -215,6 +215,7 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
 	struct vga_device *conflict;
 	unsigned int pci_bits;
 	u32 flags = 0;
+	int err;
 
 	/*
 	 * Account for "normal" resources to lock. If we decode the legacy,
@@ -307,7 +308,9 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
 		if (change_bridge)
 			flags |= PCI_VGA_STATE_CHANGE_BRIDGE;
 
-		pci_set_vga_state(conflict->pdev, false, pci_bits, flags);
+		err = pci_set_vga_state(conflict->pdev, false, pci_bits, flags);
+		if (err)
+			return ERR_PTR(err);
 		conflict->owns &= ~match;
 
 		/* If we disabled normal decoding, reflect it in owns */
@@ -337,7 +340,9 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
 	if (wants & VGA_RSRC_LEGACY_MASK)
 		flags |= PCI_VGA_STATE_CHANGE_BRIDGE;
 
-	pci_set_vga_state(vgadev->pdev, true, pci_bits, flags);
+	err = pci_set_vga_state(vgadev->pdev, true, pci_bits, flags);
+	if (err)
+		return ERR_PTR(err);
 
 	vgadev->owns |= wants;
 lock_them:
@@ -455,6 +460,10 @@ int vga_get(struct pci_dev *pdev, unsigned int rsrc, int interruptible)
 		}
 		conflict = __vga_tryget(vgadev, rsrc);
 		spin_unlock_irqrestore(&vga_lock, flags);
+		if (IS_ERR(conflict)) {
+			rc = PTR_ERR(conflict);
+			break;
+		}
 		if (conflict == NULL)
 			break;
 
-- 
2.47.3

