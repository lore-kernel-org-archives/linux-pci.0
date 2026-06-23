Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3513A3E73
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 04:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190502; cv=none; b=haWm1xCsl/JTu7qV1D//lbCKxSoQC1rHusRzONihKISSkfi4jlB+Y949eTB6PvmhJkkb8L2eS6H7BR7Gd5Thy0jr4yt1La/+J8P9vfrc5A+UIuD2aDzuueCkOD+5R412l3hc598tsVBpM++M2lIFiQA4nSo3euwNKRLbjVdWhJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190502; c=relaxed/simple;
	bh=P4j28MQiUepWUPR6ls/AjPt3mUcsoZpAfSvc8hS1j8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGki2rlQUEfGeSbUgcqS+F6L26AGJU1A+TJJVJGxo1cpX6N5VP6zEsExwBDwawbdvqDzNzAigvgYp6v6PDYlaNQtmjlnVvxCfvw8vEIehJJcK3787f5fAC0zpI5ShDkoPlSLRGQtD+Oax1KvVhlM3jPvXPos99ksEz8ohhPDe/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtUOTEJ6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtUOTEJ6"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c6afcc99a5so2760755ad.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 21:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190500; x=1782795300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUbYMnUT89p2VCtovUWaFf0u4bBhWvF56ocO3qt/G5A=;
        b=FtUOTEJ6/hFifDHj8HQG5IG+DiGbVCYAkWu7prSPWU2c5qv6Om2/SPA4Ys9NOQeDr2
         D+68Vsu9wu8/E1uqwFgZJ8ImjcmU38P+CD2gyAnWCs+j8LGuNY22e+IBaRJ9he80z1VE
         Ip/Kn3A9KK3FIz/uGGQ8BMZLq0UjPRi7h7ExoUDpklA8MzgB5o0JWLXA67N+rhJtRKek
         YMbPxD/O1tZrEIJtkB3x6WSu+QFg1i9w99JrS3PhxAZnKStR12aC3wNyE3hP1/fiYqTR
         yuUtdQiwpLZY7xisIRCnl7wfEuGhq+6F+LRnX+7ju0uKlw0u7Rq1StEDp/fhu0sIxegZ
         ElBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190500; x=1782795300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tUbYMnUT89p2VCtovUWaFf0u4bBhWvF56ocO3qt/G5A=;
        b=fYU0mG0I/EX8zsgmtUJMYx0HYns1KY39GuAjytLx2YsMB99Jmm0uBC6fSoLqj1F4nk
         sRLD/t9b0yOgmHDGJSik7Z+mS+qbWCK9qADuWt+UEXfM2+v+Etc0gwycaXHM21x3dCbd
         GoU+Zb00bMJIGTAZ//fCYjd+VwwE04cvlAtF+tYlAG3iFq29AHII9qjl5qnnS1XwpKwB
         15rfOvdZvhjIydRJz4rAicO+BzlP5lwk50dcRw66u9see560SQKNTwG/3e3sPH+6wZN1
         9TCvtJxhnClQLbrTqjEdO2WV+3WH+IUVd6TO64lv62UI4MEQzA5d0F3oD+JS6STdm3Xs
         H67w==
X-Forwarded-Encrypted: i=1; AHgh+RoMNt39ppTajZ4zEHoCK1DDoG+JtI6gGMFBJThz5yZrnCrP55yx3c2a0ATwYUtVzmEFOJMyFMzCr4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6hUaGVIPcx/fsP1fKU8EcXBFA9cWET97wRekzzheDYA6DLjw
	SxflNP+vTZaOW2nbQV1OJbaHNExLoLkY6gYGwSO7vH5LJnQyNSCUOGsP
X-Gm-Gg: AfdE7clVIuFvR5OiXDPY3NqCrJ/3cQVqC4Tf1Gy2g1A/c77RGmgVdcyzm1xIXK2SXTc
	kIZ/ODM7irUoMjaOpZdrQgbPnj7n4IKtjAKl5gW69YSyIRYt8VcRYrVIiDrHUlML65JLKj8uddt
	B5T/m6YUMXwNQdWgxlsNxzeKTZ6pv1MJTYeEsn5H7u7BqHytJg/2QQRAE66wN/l0+oHGD6wIDeh
	KO4qOs4vM+MmgBW1InhTiVTCBvRzSBacNdF5sDsdoKjab3AnZ8jdI6zd5U9X4Fp3rbiCz8NMxaw
	HjH+xNs+ml2uMueRzRdO2CxZyv8vkode6hVqqoBlSLBeyKU2HcSOdKblDDWKmGY7TgQRB88vZFo
	uFzt5JUmjaqGYIjsnvwvTFXaoKzxH/PDSyDeLEjLdSNjx98p8Y4xYfFqL3wKYUhfqfu1bRdoB4+
	54VxIZJt6+6i8B4BSg+MmV3UzvrlVNhg==
X-Received: by 2002:a17:902:ef44:b0:2ba:838b:bfae with SMTP id d9443c01a7336-2c7c3f00beemr16025915ad.18.1782190500476;
        Mon, 22 Jun 2026 21:55:00 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:55:00 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	tmgross@umich.edu,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 05/21] X.509: Parse Subject Alternative Name in certificates
Date: Tue, 23 Jun 2026 14:53:50 +1000
Message-ID: <20260623045406.2589547-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623045406.2589547-1-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
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
2.54.0

