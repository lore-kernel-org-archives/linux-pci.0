Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68C344DB5
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780606; cv=none; b=UjkkyuTEV1+z0UY9JkLLNDtpCcUjSEXCg35PWJlYTuIiQ/bzuvSsP6tDvBExrmM9CoH4VbPkO8O5wNBOPRwnEeD8CbsHMJQhUuvUKGOm9b/EE7B9IudLLXWoqOuOh/ATiwRTVncigfslkZSQEUh4XK7eCNY+ZnyFFWHpjgo+eLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780606; c=relaxed/simple;
	bh=z5H7IwFWyQ0i2GyTWoOMohX8+M5T1CFBH5xA9uQkq98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsKB3b8GoZEDQA2dYhBkc1gki6yMfxBTUjNbaRk3XnmMgfjpzQ7spKVioxdylKw3Xxqmk+k4WadKvcAv18TmamFi5g0LuEtmpfJKKfIq6L/Z43x60oygQjpk7bfmV4In5VIcg4zO7nf2ukdZI9iGetSXCNTJlhSc7c6GcUvkNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqbBJRg5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqbBJRg5"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82418b0178cso923662b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780601; x=1771385401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNztetKq9XMpM5m+98P429Tts0AUJfNMeagdulZTgAo=;
        b=CqbBJRg5eOrR1wC0PwQZUFUFwDfUR08HA+votC+wxakVbLHWeZEnqb9Mxt8lldghyt
         Vf8NxLIdJX3as1z7GCZz+iO1CA+o5Ei4gGk0YbHBYkOjKFVCIXRZsokIPWdp9pIe6ob3
         Ur85ARnjFLYL4a/bmflMd/VVdh2q41jjPyybT/3RaXu6F6gw00eqlTf28MzsqoIqAPut
         d6Z6tyhr6Tcv+TTfXqxFLk3MBDki83qSToAIxtp4r5mCfsVE6JK5Ncbwr4eh9pwAZ1xe
         ekjRo4WGsH69F3RU2RfBepdaHBOIUy5ExUCzuaQF47VtUi0EyN38vFISTvb65cX9wKsg
         mk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780601; x=1771385401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WNztetKq9XMpM5m+98P429Tts0AUJfNMeagdulZTgAo=;
        b=QzhpLuWP24PM0iIyVp1AUSLd+vrx/cVKou1BFIZJxtqQ57x8WgQrEhVKsT6KKExhOb
         ZEM42sBSqP/Q4qhB8/an0mqjVlkndupJ6XrzOl6DbCW0Lv3hxcqodkOkm8O2BHdgGq+a
         YXBPjVSiBnCLHBkLDfHQ2Wlx/Ww31AILCHNhbqlGlDdukBeBQxpT0kmyKRjK0VPM+U4U
         XZS3bGkf5YRIvXbf0tfOnWhBibOmfzCEcNnXXPaoedt3svidvQ4V+gEDVCxqN2o7GCV7
         a+gNFE9F2OPfKfnoq1B9GJwVzn8D097GIJHlNioEl62Z72PquIVO9kz7JNAS9fUgg4x8
         ztAg==
X-Forwarded-Encrypted: i=1; AJvYcCWlDnG5C+MQHiBwr8fVAHnUwSxXHqUrW35g9lLyNbRflDKltBRj9t0aFaMxfkX9/Nxke4y/H3wTXEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRS+iZFVQ01cci7yq/vTX1LaKIytNjjm6ggEWr7T3ghAwGku5g
	tL+iYQDLWLwcV+xHufjrW+D04K8QjldKbaqvBTppDZCFWRpKrRaiDWBs
X-Gm-Gg: AZuq6aLvWY59x3QQiuFv8wruRFiixRNKVd+MVcwWncEfEJFCkdJ8/9KrRcGdfK6wn59
	CSqHTn1Xt2Lrwt+xdxYVoVOzL1LG9pkxl8viRZF63scm1BwxzpxQAyQNbwU0BBFakKnXY91V9i/
	uReJrpYqj26lxM3e9lD3xdWGHhNko1luTazDXP5VUtGeT+G/w8jeDxbQT3Afhp6sCP92B8S1XOa
	WQMMiFXv8g8RkrGjWC8FC0K/Ej9WHw3G5Mh7Jke9wbbbyAN6fA/oePYCEmY3oQysqYKQHhTuyJ8
	qtiU9XCELGjx0OAzAvZBZ7iWRGSxfTYLyHmZDGWyYEcySEzKgsnmfilYKiWxTIzaz+JKgAgz2k0
	KaFQqVJKZf9S8vPY7qu9jzLZhXxbCUHrrHscszejRrZeDMBhzq+yMPpH9I00snhr84rF0LxCu1P
	Btoul4rpZUO4JEn4gkINsLU4k8QY+ysK7o7fBUxtNPbw==
X-Received: by 2002:a05:6a21:3988:b0:387:9522:b667 with SMTP id adf61e73a8af0-393ad4398edmr16857908637.78.1770780600697;
        Tue, 10 Feb 2026 19:30:00 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:30:00 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	ojeda@kernel.org,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC v3 02/27] X.509: Make certificate parser public
Date: Wed, 11 Feb 2026 13:29:09 +1000
Message-ID: <20260211032935.2705841-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
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

