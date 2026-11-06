Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982199;
	b=DNeG80fRrdVSM+xm+4DmlI6fxu1HGf4cYXjeaHIgIoh5/TiNuk2HhocPoNnApg/VWAwH
	 4AULqJ/wooTvcczLglQlJiv0rlhPwe0x2OEYxtTwz47y9sz1MC28eXDS1jRF1AsNhDlyK
	 +fglRbhjopkVPAQIci0PDunekYLMMp5GjOcVhmF6em0iGO8ktZHIO6AbFkMg6mUhjeRDX
	 gtJDvp+k6h8FeFncbqFszd623voWp6SI6pLi5XzoZHSjKsEb9qwXg1FJDOwmVh/EbDNY+
	 XnKVxbk4yzwyuAZLs/V7astk3iFypljjodU1rYElbpUPhN12Ebo4XURKe8yJ3fmbBYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982199;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=wUqjA0sYy8npT9+d6Tj/dCL65ia0S9H97G7PC1jfIH0=;
	b=HSm523Z8TuRhNw5Jyn8UhR4UtjHi6KzSp7dFbpRLvg3gIfLcX0mkmVXS2LhZvehYLQwy
	 QzwQ9AQ8j6D5THFLc/TZgaSygjBZmvpW6lDnsqgh4PEgUNpsVXnV8W2tXGRGCQCNw3Y4T
	 qgUcUqdsIW5S7fvLl81EX/bGcCkGVe1+JsJ4wIe/4BpJytg0rl9v4jBprGPdjnQy+unDs
	 lIPRdJm8DSEXuK2Sc+jUa7lQ1AbNj5bjP5o+f1ba9vmRynCS/+7PP7U+MFtqxYX7/5s1f
	 MoJjQRXKpe/WiMe+oxPe3y60njBpMdkMt1D0tw/86yGX63CGUlrkVQd1P7Yj4i0s6yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C371606A329;
	Fri,  6 Nov 2026 16:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C371606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLkxc5jVLz8XrrX;
	Sat, 07 Nov 2026 00:23:16 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6A6GN7PS011564;
	Sat, 7 Nov 2026 00:23:07 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 00:23:11 +0800 (CST)
X-Zmail-TransId: 2afa6aedfeefdbc-c8d21
X-Mailer: Zmail v1.0
Message-ID: <20261107002311316z2o2PFtFGoXh-VbqXtTGg@zte.com.cn>
In-Reply-To: <20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn>
References: 20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn
Date: Sat, 7 Nov 2026 00:23:11 +0800 (CST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Cc: <mani@kernel.org>, <kwilczynski@kernel.org>, <lpieralisi@kernel.org>,
        <kishon@kernel.org>, <Frank.Li@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvNV0gUENJOiBSZWplY3QgbmVnYXRpdmUgcmVzb3VyY2UgYWxpZ25tZW50IG9yZGVy?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A6GN7PS011564
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 00:23:16 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDFEF4.001/4jLkxc5jVLz8XrrX

From: Shao Mingyin <shao.mingyin@zte.com.cn>

pci_specified_resource_alignment() parses the pci=resource_alignment=
boot parameter with sscanf("%d%n", &align_order, ...) and rejects only
orders above 63.  A negative order, e.g. "pci=resource_alignment=-5@...",
passes that check and later reaches "align = 1ULL << align_order" with a
negative shift count, which is undefined behavior; on x86 the 64-bit
shift count is masked to six bits, silently producing a 2^59-byte
alignment that mis-aligns (or fails to align) the affected IOV resources.

Reject any order outside the valid [0, 63] range and fall back to the
default page-size alignment, matching the existing handling of
out-of-range positive orders.

Fixes: 6534aac198b5 ("PCI: Bounds-check command-line resource alignment requests")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the
pci=resource_alignment= boot parameter and a QEMU e1000 NIC; no extra
hardware is needed.

Booting with pci=resource_alignment=-5@pci:8086:100e parses a negative
order that the "> 63" check lets through, so "align = 1ULL << align_order"
shifts by -5 (masked to 2^59 on x86-64); the e1000 BAR is resized to
2^59 bytes, which cannot be assigned, and the e1000 fails to probe:

  unpatched                            patched
  requesting alignment to              PCI: Invalid requested alignment
  0x800000000000000                    (order -5)
  e1000 probe failed, no eth0          e1000 eth0 probes

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bca3a5d84cd9..c2260ee1f956 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6605,7 +6605,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
 		    p[count] == '@') {
 			p += count + 1;
-			if (align_order > 63) {
+			if (align_order < 0 || align_order > 63) {
 				pr_err("PCI: Invalid requested alignment (order %d)\n",
 				       align_order);
 				align_order = PAGE_SHIFT;
