Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893096;
	b=EUYwrGmq/KDnwBfPw/mEu9ufIwoQGv+CXH+JGQ8qn//kNU4zNLQHc8XKMyvEfV5Na78P
	 7iX9pePZlJpnvoeYubiA+zlf1spi82+VZYN1x+jaLxkwdxi45EWvoCVm6HTQkPtZmKJNw
	 0tIuz1zcC6fFxLAT2bUmu365E2yp13J7BoBP6WaB5Z+C0tweBdEDZ6lMT8r91BKbYkFPp
	 aaj2rcZwxGEKgl4TaHSY0REXBim9KekVD+YStZRJeuAxtz47StmWwt7NyDWcDrE4Qg6X9
	 P8y4LfAysoDAwYhaVjt9l+vXuVjHpoVJCWSlIev6zh0ZeJ/0MYzWn+VDoUJGF5NYgMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=F4fUx97bi7pwf9S3207BDQnL8pq2tpTO+X6+3lO1kvg=;
	b=r7d7p0XtKaElvO8g80BYYb9slR/taWf3E9uWkizcAF4o6v9piB1Z6sIFs7bOme9ISar7
	 nXikT9DAtkOohbN7YltISrRT/sEFi79m2h4h9JRMGkqq4zyBVd6oKAEEyJIeakzRRK2gM
	 hBl07FeUP6EGkGKtcNY9JfU3oIQ7AHWlwUgyC7QixZZHrSyoUOrD4e1y9eiFZPasfOxSy
	 3IXvBVYHCyGuU3i3pdoykBLo8l5RLMjk89+vZP/WhpITGYJpkpPB8CdSxbhzF/6B8g4pC
	 1CJ6OP4/nGyFECmLJej8DdHF38Yy5ovStbio8uOKeTUMbJW4ABlKvAoiCNQ2+lcKb9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=LqeGpx0o;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458EF606D81E
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 15:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 458EF606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=LqeGpx0o
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so1409981b6e.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 07:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar.com; s=google; t=1793893095; x=1794497895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F4fUx97bi7pwf9S3207BDQnL8pq2tpTO+X6+3lO1kvg=;
        b=LqeGpx0onwzV4nNyO7gBwy8hvbgQTlF1kY2WTObUIJzlJA0199/1A21cmefHZCNJUp
         F36lt/w2/mBVr76879+aQx28ku60ASRAh00HEjWJ6kSUN7txwODiQWoCsDACTA7t5mAU
         te9uqemzhvEIqBrRkDaM+F8O0X9/tlmKrShAHkJyGUnFTCqHbAmk9WeV/pZ7DgCO/cqK
         oBUO0YrZRxytKcBuf0CF+umwg6WESLSLbMCUhPoHGnRU3ACelIjdDPXmMJX6MudTjKqM
         twBfOVYYyWQThXl4gnAWbMqxSK3nP8Oiz0GWtV2xqXpMjCuA/ULcXu/bqFiMGPlpVTDu
         EEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893095; x=1794497895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F4fUx97bi7pwf9S3207BDQnL8pq2tpTO+X6+3lO1kvg=;
        b=kh0hGeQvg/imqtd7vWL6udpVluBHA8v8v5AunfwujqBAJDBZCIdViHnNUW4ftct6zj
         yllp2HSKGOUbskL7KjkEg0XauAbHEI4Xhi+tyGyVr3ltciQMdyJHhNSJOScM1NyIMOc1
         i2QTDDWLhW3azr30PohamYMCad9cxJmk+llmBYJa1eT1l6g5l1aD5PKxVBUpLr3QxNFO
         xZcWZiGkGsEKOwLl9bqiOUFM6HZfJDbU9fKmW5VsBbiGN+tjkLW2Crf98qkHhtNScvku
         7zmfzSGU9W+teB+wNNjz9wehKGkitU0tKje/fAiJ16bhI3U9KtFX1z3e1ZoZcFbpQQ8F
         Cbbg==
X-Forwarded-Encrypted: i=1; AKwUvBx3saGanqI/09Q+uOqTopAIijjMMh/SsPqAyYlZEF4o/wcywbfajkTzY5IVDz1TxMBAi9JLvJDgKwk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YEi7LUiFh0dKGAu6W1u4BQBYmAzSKEg9vo7CQY6gghbWO8dfg
	yH8w806pS2Cm61egYMHgmNkLbGhs0CpXSM4exrcmCpGfQuRWKLQ3p60ItcJApXq6VUA=
X-Gm-Gg: AYBFou0geQ8C54tum/jKlW9lI3sFT4zzI4KIEY7aN1EMalW8lnaTo9V3/Q8no+Mlrmj
	5x1GmdZ4+NUW/rmmuR/xuxREYGnXXWSviDXWJY+F5TAtYN9w3awGTKSLPlHzoXcT1Zz9Vp6iYmS
	S+hqzBbHt+Y6gNxv2Tws0RJ7U9RxHIjWmyva2tDfucWsIynjsB5MIGquKeETWStnBE2uePev0Uc
	FMjhOGOLdp+k5JLS43eNMYeolRmuDX51UhRLB/9B1bFCNTonpLhhagkm1S5w4VFG3UADDswE4f8
	+0MbfPv2POhkdcFDxtbZTY6RNUAne70LhYPAIscz0GKaNdsb5nfaWjI3SjqYkgehsQanLNGRyHk
	hopuk7BRPs1C9IEaraX7FjyZf8hdvaVWGixg2nrmYJVmDnOLkfpFTgisL6j6qp/vQGJMq0to1EI
	vQtF4LkryacDdGVEu/RQGID2924xDSg/+o50JfF0y9ghtOebhuRsRNbb291ykqriOepUCT24KbN
	JXNJq5sGjQVlgG2qUtkWrUQJ9kwboqaupFRmltPuNE5csQR4IH27MC4wJCKqykdhkUqFqOrRFAW
	8D2Zq1mF0dYLyXxs2/Qk/bsrNrbLCtOJ9Q==
X-Received: by 2002:a05:6808:1527:b0:4c4:28a5:1885 with SMTP id 5614622812f47-5640d9278d9mr14332042b6e.9.1793893095035;
        Thu, 05 Nov 2026 07:38:15 -0800 (PST)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef6e3bsm4435329b6e.5.2026.11.05.07.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:38:12 -0800 (PST)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org
Cc: herve.codina@bootlin.com,
	daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v7 1/4] PCI: of: avoid allocations in of_pci_prop_compatible()
Date: Thu,  5 Nov 2026 09:37:58 -0600
Message-ID: <20261105153801.435566-2-elder@riscstar.com>
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

Three compatible strings are formatted in of_pci_prop_compatible().
Their sizes are known in advance, and the largest is 16 bytes.

Rather than dynamically allocating the space for those strings, just
set aside a buffer on the stack large enough to hold all three.

This avoids a problem that Sashiko pointed out, where an allocation
failure would cause subsequent crash because strlen() is called
unconditionally in of_changeset_add_prop_string_array().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/sashiko-reviews/a647bd56-7dc8-4fec-9d96-834622054cdf@riscstar.com
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v7: - Don't check for snprintf() buffer overflow (buffer is big enough)

 drivers/pci/of_property.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 1500740cc55d2..d351f500c2ce1 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -331,27 +331,32 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
 	return ret;
 }
 
+/* The three compatible property strings have max sizes 12+1, 15+1, and 13+1 */
+#define PROP_SIZE	16	/* Enough for any of the three strings */
 static int of_pci_prop_compatible(struct pci_dev *pdev,
 				  struct of_changeset *ocs,
 				  struct device_node *np)
 {
 	const char *compat_strs[PROP_COMPAT_NUM] = { 0 };
-	int i, ret;
+	char buf[PROP_COMPAT_NUM * PROP_SIZE] = { 0 };
+	char *bufp = buf;
+	int ret;
 
-	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =
-		kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
-	compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] =
-		kasprintf(GFP_KERNEL, "pciclass,%06x", pdev->class);
-	compat_strs[PROP_COMPAT_PCICLASS_CCSS] =
-		kasprintf(GFP_KERNEL, "pciclass,%04x", pdev->class >> 8);
+	ret = snprintf(bufp, PROP_SIZE, "pci%x,%x", pdev->vendor, pdev->device);
+	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] = bufp;
+	bufp += ret + 1;
 
-	ret = of_changeset_add_prop_string_array(ocs, np, "compatible",
-						 compat_strs, PROP_COMPAT_NUM);
-	for (i = 0; i < PROP_COMPAT_NUM; i++)
-		kfree(compat_strs[i]);
+	ret = snprintf(bufp, PROP_SIZE, "pciclass,%06x", pdev->class);
+	compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] = bufp;
+	bufp += ret + 1;
 
-	return ret;
+	ret = snprintf(bufp, PROP_SIZE, "pciclass,%04x", pdev->class >> 8);
+	compat_strs[PROP_COMPAT_PCICLASS_CCSS] = bufp;
+
+	return of_changeset_add_prop_string_array(ocs, np, "compatible",
+						  compat_strs, PROP_COMPAT_NUM);
 }
+#undef PROP_SIZE
 
 int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
 			  struct device_node *np)
-- 
2.53.0

