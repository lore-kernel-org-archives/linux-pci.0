Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07699357D19
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557939; cv=none; b=Raxcg7+vNiz9K2OTRr6+D0UnQ5CFVRMxmfu4zfeDgS42y6O4s/wFgCXBGVJ+5aixJmp2ORB78DWPCRfcTSs8PdeJdUcYW9wbkRLbZD3ZZq3Sb55yDvFF2nBXthPc232C9p/q/mh8sIqxd5MrDluesR7o6jbhMfvAtZRSJQr2CcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557939; c=relaxed/simple;
	bh=0JGUpE4k1PmLAxdyW1CDm+kOaSuNwlxy5EWP/0iy7YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6j7dK0d5EmRcunS2+0uYwjICmjMopvR2aHmOO6431B/PDxdSB/b/VWtO8cP2pUgDoYRszvnuG5ot+HVBspLbt9EFNg06mu43hRWXxS/lPo/n43W51dkouZTrwqThCDR6omDHcEfGGDyE4/QNDGC6IfT/QzSkxtgHVS2VViNzuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkOp6dF7; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkOp6dF7"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so898898a12.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557937; x=1791162737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jIcsSTZcRttPSVFsvlIP8uLVExwGwURdPEd6Mb7+UkA=;
        b=CkOp6dF7bKujR2NLbnCjDt2tRvCu2JAPqR7XsVkRKsgj/Y6vx9+7fz9kS7g1ZwNckf
         CXq7EHdTw6hD/VLldSwzMMH4453lagngjaTgnju2YDB3lIymxxFoXawaRe9szEh4UBaW
         IvHg2tAtsdC3inEFQHNDk+MQP8Vcldey7IwQ13qT0ClpbLBT2rQjaM3hJGRfINxUkVck
         SEeQ4u3JI8R8HIM7i6o44ve9nT2kM4pjXMk6gE+H8vctzEancsAf9oHsGkl1azGEXs94
         JgkgH4pj66AgFcWoKHLVM7BrDdcDFySGxh5edchXfVQJO4CgVJO3LafM9ZF5ahdLrPB5
         Pxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557937; x=1791162737;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIcsSTZcRttPSVFsvlIP8uLVExwGwURdPEd6Mb7+UkA=;
        b=PZZ9BrLgGBOx1X9WyVJsSNvy2FSoCbJFGO2u0Z6YqO6vM3/+SaMQeZyGY++nzq0et5
         QxjX01xj0xy3tLouqGy6lQZ4NuJDYX5UsPJA+Hiv5ycTsnwRn/4Af9niuh+Ug42LGVI7
         kb5YIqo/7DNe0EPi6Ow1kdrLO0TZsKwS+i1EgXP0uKB7IOH3T3hEfGGtueoSyZ+k12NW
         VV5DlXFW+W15+izIzd52mrcBt3xChyOut/KsMLDA8evfT5LGtVpMwfxDwO+ZhWSRw4aZ
         W197v6koLCiwwsXlt+qjZIzT88WG+t+X8jvDft699j5pG1qkzpW+cKCybWX5s8JKXr86
         J1bg==
X-Forwarded-Encrypted: i=1; AKwUvBxaGDvHv6qyTI+zFpbhFyhUiwUODLtxqxXhDQKwzoL3r3Qys1sVyKFtwSxCFeTtcycp9DD0FZhBCH4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3CwI1aFx3xTt9o1MJUI6t3md8/jYBNqvnHlEfuTQ0vxaUbRpA
	6dff4vdt34aZb5N0jPQAiu474b3mNDHNaRZaN7K/qP8XGmmn0lLMRsPB
X-Gm-Gg: AYBFou35XfcCSZEdRNv0niODK74hVFbHjOuyDUI17cWXRzdltDrfDG6hhMBYemt3QDY
	XzYfTncIA9iHj/yGlhKIu5lzlZCn8JGipqWWRsZjH5f6QHx2FC4ZWntWirJTzW5ibyu+aryP633
	r69zPbGDDcEg336YF2zXxcKXRJhB7rGVmS2zl3Pcf6s+I3A2Pj7wurYY7iMUT8kvpf239Xwn+gT
	yf69PnG+RTdPeGIX2w3BjdjO1xnA0RnKPhRjqX0kypdHco9GFw3Em1e4ra01W6ijupgG9b8o3G4
	zdB++VGgSq/wFXhxkAKPVT7XXFpbPhWwoJkzjxNtyZKOcNhy0uv/s62+RoGE0G4c0R3pGmgnU+6
	joJX8LWj6Jkr6aY3fMe0Qe7PMX9YA4RI9Qy7mRwCwZ8UE2rh2o1kNfjiIIojR6Z0dOeF7XoKW0d
	ffqbc2ZE0GODJsHUzns7FqCOBvuRPShvZ7uGZrx+FlkNZ6xDNeUqqFEgfmiv8T7B7wkZdy9ACKW
	n1bj4qJy4naLe0J
X-Received: by 2002:a17:90b:28c6:b0:3a0:f2cd:fa3b with SMTP id 98e67ed59e1d1-3a0f2cdfd7cmr2894386a91.46.1790557937216;
        Sun, 27 Sep 2026 18:12:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:12:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: lukas@wunner.de,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	alistair@alistair23.me,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: wilfred.mallawa@wdc.com,
	a.hindborg@kernel.org,
	gregkh@linuxfoundation.org,
	alex.gaynor@gmail.com,
	alistair23@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	gary@garyguo.net,
	ojeda@kernel.org,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v4 06/22] X.509: Parse Subject Alternative Name in certificates
Date: Mon, 28 Sep 2026 11:11:07 +1000
Message-ID: <20260928011123.450800-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928011123.450800-1-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
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
---
 crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
 include/keys/x509-parser.h                | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index bfd10f0195e0..c3ec2846695a 100644
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
index 8b68e720693a..4e6a05a8c7a6 100644
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
2.55.0

