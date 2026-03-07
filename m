Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20933556E
	for <linux-pci@vger.kernel.org>; Sat,  7 Mar 2026 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772905404; cv=none; b=Aa3liUOkQuEDNSDu/RqqLqVvh+m+Ba/1sq41+P0k3xkT8AJ0MBjFG6UqQ6ND5jp84bwfFkZCN6nzywGHuaFx6iF/xcLHXxwagkOhQTWbb0QpY8VOJym/w6I5Xc/vC8734AsnA1aBmMn9OCczKlx5pKBjY5gwaukggbYnakQmM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772905404; c=relaxed/simple;
	bh=6X4oQdey6JTq8lVL/QPboFW+3dxs6wmLKYR1XWmJnog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZCEBLlW3P7sXLNC6yvsi2mmHxY5wK51pf0d5TVsWzrS16ffshE9awNQxo+ojdxpwjGxMHUabyy1NzLYJqK2w6s4h4lOjw6cf+mwcmXBUqf/O5O9vbGzj9PvevKdF7wdhOAvmwRo3bjMU7TOcpfgJ58UApQ0noc4soNqBwxQiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 638463F53F;
	Sat,  7 Mar 2026 18:35:59 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-pci@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH v3 3/5] vgaarb: mark vga_get() and wrappers as __must_check
Date: Sun,  8 Mar 2026 02:35:36 +0900
Message-ID: <20260307173538.763188-4-Simon.Richter@hogyros.de>
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

The vga_get() function and the two wrappers vga_get_interruptible() and
vga_get_uninterruptible() can return errors. As these are paired with
vga_put(), which must only be called after vga_get() returned success, all
callers need to check the return code.

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

