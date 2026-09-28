Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58E2877DE
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557932; cv=none; b=pr4HUsZWuhLhBzcEPpNnQbORBv1WcRwGQvQMsLA8R4fhhXKRC+9uq3qhUqzRzDJECM6Eo4I6cwzUkd/yzKxvvXhauCdv4AZ4KL9ISLjpo/qh5tNIRa1bCcPm3FnKH3aA/8iXOYAV10Ix1EhVH4ifu2Yw8JylXPUvsRzOzBgLyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557932; c=relaxed/simple;
	bh=CQFEUDdrBOr25kMcKMXOfOQ/OinpeF576SKItpXVsJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T39fgXSS2ky6+GBW1S8HSg2Hl7k49ZPtFltniRW4cU0ntskthZGOHYDkRDZiHR6uxwzkH4HIz0Ssj+xkVQbmpirqBhHmzo+igaEGfPt/kTT57cmDOG+sf6a+NmdIr8n1IdA/Lprb5IM3QTCnRk6pubFEJ4ukHVnzKpwzB5BBbfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QimQiaZO; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QimQiaZO"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bcdf41a3so1240284a91.2
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557930; x=1791162730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UyJ6OADjMeEJ9CwYlU3XCJzTi4L5CBgkg5gwk3kMxf4=;
        b=QimQiaZOLLaJvOSEn3LNuv8IPgkQgPPdNch5Wf+hnKaGb1nbWxJka6Yg4GMlFQNBAM
         3fveiI2zD6VxWCsDJ78X8bIvsd0IFE/SJ859WHHsDEXMzw2MnTHuf7uSTv68Ac0RAgvt
         k9g02DnXaC7zyGJ6PH4wJz5aWDmtqutvV78wtodj+W7WfN9qmNCEbBwJE0UqkFDanzM7
         cmmWP55W9Jfjas/QuiMCB73XhAay5+0VuxyHhO7zShSqVTYCNzZYGwc+aSUewRAItJ30
         M/G3mVaPYjvU5MiSxtMXfLTbBGLgnvb+iYFtRJUdK4+Soci1xskTbhCcnmGwoqhF54VI
         MWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557930; x=1791162730;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UyJ6OADjMeEJ9CwYlU3XCJzTi4L5CBgkg5gwk3kMxf4=;
        b=AAbcRm/X/OfXtZC03c6ApwQP904G18Iyi3drS/Xqadng4V3yNQ60JhnfPNowSX/jrI
         UlNEM5Rjzma4ZHGP7rlym6SxEHIT0OJgKp8O7qwhUDJOVWMcLl2i3MCvwoze40Vb1p/X
         i3CBkwZ3C8l8whg6s/3SN4rpQ/oE3CFzuraCTBrb6R3LpHBR3IQPELq3GoTXtHgttbXm
         KuaRnrZNNkFVlnFr2s34m7GKvZkh0pdmVBv0NJnO4vMa73lHkYFVRWFXpwDNTV8+jPk3
         m0+ciwf9lyoKPCH8NnN1gluEx520n36sJf41OpcpsEQzWW8RtDQkJmMpegQ0fp4dbQRX
         Q4bA==
X-Forwarded-Encrypted: i=1; AKwUvBzwfasj0e96vrbW1KtoRfMDsFbhWUiswZHm7v7S2+Gk/NNJDmGRskmJ0xEZQPw+7xzWo6aLIotXLEk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIn3EcoFm4F1fIizvIvduKj+5/enFxpfcPxjHSa77RlJfX6xphw
	xBwiCyA1n4ZDK91LGpNK6Ddgi51J4A2tTeqsjE8WAjGeZcWbujWy5+9X
X-Gm-Gg: AYBFou2f4LKKgcdeXXxZbVXtOLsTPZKeKDilI1RN8eyGvJvwhWqi4lrhXMcFsh/sEIV
	e7XdDqxrS86ZiYS+GizxL0Bjj6NFQAGwRAPiThIIYwS/ID93ZZtut1fgzvHyYtro+Vs6Gbmqd3s
	XOQ+dCI3mws74Jm0QMYX/Nr6O3a04z04rrSRmoG/sF/dpNqcWznn6s0XcyKowbMcoqFpcM/DAS9
	VI2wa3dDbo+i0jemuiAPiOwIjfevOPR/tp4/+gfhJtHuGzefqqI6Pn8Vu3hcF2peZNXCpQRkVW2
	0sPEAWR1FQGKHy6f6F5GSi9qMy+hM1/LZCPZLbxuyugKJFety7Jywm+/tADiRsV391ceGxjaGRE
	jYONcwGisBBhrZIocrrK8qaTLJP0/3C3I9wBJotLS0sDmNyEPtTZ5DIlH9iVO1etDAgE7lAvCpF
	CWnDBkXcU9ggWziMKi7ARrIjkFB8KRNsdTcd38PGVEOiciGawa61MFn7fyWavY1n3m/S4Q27xYO
	FYCspj//pS63O7bXQ==
X-Received: by 2002:a17:90b:3901:b0:3a0:80d1:28c7 with SMTP id 98e67ed59e1d1-3a098d508f7mr9517350a91.62.1790557929769;
        Sun, 27 Sep 2026 18:12:09 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:12:09 -0700 (PDT)
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
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 05/22] X.509: Make certificate parser public
Date: Mon, 28 Sep 2026 11:11:06 +1000
Message-ID: <20260928011123.450800-6-alistair.francis@wdc.com>
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
2.55.0

