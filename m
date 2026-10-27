Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078785;
	b=xQ3Y4fOZDFT6HY2fW6RS2Q1VYQ2K5Lg+3UEWqvVVfn/h+vabbb4bK1jjEdoiXw4CqXPB
	 SR3O4FPc0h8w0J5SByE+peKAUZ/w5TbLSSY1n3rxQyx4myX6Omc6AWTIx9TGJA3vw0B6X
	 9NJ07ZHEBdrvQkKv5XTkXreYkogZBNlKlGEmWx1zOd4MJxpKDx/r5sUg31kAmJJcFQQyi
	 0JQwwqg/44BM4WVlE7vzL82gTZK536N29kYML1paTMysmp6yE5OPFGWz0tF9iep3mRn7V
	 MbGyNwkMAFPvn1GDX3gEBHY4OFJsNBp/bkhxs44VfoJ4k5f9a6GtW3vn9KlcqdPdiSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DF2GX2Vr9/zlICZewnCnHZ+XwMhrVOLtr9YXmakaBJ8=;
	b=IZIDePMZIsfEp79anoRMp3WW6AmkLJVBSbjoYU5Tb7gZk2W4LANHzWVhp4MYUo05I72m
	 6KafAs1cTmpf2OjazYpJVFB6l+lGx2Qhg5VygysK2gEkpqWbpAPGdmTjSFL+CsvSifwcQ
	 rwZRqbdpsisKZtZbDCzwUo73/uecsiROwS0Uh9f35nbCQCoAYjrWd9yq1EIvFfH8V2Gxf
	 GqpVYbsOapeUN5kQVr04LrqJ0Y5C6w1E3WJFqNShLq3XjK4QukLNQDOFL3ewYjG6KjHd/
	 dRUBoBTWqV5UXvZMJSjhsxRAs//UyhaguIqlWyds2YxqFtUPKZsiiRe2Up2SkZykJpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ppBUU5Jt;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E10606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3E10606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ppBUU5Jt
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e987b4a710so2528645ad.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078784; x=1793683584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DF2GX2Vr9/zlICZewnCnHZ+XwMhrVOLtr9YXmakaBJ8=;
        b=ppBUU5JtRQffnmvz2rPfVCMM0am1iKNTT99vWsxtfGruBwur7u+9uMc877XNtqKgWx
         nIVOk9/LHIxR2M6QwA5WZvMpE75bn2BdBs19T+/oTV8He95F8ZGDE0Blcw5sWb/8pZC/
         c8ujYPR/A99kQKfnnuCMEUueJWGXuEmq+WzbTUqJzCrVRNDPORf8hL6d9SAx5WS++S4m
         GdnHr557QDvgp4i5dRMmTe2xa5zvSPTz24vrxafPuEG5UHK1fTBQwqOgKYqnF+/UNTWp
         7lzZQePJQVfpNjfYh0hTJDCZgTmefumMec75BK2aGFPYKLmN4nZdkL/8el6bwtDSqldb
         qUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078784; x=1793683584;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DF2GX2Vr9/zlICZewnCnHZ+XwMhrVOLtr9YXmakaBJ8=;
        b=APoK0r6MRmw3Ia0j471DEF1qL3pmxdoIKdnaITBhlViYN/R1McFb//nqyweJKHL256
         bpHi9wNVp7b93JBhmr3/rtz03AsEwU8otZbD7u7TyvvbxYFGhgvn45iICsKIytJCqIKV
         avU6wkhA6UeppnRf2dPHH+euiNlKn4rYp7zIHVLA1JuvHBT0bTbP1woKAgi247FkuaZ/
         +976skaTY2teB1x9hUjImGN5VtEas9xYe5Z0FAwYMZwukqIK3jjedrq8+YwblxV3e5xL
         WFXq7lqvYYM3ogaDzkJoinU3PhrzDNgDmavycl131bRlmd7g25Xw508XfTFbpJnRUo8Q
         mEXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVesVEqlNQv7gdzE0WhOJLQ71GBc4RC/vV88+OZsxIeCr8EYzwrvuVSPQYY3iLrGqdC69KLJ/y2dc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIG81SKmYyYubcJt2HAWw5/Nj/P7oXTw7DZ+4sZOcHGwM3EgZqV
	jAmQ7DtJlqbXKVvdoIC9t9/eeBPWMRrqvXtPsElRKJeCAU59kVVHFoIn
X-Gm-Gg: AYBFou3JZTsVBTEJ59BbQFor+O4zZOJUYOnCg9JeJtcqIU4GTIT0s2Zri5iF/+RPWcS
	FaMybMNWsJ0cVPk10HC8ob3+JdONPczFhLGGgJEb8vThfCRjcVI0AFW7iurMzhFdy4IVVlc0vRk
	JK3NKkAOSR88MGex20PCbrb9a1I26BIOx9SgJy7q/ILSQCcQMFpRfZJa+alc2qt0Z1CdJuohqFm
	3gbVr3rsJRYb9/vhGA2nc93sE8lydBa6FsH8Pr2i+3nALXEID78HrSHeFDQoL7uP3WVWUtWWuGt
	3sg3PS0R6xsvG7DF/v58/xu55uE7VklFtxIul8Wozq4BRGUhMt6NSeGNrGVsIi1fZ8F5++mN1yg
	3IN9PCxpvhiimO8GqdcsyW0kmJjBgMA5QF13jI2vLA3qQ6+6/aNB0BPm67CGX/vRt0QP3qH0Atv
	UuOxePeVe/rXaSy8ugkBR9KF3dyJduTH7pbOuMEyndwzWSpWXkK0zpTibQprg5csGVE8PQ0ZGt0
	2ThL7nkSFcW8WhDNZtGEDOLE7MvBONusWMKQx9jdJgr+1rYH1JPiHtCWPvluet2A9MSdms7SQ==
X-Received: by 2002:a17:902:e80b:b0:2e9:5313:8f7a with SMTP id d9443c01a7336-2eae3d1de56mr9703925ad.6.1793078784280;
        Mon, 26 Oct 2026 22:26:24 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:26:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	alistair@alistair23.me,
	rust-for-linux@vger.kernel.org,
	jic23@kernel.org
Cc: ojeda@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	bjorn3_gh@protonmail.com,
	gregkh@linuxfoundation.org,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	tmgross@umich.edu,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v5 05/23] X.509: Parse Subject Alternative Name in certificates
Date: Tue, 27 Oct 2026 15:25:18 +1000
Message-ID: <20261027052536.1722081-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027052536.1722081-1-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

The upcoming support for PCI device authentication with CMA-SPDM
(PCIe r6.1 sec 6.31) requires validating the Subject Alternative Name
in X.509 certificates.

Store a pointer to the Subject Alternative Name upon parsing for
consumption by CMA-SPDM.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
 include/keys/x509-parser.h                | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index bfd10f0195e01..c3ec2846695a5 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -596,6 +596,15 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_subjectAltName) {
+		if (ctx->cert->raw_san)
+			return -EBADMSG;
+
+		ctx->cert->raw_san = v;
+		ctx->cert->raw_san_size = vlen;
+		return 0;
+	}
+
 	if (ctx->last_oid == OID_keyUsage) {
 		/*
 		 * Get hold of the keyUsage bit string
diff --git a/include/keys/x509-parser.h b/include/keys/x509-parser.h
index 8b68e720693a6..4e6a05a8c7a66 100644
--- a/include/keys/x509-parser.h
+++ b/include/keys/x509-parser.h
@@ -38,6 +38,8 @@ struct x509_certificate {
 	unsigned	raw_subject_size;
 	unsigned	raw_skid_size;
 	const void	*raw_skid;		/* Raw subjectKeyId in ASN.1 */
+	const void	*raw_san;		/* Raw subjectAltName in ASN.1 */
+	unsigned	raw_san_size;
 	unsigned	index;
 	bool		seen;			/* Infinite recursion prevention */
 	bool		verified;
-- 
2.56.0

