Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D87A328246
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771422425; cv=none; b=Gek0o7RkM+PZiYmJszhiWJrWgxw/Y85j6wTN4ogBv6BPjQPwykwMySC1oe0Ol+vVuk5QV596s20chn8Ykal0CetPKo3D+r5G+Z7A/corcmkMBQGgDfwFtDpQo8TDPxQw16dSDShQBgMy2qHbOiFURvBsh0aJOvoAgrV5nReFcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771422425; c=relaxed/simple;
	bh=1WdgBCenBtltjBcqGb1FLuDG1YNItYNz4f+TC0XtgxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwIgMWgH22WtiVnVsG/H41jIig7grjp+Zkg7BH3RstbV9Ny6x9KGJQahqXurzRNAH8OEAhuj4gnxxdy7dxyboT8GfVoiheGCSlRnWE1Dt6+YCSUu0WsM1qNKNkWPB21e6atrm9jsRRSi33X8Ds1Q4DXr016ugtiRvCIuHXGoaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 398093F213;
	Wed, 18 Feb 2026 14:47:00 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-pci@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH v2 3/5] vgaarb: mark vga_get family as __must_check
Date: Wed, 18 Feb 2026 22:46:31 +0900
Message-ID: <20260218134633.461181-4-Simon.Richter@hogyros.de>
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

These functions can return an error, but some callers expect they don't,
and unconditionally access VGA registers afterwards and call vga_put.

Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
---
 include/linux/vgaarb.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
index 97129a1bbb7d..eed524c67c22 100644
--- a/include/linux/vgaarb.h
+++ b/include/linux/vgaarb.h
@@ -27,7 +27,8 @@ struct pci_dev;
 
 #ifdef CONFIG_VGA_ARB
 void vga_set_legacy_decoding(struct pci_dev *pdev, unsigned int decodes);
-int vga_get(struct pci_dev *pdev, unsigned int rsrc, int interruptible);
+int __must_check vga_get(struct pci_dev *pdev, unsigned int rsrc,
+			 int interruptible);
 void vga_put(struct pci_dev *pdev, unsigned int rsrc);
 struct pci_dev *vga_default_device(void);
 void vga_set_default_device(struct pci_dev *pdev);
@@ -39,8 +40,8 @@ static inline void vga_set_legacy_decoding(struct pci_dev *pdev,
 		unsigned int decodes)
 {
 };
-static inline int vga_get(struct pci_dev *pdev, unsigned int rsrc,
-		int interruptible)
+static inline int __must_check vga_get(struct pci_dev *pdev, unsigned int rsrc,
+				       int interruptible)
 {
 	return 0;
 }
@@ -74,8 +75,8 @@ static inline int vga_client_register(struct pci_dev *pdev,
  *
  * On success, release the VGA resource again with vga_put().
  */
-static inline int vga_get_interruptible(struct pci_dev *pdev,
-					unsigned int rsrc)
+static inline int __must_check vga_get_interruptible(struct pci_dev *pdev,
+						     unsigned int rsrc)
 {
 	return vga_get(pdev, rsrc, 1);
 }
@@ -89,8 +90,8 @@ static inline int vga_get_interruptible(struct pci_dev *pdev,
  *
  * On success, release the VGA resource again with vga_put().
  */
-static inline int vga_get_uninterruptible(struct pci_dev *pdev,
-					  unsigned int rsrc)
+static inline int __must_check vga_get_uninterruptible(struct pci_dev *pdev,
+						       unsigned int rsrc)
 {
 	return vga_get(pdev, rsrc, 0);
 }
-- 
2.47.3

