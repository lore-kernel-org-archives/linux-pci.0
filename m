Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7C836E491
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771348435; cv=none; b=Vae5FruVu25BZFn3Lo0gQ8GK0We+sTcJa0RE14hFyTAG/M58+1K6IIEOf+0rFG6dkEoo2LawimJzo9XBCrR/OL0fXTXM8ltXWWcd7N1Gs278GUiVp/SX3W9i/1ZQqoc1RifdCmFZTYxtP+oFwTM5UO0j1hQmY+7KNDFrXDTKZpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771348435; c=relaxed/simple;
	bh=YcG2+sY91S7CPMpIvFiMm5l+Kluf4+CWdFaeP7g0DxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVHLQVjVJICyHe8lk2sGrrtR8WeDCO6XedPB7gBsoyb7JxwO0Ip3kwZtYRd2qKzQH41HRnwpItn8wFmTLBqll48iNBMxBkh1ciFTcsABl92fNKx0BTm1guVdJdXemUCTv67cEvy4/3hZRH+3BDjQXAE5jOcoMjTX2FVfgKmZM+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 34A883F204;
	Tue, 17 Feb 2026 18:04:41 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-pci@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH 1/5] vgaarb: pass vga_get errors to userspace
Date: Wed, 18 Feb 2026 02:04:15 +0900
Message-ID: <20260217170419.236739-2-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217170419.236739-1-Simon.Richter@hogyros.de>
References: <20260217170419.236739-1-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If vga_get fails, return the error code via the write syscall.

Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
---
 drivers/pci/vgaarb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 87143e235033..5c2719cb1bfa 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1134,6 +1134,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 	char kbuf[64], *curr_pos;
 	size_t remaining = count;
 
+	int err;
 	int ret_val;
 	int i;
 
@@ -1165,7 +1166,12 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 			goto done;
 		}
 
-		vga_get_uninterruptible(pdev, io_state);
+		err = vga_get_uninterruptible(pdev, io_state);
+		if (unlikely(err))
+		{
+			ret_val = err;
+			goto done;
+		}
 
 		/* Update the client's locks lists */
 		for (i = 0; i < MAX_USER_CARDS; i++) {
-- 
2.47.3

