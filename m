Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F871A5B8A
	for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814893; cv=none; b=TLtb3i1yqe8UteOo9u3/MQ2o4k0mUrhbRxKNCFhZFKLN1F/MFLahPi+HaogjmFX3ztPkUeH4lKLliKH77+3az0C2Cmau1hqdw2Hc8glLsTZgmwREuSnmKtBq1YXsnvGUMxKpq4FFyCAkn4LKQc/dgkBjPsY0XsVDXQ9A2eF+B6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814893; c=relaxed/simple;
	bh=Cl5YG/mDjfpWhT2HWmxYZoFwquZLjjwBvTfgZj0lUIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KBD4WpTzIOfJhVIDIcT+86LkoC5fVDP4qxb8AJ9uD1TC495DoXoXm8Gl3GEZEam+oJ308H8YwHCx/IiSznSv3KCQQ3YtbQUUu3ndb0zeyk0FwtfFKJICjG4n4uSuTcT10A1kMtoe3jTSDpSlYF6X+n+tFGH2TPKD16xpjZGTR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAJ839kq; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAJ839kq"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-85590c5aeabso84260b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 00:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787814891; x=1788419691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DNt1zgs6qAkEI9XNYbk2SKsA/z50MMsFTX1oHBMliIM=;
        b=gAJ839kqdTlF60SrYl2P2EgyKFLTJV5ZdcqqfibYGCVTN0jPLBNzxBFxhmNiVepiLr
         jPKHQnClDLU368tx0zWCRrYHsX4GQG2n9J405GWc6Jz6de9UHh9YF7Y1nq+TkYekUCqa
         i4i+ObWD89WXhwB4/MYeJWcN+rGFbQgg91lNOGXRE0Bs/e+YYrkjEMPni4WbwWlNEBGu
         H1XOdutNj4EUB/U9CNfNsTVfjT00rWibgpPwvUOVkKk/bz2CmutIlCmWxCTCF/R12d/q
         gt+z3x8VnDfhL2XbcGxkH5GGRqZekPl8pYrVZOa0G8vlyXCF01RRawkGi2uNJsJCMerK
         RfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787814891; x=1788419691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DNt1zgs6qAkEI9XNYbk2SKsA/z50MMsFTX1oHBMliIM=;
        b=bQIk3nwFb0LtXKthcTfHVm74FvvgbU35hdjtpP4Yy+XTI+owUH3jwnepnRN/mt0OiH
         IBrALS6qgvvYMT/DTX1aVws75hwwaZCoy2tbAfkQ/0pPTwRZd53DvAHhWKTd52mYfvO+
         2oT8ZAJqRKzfIQe4YBTXwiOh0OG0/6PHdjoYWlU5I1WpQmtMZag4+ztTop8muZ5BG7x5
         BJAqiSNOvss2/vk1ZYs+XejBS+5E2MFhDPs1cn80JeAO9Bm6AIBTtxLpb+Jp5QUketWC
         mimfbLoSp092te5EtA95TwDMHk+vL7ZE2BgDipe+u/m+6MaQelom+M3+QaUyBa2SE2nC
         cS2w==
X-Forwarded-Encrypted: i=1; AHgh+RqvQUhH1VdUtkeQ4H96rzYRPLN5Vg67iZHu0KzxrR6IFs+XlIzuvHZtVHI6rmhMwQjBOW1xLA7GcB4=@vger.kernel.org
X-Gm-Message-State: AFuF++mLRw2JKQfTY1qhMMX5MY+jJoQuHmrn3O3tYljykueKx+tYeIuL
	6/IofJ1VUp3Xi1rebidR0B3a8z0ypNsLJLo2RPvEOsx41LuBmBuUqwk9qj1bNnJ8
X-Gm-Gg: AR+sD10Ops1SIsCAYfa0IXuVHCss5sBrERekkbn0Wf7cAF9eFuKCw4btiO2c0W9Abq5
	T3rpCMPWPz0KG/jpoFp8jrLBh+pSCTi2oNitZ3P60brKvo59IxX4aU9Rfa0/PJx7izXXXXh3RJp
	ti8NsCCCTtkS5njJnglrwDjQQ+M2DtohlzD+65xrn8NjklNGs+oM6OyEq7Whf3K3i6+oj7Q3SS2
	91WIlKv0FmdFam7eMd0K0xsgHZTZ/hjS/1CuNgMo3xXuKoPH1UX8cjG+fBQX3TaIKoFpatUa0KP
	9jHAwzAESgIofziC+fDIDH4ahyZ/WRLLyy7L4ZJCmSSe2K2jkh9yzRwVwgapZRjA0i5N7Sy6p/H
	WjJbAxqiGVOPxMs4jv4bahJWR25tROhtrHch8FeuHjoUqU5ObDjmrlHek8NsgNwrxwJbPcm4GV0
	wQVsSx6znkKLj/aAy+3M1F/Z+3poQcwlU/ZhaWoNuYX0GmqapHs4qZ/bJGxUAeSJPoaUbF/otA3
	VR7wOo=
X-Received: by 2002:a05:6a21:6190:b0:3c3:a31b:3949 with SMTP id adf61e73a8af0-3cf83c17574mr27206586637.11.1787814891560;
        Thu, 27 Aug 2026 00:14:51 -0700 (PDT)
Received: from kernel ([45.251.35.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283da25c09sm25999575eec.31.2026.08.27.00.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 00:14:51 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com
Cc: noaos@mellanox.com,
	gwshan@linux.vnet.ibm.com,
	ogerlitz@mellanox.com,
	skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Subject: [PATCH] PCI: quirks: Fix out-of-bounds MMIO read in mellanox_check_broken_intx_masking()
Date: Thu, 27 Aug 2026 12:44:38 +0530
Message-ID: <20260827071439.4480-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mellanox_check_broken_intx_masking() function maps 4 bytes of MMIO
memory using ioremap(), but then reads two 32 bit values using
ioread32be(fw_ver) ad ioread32be(fw_ver + 1).

Because fw_ver is a pointer to a 32 bit type, fw_ver + 1 advances the
address by 4 bytes. Reading 4 bytes at offset 4 goes past the mapped 4
byte boundary. This out-of-bounds read can cause a page fault or kernel
panic on architectures that enforce strict MMIO boundaries.

Fix this by increasing the mapping size to 8 bytes to safely cover both
32 bits.

Fixes: 1600f62534b7 ("PCI: Support INTx masking on ConnectX-4 with firmware x.14.1100+")
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
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

