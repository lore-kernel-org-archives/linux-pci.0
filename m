Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA9D49C4D4
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625074; cv=none; b=l9mPQXkhX7jbVZCRKnZadKqiFl15W5yPlgejLLmtUTQ6PJQ6L8FXDxIvYb6k7TSZSNeO772vY1AtCzXJYrj41T6KxUowjCRZYpOEkHK/CNIn3mU0hjm2v9WpBCmwDTP3mtGKLRMdsWw8vWHfPsvdhI2GzkjbkY7IrNAnPN/U2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625074; c=relaxed/simple;
	bh=nGh6RsM7aCBkLteBnwvgaaPX3UTn8UTU7R4yvf+CRk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a47MAPHKPVP7ojqUtl0HrSKc3D5kMX3lDIGRUu6RxWlfp4EIdB9X9uYzicxLxGblQG2GZRU5fNSBAr0py1A2QlSEYrEVrKqT10fdjFm3P1/HwczRxt/HD4wWEvggrIe9vcWrxIApnTkbY/95BkP79SRUzwJ4gAd64AOhfKGsNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBPN5DKL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBPN5DKL"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-39b2ad862bdso2033506a91.2
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788625072; x=1789229872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JcOig9NKf5o6Qbc3piYOUfGf8ABZUBGBIb0kMgo7Eu4=;
        b=HBPN5DKLbgE4qlPJWqkWqstycZdUspgB0H2lGiKaKIqmv/ICoLam+Gc3mrbYrpSyuV
         wBxlVIBrObpUjTfvFTYZ9B0JW6FmwFSFD18UucvM4Un/lisEpF0kbqXHQNtz+GdmHFhR
         dgwUPX9B2aJmXVMnFHk6qmTTdgSKS/kSUUeKy2TGreTFKQIyOqQ4Iw/RsjII++7Ma4b2
         GTpEj8quREwX/STxLMQrCPgvCNoA6xsvM59ii2UfaeOV8qbcLV/evnRRdda2pcoSoPzv
         ffoDcVLS9Qr3DkyarJITvVaO9yzELhUy1J46rJ1bgyarvsXX0FBOH3RPO3PLnyxtMAjo
         a/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788625072; x=1789229872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JcOig9NKf5o6Qbc3piYOUfGf8ABZUBGBIb0kMgo7Eu4=;
        b=N1LD5fr8ykwkaVixk9u+18WBhno+UUGyotQOoJGnNdK4rNSvMwIkDuyRKecFEw+t3O
         3FJX5B1DAI8BSvQz0wS27k7Scw+pS1vfGanqC03Fr0jWHyBsHt15NZWk0rpJC7EUCJU6
         cWOoYg+PfoKAL1j5VnsTW+4CeVOy7ZNkz/zXR4XlEQSF6hVg06ADSn8q8vcotA1/tggQ
         rwry/Gmm5BfWsiz8iSEIm2p0gvP7Ydoxigr8eZv3d+N2BoM/mCZly/SIp9qOfrJu8w4Q
         tGQasZKM+mH1VeJFGWvxwbluhPjz/1eLGUf3ckwwVwXahXf1fo/ouFNSxJWI4q4oonsf
         PjiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEM0trDRf8EbX0sQGaXoK5vzgMMyQxHXvZ/+4PWuHnFG0xzZCTAMDCXU0fhmgjW3zO3f5ugfutTEc=@vger.kernel.org
X-Gm-Message-State: AFuF++k0iaPzh27IJnZCF8gmkhsBdatLCynIccpxdTorjD0Zz95Krjkq
	JV5qJWc9po3FJclXxpKZTvWvryHdlAnnHKGVwsUx05LJUXMin8pKGZIp
X-Gm-Gg: AYBFou3JiIdAC2QiBuAXoIKRB+C3Bozoq73/DzK/mmE8JCgRTazUH3vS8fwDkuhXWt8
	G96yNDStW1Fxr/o/rOyl4x9ovV2gcuKSR6NtKrTBIGE7XUcebvt8XDjHKqP/Vkdmu6COqX52Cjj
	YN5rnozJe3FueUS7eh3efDoJk6f5EGxdeZzacg3pqhxspW996WSk06XtKuGww4rg8kUY4ZuNVaB
	q1Y0JsdDk0wRUgio9JLJOywVhJd66/QHKfS7yCZwFL7jv+XGsrDrViSNv7WnXJSg3aMhP49lvM1
	YRtVuySatXQIH5Kezt7pmbsTogHzQhSfEJSVt+N6yTtA5ip2/sfSY5JUEdmelIsppd9km0OHG7u
	fSCXvgaBdTvO9G1oVWt/ud7XNTDYiCI1g2pVas0AyFYg/1wo6tgLueu3ItyE0oTsxsONtJEDcRS
	qG8e0Ql4EUHMA8cNs2XFoSB7Tn6+L86wGITFdMWtGrGLzkJRZfw29EcGXet8/mJoF5Gz4PovSaJ
	VpAqK8=
X-Received: by 2002:a17:90b:4c03:b0:398:cb56:e92 with SMTP id 98e67ed59e1d1-39b26130698mr18530874a91.11.1788625072094;
        Sat, 05 Sep 2026 09:17:52 -0700 (PDT)
Received: from kernel ([45.251.35.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3346ea43377sm12992382eec.3.2026.09.05.09.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 09:17:51 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com
Cc: alex@shazbot.org,
	skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Subject: [PATCH v2] PCI: quirks: Fix out-of-bounds MMIO read in mellanox_check_broken_intx_masking()
Date: Sat,  5 Sep 2026 21:47:43 +0530
Message-ID: <20260905161743.5766-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mellanox_check_broken_intx_masking() function maps 4 bytes of MMIO
memory using ioremap() with a size of 4 bytes, but then reads two 32 bit
values using ioread32be(fw_ver) and ioread32be(fw_ver + 1).

Because fw_ver is a pointer to a 32 bit type, fw_ver + 1 advances the
address by 4 bytes. Reading 4 bytes at offset 4 goes past the mapped 4
byte boundary. This violates the API contract.

Fix this by increasing the mapping size to 8 bytes to safely cover both
32 bits.

Fixes: 1600f62534b7b ("PCI: support INTx masking on ConnectX-4 with firmware x.14.1100+")
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
Changes in v2:
- Fixed a typo in the commit message("ad" -> "and").
- Updated commit message to use "violates the API contract" instead of
  "page fault or kernel panic" to avoid overstating the risk, matching
  the feedback from Alex Williamson on a similar patch.

Link for v1: https://lore.kernel.org/linux-pci/20260827071940.B7CC01F000E9@smtp.kernel.org/T/

 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..b30ca4244f14 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3714,7 +3714,7 @@ static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
 		return;
 	}
 
-	fw_ver = ioremap(pci_resource_start(pdev, 0), 4);
+	fw_ver = ioremap(pci_resource_start(pdev, 0), 8);
 	if (!fw_ver) {
 		pci_warn(pdev, "Can't map ConnectX-4 initialization segment\n");
 		goto out;
-- 
2.53.0

