Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467843;
	b=014Ll3ZFJXkqxRn8zqG60JWH0txx+N/C6OnmRzVb012cEUaYmE88YROzmfylA8hQblHg
	 qswhv+fZAEj2ZEYe52xNGIMlxdPiP6VHoiR7CjFf7Mqe9e0x6rtIrwi9f35dFspKoBRaI
	 X3HtXKo6yXHkQL41lMiFCZpxAXa3OSyp8uRkIbigwC5DZXVuupo3uTlYbFTjnl1BPQkEZ
	 tSnj23VOMgDEv9pcMJYxdL62FASMwLeOfLdha6Dk/cqqcEUzZCAvQ2yTL6G+VbDnrjuNG
	 7gOOZiUjVoji3UZ3HydXQARsXbslfqJ6PNy9JRiTsyb5RybO6nyyEuDR2eMyzpDbIPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467843;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y9mFAcJSAVxyNmz8kQNK+Ob8oGC1edSsJJjdeUbiSaY=;
	b=IzDxKyaGy8eC8Ge582QjwbDrRcUoHT3v7pZY5X2ROu78eefPVU3ER7LpF0e0yCSpJ5cl
	 hWb8EOiJnjCMpoqbshWCigGlpERpPvYncAwDDyjOwR7Ve1hAo3VGz8NYStzyvSRXoURQp
	 Mh6klJEzUPdZplWIFawkUVeKSFXogxRfl2y/vMf59O1BknHd5f8yqNEyduQ+eGnThbv8F
	 oRJ7zRZ7pHmccUrreLgzuyJh6v+cg65xPSbfD212FWwOiWE6vCiVPr5oattSmR/gZb4bH
	 6bT+wasdP6DU2jDb8e7KBDTf1aR11THx1Os1OUlTkbGXAyYQQNQDwrlSgbEc5qYdcFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tnL8CcYy;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7C2606A332;
	Thu, 12 Nov 2026 07:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A7C2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tnL8CcYy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=tnL8CcYy5pw9pEtg0NMKNSbHuvDgtECm3Wgig2M9/DSCbFGz+oLb3XjL6WIUUTNbYhKCtIH52I0n2
	 kXp62eQx3OHOJA2I3qUUDrR+b4WqKpFBzifdvfakP6sAPATgI2KdiXfgGb6fea2XZc6m0JZxkIClw3
	 MeNpwkavIdC2MZd4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af567fea35-ab3d8;
	Thu, 12 Nov 2026 15:17:19 +0800 (CST)
X-RM-TRANSID:2ee36af567fea35-ab3d8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26af567febf7-f70f7;
	Thu, 12 Nov 2026 15:17:19 +0800 (CST)
X-RM-TRANSID:2ee26af567febf7-f70f7
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] PCI: cpqhp: Release the device reference on config read failure
Date: Thu, 12 Nov 2026 15:17:17 +0800
Message-ID: <20261112071718.154545-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpqhp_save_config() obtains a PCI device reference before saving its
configuration space. If a configuration read fails, the function
returns before reaching the matching pci_dev_put().

Drop the lookup reference on that error path as well as on success.

Fixes: 12a9da0fcb14 ("PCI Hotplug: cpqphp: don't use pci_find_slot()")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/pci/hotplug/cpqphp_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 81c58b1ec200..c24d311c8e44 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -409,8 +409,10 @@ int cpqhp_save_config(struct controller *ctrl, int busnumber, int is_hot_plug)
 
 			for (cloop = 0; cloop < 0x20; cloop++) {
 				rc = pci_bus_read_config_dword(ctrl->pci_bus, PCI_DEVFN(device, function), cloop << 2, (u32 *) &(new_slot->config_space[cloop]));
-				if (rc)
+				if (rc) {
+					pci_dev_put(new_slot->pci_dev);
 					return rc;
+				}
 			}
 
 			pci_dev_put(new_slot->pci_dev);
-- 
2.51.0



