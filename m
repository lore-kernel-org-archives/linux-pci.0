Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1C2DECBA
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210268; cv=none; b=OUKCGp7lFXu/m9ZHyEll2boF0cF8phSujYtIfMJtt4IOzlxipfO/hbHtiE9Y3xUIxPxz8lPOEUZHajj6DOruows4CyHjvU/HzBua4eXkUut7xMGj87/F/L3ho5WBPAIMyhmpPy7c8ymzrfZFEAKfzl+08MWVjmZAHKhY36a8JBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210268; c=relaxed/simple;
	bh=KQNEGxY9INaXySHb00KAS0/IBHXY6dy/wI2exWO1eig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWstk7XkAW39fJimRvQ7s2Bv78GMn+JP1cElqX9Mcf4lolwi7iHRT7PGHMevpZRUMKL+R96r+DpOMh9rJxUWXBT6LIrblrzRxV7QzUIRenl9dN4H7k5CNXvi+e26vdzt5b5Bin6ghfx71M9kVdkNQdcyOkfPX7iWq4xWzi+YqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjAfJZju; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjAfJZju"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso14670725ad.2
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210266; x=1778815066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+exDoq3R7sORPn6CGzFv/4xCKwv+Zs0uPc325B74MH4=;
        b=JjAfJZjuCp3AqFLkx0KYP3+v+FYdh6/AMit6bMvm/eB7cVDO0hVqeiJ1NnJAJ7QpEo
         1Etlj16bnBEWTm7Ecw/sFz7hMRWybOVNKou22kDL8mkV/IpdJP0hpSE1pCSWxEo4rLGL
         B9a6YH3Ovw+qzTWcv/QpC9MzR3D/F6Et2wy/XlzamW+ARC4ls3JHJGDXkp8O6oIRvAwM
         /fx7GX/nInP1smdOC3RIP67O0kD0nWuvRynZKER8N3CJGFEoz/nrS2Qa5aYJVKbptQUb
         sQ3WG3gQmtCy3GO4AFKs4TMVFNFXISFWlapvDN6Zktdg9d28C39WBSPrEUMnf/jxr+R5
         Fovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210266; x=1778815066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+exDoq3R7sORPn6CGzFv/4xCKwv+Zs0uPc325B74MH4=;
        b=fOSWmxT2odL1//uomk3ChpjuKfsW9MjZuTra24xjG9JArdccw3sTWM9VG29jjQmviC
         qfjpDE01TdTamo1LzwZGd2qx1aBFQxV5tOL3XQfDgDCl4FpN240KkcAStRl5X+Ur1m1V
         54GQSjbStzwyBduG6IdFAjMqtOhwRxeZNZuCVO6v3CJnKbdBBMxRiTABSA3YlX6S5Qfs
         7o5aiZVPliMonXjnyWRSTDVF8IkAXIQPPHkgYKzF89OAJkSbzsnlnCd7esfyhNcPkK3i
         1eMwumI0CgPkVc7alIUocxc/R9LVQTRjE7/DG5fr0AmJzj2TlIByFfZ77EBRzOmwoGjM
         xLpw==
X-Forwarded-Encrypted: i=1; AFNElJ/Xs45u4+WBkCgIQvv7QulZAgw6ek+u6Ff2s+4pKNYo2EFdLNFwngJ8rOJXs6hfi+iojyIrVcLl1ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkpqMZqpcULqrVmQs9kEAKi4gIRsBqVykHlheHTzsr+1N+POzh
	NxH1qOspI06pf+67q57mx0AkJIhVIFIRdB0z9hg/Mq2/AWNUdbF38wzO
X-Gm-Gg: Acq92OHfkrXDS8zlXb1CkmfmcphGgvVFEdqur3ogAUB3fepZXyiA0rAQ81HpTkfVpHI
	UkoaZQXMJ3w5khIVn/uT7LejgT50oJyjTvodt5g13Nv7VHA2+X+WeYIkCXuUD+FejFquQ4uDUHw
	6NejYQdPAOEF4KqpU+dpWWNI+qznwsxJZcLfoNqvhv/ZsHJsB6BEXanBaXrv/XqqjeoTtX6pqKw
	p9Re2XBvhTRIj6z+2mJA5ZFzXhfYT3uE/fdSuYJ5Y35qU4El480Bm4w3KzIbrsEhUjdi44YtpAw
	GOCLAw6Lj+M8wGwtdqee07FLSI7A34PAiUoZ/D/xbpi2NsF0l6Ds/nZ4SkWAI6Qo8ftIWV1oQdm
	o8OTYNGegrK1vp9a5NEGbzHIRmJ6Z/f83Bj1om14Ej8+N/hupiCxe4w8e92CWs7MwMUjzalEhId
	j5NhLOIFinoOXfy7qitW3pNM5DUVpNZ+AUUoBIeq+DMs9NrjnjxY8=
X-Received: by 2002:a17:902:fb43:b0:2b2:489a:f46a with SMTP id d9443c01a7336-2ba798d2797mr77415615ad.36.1778210266365;
        Thu, 07 May 2026 20:17:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:17:45 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 03/18] X.509: Parse Subject Alternative Name in certificates
Date: Fri,  8 May 2026 13:16:55 +1000
Message-ID: <20260508031710.514574-4-alistair.francis@wdc.com>
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
2.52.0

