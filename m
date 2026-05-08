Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF872EBB99
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210261; cv=none; b=Y5y6nZSHbcoptQVSq6BpdsFs6P1/CtgHYqVOi7SW+VIQHmcr8JBqwjlRNWUYAv89GRAt4pyTaQzD7ZY7e2O+S9ouOK/lW3rLrQHaNJb3wc2EEBkAgR5zbL3D4D+/L5L0148/bLkevjPqe228+dfuzLXg4+vqSGyjA98PEqiaVpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210261; c=relaxed/simple;
	bh=z5H7IwFWyQ0i2GyTWoOMohX8+M5T1CFBH5xA9uQkq98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azmK3HymdE4njBBZ0OdmBrEJR81urGCaYiO0uj79KKNWAOZC1u8hIKKuCPDDGrUpB77T0h9lBPUK+2POTk/3HcHTiuYKX0mUH9Fwn/R6pKEuv1TcKy0KOLDibY5jR/QV6NhFfHPUIMbeR9UhqdCF7JG2p//CRigpzyIfOWa5g+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3J9ZhQD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3J9ZhQD"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba21d32776so11073725ad.2
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210258; x=1778815058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNztetKq9XMpM5m+98P429Tts0AUJfNMeagdulZTgAo=;
        b=Y3J9ZhQDAFQUR9WNkcoL7BK/wimN/GK/b4PIa2EaSphEsW0hBaalXoc4/w/XtQmF1I
         K+7zoz9nWZBwM0iqoxh8faf678FELgVXjMN44M9A4IFk6TLoUHW7CXu6YAIY3WNG/jjV
         q+EZx8kYEw9Ky7Z6dA1Iz2I8PnUYzzqjULVpqGmuN0r6IClNjP/SLftN0W8RaRprrF/O
         dtP1hr5yateyftfmFIjqXl2c+sF2Js4zZ6GJHv8coeodROKEnF4YTAVE4OYRZIW3Yfvj
         UCGmT+4hhXk/GHyOTrUM74eszY+FwwZpb6YsLFtjRNlI2xAyUUgq0hExDZ/p7zvedflM
         atXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210258; x=1778815058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WNztetKq9XMpM5m+98P429Tts0AUJfNMeagdulZTgAo=;
        b=FK//K/sNBW4O/HpzNTyq9bqOSlwy0DifMWZM1uQKJvg61uBQEh3TrmPxaAiJxaLgcM
         ngAHO7IHvyYrUofuAwanehPJEsHcbuQsQTQQWo+RqaCYKnx6hwdd/J1s8r7mOn9O1LXw
         j7ryRKjKiE5TLwQFq5zQNmHomDba40vni+U3/ADzjiIZEyIXCLImkNeujTe5tf35p9KL
         uloW7OJxCBwx2kBzOQ6rBRuUwSEiomPqexVazJv6dcRVuW6tnUPrwBZYNK4xlzdXBP7V
         T/3OHCwyriFSPb4UVRIgCHXJ9suFQHYctK8+eEp4+BhZ7kZY6DZwWaNPCk7vJTkEAywb
         k4Xw==
X-Forwarded-Encrypted: i=1; AFNElJ8OUgorh0SUY2LMaQWh8Vds7K0n/RmUDlCXFvP8yRMxo0TsnEzr9AAIpiHFzZH8EQqm6zxccDo0Iv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZYOXingjPY8Hp3SV2JpjB3actiJKaGOevSqT5D+mA5p0vcSan
	7QlakliWwfmutxsjh4GS8WpPgAkmoYVkU+9a5eIzuZ/JNLfYx9IuDsXQ
X-Gm-Gg: Acq92OHXS4afWouRkJpWGZYUlUgDNX1ABz7lhw+xP8e6I1Wetg54IxOMX4G6dlrPHXY
	TgArx4oJiEtc1Y6wJ2K/4vIky3hejiKXHeXtPF2AXela2e0z5sL04cwGycICbhaMovJHp/+EKtE
	dwNOV9dgPpafHViL0D+H7iC2ouBn3flGC3GN/e9J8nkIrQducTQZ5qJHrB6jkuQiiT7Hsw70gVl
	IvZQaLgrrK8jg1JIkd7cuEcLcKtMtB10upbZNDxgUl1zoXIv8GmIZFN2+vt0Bj5hiKeBqwOrjLi
	pFc5AwtWRXTLZnIP6fYYXS/YJddeuiN9cQg6jifXbi19fUuDDdpE1Jy1W2saTif8HUhw2vCU/YW
	leBdxOJ08fLbOM5oPJBXEd1W8hSINZRy7865zV9roL2YwuBLnhqi0XoUyRs8K16KvLDOQKx9zWd
	KRwKdCOEBkSStfGCG2Ftznr27wJCDG4GOepXYojteMMaAAU8Ni0iI=
X-Received: by 2002:a17:903:124f:b0:2b4:5c0d:314b with SMTP id d9443c01a7336-2ba798a8fc5mr108654285ad.38.1778210258226;
        Thu, 07 May 2026 20:17:38 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:17:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: alistair@alistair23.me,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	Jonathan.Cameron@huawei.com,
	bhelgaas@google.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	wilfred.mallawa@wdc.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alistair23@gmail.com,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 02/18] X.509: Make certificate parser public
Date: Fri,  8 May 2026 13:16:54 +1000
Message-ID: <20260508031710.514574-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031710.514574-1-alistair.francis@wdc.com>
References: <20260508031710.514574-1-alistair.francis@wdc.com>
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

High-level functions for X.509 parsing such as key_create_or_update()
throw away the internal, low-level struct x509_certificate after
extracting the struct public_key and public_key_signature from it.
The Subject Alternative Name is thus inaccessible when using those
functions.

Afford CMA-SPDM access to the Subject Alternative Name by making struct
x509_certificate public, together with the functions for parsing an
X.509 certificate into such a struct and freeing such a struct.

The private header file x509_parser.h previously included <linux/time.h>
for the definition of time64_t.  That definition was since moved to
<linux/time64.h> by commit 361a3bf00582 ("time64: Add time64.h header
and define struct timespec64"), so adjust the #include directive as part
of the move to the new public header file <keys/x509-parser.h>.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 crypto/asymmetric_keys/x509_parser.h | 42 +--------------------
 include/keys/x509-parser.h           | 55 ++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 41 deletions(-)
 create mode 100644 include/keys/x509-parser.h

diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
index b7aeebdddb36..39f1521b773d 100644
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
index 000000000000..8b68e720693a
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
2.52.0

