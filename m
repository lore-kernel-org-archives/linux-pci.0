Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982204;
	b=ogyMsxQgh8OU6G5T4/LY/fhW/p1jkgZq8qiQHupB1mzPxafGWBec4ZV3t0EBM1SwJ40e
	 0XWRtM63hjzGRMdH8pq18JckFbd4av3AzsUQ7hulJDx41R5Bm+E8CXX+Qypf/wSfoxVVq
	 9sMiU0C2lnD6r8+hME9XmYnaghheS45xFZ2MCjF8w0qTsyGE1os7uD+7slDtf6jXkafzm
	 sHRXf9IpLja7kwzpNWaTKeTKFvFNJJoVXilY6vN+wiohDTtX6uUX3G0Bgye914tBjXM97
	 nw26VJ/+dnUdslvgTE9zot4HNtxwEXYRDch/ZHR5UmAh87wTpDo6KCyVLYZkId1TtNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982204;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=3i/cpLj7jioj0efCF93XiFFApS0T2T4Fdajnk5CIbRM=;
	b=WlY6VY+QpGNNrD6cDca0jH9XrulsLsERnAYG4id1xad01c+nM4fEXiTtG7ym0irX5J4Z
	 UA3ws7iRGQEqB3ZohXaCmH7xANPa5Kjsto/yrt0HbaXKXCJcQPNzvp1WCABPMcS8mvI++
	 UhQBTMZhmvcGlHqLM7wqi7RVLNUjtcPCqNEzCQmPdBRY9+KmQLAnTA6npy6b3WkQSA1KZ
	 ClDFfFhJUwRhXniS6fVgCPwEVg2Xy5PIpu/PuDMuLYLKEMl07DLVbe5taacZ1ktPRlaVC
	 Rsr4SNCAnbvL4nu6T+BCn1nztXWYcDOAHxX0cAWaJOSIX0yocj9RGdzLZ4IyeRIZ+Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998BD606A32F;
	Fri,  6 Nov 2026 16:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 998BD606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jLkxc2fsHz52SGl;
	Sat, 07 Nov 2026 00:23:16 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A6GNBKi089350;
	Sat, 7 Nov 2026 00:23:11 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 00:23:15 +0800 (CST)
X-Zmail-TransId: 2afa6aedfef3eb6-c8e1b
X-Mailer: Zmail v1.0
Message-ID: <20261107002315181vFaB7Y_zoFugWEVkOSGJZ@zte.com.cn>
In-Reply-To: <20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn>
References: 20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn
Date: Sat, 7 Nov 2026 00:23:15 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDQvNV0gUENJOiByZWJhcjogR3VhcmQgcGNpX3JlYmFyX2J5dGVzX3RvX3NpemUoKSBhZ2FpbnN0IG92ZXJmbG93?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A6GNBKi089350
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 00:23:16 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDFEF4.001/4jLkxc2fsHz52SGl

From: Shao Mingyin <shao.mingyin@zte.com.cn>

pci_rebar_bytes_to_size() passes its argument straight to
roundup_pow_of_two(), whose implementation is (1UL << fls(bytes - 1)).
For bytes == 0 and for values above 2^63, fls() returns 64 and the
shift count is undefined behavior.  A value with bit 63 set cannot be
encoded either: exactly 2^63 rounds to itself and is encoded as 43,
outside the 5-bit BAR Size field.

Bail out for bytes == 0 and for any value with bit 63 set; a zero size
is returned, which encodes the 1 MB minimum.  The largest valid BAR size
is 128 TB, far below the 2^63 boundary, so no legitimate input is
affected.

Fixes: 192f1bf7559e ("PCI: Add pci_rebar_bytes_to_size()")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG x86_64) with a TEST-ONLY hook
(applied to both kernels) that calls pci_rebar_bytes_to_size() at boot
with pathological inputs (0, 2^63, U64_MAX) and two sane sizes (1 MB,
1 GB), built with CONFIG_UBSAN_SHIFT.  No extra hardware is needed.

Unpatched, the 2^63 input is encoded as BAR size 43 (outside the valid
0..31 range) and the 0/U64_MAX inputs shift by 64 (UBSAN reports "shift
exponent 64 is too large for 64-bit type").  With this patch all
pathological inputs return 0, the two sane sizes are unchanged (1 MB -> 0,
1 GB -> 10) and no UBSAN report appears.

  unpatched                               patched
  UBSAN shift-out-of-bounds; size 43      size 0, no UBSAN report

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 5bbdc9470a31..fd448dc7c322 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -31,6 +31,13 @@ int pci_rebar_bytes_to_size(u64 bytes)
 {
 	int rebar_minsize = ilog2(PCI_REBAR_MIN_SIZE);
 
+	/*
+	 * roundup_pow_of_two() is undefined for 0 and above 2^63; any value
+	 * with bit 63 set is outside the 5-bit BAR Size field, so bail out.
+	 */
+	if (!bytes || bytes & (1ULL << 63))
+		return 0;
+
 	bytes = roundup_pow_of_two(bytes);
 
 	return max(ilog2(bytes), rebar_minsize) - rebar_minsize;
