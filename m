Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284378;
	b=pHXagCCgeBppx50oLQ303S7sq0NtvehnyyNL3RfvQuCKRyzfTwhO5NYiCciWQD5+Aqmn
	 3NRMKLwVt9EYEhLoqvsu615Y+nNIHFTRp5k2Llxhng6OfD8VLjdWoj8OecUQanbP7sXI3
	 NZ/EuXdHm3A4MYgv5busJq7feAKH9hhPxDKHJj7Rl/QfFQ05pOxoD1omUGMoUc5a8nkG9
	 8sbWECk3ah5MQHUC8nUD2BzrCSA9OUDyX/kvrwODiIU1K6eFkq7bmumEt1tPzh00jr0UH
	 UKwvLsnZ8y/bKge1dNa6JP6oBTNdK3RljQ2tWBbse3tPu7cd0BjzQVLi5yu5DPHjv3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=akOgOFZaJ6AkC9My1p+5ZWxqR31Lz10lBBUyVueJ0Ek=;
	b=sLe8d+XGRcEFpc76OFAjgX1mMCnPKfLqyPLjsIzj9zanWiGiP2Ixqya353/ReYr0sCrR
	 NRwGopKtXLedwSJXu4xlMf2hl3Q9AmxHRPMipLw7VasDsdL0Cn3ZSkei+PFxdNJhSJOWj
	 aZkOZemXyaMX4pZ2cwqPN4Lm+qHaD2+rdxPkjNsZj0fQud9IE9jXjdbeEMdwTENoez4+D
	 4W2wlb94+hwKtolPejZ7mqgevWaqG6Kp8FMvQ8+rVZgmE8P57vrlacB2feI26pGe/XHKE
	 eD6WZMCV/Y75j5mDDpHu6WM6+QJiJgmjhIFUYqJxL8fa6nN1anZ/MKGOGsxF4pQoQBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BYW6ru18;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843160A6F7C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9843160A6F7C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BYW6ru18
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1aefd1bf74aso1357979c88.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 20:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284377; x=1794889177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=akOgOFZaJ6AkC9My1p+5ZWxqR31Lz10lBBUyVueJ0Ek=;
        b=BYW6ru18H3XBx3AsTpAR8Xqn7UK+BaL7xpqsLxLhqN2QvvOiWbVZxKkyqDcuQPdzVW
         2+gpsIN6qgJie5m6wTOQRhX+fUPxLjgcxBll/ZY5p5UUbL0d50ye8w6dG9XoY+qrh79S
         vVkCKtAvNEplr6QFFbhPl5rlOHja0HaBtUjHnvmCGW4fMecoJaMuo0sRvS36ezUY3TJn
         rpl5lcuLVLu+51qXKbkEETsCX/Rp45x3aXYPZ5W9ze4MZOYCpD/pPMmfcTFNTa4MM7O4
         pVBCqfOAZdqwjRZmG0VMJWPLnctGlbgb+BcQqD5NJ7ofHiuG6bpYKdyv2tR/xhNzr2NN
         taMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284377; x=1794889177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=akOgOFZaJ6AkC9My1p+5ZWxqR31Lz10lBBUyVueJ0Ek=;
        b=DPL4scSaoObHjWoRFzhoZCcZ12MdIpVy7ECMKKvvZd+QkrUd0eRaeD7wgW6sh/Lg4a
         vSIGQDXodZSz+1Jd8UtWEbDD0GEzvlisjBMJ9PRsFL/X/z5AwuJ6ryyZQnzxdLV1tSlw
         GoW0UIJdgLW8qaKYYT5T5TOOWZ6YaxEifAQY5Hxop+Kb8aZQkhvqKXjM+vkn2PCGtXxg
         oGpwJ+j5OaZnfBV/pV8mrpuqxqtdAy6Qu+rMOlhlo87jpVToCkDaa+TBLkaa5lqLY/03
         NdJnob53narn8i3yAYtd4zcItguf+PnuddgV4jaSfQtSgcQOFpd7JqDBQG8xR5FFApur
         Cq0g==
X-Forwarded-Encrypted: i=1; AL+hErGqyYJ0Irs42pJ4YwvOKn+vRie/6sEt7r77NdA+B1Me8wDS5T/1zBzfRs7RHODsV+YM7pzwQ1kUC4A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SeyqznqriYFu6KDYQXccyZCoUnoolhBSnWeSFWAjHwnzkhWo2
	lea8KvGqGAZHQbyuljBlMp9DtAyJ0uwOfIbpWBwlcvnDXzGAbPklk3at
X-Gm-Gg: AYBFou1vi4MWcBxUKeOyD9NVMS27m5Kg7qhOT7O77N/O1sDpoXZHAyU074qQhsrf6wo
	C5tsRVCs3rp4XV02amr7ycnaVupH/3u5eLkFVHn3B+omLp1DV+4b5Jw0dxXib3qeKl0/qYTBbxq
	FQtmbtQ7Yy349UmDyAULpXPu15fpjpjOdWRw4QlGRrFSgUO3YQhwYjrFLPD6iq3Kvh2kNL3eIwF
	6jSOSMfRWn+pLNop33gcngp8j2FPnfuFNdBAkmBMro6Z3aPeNVV4Zk6v66YcsmIBfhvH7UqrW3E
	OCdVRTZP2GlcvR27r4Y80kepMAnulweuNGE0HRdk8tSp65aDjozZ3S9PIgMUh95zOOqEZjG+OwF
	5T7ZlRB4dqdikFB1z3lKQaCjmeb0MLwPOm0hUEVOOIxtnaWzlcZXwrp1ABMOEtq/GR+AOGxMEdW
	RSsUoc6UmBSAX+tNdj6mgU5hG6Zv++WeuRmYAoB7eMMr/K54x8p6nm/XcHS728SbtZtfthFcH1q
	X5nZYA1fig9pUV91Qj8HCarVLhkC/7VT7jRgaDrhfeM4qky3vyTkaKx456FB2WCPoXf3Lmwy5OD
	0eIB2W7ww5ddxtUz+nP3rbKm3JBb/W4OQRjY6fPyUFAlwto=
X-Received: by 2002:a05:701b:4502:10b0:1ab:90a8:87a2 with SMTP id a92af1059eb24-1b3b5e25dbcmr1978641c88.11.1794284376568;
        Mon, 09 Nov 2026 20:19:36 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:19:35 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	bvanassche@acm.org,
	linux-pci@vger.kernel.org,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	rust-for-linux@vger.kernel.org,
	jgg@nvidia.com,
	akpm@linux-foundation.org
Cc: gary@garyguo.net,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	boqun.feng@gmail.com,
	alistair23@gmail.com,
	gregkh@linuxfoundation.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	alex.gaynor@gmail.com,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 06/25] X.509: Move certificate length retrieval into new helper
Date: Tue, 10 Nov 2026 14:18:13 +1000
Message-ID: <20261110041832.1730924-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110041832.1730924-1-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
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

From: Lukas Wunner <lukas@wunner.de>

The upcoming in-kernel SPDM library (Security Protocol and Data Model,
https://www.dmtf.org/dsp/DSP0274) needs to retrieve the length from
ASN.1 DER-encoded X.509 certificates.

Such code already exists in x509_load_certificate_list(), so move it
into a new helper for reuse by SPDM.

Export the helper so that SPDM can be tristate.  (Some upcoming users of
the SPDM library may be modular, such as SCSI and ATA.)

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 crypto/asymmetric_keys/x509_loader.c | 38 +++++++++++++++++++---------
 include/keys/asymmetric-type.h       |  2 ++
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_keys/x509_loader.c
index 0d516c77cc26a..174451b93edad 100644
--- a/crypto/asymmetric_keys/x509_loader.c
+++ b/crypto/asymmetric_keys/x509_loader.c
@@ -4,28 +4,42 @@
 #include <linux/key.h>
 #include <keys/asymmetric-type.h>
 
+ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen)
+{
+	ssize_t plen;
+
+	/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
+	 * than 256 bytes in size.
+	 */
+	if (buflen < 4)
+		return -EINVAL;
+
+	if (p[0] != 0x30 ||
+	    p[1] != 0x82)
+		return -EINVAL;
+
+	plen = (p[2] << 8) | p[3];
+	plen += 4;
+	if (plen > buflen)
+		return -EINVAL;
+
+	return plen;
+}
+EXPORT_SYMBOL_GPL(x509_get_certificate_length);
+
 int x509_load_certificate_list(const u8 cert_list[],
 			       const unsigned long list_size,
 			       const struct key *keyring)
 {
 	key_ref_t key;
 	const u8 *p, *end;
-	size_t plen;
+	ssize_t plen;
 
 	p = cert_list;
 	end = p + list_size;
 	while (p < end) {
-		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
-		 * than 256 bytes in size.
-		 */
-		if (end - p < 4)
-			goto dodgy_cert;
-		if (p[0] != 0x30 ||
-		    p[1] != 0x82)
-			goto dodgy_cert;
-		plen = (p[2] << 8) | p[3];
-		plen += 4;
-		if (plen > end - p)
+		plen = x509_get_certificate_length(p, end - p);
+		if (plen < 0)
 			goto dodgy_cert;
 
 		key = key_create_or_update(make_key_ref(keyring, 1),
diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index 1b91c8f98688d..301efa952e263 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -84,6 +84,8 @@ extern struct key *find_asymmetric_key(struct key *keyring,
 				       const struct asymmetric_key_id *id_2,
 				       bool partial);
 
+ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen);
+
 int x509_load_certificate_list(const u8 cert_list[], const unsigned long list_size,
 			       const struct key *keyring);
 
-- 
2.56.0

