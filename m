Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284368;
	b=yG4DguHuDVRMtVgJ6xUU7TIwnXp6GLJkM1E61pcxjLe7hjvgJZEYADCLl1JIcPZ6bqzi
	 2LDyDwrIn6oI2g5W+Z004FYJgtTlFszSKGoswp6VJ05VtMHqBpO7Dn8N4y/NhKHKqcUYA
	 b/KEgjMnme/XNEQlngWmIlUE3siJoV2uZpQWWqkVWYs07fZj6WwbLR2qmQT9bm5LbIp9M
	 6zpfaTvMKsn7ikx8QacFjBwmLT975PGkLyUVx6RZh/EL19uz+7D00VvgjupskJ3BUV23J
	 wrlVloL21lAjV4yJ/r5ynKkLfaQaV77/q0xFNkINzA82Th5WARpV5cIY13osvoNRnlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DF2GX2Vr9/zlICZewnCnHZ+XwMhrVOLtr9YXmakaBJ8=;
	b=FaiuFsixEj6Hgl7N8Z0fdf81wMtAqmV/ajnsK2kvb66YOP3g1iAORaTOvh+4g8Q4QlA7
	 qJvNa4xHmrtogvQM3LsrR2HY/xJEAiD/u1RKX7LWJn5VqGlBfVrnaOvFScUUAPg4dH504
	 wI9A0Gc/aXKP9L3+hf1W1Xm4ad6KRZ331JKI0bA3QP7BB8ZMlZGSPhhch/9PD9hcosBd0
	 /ZEJRl7A82otGoCP1f+YyT3oihLP4Fw+rNxAIg/ku3Fy1qe0Y95PDG4eh+J7HIf6eytNL
	 bslhZR5RsRiJBIQEbjHJkMrKLBH917kHxwKiJiwfapSEjDMXYQrkGpkL/mcNBxJELjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RWXI6nx2;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69485606A33E
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69485606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RWXI6nx2
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15ea896ddc8so2710010c88.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 20:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284368; x=1794889168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DF2GX2Vr9/zlICZewnCnHZ+XwMhrVOLtr9YXmakaBJ8=;
        b=RWXI6nx2GRh58cVQ3eVAqSiKzpFdhkGcuKrUVqZBTguWwL8ORLFBkqpFpvsZzQAr6f
         X/Bv16dT0jJgVH8v9tpsi8ml2u3NKo3LG84JzfyJR+PNTP6Vz4FBCEnh3wE/VrulnPoN
         d45MtlsnuEnECG87c1Lr5YwwY3DTHN2Y60/Z6kamzxkXxCoV5ICJIbfu3b1QLPPJpv0h
         bvDjZJ6ql5VEcKz2loy1jpu1R4doD4KIYOe8o8dMdZTwysoc63QTufoThjEcBPmF2tVA
         h1vkE846+i+TR+k5UutlaqiTFcqY0tjUa52de2g4aTAD4MWmzmbYCS6vyViMR2XhakZb
         4O+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284368; x=1794889168;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DF2GX2Vr9/zlICZewnCnHZ+XwMhrVOLtr9YXmakaBJ8=;
        b=F+f4JUJpgEQuuzr0GR9TivWncaHRake68zVwh3CDwR7DtnUGyFH43Dw8Lad2gxx211
         /QIXLJUzryXy4JxIfQv4Emogu/oIMUoNIBMQ2Bwc8ohuCDvMcNFiwg91HE3/8YZUeScV
         jKEDwgaMtq5QEXIomym8Hh/ITN5i+JgSFNeDhI3CwQ1lSGf+UPUr/xBkl7X/PIH2Lf2j
         R2fF6syn74BPBTHpEnLf6cdylrLdOYAA5FixfdGqrEleVwC+SpwQZu//+/QItZHa9s6y
         u6M6fkfUDdOq3/Txv5b6SoFCPFStRKtT0mGN4ztWSw/eudDm6hOBMWjPNMGUqJ0pyoGd
         NqNg==
X-Forwarded-Encrypted: i=1; AL+hErG9e/XD7pwCl33inrFO5k8vSEUEfdBaCAh9o/n+NkV2yXAkcLWYbpmr5Xmgrzzis6FdSfXsONvlKeg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nh5ESZzHHtvGNXdFTxtO1WMTH/9PhlN5W0POQ4nmk75jGpDuh
	7F4rov0gJ6E0HzqXAYXn4/wMRUg0Lz9co6mBX98AXjl2s13N16Jg8sLm
X-Gm-Gg: AYBFou1eJnvf7rnQBK/aR9QC0u9xfG4qbviJi65G78/7xGr0jeUg9YogdY2GpYKx6Qb
	U9cdswU9uMFh3T8O1Tep9U20XEoNH3iObqJXRNAsnQDEUuxcwnUBodLAqMbA7e6hwGNVsACoj0j
	MyKa2YrrvV6zlpZmVwtuCfyU2V08bznkBGP13klaqvMO1i1F+fLyu/6JNA9UpI1awejlF1d033D
	uf68/ziaED/8JOPWyf1VamcKGIVxHs3VH3T+pMeGFIacG8f7lgpwuJdC8rCPGuAcp/bDpINhpIQ
	wPRk2mGgieTLyGIg3uXMCrt46yXdOMbOAUA3ZMW1bQp4yc/Hl+MPCR0Ty5I/CS4eg3bViIVGfqT
	yQMJJBh0imbIPYVwbo5LCyiqMe2Td5WntgkFy+c1Du/cdb/4OtjUsGigurozZF64ypFPktA3kbx
	FHacoBrzFfMsN6pyarjtMC+wQOVz/LoBcrfic9qpqTw3FWhg4494HDZ2KzL1jPnrmOEXKOjuJuY
	AvMAuvkNWhc6D+6pVzBGiLVQZYd3PYUuHYIp2+BceM/3QAyjYFMWN3v5nJpR9f+f/+SlaQZhxX5
	XuQJ4HH/9uYmnguIvd8gnP7WspVo3PE8fdLlcd2cGS9o8Yk=
X-Received: by 2002:a05:7022:ea55:10b0:1b2:6cba:7f7c with SMTP id a92af1059eb24-1b3b605183cmr2161968c88.37.1794284367571;
        Mon, 09 Nov 2026 20:19:27 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:19:27 -0800 (PST)
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
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v6 05/25] X.509: Parse Subject Alternative Name in certificates
Date: Tue, 10 Nov 2026 14:18:12 +1000
Message-ID: <20261110041832.1730924-6-alistair.francis@wdc.com>
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

