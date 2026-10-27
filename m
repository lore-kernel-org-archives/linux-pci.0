Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078777;
	b=jiwcOyM+p+f6qeM4CNnzfD5ZhQrKZT8mApNr8qX9sCIqv3MDeDmsdUn+54Nx/pbmNqud
	 vKELtTc+hy6ZDXriuQvez3qSJxFSV2aYN9JWivx7/NEpHRIphJhzVXgKDyeYFAXWzHdUX
	 yEy7B9Z7NLIKXhUTCw/IGYRgVAXrRVyHJOOJockyIKjsZhGvz0a6ci1dbs+nm17Hf/QA4
	 YQ6ghiVDa8KxnMcxdmcF1OQFlFl5OrIMhisxDiaLnHCFVbRZqEUNvuQp/6/LEUBCnPy0u
	 inohspGYEZxOKkbI+GmGeZl+rkThSFnM9ymDc05t7p+l0YxDGQx8sXnHwyZroiNWaQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jPU4IMrUNrr8h45vc8EL5JTCvYSHe/yNNj7XMONjgu8=;
	b=Xfz36P/0wIntYRDAj8PvMHRZnzx/5f+lDxq+HJblFLTfRe7gpbanD1nRuoMgGpP5ivt9
	 I3ogJ4eR6ieekqYh4XmMtPhp1T0aBdKv0oI06lVC44Q3SgIbXXF190eVFFxYwA7oev/9Z
	 f0cFTwo3te5J1z5W7+GEAjO25wPq82/in6xTnj0nImmn3yS0elATj4kLn26o12jfEhIEw
	 cyaVD99CksHQXqGQnRTYqcrU2jb5SeYymRhu2KJlMnFci41JXHibuvrzEIkA4yWWDVDuL
	 gBOI9O0hMiZSGmZ2gBNsp/q3V6uumk87dRXSSRwPGmTyvyHN+321nCOUOiYmqZrQLgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cs3qXRCT;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A18606A321
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21A18606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cs3qXRCT
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso20818405ad.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078776; x=1793683576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jPU4IMrUNrr8h45vc8EL5JTCvYSHe/yNNj7XMONjgu8=;
        b=cs3qXRCTz9nB2wngbl4nhivYX1L5cGCnAZIM5Vc4Sie58g9/yh8EBNZXs4YlJF33OO
         8Kaj7KE6oiinLgTv6Q8F7EediA/jRQgxS/K5nddpxBBhkUd72ZiumOJpZ1GUT4JOyeKf
         +Vc5DsmvIggUiKD34y+OoHVuQHyHMscIJKDp+v4DW8qL1aSVKdbbcLMTkWmDNxrIyX38
         6lDX7nY2WxLCv+b8kBslxNsUKBKakgWXoFGdJxtVmWCKnU/PfzPcSbZqzS5EwAlJrvGX
         krMLCoLoxcQF/EyU4mQw/1+BnRutXseAQEQU9Twe9XAGPrmDvWzDvg3w6enASb8bbzVD
         QlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078776; x=1793683576;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPU4IMrUNrr8h45vc8EL5JTCvYSHe/yNNj7XMONjgu8=;
        b=yQcK0hDyU5nNWp9jKwNBNc5EC13zJEPuX8YZIDrHjY5wMp6aQKX4qksIWTYrz8+Csh
         R2CT/RPO2MXXAK4g+5vSYRLjUrrWN5ToFZI7KIB8QUQkx3ohA6SMLEL491wB3FOfgMJz
         4lH7OvvaliZZZ/wW3YPC/w7NreRxqNNqgcDeXCpzg+LLyptHKS3KVmqHv87jQ4IUqYkA
         9zVBSNpQN/cySYabmUvJH54JFdI+Qg/Fwqnej4eLK0ni7jOamg2ZK8X1PH+ykJxMX8UI
         zzTjEoWos4IzVW4KCtGKPXLiiboaf98jVYomjfh7L+HVPln8aK9GJKWWaBC+Z11bsceW
         aSZg==
X-Forwarded-Encrypted: i=1; AKwUvBxPQg83qg3JjUIF0xNyTuJGiAps5WXa2tBBSj4sF8B8wA0sEazqRvBsMCfQdLgSoDevFbgUbfm2QO8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyLDpxsZIEqyhtX3Jh4E1/ATEm5ohGVcWqPVHD1D8Y7t74XoGm
	9DXsLY+i5EyFJsCXxEqPNUZWqcOWSsbs71iEuP8iuVXFBaC/O3TmnXyy
X-Gm-Gg: AYBFou0oDk6ZeLQOR+GTKO2pkulZwAt3LhvGwStrQ+PBx4QJLCHirPjxhAD//PX3SxW
	eIuB6fGwjZ5ltTr4D9mrT5LloWehYEOnDKFPGp1ksCDMKw02al3FBkjb8aHo6hg3aCIhTRSzPPO
	E/Vn5IivosvTOWQY2IqvZH1M2AqFmaqofTYXQbm0VAesPtUM/vjKEfj3xA2xdKB5VUP5q5Mfro9
	wiUQSDxd9mILrLGbye1gmOlRxi2Bo6+Or1SbG0shbvoGethqXoYJ35SCIUqvp6FI9L/WTggWdKR
	PeXb1vhFtd4pElQg3Q/vMvkU/BoMSnaYYpNrZ8wDWcTFwnzXU6ne7aA5H9xgFULwUD+WvIBSsWf
	enj+MhcHNnBiOcwPLbjN6OQzCV0IUX8hnCdk5r5z+2RHRAFCD9Le7V131rFq1zj3L98dkfykJlT
	rzmJfxRJ57Sy07FrmT6ehASx+p+RZxe2udR7JYzM5Q4wDcAcITDlJ+AEnCgq1eY++oKbbY8MTrq
	hL2VHB9fG7PPow+qn/eGSl4FBUnbSiX6wJ078iQmOOCPaueduY0I7tLehaiG+Dy6TsALPGGFg==
X-Received: by 2002:a17:902:d541:b0:2e9:3dd2:a90c with SMTP id d9443c01a7336-2ea9c7bd583mr74901225ad.20.1793078776372;
        Mon, 26 Oct 2026 22:26:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:26:15 -0700 (PDT)
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
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 04/23] X.509: Make certificate parser public
Date: Tue, 27 Oct 2026 15:25:17 +1000
Message-ID: <20261027052536.1722081-5-alistair.francis@wdc.com>
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

High-level functions for X.509 parsing such as key_create_or_update()
throw away the internal, low-level struct x509_certificate after
extracting the struct public_key and public_key_signature from it.
The Subject Alternative Name is thus inaccessible when using those
functions.

Afford CMA-SPDM access to the Subject Alternative Name by making struct
x509_certificate public, together with the functions for parsing an
X.509 certificate into such a struct and freeing such a struct.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 crypto/asymmetric_keys/x509_parser.h | 42 +--------------------
 include/keys/x509-parser.h           | 55 ++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 41 deletions(-)
 create mode 100644 include/keys/x509-parser.h

diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
index b7aeebdddb360..39f1521b773dd 100644
--- a/crypto/asymmetric_keys/x509_parser.h
+++ b/crypto/asymmetric_keys/x509_parser.h
@@ -5,51 +5,11 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
-#include <linux/cleanup.h>
-#include <linux/time.h>
-#include <crypto/public_key.h>
-#include <keys/asymmetric-type.h>
-#include <crypto/sha2.h>
-
-struct x509_certificate {
-	struct x509_certificate *next;
-	struct x509_certificate *signer;	/* Certificate that signed this one */
-	struct public_key *pub;			/* Public key details */
-	struct public_key_signature *sig;	/* Signature parameters */
-	u8		sha256[SHA256_DIGEST_SIZE]; /* Hash for blacklist purposes */
-	char		*issuer;		/* Name of certificate issuer */
-	char		*subject;		/* Name of certificate subject */
-	struct asymmetric_key_id *id;		/* Issuer + Serial number */
-	struct asymmetric_key_id *skid;		/* Subject + subjectKeyId (optional) */
-	time64_t	valid_from;
-	time64_t	valid_to;
-	const void	*tbs;			/* Signed data */
-	unsigned	tbs_size;		/* Size of signed data */
-	unsigned	raw_sig_size;		/* Size of signature */
-	const void	*raw_sig;		/* Signature data */
-	const void	*raw_serial;		/* Raw serial number in ASN.1 */
-	unsigned	raw_serial_size;
-	unsigned	raw_issuer_size;
-	const void	*raw_issuer;		/* Raw issuer name in ASN.1 */
-	const void	*raw_subject;		/* Raw subject name in ASN.1 */
-	unsigned	raw_subject_size;
-	unsigned	raw_skid_size;
-	const void	*raw_skid;		/* Raw subjectKeyId in ASN.1 */
-	unsigned	index;
-	bool		seen;			/* Infinite recursion prevention */
-	bool		verified;
-	bool		self_signed;		/* T if self-signed (check unsupported_sig too) */
-	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
-	bool		blacklisted;
-};
+#include <keys/x509-parser.h>
 
 /*
  * x509_cert_parser.c
  */
-extern void x509_free_certificate(struct x509_certificate *cert);
-DEFINE_FREE(x509_free_certificate, struct x509_certificate *,
-	    if (!IS_ERR(_T)) x509_free_certificate(_T))
-extern struct x509_certificate *x509_cert_parse(const void *data, size_t datalen);
 extern int x509_decode_time(time64_t *_t,  size_t hdrlen,
 			    unsigned char tag,
 			    const unsigned char *value, size_t vlen);
diff --git a/include/keys/x509-parser.h b/include/keys/x509-parser.h
new file mode 100644
index 0000000000000..8b68e720693a6
--- /dev/null
+++ b/include/keys/x509-parser.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* X.509 certificate parser
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _KEYS_X509_PARSER_H
+#define _KEYS_X509_PARSER_H
+
+#include <linux/cleanup.h>
+#include <linux/time.h>
+#include <crypto/public_key.h>
+#include <keys/asymmetric-type.h>
+#include <crypto/sha2.h>
+
+struct x509_certificate {
+	struct x509_certificate *next;
+	struct x509_certificate *signer;	/* Certificate that signed this one */
+	struct public_key *pub;			/* Public key details */
+	struct public_key_signature *sig;	/* Signature parameters */
+	u8		sha256[SHA256_DIGEST_SIZE]; /* Hash for blacklist purposes */
+	char		*issuer;		/* Name of certificate issuer */
+	char		*subject;		/* Name of certificate subject */
+	struct asymmetric_key_id *id;		/* Issuer + Serial number */
+	struct asymmetric_key_id *skid;		/* Subject + subjectKeyId (optional) */
+	time64_t	valid_from;
+	time64_t	valid_to;
+	const void	*tbs;			/* Signed data */
+	unsigned	tbs_size;		/* Size of signed data */
+	unsigned	raw_sig_size;		/* Size of signature */
+	const void	*raw_sig;		/* Signature data */
+	const void	*raw_serial;		/* Raw serial number in ASN.1 */
+	unsigned	raw_serial_size;
+	unsigned	raw_issuer_size;
+	const void	*raw_issuer;		/* Raw issuer name in ASN.1 */
+	const void	*raw_subject;		/* Raw subject name in ASN.1 */
+	unsigned	raw_subject_size;
+	unsigned	raw_skid_size;
+	const void	*raw_skid;		/* Raw subjectKeyId in ASN.1 */
+	unsigned	index;
+	bool		seen;			/* Infinite recursion prevention */
+	bool		verified;
+	bool		self_signed;		/* T if self-signed (check unsupported_sig too) */
+	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
+	bool		blacklisted;
+};
+
+struct x509_certificate *x509_cert_parse(const void *data, size_t datalen);
+void x509_free_certificate(struct x509_certificate *cert);
+
+DEFINE_FREE(x509_free_certificate, struct x509_certificate *,
+	    if (!IS_ERR(_T)) x509_free_certificate(_T))
+
+#endif /* _KEYS_X509_PARSER_H */
-- 
2.56.0

