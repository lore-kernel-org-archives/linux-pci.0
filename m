Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B780328246
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771422423; cv=none; b=WVh0HHYEHDQBxBcN1L2W1FQQWSgy3+ZHgogs2fXGCDOG0g9FmmYs0V5iWpdJA6Sq4659cqWmHuec0ZHitz4824a+dsgZzlDjy11wddhtFtuO2mnq/dQN29o0FllRkKYsBB24b+vZXwaAxnP8IKchI9bzgmcnXHh/WD8Sub2VJoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771422423; c=relaxed/simple;
	bh=tV5Zl7hb5xuXldR8mGLUJCleWHHBrRQDEMUtV7cGqUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2vBUKv4CMUIsNKcL514LoNd/NIqxecMLdsH0O0ROSLDj5Id43Wb9elI4XZJ2GWt/9mRWeh0WCwB0nGpJCOxl351Zao6cLNDML9IchG/WQXkrGiUyE9u8yc9MycvBhd0avdBKR3eGV4s6eceOICyU+5b9VEX2wwuv/bOQ6MvVbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 4EE843F206;
	Wed, 18 Feb 2026 14:46:59 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-pci@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH v2 2/5] vgaarb: pass errors from pci_set_vga_state up
Date: Wed, 18 Feb 2026 22:46:30 +0900
Message-ID: <20260218134633.461181-3-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218134633.461181-1-Simon.Richter@hogyros.de>
References: <20260217170419.236739-1-Simon.Richter@hogyros.de>
 <20260218134633.461181-1-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_set_vga_state returns an error code, which so far has been ignored.
Pass this code through __vga_tryget (via ERR_PTR).

Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
---
 drivers/pci/vgaarb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 188885d30d41..93f695f9d768 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -215,6 +215,7 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
 	struct vga_device *conflict;
 	unsigned int pci_bits;
 	u32 flags = 0;
+	int err = 0;
 
 	/*
 	 * Account for "normal" resources to lock. If we decode the legacy,
@@ -307,7 +308,9 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
 		if (change_bridge)
 			flags |= PCI_VGA_STATE_CHANGE_BRIDGE;
 
-		pci_set_vga_state(conflict->pdev, false, pci_bits, flags);
+		err = pci_set_vga_state(conflict->pdev, false, pci_bits, flags);
+		if (unlikely(err))
+			return ERR_PTR(err);
 		conflict->owns &= ~match;
 
 		/* If we disabled normal decoding, reflect it in owns */
@@ -337,7 +340,9 @@ static struct vga_device *__vga_tryget(struct vga_device *vgadev,
 	if (wants & VGA_RSRC_LEGACY_MASK)
 		flags |= PCI_VGA_STATE_CHANGE_BRIDGE;
 
-	pci_set_vga_state(vgadev->pdev, true, pci_bits, flags);
+	err = pci_set_vga_state(vgadev->pdev, true, pci_bits, flags);
+	if (unlikely(err))
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

