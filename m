Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F8236A35A
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006766; cv=none; b=kB0N+2Rkbws4iQ8mi/EojDs8nwxrlaS1W3JUjYIkQrBLqdAJK7ukuxbMB5xUVM1rQl7KZ7QDBPDlX53/ns5fCZbcIoq2S+8mZ6bTcLv8lkna0paoDf2PFvoG2ViZ300Ph+nd+ARFHdH1UWVOScLA3UdzFd589UbjUSwRZ11gjYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006766; c=relaxed/simple;
	bh=4ssMfydNhx0e/pAaE8tlH9aVyGRcmjwMRizcNlTI8CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hB5T6y1Dt1Fcth8AQrMa2K7uhX4nqfYwu11U3N8eRiUuvlhapsT7xxjMb+3doSjSUHAQ7sPXmY5pYElqWWxne9BLe2atpF5cfkCdp+/Rll6FnVxVwSPp8hdQmoceVXi4N2KJv2KqR7PUKspMKj1KD86lcK0WLiMpQByYyD26Qx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=ValuYGQX; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ValuYGQX"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-90e8e70fa02so69956146d6.3
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 19:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789006764; x=1789611564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2pS9qh/eX0ccyCJkHhJeDU7kKBDT75Cqi6iNrcLGYE=;
        b=ValuYGQXfCCWanqWXroSgxt9zS97nTJOUIiv5uUOVJbLCDJTBkBzIuDcD3T7xXp3tR
         NiZi5l1lKWkEn654MHOFmxFHD2cVpVwcLH4IhPIG/NTZaJ6WJ92KkVUsjXYwY5dDJ8I8
         Ypf0gh6VD0XWJ7LNe4ryPJ++6gu7d1WloZv8Rp790XEggsAWVVI0MsSRVI1MfmT9SRNH
         MqO7+W+L006dQZzDqzPxnp6UH9E1lJS00pTPhCru3w8+AzMHG+oeRBs7zDLtHCWPUgv3
         WsB2Xx9CB2x8hxjQUSCtqFUeXBrh3fBsyiOZF8jPMN/pqSZeHbr7awH5sT4mBFqoTZ18
         B1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789006764; x=1789611564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W2pS9qh/eX0ccyCJkHhJeDU7kKBDT75Cqi6iNrcLGYE=;
        b=V52wKLVRMfmgJGs3G9sWOkdnSmHwB+XKa6StN+UJSXrljiFTrqoQjVgSwmjqYj/FWh
         o5sWZOSbi0Ym8XX7cDtaWN8Mwp2OS54+8GGkpbTQDpdElkuVE7iP0ZZi8EUEsPNBDozK
         t6DRt4NwoXF+V/oHAyreUxgAsRMoruqMHfcwhp6XniO/iwXp/l2fqXL6BGrdg7YfuBIZ
         KwCDLHKjJmEwfrnSkIDn5zEaW1MvXlY/AiRi3nxJbOX6RSHeFIfY62ZcRJuCDapawn6n
         k3ap+dFQHEgkuVgUShjRL1GGdUpyMLnp/TXWjnMafNWVqZeyfy8ebL1DGejlwktjtvKQ
         2Z8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwrB4BKRrHWmMJTUgOCMUVm3S4hfaVyFEtgRVjvWEn0JStnPPnmx+KedY4II7k8L4Ak+y1Cudkk/J8=@vger.kernel.org
X-Gm-Message-State: AFuF++nBvp+HGzeObHwg5nyglhRMyMBsv5JNSVQK/l2z9RgXWYiKxa4w
	vyfoxbeB8/wAFdR2iPPLe1HpYsX72oFdWNGMzVzHiflNTyOSWdOeQdJyTiLMkq8sqJ0=
X-Gm-Gg: AYBFou1+Ucvu8YzU9IedOd+UJEAkEberimAxgEbjhyhSE8G+K+jyxSuzcyFFUFzBXlq
	eIwZ5S3HLZh1kRmYElrDtdZHkJ9TV65DPDd1Wy03MKWHpX6oHIx1Zp5h1M7wvsBkSt5sT0CKT02
	er01ty4B8GKhjkvSwa9SjTYDAFMBfp/lKYSwXNnYPu4bii/zOh5Iy52ip85p9M4jWKXOyr3lZxb
	NwIgEYna2n0WkV4JZIwtS8c6dXoBKdGPTSyYPEJIodSVLacRL0QqYqzjOgFo5nNYcK2YxGORKMg
	GerHgn7NaC7m4oOp3+9MF3SSeQuNOLUeH5//rD6vFT78ru/Q2WtGCYchYPJrsrPz5EnrZxtMgwS
	TUKp/dqFE1lsQWu0x3stLp+rMXURHdgt1Ph+jPE7VRgbGv22VKuWKuqj8TaJheB9ZAgzolthz8p
	By+yNULmN7C9ozUUPQ9zYIi9dKi5dfKOduWp9qFHRLk64JEWPFchzmFElLfadN7tU7gkPA/YJcB
	yg=
X-Received: by 2002:a05:620a:44cf:b0:939:3571:bb90 with SMTP id af79cd13be357-9398042909bmr4404190585a.24.1789006764168;
        Wed, 09 Sep 2026 19:19:24 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb70fbdsm1561375585a.32.2026.09.09.19.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 19:19:23 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com
Cc: lizhi.hou@amd.com,
	herve.codina@bootlin.com,
	andrea.porta@suse.com,
	daniel@riscstar.com,
	mohdayaa@qti.qualcomm.com,
	lbiancon@qti.qualcomm.com,
	mani@kernel.org,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] PCI: of: make a flags argument optional
Date: Wed,  9 Sep 2026 21:19:16 -0500
Message-ID: <20260910021919.3421449-2-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910021919.3421449-1-elder@riscstar.com>
References: <20260910021919.3421449-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The address of a u32 object is passed to of_pci_get_addr_flags() so
it can be filled with the computed flags value.

Allow a null pointer to be passed, so that the validity of the
resource's flags can be checked without filling in the flags value.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - Moved this patch to this series

 drivers/pci/of_property.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 1e5d7dde467b8..a6c0cca986bdc 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -82,9 +82,11 @@ static int of_pci_get_addr_flags(const struct resource *res, u32 *flags)
 	else
 		return -EINVAL;
 
-	*flags = FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
-	if (res->flags & IORESOURCE_PREFETCH)
-		*flags |= OF_PCI_ADDR_FIELD_PREFETCH;
+	if (flags) {
+		*flags = FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
+		if (res->flags & IORESOURCE_PREFETCH)
+			*flags |= OF_PCI_ADDR_FIELD_PREFETCH;
+	}
 
 	return 0;
 }
-- 
2.53.0

