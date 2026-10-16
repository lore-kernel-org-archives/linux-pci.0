Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9DC448CF6;
	Fri, 16 Oct 2026 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146057; cv=none; b=VewoJUG+CycKn6fmqPS0z36mi86WPF7OEBHp1s5E4p7f8zZeZhuKhnQAI2ed96PIu50XvKgemRwV4Kq2DOE2GGX026Qzd5BcCMYGM2ThVJERVviZiaqMiRzQlEN1ZZpCK0Drbx7AfLBN3q0ghZv5bnOJT0etnA9INxgqPr6W0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146057; c=relaxed/simple;
	bh=DO69BOUhTUmLdhrln5SbJj0SO2wXNePAqPT4Vx7OXOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bfJwLnfN7rXMMt4FTCg//ZDoC4VuqoNNjVuLan3c/vHgqhAPBv5NKm679Qty7WZkqRlRRaTlt82cI+SKa3Zk+A6UPAdoIc7l4eDgAdL6TyFtZLmtNUT6DPcsSt/697RFKGdbuylXEy2JIWc9pfy/0dgxqRUDpekSsafB1eA0jlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hMUE4/nt; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hMUE4/nt"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j5gv20vJ4zKp1n;
	Fri, 16 Oct 2026 12:20:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792146046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7sINR0KxDzfyw0t1SbAYRVQXRRT2UCK0z6obmqsIzao=;
	b=hMUE4/ntKGtfCKQc++NzVjAvbRp7mchy2Iz46iBZ3WnwoSOI1zXvYWyzn/yxBBUVZNjW3q
	QiLygnzlXPi57Z1zmZQGRkCYA3nIypzQ7ltCw0m92yEX5VNAnQolg+CCgHOIF06MpZjHfi
	r7fBZD18ajh4WCvdTPN6cTjYMjD+2Rcz15YYkvXOPfcQzcLdEKNJ9BEzC8XUKdrhThSLE/
	KjttsBPb8VK7ZKdBvmzc+z/7rc7TUWBzdsrHWm0JGfPl7mOU3nA1fBQY8qdTpWft7YtNbb
	Fef3j+XBPc1dxJ+fE7mtC84ze7XuGLbaNLs71hlwRm4/igqcImB1LSAa3nBX9w==
From: Alexander Gruhlke <gruhlke@mailbox.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	Alex Williamson <alex@shazbot.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Alexander Gruhlke <gruhlke@mailbox.org>
Subject: [PATCH] PCI: Ignore Immediate Readiness on Samsung 990 EVO Plus NVMe
Date: Fri, 16 Oct 2026 12:20:42 +0200
Message-ID: <20261016102042.641801-1-gruhlke@mailbox.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5d24d3f49fd0275b8c8
X-MBO-RS-META: zmj6z9tp9xr3c1188fkx5dcnyn41u8ug

Like the 990 PRO, the Samsung 990 EVO Plus [144d:a80d] advertises
Immediate Readiness, and VFIO passthrough of it fails since commit
10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs").
Using a bus reset instead of FLR works around it, and the latest
firmware, 2B2QKXG7, is still affected.

Ignore Immediate Readiness on this device, too.

Fixes: 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs")
Link: https://bbs.archlinux.org/viewtopic.php?pid=2312085#p2312085
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Alexander Gruhlke <gruhlke@mailbox.org>
---
This adds the 990 EVO Plus to e6111fbf0c ("PCI: Ignore Immediate
Readiness on Samsung 990 PRO NVMe") in pci/for-linus, and could also
be folded into it.  I couldn't test it on this drive; the reporter
confirmed Status 0x0011 and that reset_method=bus fixes it.

 drivers/pci/quirks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 15f083b6b1..0d8c47a46c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5623,7 +5623,7 @@ static void quirk_no_flr_snet(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLIDRUN, 0x1000, quirk_no_flr_snet);
 
-/* Samsung 990 PRO advertises Immediate Readiness, but isn't ready after FLR */
+/* Some Samsung SSDs advertise Immediate Readiness but aren't ready after FLR */
 static void quirk_no_imm_ready(struct pci_dev *dev)
 {
 	if (!dev->imm_ready)
@@ -5633,6 +5633,7 @@ static void quirk_no_imm_ready(struct pci_dev *dev)
 	dev->imm_ready = 0;
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80c, quirk_no_imm_ready);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80d, quirk_no_imm_ready);
 
 static void quirk_no_ext_tags(struct pci_dev *pdev)
 {
-- 
2.56.0

