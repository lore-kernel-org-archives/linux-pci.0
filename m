Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E290337BBB
	for <linux-pci@vger.kernel.org>; Sat,  7 Mar 2026 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772905404; cv=none; b=jSvk/dEy1GALVJ5yNcHRJA/zWWMvh2hEWNeC1c0C61a2OAjxrgdpM3i8Ee1MqDoqHVb9vNkOjM9Ds7tPYPCx6Ucn8hoOKXeUpC3QBQ/sLi8xmaO8TLRvShh/s+2tFCH1J2CBE8FB1MPUy1WGBZHbZGeDz0RGgNKMy7A5Kwwg21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772905404; c=relaxed/simple;
	bh=U/SdcorbvDOC2eCspLiQuOz7pJUvGxqnENxDxcfkmqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGWlGz1ElQsqx7O6feLSg6Z/VDJrGosGinP/EMaxV51gyZBJ5zZiMQgVqjDjerLZa3mfmNYQ0S3DXfMrxc9DaPybQhJ06Jck4XNGNOQtK7nhp7OJRDw8MnfIm/uzW0tmHBwLr+jGm2b3yNDs93PSWo4H7BUVnPbib4FpEhaidoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 9B4893F28A;
	Sat,  7 Mar 2026 18:35:55 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-pci@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH v3 1/5] vgaarb: pass vga_get_uninterruptible() errors to userspace
Date: Sun,  8 Mar 2026 02:35:34 +0900
Message-ID: <20260307173538.763188-2-Simon.Richter@hogyros.de>
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

If VGA routing cannot be established, vga_get_uninterruptible() returns an
error and does not increment the lock count. Pass the error on, and don't
call vga_put() when userspace closes the handle.

Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
---
 drivers/pci/vgaarb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index d9383bf541e7..22b2b6ebdefd 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1134,6 +1134,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 	char kbuf[64], *curr_pos;
 	size_t remaining = count;
 
+	int err;
 	int ret_val;
 	int i;
 
@@ -1165,7 +1166,11 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 			goto done;
 		}
 
-		vga_get_uninterruptible(pdev, io_state);
+		err = vga_get_uninterruptible(pdev, io_state);
+		if (err) {
+			ret_val = err;
+			goto done;
+		}
 
 		/* Update the client's locks lists */
 		for (i = 0; i < MAX_USER_CARDS; i++) {
-- 
2.47.3

