Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893098;
	b=T8ylUzqqouCRCdpQryGd28Wi+6Ms71gc1JF7nwPYQ3HEA3s0sRlgJOST1VFN5iMTl7Cx
	 vF03rN0CSh0qL7NmlQY9llFRPQpgtz3z7UTfq2pwWgyS6XzPuBnMMGT0NsLYIwJv5vUKH
	 gtdshrNenJD7rWuc9tS93HV5kVw7sO7Q5f50X66rsc/7qcyMSYR5W3IBBkrvC9WM5Yrao
	 Kp/VFwqFS47VAv8M/XKwpNseyvu33/EbwZ/jOZ4xGOSi+Lzb5auB+pJFqyFfNJJOkurUB
	 n36XPT0znZkGlCcxAKrg0ofoQue1OmqQQaReq9F0ckTP+VMWHxtw/EC7l5zrpQ46xTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5nwBNd9yUUsPIoz1aKyDtvky4U2vOuqkRzqvPOH8T5s=;
	b=Pqg4KEcC3tkvIQ+gLyYKZRL+C0jMma/ApOVHGFsoWH6SldNqaNQSNi32wWnwpll1lwQI
	 IsXNyo20NcUabLWNMM5uhPsNLzdUUSCHEpJB5Sj8UwzPfj3k+T195U9RbZbkDEFtop3Ym
	 s5r0XdXPm7qf3/LsEzuKv15ZsyuMPy8lzymuMYoywKO43iDCnDQZ4EhcnDPTZV6GzFQkn
	 1c7MMhd7ogabHsSTQTMq70wu6vknicBUNnygHCNKGFTLzBz8Wr/3j3wfvKvmd7LMgt5b8
	 JdmbPGMH51SrlA3D4Ei2a9iTEz7MPIZUEd9Q8w5vbjQu3vuDWr1KoeZIXflw8v8z/cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=RzErGQWX;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A197606D82A
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 15:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A197606D82A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=RzErGQWX
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-823e4047037so1443978a34.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 07:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar.com; s=google; t=1793893097; x=1794497897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5nwBNd9yUUsPIoz1aKyDtvky4U2vOuqkRzqvPOH8T5s=;
        b=RzErGQWXWtDnyIbyy3GTxW9gj5vi0VMVFINajMWK8dv+li28qECAg64FfIXnY/8w1Y
         1Ipbecb3x4TYKK3ruVo+UuA92bD9fhOacV97hmDZB7/0r8oIqlaHw0TmINmHeYDS4Sil
         3rG7b37+xKZRVgqhwr9w0em37IFnh5YgrfdJYSBi277DGvdeK9B2cQZiM5odv4TQWnfF
         zVcjxDT3GdRZ4HF7Dq8ZbLq4HTwkLYAKJ/CMRGEIiAx1bsrwzWTHwXYc+esLQIYdF8VJ
         cNv4Kc1a/+PYUJnUkzQSpg28cTgB8uzcWHfx34vLCalu/TReYTEg/1XcsAYgZGChXrts
         kFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893097; x=1794497897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5nwBNd9yUUsPIoz1aKyDtvky4U2vOuqkRzqvPOH8T5s=;
        b=hTZIQov6GIqzNrWXeEF1VIAGthKIys8tYA+Qmqu7zdPLzIZxeczxceRy2vvx9MIAkv
         p2ceAvg7aYsAOJ5nzSeLgsj6gSWQmZqTmzmIcd/RBP4a4hW+QvCTrCcoESCHcdYcPmAB
         OEJh7QNXF5f5TK3BJ9UHajxbTMsJhGCV7anWfozmY3SJXvYzHw0MdSdwrJsA3vY2Ofmv
         MGBOHlVD3MFYZyG57UlPXb4igAlbb539fkeMA0JiGt4FYGsw08EZE7mgpXD2Ljtc3H5W
         RM68Tt1WBisOZVQAxWmv0w3VptP6Mv90u/pT2UiNUQki0wEJ/uGiGGCLp/rFFt49B8Ey
         YVEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwy9MwVwFi5lJJppkiSEVcfcLwY5Xzsfb53MGyP3Eew6kiXVEFQ63K1Kq/3g3ievth0fug5m8OtcMM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aGSu4k0fnnugxurMhFHzjR3OAlEcytwdqdrIuKpDX494eaOXC
	FIfQQgxOSBS5m6XOwldIU5Glmii2Vu9rND52LMWiU9qrvddbbyOSE5BDxZ+UMdb1cxA=
X-Gm-Gg: AYBFou31Lzrm7GeXMdbkVzxJTf1m4qzcfj4P80R+OfGsUVhZgAgaf2e7RQCELHhbDXl
	yihQJF46gG4+v0v6xhnuXN2m+8JlWF0KHWBMimqMMeJZvtpT2OoW7ayy/B5VkKQZo/dF77I9UqY
	3TvSO4KQ/0QlldHANp4ra5Foqnn3/S3d/7X9vInJivI75fYjuJ5gfhM7eX9Io66q/9E/eWA8eLB
	FqH5Nwd8StP6p3aruzKCQQonCPz73vQ7l2EUdmqu8ZoEufct4AOi0q4czSbVWbXzHEZ0xfKFhlE
	wGMQqqMM562fn8z817V6c0+b6xi11YA3zm1JkiinZJSohRkLk+5eo+Q7yFmmxoQxLBYe1/BrpYj
	TEOxndu984TNGeL+0EOF40TuX++nR9YUQOr2bZ78qKZ4NQhbt9Pn/HpzD8i7LBfO6QhM9XW1Lga
	YY5Q1dv8+KvSjIsg9luQhHyxtlBx55Qz3ou3fDfusuPkc0sX8qRetGSuj5ns4MENZwyGScr1Sl+
	ZRl9uh7Ye/SQKTGGwxV2MtOyXJozgVkc0MlGX+nMLh+d06uYCr0bDqGPwyBe5GM5qfJ667AeudR
	7laF0MOmnNfk0Qv7W09uDbF2E/cqHBVgLw==
X-Received: by 2002:a05:6808:6ec3:b0:4eb:80c0:f4bc with SMTP id 5614622812f47-5640deeb2a2mr15565977b6e.10.1793893097040;
        Thu, 05 Nov 2026 07:38:17 -0800 (PST)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef6e3bsm4435329b6e.5.2026.11.05.07.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:38:16 -0800 (PST)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org
Cc: herve.codina@bootlin.com,
	daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/4] PCI: of: drop the reg_num argument to of_pci_set_address()
Date: Thu,  5 Nov 2026 09:37:59 -0600
Message-ID: <20261105153801.435566-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105153801.435566-1-elder@riscstar.com>
References: <20261105153801.435566-1-elder@riscstar.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reg_num argument passed to of_pci_set_address() is always zero,
so get rid of it.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/pci/of_property.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index d351f500c2ce1..6236dfaaae628 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -52,7 +52,7 @@ enum of_pci_prop_compatible {
 };
 
 static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
-			       u32 reg_num, u32 flags, bool reloc)
+			       u32 flags, bool reloc)
 {
 	if (pdev) {
 		prop[0] = FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
@@ -61,7 +61,7 @@ static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
 	} else
 		prop[0] = 0;
 
-	prop[0] |= flags | reg_num;
+	prop[0] |= flags;
 	if (!reloc) {
 		prop[0] |= OF_PCI_ADDR_FIELD_NONRELOC;
 		prop[1] = upper_32_bits(addr);
@@ -135,7 +135,7 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
 			continue;
 
 		val64 = pci_bus_address(pdev, &res[j] - pdev->resource);
-		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
+		of_pci_set_address(pdev, rp[i].parent_addr, val64, flags,
 				   false);
 		if (pci_is_bridge(pdev)) {
 			memcpy(rp[i].child_addr, rp[i].parent_addr,
@@ -168,7 +168,7 @@ static int of_pci_prop_reg(struct pci_dev *pdev, struct of_changeset *ocs,
 	struct of_pci_addr_pair reg = { 0 };
 
 	/* configuration space */
-	of_pci_set_address(pdev, reg.phys_addr, 0, 0, 0, true);
+	of_pci_set_address(pdev, reg.phys_addr, 0, 0, true);
 
 	return of_changeset_add_prop_u32_array(ocs, np, "reg", (u32 *)&reg,
 					       sizeof(reg) / sizeof(u32));
@@ -470,7 +470,7 @@ static int of_pci_host_bridge_prop_ranges(struct pci_host_bridge *bridge,
 		/* PCI bus address */
 		val64 = res->start;
 		of_pci_set_address(NULL, &ranges[ranges_sz],
-				   val64 - window->offset, 0, flags, false);
+				   val64 - window->offset, flags, false);
 		ranges_sz += OF_PCI_ADDRESS_CELLS;
 
 		/* Host bus address */
-- 
2.53.0

