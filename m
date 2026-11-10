Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284359;
	b=ujh1SkFRJPxr1sNhX/8vLv6fyiaTRLizDD0U0fU2B5Kx3WTIotc0kNssIZnNvWXHxqk5
	 qGsvedxay06a4K5WiT1+BTnsMSg283bWUSl4hwkmNHtaIGRNL1T3yq4OHtHn7t7ZAZp+Q
	 hs+YkhQSUnGYva2mF1EnThYMLCbE873K87B1C2NLh8i8odwMK7YU1/s42TuBvlYQbcj3A
	 TbUCl8mFLYUq3vMgGg8+cfYyPxgNAgokW46J5d/w5Ef5OB6wJhBuple/nHqjkBe6IrVbI
	 q4Xw/n5p8MjeIdin8+OxviQzFBq3tML+outd85H6xr20O5Od10HdRAk8RHnRsrHBN6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jPU4IMrUNrr8h45vc8EL5JTCvYSHe/yNNj7XMONjgu8=;
	b=JrcyOvGQVOj5+Qjsd6/EX32WoO9VbaQQEQTtKN+pi1bfQtf8uN+zkTGkNTgRXnBR5vYA
	 3hyCYxtAbloshsIg+zE514nxTZFNJ/EXM/cq79dYJOO7Grg9z/dzk1mleBRaMC2n6bDZq
	 tfrJPBXEjyCRU2qbYamPl/lPL56riXq8KGHYS/Dud4YIayhT0saJ+Rlv4QFEkDI+4ltjQ
	 hEUPfrnCcyTKEo16ADchEFI97Y/6RjaenNv0Sv50JlK08EIHulZViETpsHGLQk8tQ5tsk
	 PE4gN0S3t2ejzq0a7BoW1nVavSdyIAnbbSnJuRvTxjvV2Q/BPNN8QEtv/HU+kw8O7Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ovAYrcEU;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527960A260B
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6527960A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ovAYrcEU
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so2709860c88.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 20:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284358; x=1794889158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jPU4IMrUNrr8h45vc8EL5JTCvYSHe/yNNj7XMONjgu8=;
        b=ovAYrcEU4YpDj+qS9Kyezyn7VjwJYTQDYf/0Vweej35GM7wXA/wOoKS7MWECpqjyVb
         TtebLwvQ8/cDfHo5BPUx3cqMp9bm31UwYU+rzH+jPVJ5pUHQqy5ISGkvu1J6oCmdC3Ww
         k3NXlfzLR0gFgTX15eqxD6aCfQ6oVPF+kU67mQmQCBQk/kPkBZwaaIL8856LeMuif8S3
         DHdpkLtz5XpfHtWYyox+VVAx+JTuTi0g4xur9KhGJYaYK1XBVAVW2Oh1NeiyZiP8EGSp
         MEAzO99G76otNRCOY6hvZjYKWBlhU49J7g292qg5I2GkfK3s6t/lRAmBrcgTumrCByD1
         /D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284358; x=1794889158;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPU4IMrUNrr8h45vc8EL5JTCvYSHe/yNNj7XMONjgu8=;
        b=21OMC9HMn5pTfBCRordWNvEzpi/6djF91HBr9QqkNDdBfvB61ILIg30pUNS+htyLyA
         szdjPVqxnWD1XKAIGJAvCIfIZqwNNCszu4w5iaa1fh8r0bSCS1+PRq8CDivucmUcCVkt
         8EKddOPF5WH+/5qwZCes4Z1E/LKy/LPmXwCOtqgHICj6He1GY9x/L1cenvkv03Zu1OH3
         PkrumP18egeGJjldlmaXN1HCXnVdvCm7IwxrfObqcfqhS2wyVMfbdcDWuowWoIUm8vMd
         y9rlDffwOFALDmj6m1Mst2J4kwL0eDQsdDJyrSgpBz8Ts61D1gZXcOIQjS8LJk0B7Wp7
         RUuw==
X-Forwarded-Encrypted: i=1; AL+hErH4dJBLXOCOvxqtSOfoaXA3f2uaEb/9uWK5Q0c9HaIlcmeukWIjzZbJCRJ187PNBa2xlcoP3Qy7Q90=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KzKQ89Fg+JIg7QnFoXWezYtB9vSmByeD/s6D22lUnWP0kuqY+
	dv+aTT8JT8JSsMdxJfh5WlewZcz7FDuD6g7R4k57iWiAlhbnpEUCDUGx
X-Gm-Gg: AYBFou3SYuVRrwQids8UDqSblONo1HkIZ5E32w4GPLiIF3x2Pp0HUn4HNUqiu+tifzb
	8Ec7epnkGFLgkYb57w53/9vCWvXWItlfLjTZKeobxKOXdSEbQJva4cWZnxreiHn4bZxaqi9dFSJ
	bTIz+KNq2rZOYdIMriISZli3jQUaSyexERZ5T85c/O57aYxErJCs94plTthOzhmaX8szeTx6X1B
	UkMBkBynD9pEWNEsHEQANKnlRPfsnjUj/ex35Nl49vbCMom+YhktmzTkmaTMkO5JXuDydyWPlvg
	SLWc5V2V4Pd3j2CaolFPs0ROmPL0j/B5Xz8oTNX7pySAU4Daq/tAdycDF9mcJa6j7hRSZbhQ9q2
	f9qvaTE2VvIlAdLE/rXYr03B23bN/ONU+JziH/QKwAIGc9cJUtfcxdkNUkav8/RKP0N8kZbknG5
	dHhmDlE4rM+cbYdw+iFob8iVo0Wge39FP6l+WxXiuDBtiHH03PQ7OPfCst+8YOeiUpG87jlU2ow
	WRumXBx/ba+LW2N9m0ljJOSjApzpgk3gGdFzMcjbFHBCHqL/g55mSzS3QutM+UGKMPv6pRgOomc
	4T1vF+D3zZJNRxUEQCWxn0uMEa73VT9jCQRqFs7eyLOhkvk3LtgBZpoGDGwDRCyadG7u
X-Received: by 2002:a05:701a:ca05:b0:190:3950:43e2 with SMTP id a92af1059eb24-1b3b6000497mr2107814c88.8.1794284358348;
        Mon, 09 Nov 2026 20:19:18 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:19:17 -0800 (PST)
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
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 04/25] X.509: Make certificate parser public
Date: Tue, 10 Nov 2026 14:18:11 +1000
Message-ID: <20261110041832.1730924-5-alistair.francis@wdc.com>
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

