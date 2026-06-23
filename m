Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BBE3A3804
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 04:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190493; cv=none; b=pfV1OuP9eK0xN6DAj2h7/JiMxIwN72TaZWa2DG/W9FZ2K5KbfzNu5pwFK2qC2DisDeKbDAwyz7sajc68D6Y9jVUpU/nTcIe/6YhWaw2XbnjmuROMYXzLRMvuQNWhDO+gP2Yfv+4U1R0i0bdntejHYBekfMJmx/Xd1Vw9hKtKs+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190493; c=relaxed/simple;
	bh=OLXs3Fufa2MbacrwYlnD48/27+yJ2MkbIQw8G8Ag99o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EslwpXRPe66RcUwFplNTyzKfxUSoRqTHW4LOh9r23W1VBNuoxtXQkqUzyFJfBQ+atO5fUa0M8Q9s/DSi8600krwXDWvk4XmsFsGQVWEeccwTatYq4ztyeLYfEO0GO6LnMTwcYZbfeDJNERDcARmiYuO0kxyPIOGoX5ltczXy6NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoLT+sMA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoLT+sMA"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37c6cd1ac98so4495399a91.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 21:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190491; x=1782795291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=em+GgXcAR5Bq6k8M2WoqxbNFVjEAu9j/BAUf/d9vc7M=;
        b=ZoLT+sMAGM5SxmQCiOKTrfXio6huyA6o0wFzSy6NShs7kDPXjhqcugB2VAdNs7F3s3
         rOAioX6Y0d5V7g3PWU7CW66OiXUg5n9kFZTOn8WjS+AjhiwjGUh7nQ5b3Gn+2A6D5Bji
         uAj/BSuotuDlEUJWj/j+Ury8ORf92Gm6IkqHBfAXC5bndwMZ4lnv+tojQOP9BPXFV+Mz
         kESnZwKRBm7NFp4f7itq/E0QUMuclSq05a6WuGBCCachvRwsYbgP8EGXMWcJ+d5aqnsm
         CPJScm7dMD11k38EChBJTJXjam2+fTerFfkxG5YKCbzokarn0PJmhh4M7BL4w+Em2m8k
         POXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190491; x=1782795291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=em+GgXcAR5Bq6k8M2WoqxbNFVjEAu9j/BAUf/d9vc7M=;
        b=WJkAMl1lnModkhfZ61+flNJv+IC4682GVk4kpmkNqPqc35ipRIUcCo/Sl+E2rr+l2t
         dGQ4VsmWyqZpYQZFkFMhdR3CFxDIuM8XRJmnRMoKuqzbkQZdMN+jzkEBYO2gb0o55BgR
         nPaA2zFi0bUhbhd2ADvMQvhuhJAHc+E/dbvFbMyoFnNyXLfAZZfxkMI76+zxSzWeS+jV
         j3DxP1v7E9yfPHg/07adLZH9BHmPaB8seOMgUWiGhXlF2s4MavmQnqxrum9HqTmjGFST
         z6VsXEXk5lRRYgyziPQslCZpMfONQ2JBTkaOlhI7HV9j19ZLcpc6hsRu48px9DKiYS3f
         juBw==
X-Forwarded-Encrypted: i=1; AHgh+RpJ1xc1oHFgyHgjR5BLCCQp2hQGxZ/iHw6XJJ44KTjRQe5hHmp3vx3XNmwuYdAhN6k1Llk3WP80DEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuYKcvULzmquQKTOM4n5utY/q+HnztLueo3l9h8oBs0OQ5/8ur
	feI2VEZKm8+YH1CE/po3KPFfYuEgy87pG5TmiQGrnzTLWWg/r8SqEQUn
X-Gm-Gg: AfdE7cmJET7arvRQEDKQAUPiqO746J43aJL4pWuhPTmvwkULBWvsmtIiERinlE0qwkN
	irQSWIU0PgPyjzwBiCRzGQkiiaqcxwDu1PkbQczmfDaasJXNV+6ECODsgG03JBN+ToTwm9ZH1v0
	06xZf7Vh+G3wBlYPguxNd6KLHKLTz4ZEConk4WQbFcnwdt+V4Neushxrv1N74VFkoNrBOR42PHk
	cxq9qZb6kF4RDGLXWo2qohCh/QkkI5lg6wWg+yAGjjjxsIKB6pG6pvzS7xirRWtqvcv4cdsmpAc
	OPJoLI8X4ch0RoW2oFSMry2XGTiq8IggwSEJ+z/Q9rRs2LkHn7sk4I7CncelIJJWJzGgtTLVf/x
	JpwKQRTTKiCDJ83jpV5ZRg7R6+eXeKPjglWyu4SAFXxXxezHm1P6lGtCNgeMzks+5XllVGcWHVy
	Bd6T2RN04XqR5zQMGhH33sX9+2bEfxDw==
X-Received: by 2002:a17:902:ce02:b0:2c6:a97e:1c24 with SMTP id d9443c01a7336-2c7c758b9bemr14124315ad.7.1782190491545;
        Mon, 22 Jun 2026 21:54:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:54:50 -0700 (PDT)
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
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 04/21] X.509: Make certificate parser public
Date: Tue, 23 Jun 2026 14:53:49 +1000
Message-ID: <20260623045406.2589547-5-alistair.francis@wdc.com>
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
2.54.0

