Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FCA43F4B5
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382614; cv=none; b=mke5POklvose1XgI8y1L/ki8rINGlPpAmORhoiqazHBGGSCL1c6kG4YSf1PfrJ+bAi4P11fnPBi4owEfA096Z0uSV8c5PVMc0lpUnhBiLV6cxFkpkNCHQHvOMRYAAo2EwhaHqkdaAnvfXrbThV+jJ7q8TRMJ5U6/MsmbbWhaOoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382614; c=relaxed/simple;
	bh=Qmkf+XiGZRy30vGcRvQw4oCFml7R+FQ4UhT7npyZ/iY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5P2tLouVIoJwpOkNii4oSoKWZB2NNRqYOPpGkJ5RL8g/iM+q2Mm4ebilXAqq65+Dw7GhME+0B1ZIS3OD4WM/jEGjinvPUnp2K/lJFEFpIsXFP+vewaWqYgAfWNdDPiTGBNSw4v1ERHWyGIxqtHb29LVSM/bmu0lCkyK4gD6DOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5q6yfo4; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5q6yfo4"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-828f4eeba13so1198978a34.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2026 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791382606; x=1791987406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jgfFU4PoWoQaUk98vWn6gXhkSnB1yU0D/q7IV/OvUeI=;
        b=p5q6yfo4AjoekKy2BPgPXnZ8jVojhWWEts9/jCh3R0Jit6Z6a09O6THePg1rk3RcmX
         3jn1MmiZmhL6GICR58kEdimoK6sd4mu8YmvJ2JeiIGOoxEqiPAWtTw8suNsmK6M0vX/s
         TtjSKZcN0RurG8HaE0F18SdGQt++8neOhN1AFERlpJbbfPwibCzA6ptDWkY4TGDzHZhb
         bok/Qi6LZ5Ufyk6wa7Lfft5oruCbK9dwEmtYapoAlJ+64HZLFamefjD4DwBgEOdNgAfY
         ARVuf/aGdV6ad24qTYN+fWpmK0IraMTd38Ia6/6xIph7ogMDDokuBh3K2EmzPXd82HIC
         +PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791382606; x=1791987406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jgfFU4PoWoQaUk98vWn6gXhkSnB1yU0D/q7IV/OvUeI=;
        b=IBw/eUjr1dGXTyqAlkQ8p9HiKANbIvvGmRy6q/xqYG6NI+IWxoAHnbsjWr7nDtjfOj
         seyMkX1BmWcZnuQpwj2EWnQsXG2g3ldyNPcLPSymBjenaUM6P93DBAOgwPjaZq1jFYky
         lYBnMz0HfkCmL3AN41daNoXIVGDSJkMWJIN3kq2CJK/MsFFa2URn1DkoITUshPfvo3Ej
         J50tVQKKqbzMj79TAft+o1suraJ/Rnmd44Wtl9MjSpq46qGdM07ihLgZNEWPR/ph05R6
         /qtC8+NgIUxcmkewT5jqDZ3KfU56pXcSTA/dyrwrLu4FxpMThbDTwd3sSpsaIz/i1VU+
         LRCA==
X-Gm-Message-State: AFuF++lIEld0efknOWyjBgHTW0BFdxo77jFl1ULpUy7Pjn1BkvP8h+qH
	5fD1JSFSuqWJSq+/jPj3BU9yRABYUWnDw2eZKem0fcV9/Kf2GoA9pn/oN/WXFy5qMhM=
X-Gm-Gg: AYBFou1H3dLlEecd91kpAZiZfSw/4auOyNMYod8Nag3IV3NQVyQgNE+4YF8dZMYmsjP
	bpkH4VT2Y98tcmeCl0Wa8lhoE5yYQhb2jsB8B3eMnCVj4X2UD7ZROR/Ke4n9wO/BdtBq6S8xKbS
	9Z1ydozrvCOAWFWPl+xW1ulxDSXNjUNWeEim9ARbEm3hqLOyCCLPVeNRN3c7E12DfznWMNKB4/f
	8QmP+qlKmRJPdRilZBTjZU2cEzvZcJrXFvMda7Y/n7/4Ceuzv800xgquJlyRqqPhKeEPbQVDuZU
	a5I+ydHb6/E8umStCzYBbHcdCf3n25Dmm02tudKoU+Jdd75EGtx5hGKA17dCD3w3YSgpcB6dMk4
	oWlFQKPIf2j/aoHmzWNaHqgegem/OMRqf3SUQBuqXNfja5+VihR9DywNJ4/LjBFG5SlDNRyHBHh
	MdwdvhNd0nc99Qi6GKdD/9sEtIHjdUCuKZnlm6t4iOct0a0v6r8t0tub3CBa/oWuoapu2f4Thkh
	Pj2oS9FLV3FjKNEAH+qjqTq8Q3XdT0dQ9/AxFKK
X-Received: by 2002:a05:6830:4884:b0:81a:9522:f00f with SMTP id 46e09a7af769-82acee9056bmr2732551a34.6.1791382606170;
        Wed, 07 Oct 2026 07:16:46 -0700 (PDT)
Received: from MacBookPro.taile6ac9b.ts.net ([123.113.35.89])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adc3f6d5asm2899704a34.12.2026.10.07.07.16.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Oct 2026 07:16:45 -0700 (PDT)
From: kai zhang <zhangkai.cool@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/P2PDMA: Add Intel 0x6f00 host bridge to the whitelist
Date: Wed,  7 Oct 2026 22:15:58 +0800
Message-ID: <20261007141558.59852-1-zhangkai.cool@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For P2P paths routed through a host bridge, the P2PDMA core consults a
whitelist of known-good hardware. Add Intel 8086:6f00 with
REQ_SAME_HOST_BRIDGE so the entry permits peers only below the same host
bridge.

The bridge was tested on a single-socket Intel Xeon E5-2697A v4 system
with two PCIe GPUs below different Root Ports of the same host bridge.
Without the whitelist entry, peer access was rejected before a transfer
was issued. With the entry, 64 MiB peer transfers completed in both
directions with data integrity verified while the IOMMU used translated
mode.

Assisted-by: LLM
Signed-off-by: kai zhang <zhangkai.cool@gmail.com>
---
 drivers/pci/p2pdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9334eb314663..84413920e39b 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -542,6 +542,7 @@ static const struct pci_p2pdma_whitelist_entry {
 	/* Intel Xeon E5/Core i7 */
 	{PCI_VENDOR_ID_INTEL,	0x3c00, REQ_SAME_HOST_BRIDGE},
 	{PCI_VENDOR_ID_INTEL,	0x3c01, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_INTEL,	0x6f00, REQ_SAME_HOST_BRIDGE},
 	/* Intel Xeon E7 v3/Xeon E5 v3/Core i7 */
 	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
 	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
-- 
2.54.0 (Apple Git-157)

