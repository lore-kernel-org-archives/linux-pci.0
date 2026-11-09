Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794216289;
	b=3+RElFHuLwyf6+36zTbKC8Mnk9iSgqkK632o/lHhC6zMIc33t7icL95XVSjGuCqlPlEo
	 3vt79+n5vxlg+DdZ1nWWdpf876sXOqpsvEI4R+BShE1dZ7MxT+vHO1/Dl/ncRs90URT1P
	 zCq1DDvq1x9QXFV/zsVLSiFj84/B74KBFnyGwcnLummeIfiHuG6VTNRrZdSFUusc4d4sx
	 kvUXju9NSbdYL/MuXhiwr3VGsywDKDdX03f/ISSdfMd+WmHQknm1ff9sxPKT+RTPJVb9E
	 p2UDnoR3PvEILIm6Qzx/nbIERHv71hngsFUKrz3z3u4PGNowlebo9eDcg3+lM59eGZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216289;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Xu12zpNi8g3Ww+jQlbS2EOpBtBf4+Qt+Ls/JoZ5WG78=;
	b=UZA4IBttwT9UlFm9MjgSnY4qjMz/M7/wMBtbT0fEev4NPFodRJKMT6lUlVhf/R6Y5D0M
	 XgVYCdmRUVdzkXrVACPzYhJx5YBajf5cXR46Qr01d/msg/+N9K/ljKzNYFcR6asBTFpMa
	 U1TK0wWTkEiQPEVmX2kb01hVVj61mEortBLENwTvG/A5cfvfj0g8kQVas4+2uljNcgs3D
	 TQJVlbKHP7FsrTgJKqct6LqEJw3wm/pam9s0NSx6ow/gi6CKS7Dj56bg7v25vsj8EZH9T
	 OUjxpgxCDsvuVsGKMqleHBHpEYjspBoyix9ZvikW3bZX+heCAADMLsZzKsNTTBPvcYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nhu7iR0C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB57606A325;
	Mon,  9 Nov 2026 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nhu7iR0C
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794216289;
	b=X2fXWHuataOfVkuBDCJwTK5UTbptMU+YpMwufHE+sz1sC5mToAjKG7XDj1rDMkbEaDyT
	 pO4IqvbdSoWfmS7K+FFZFITyyqPXZB8ZpUZVYIo+1QBIY1UwwHNwKRhM2HK5eg5fB4Wga
	 6pZuaRZBNMIAGAqKDxNetYwhICUvXobPLfGuSXrAAM2WoDGdzjr3yj46kxnTO+oHfVcWz
	 BPJO6qDIY7mdJE54jffd12AFDfDCWzoGTUGZwGA+iihb5VOmV4IXzA9ipFxDE/Dak1W1q
	 lqYK3is+vWLxKSyqXA9WGGHpgmFeFtnAb7JRx3j5WeYM2rh75zHoY+Jfi1CedOrBcOQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794216289;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Xu12zpNi8g3Ww+jQlbS2EOpBtBf4+Qt+Ls/JoZ5WG78=;
	b=feoDFSqcGSeYk7un5rCFo6FJ+WlDw5ZakFEsP1jG0j9g/fDizMtbm71m+jopCY/0olXV
	 udx48UAxgoH5sazpOEhLfWp85+0IyGQ9Iapjr4rjJoiWJU70u985wwXCtkhbr0sfL8gIT
	 IDWgKtzCGcff+HbTOheM+YLqwWoKoVOI0Emvbk6HHvEVi7+FWlJQfb5WIpwfkamc2PqLG
	 qzfZrmuTox7lOkKsf5IUuVzSNczZtF+FYWCDO5AXF5F2xIrFq/uI/xmhVqZg2bJyzxbkx
	 vo/F7aJfEKqaaD32/WdOi7mzStd7Yn0XItxAqPyQrV7xTNyI3/hcxaNbpV4ZYBz8AIw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8D8AF1F0089F;
	Mon,  9 Nov 2026 09:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216289;
	bh=Xu12zpNi8g3Ww+jQlbS2EOpBtBf4+Qt+Ls/JoZ5WG78=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Nhu7iR0Cn+DE1zuBqUTTEqK1YvQ/Q5sZwBlDYwkAqA/cKamoLgYe7gg4jm0R0gZa5
	 oYzZVrf1x2YSq89Wrst1QvaGXyOUz8bwXNnrdhUY+rTzjeQj+YXOK1KRgFcyux76r5
	 DDH7UQsFo1XjRXDDcOsnqvHllTmndmnlQb7ZCdYv5jSY1AvyYmUKJ9jicXln4YAaTv
	 JhA7HvuI/4Es29H/uqBccchSCeOglFiFTz7vG0c2PcvlX/k03nj0fA0R9SeFlRxOGk
	 U8Fj2rzDFNwz3D9uTEM1dW6LO3YwZlxrQ4goev4fCVBAQfSjsIahBl9BqUVITtDWG2
	 YkhFAgte4CEAw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1A1344836E;
	Mon,  9 Nov 2026 09:24:48 +0000 (UTC)
From: Yu Yang via B4 Relay <devnull+yuyang.kylinos.cn@kernel.org>
Date: Mon, 09 Nov 2026 17:24:28 +0800
Subject: [PATCH] PCI/MSI: Skip address mask check for MSI-X entries
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-pci-fix-msix-alloc-failure-v1-1-6370c0b84354@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAEuR8WoC/x2MSQqAMAwAvyI5G7A9uH1FPJQ20UBdaFGE4t8NX
 gYGhimQKQllGKsCiW7Jcuwqpq7Ar25fCCWog21sa0wz4OkFWR7cssLFeHhkJ/FKhD4wU+Cho96
 CDs5EWv7zaX7fDxH2mldsAAAA
X-Change-ID: 20261109-pci-fix-msix-alloc-failure-cdffedf97e82
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, 
 Brett Creeley <brett.creeley@amd.com>, Shannon Nelson <sln@onemain.com>, 
 linux-kernel@vger.kernel.org, Yu Yang <yuyang@kylinos.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794216287; l=2146;
 i=yuyang@kylinos.cn; s=20261109; h=from:subject:message-id;
 bh=fq57q40/5O4bXqj13wzHAYXlVx1mOt/jNhP7ggzzvwU=;
 b=HmUWeekm6t09OjI/k6Xpy3e41nbV6rOobI0E6lAx7TjPCaJo+xung/OaZDLhu3v8VVnLnWEs4
 9y7toDvn/GbC1cDslIZz2I/OGVc06h4NcnugXpxwzH14DUZ6oz8TcZj
X-Developer-Key: i=yuyang@kylinos.cn; a=ed25519;
 pk=LQAY8k9sUwvjwxS9P2CQE0GbrKw/MJPJbDHlapWOZ8A=
X-Endpoint-Received: by B4 Relay for yuyang@kylinos.cn/20261109 with
 auth_id=1458
X-Original-From: Yu Yang <yuyang@kylinos.cn>
Reply-To: yuyang@kylinos.cn
Content-Transfer-Encoding: 7bit

From: Yu Yang <yuyang@kylinos.cn>

The AHCI controller on Zhaoxin ZX-200 platforms supports only 32-bit
MSI addresses, but its MSI-X capability uses 64-bit message addresses.
pci_msi_init() therefore sets dev->msi_addr_mask to DMA_BIT_MASK(32)
based on the MSI capability.

msi_verify_entries() is shared between the MSI and MSI-X setup paths.
When the irq domain assigns an MSI-X message address above 4GB, the
32-bit mask inherited from the MSI capability causes MSI-X setup to
fail with -EIO:

  ahci 0000:09:0f.0: arch assigned 64-bit MSI address 0x8002a030040
  above device MSI address mask 0xffffffff.
  ...
  ahci: probe of 0000:09:0f.0 failed with error -22.

MSI-X table entries have a 64-bit message address field, so the 32-bit
limit derived from the MSI capability does not apply to them.
Platforms that use msi_addr_mask to constrain MSI-X allocation, e.g.
powerpc pseries/powernv and ionic on PPC64, already allocate addresses
that satisfy the mask, so the verification is redundant for MSI-X.

Skip the address mask check for MSI-X descriptors.

Fixes: f144d1496b47 ("PCI/MSI: Add device flag indicating that 64-bit MSIs don't work")

Signed-off-by: Yu Yang <yuyang@kylinos.cn>
---
 drivers/pci/msi/msi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 8a0133a6a286..7f34bccc8248 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -338,6 +338,13 @@ static int msi_verify_entries(struct pci_dev *dev)
 		return 0;
 
 	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
+		/*
+		 * MSI-X entries always use a 64-bit address, so the address
+		 * limit for MSI capability does not apply for MSI-X.
+		 */
+		if (entry->pci.msi_attrib.is_msix)
+			continue;
+
 		address = (u64)entry->msg.address_hi << 32 | entry->msg.address_lo;
 		if (address & ~dev->msi_addr_mask) {
 			pci_err(dev, "arch assigned 64-bit MSI address %#llx above device MSI address mask %#llx\n",

---
base-commit: 996a59519af2ef3d8f47479685616bb2278c6cfa
change-id: 20261109-pci-fix-msix-alloc-failure-cdffedf97e82

Best regards,
-- 
Yu Yang <yuyang@kylinos.cn>


