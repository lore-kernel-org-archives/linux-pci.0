Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078792;
	b=1k5E0IFELZyd6g915qSNq7shoGUHZuFAMt2lgxSh5zqzEsJJSrin8bNSNT5lfzpIuS9G
	 Q3XF+5qq8zL8g+LeZRTCVwHTw97g9V3NW1jLSzGPfWdRG+Ej62KM2r0iKiJV152yZi7qE
	 yBu5qBvXzL435jThJRPplE/hytff21zXUVoiw6PVu4hS2ZuRzTGBYftC0RfinFTZV8g16
	 vgpcJsmdvkNEvfuDOvCgMfN2YFR0Lig7j6aW0MHhJf8r+Q2sS7MWNaisDKcHJmxmhwrxO
	 /VPOcr4ydUIKXISmpSk0b/gG9R9KzwTQD5b06afXBPU+GmpDqWgVBErlQOwH6SyhvpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2Z3y/YgIqgW/WpidEBgfx0w8AzIW3YmYo27EBzGRl0g=;
	b=4g56TQHMLOyfuMDg7chGVsMrEZmUCD5L6WhqRkVJObv969SKR3f9EQ2d5o9fUb9H5RTQ
	 e/M+e2+rvIHYpWuFO8CkQDQQ6HgOd0ny5boT9KO9xD00d512FrAMqFqnl43znsHtJavfh
	 V9kvGTGLiJSsPJEy9Y+9gCH+8s44Ji2zP3Iy8CfUYhwjzE2uKi8hQxetWfKl+g+UNq81x
	 +Rug2J5aVxXV8he0N9LhuyDqbbZ/AY9xk7bSqrnwiB+iw++I8P7cixSsYFGb3kFr/WKmt
	 PoN3H3gcx8K0dlquV4VrzQa6uI3HOqBnZl8NRy2u6wCEAzF6+kBFhCm3UUMzLXBFFWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JrICPA59;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932DA606A321
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 932DA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JrICPA59
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9d7791b00so23857145ad.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078792; x=1793683592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Z3y/YgIqgW/WpidEBgfx0w8AzIW3YmYo27EBzGRl0g=;
        b=JrICPA59gqLNarvkqoO6weEHrW/zx/EtXlFr41nnZZhTOrquJH+7KlJpdvFvK/0UcH
         Dh5tNFTgPHYmXFKvUFewJIi2XvEK8rLKITKXSbOkrM3tI+SRkVR5oEMTKMAZb+VhmfnA
         rluifilPnZR2HrA4S8rDrLOLFcEIqm24Mc/Mp67k+86FnLlq+Pxfhy0Ov5ayl9ME4LYi
         RxR/iKU2aFqvtDs2/s42VfPtOGh0zFNvFu7m57mUq/IEpvdZT6da1uFfplL4oOx2MdkI
         ip7NjXTlg7qYq5uigXCZ+bFxBy6qDV3BeFpncVkIDluMNLte1MR4h3C8r3vHc0TileXf
         1xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078792; x=1793683592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Z3y/YgIqgW/WpidEBgfx0w8AzIW3YmYo27EBzGRl0g=;
        b=If9380BD2Y/iCEe2CnIgvranx+CtTAywk91qE+ucSMk02ljSbUyh1E1vt6dTnpmeRW
         2Hkug87UDrwQ5FuyEwZc13gesNqs8QAVq9K5E9OhjyGN0SWxx/4P1J/gF1tsa9MStkwW
         X3ALEmeBA9KDh9kuUNchyJX59ihcQGlWCEy+KKe6XZ2ZHPeAqLULJtzsEq9EVto+QC7C
         wcYQrt5bJEbrxIf1i0PYuWAZMQvVNj54Nimu5KPTCtz7YUzym2UQpdq66dw722ei8VTX
         cSQQOy+0dI/Vp5de6WrfiYcuKN6fYp3M3Hi8U/4IMhWJYcMI6DnEO54ghzhMUuG/lPo4
         jccQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLnqcr+Fl47JvXxuo69c5Q6b6btRvBVL8h7w5Dd/YeVSXxZaFDBsNekg2AmVhxRS+N9q5cONJS0mM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyT3p/0tY+O6ah3pJq9e+QKC9bnthrVesV3baheNRuBKdBRSMJ
	CcFSHWvj+kGv2gy7TSRJf7zbf04tzMgifl/dy5+uwBiDv8Udd1gpHDks
X-Gm-Gg: AYBFou09Ck6nVVpSW3+H0RPJcBNVr4wqhMd7wzpUaVAyMRBqY2SivamPqdTvi98Rj4A
	5NRHo6vN4vA7HwlHuCFz7OUji6AQ3zujjRqA5ROYhXSRbOiacQm+eLQ8SeiodVhVbasHiAOGxGC
	ruDFHWnuWwYhnMjSBEIRUjxuikx3VSpDEn6Bzoibe7n9c98YA/XCgMfunDIW9zHYphEGggRcpu0
	sNrjCXRJkLaZO+IKaeQ/7OJVyJdiq5o9A9VqQ2X4WS+jiqytNzvdr9v9slDKHC5NMHleU50VRJT
	9ZfnMkGY+lweu3pYYoA9r0o+twcJt6Yh4U75X29uFrJtOOc7EYN6wyJfRjqC/oMqKNiDozhngOF
	jXMNNNarX/zt0sqRdFVGoFXiQqjxeQWXQrZkTC8vxl7ovdFfcYPeVjDK5FCN+0q/N6eArCGlx2T
	90X9cysMF3e+zeZ0pnX2mI0Uo/9UxnWWINxZGk0nW3UAbvEQFUPRhZzoOOPy9s2P5iYbkGZSoHh
	1smYfWMYMUtKAV47cAar7Dv09PQQdnTLIwImGtnCUrSU094vkTqqMa9fYqw+Hq6EkeQO6Q5WA==
X-Received: by 2002:a17:902:dac4:b0:2df:b250:ad9a with SMTP id d9443c01a7336-2ea9c7c46e7mr64891145ad.48.1793078791992;
        Mon, 26 Oct 2026 22:26:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:26:31 -0700 (PDT)
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 06/23] X.509: Move certificate length retrieval into new helper
Date: Tue, 27 Oct 2026 15:25:19 +1000
Message-ID: <20261027052536.1722081-7-alistair.francis@wdc.com>
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
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

The upcoming in-kernel SPDM library (Security Protocol and Data Model,
https://www.dmtf.org/dsp/DSP0274) needs to retrieve the length from
ASN.1 DER-encoded X.509 certificates.

Such code already exists in x509_load_certificate_list(), so move it
into a new helper for reuse by SPDM.

Export the helper so that SPDM can be tristate.  (Some upcoming users of
the SPDM libray may be modular, such as SCSI and ATA.)

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 crypto/asymmetric_keys/x509_loader.c | 38 +++++++++++++++++++---------
 include/keys/asymmetric-type.h       |  2 ++
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_keys/x509_loader.c
index 0d516c77cc26a..174451b93edad 100644
--- a/crypto/asymmetric_keys/x509_loader.c
+++ b/crypto/asymmetric_keys/x509_loader.c
@@ -4,28 +4,42 @@
 #include <linux/key.h>
 #include <keys/asymmetric-type.h>
 
+ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen)
+{
+	ssize_t plen;
+
+	/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
+	 * than 256 bytes in size.
+	 */
+	if (buflen < 4)
+		return -EINVAL;
+
+	if (p[0] != 0x30 ||
+	    p[1] != 0x82)
+		return -EINVAL;
+
+	plen = (p[2] << 8) | p[3];
+	plen += 4;
+	if (plen > buflen)
+		return -EINVAL;
+
+	return plen;
+}
+EXPORT_SYMBOL_GPL(x509_get_certificate_length);
+
 int x509_load_certificate_list(const u8 cert_list[],
 			       const unsigned long list_size,
 			       const struct key *keyring)
 {
 	key_ref_t key;
 	const u8 *p, *end;
-	size_t plen;
+	ssize_t plen;
 
 	p = cert_list;
 	end = p + list_size;
 	while (p < end) {
-		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
-		 * than 256 bytes in size.
-		 */
-		if (end - p < 4)
-			goto dodgy_cert;
-		if (p[0] != 0x30 ||
-		    p[1] != 0x82)
-			goto dodgy_cert;
-		plen = (p[2] << 8) | p[3];
-		plen += 4;
-		if (plen > end - p)
+		plen = x509_get_certificate_length(p, end - p);
+		if (plen < 0)
 			goto dodgy_cert;
 
 		key = key_create_or_update(make_key_ref(keyring, 1),
diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index 1b91c8f98688d..301efa952e263 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -84,6 +84,8 @@ extern struct key *find_asymmetric_key(struct key *keyring,
 				       const struct asymmetric_key_id *id_2,
 				       bool partial);
 
+ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen);
+
 int x509_load_certificate_list(const u8 cert_list[], const unsigned long list_size,
 			       const struct key *keyring);
 
-- 
2.56.0

