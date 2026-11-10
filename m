Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284505;
	b=QnCsxCx5uIWOnSQWXpukIj4eI0B7+/88HI0iA38tnFqF7K+ws/2k+1JY9NdSiVrZZa3i
	 7CQG8pBUqjuQHHBMwCFZGeqqa0JRY90/U5rof8Ra4GVrnqUHEXK+B7Ycvwt9tkldzBLnh
	 aKdoA7HsjCWGz/abL5txccUJuPF9hIthheVkfRQuZKNc+5zZB4pUc40JVrr0NqSHdICeb
	 f2ID9Y7htUVlNuHDOVNOJEjrbDOLbW3FClcMCDrcRae0PCSxX8c4wlOZKnKXI2kOQ62H2
	 Zxd7EzJhvaazi8LvyU9pWyAtWg4tUViq5lyUJ5lLpiE2vq/n3wbOpGACUEBhAQdCxAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vvn0N/Mf2XDKU1UdfH8n9zC897rDJdvpuyd+JGWtjC8=;
	b=B1fheyQLx6VVXa6ibe/59kQ4Q7Ypv29dOgbmk3Mzks32oxc+nuTgS9w+USctokp4ooTa
	 928dmwKxB84ovb3YCNsLfmcKwij4ijthNornvcKIL4qAePzmnsyVJULhQmMlc957i35yg
	 SBT9O4vkhn6WkfsZ+2usKFRyr5hg5RDceFuWLvBRZnAYz4bgzQcStEUHQ6JyLcEEx5FCg
	 TJPVZaflke5H42wzYU7voTGp8WGXceNWzyCsuFka1LpEoHW0jbb7zx+2+/cSqmbyd98/V
	 kUhDh2QE6Q8cvSh9RG/EPfsSTyGwmdQXgz8+FYxS8memAMkSoI5Fzc9kenOSRwpRMog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="CkUNtGc/";
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F25606E8EE
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7F25606E8EE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CkUNtGc/
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1438d9363fbso947919c88.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 20:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284504; x=1794889304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vvn0N/Mf2XDKU1UdfH8n9zC897rDJdvpuyd+JGWtjC8=;
        b=CkUNtGc/IdLYYEBp0KfBNkDLcjNwOLWYY5889OwOd8dCaFE/pf6bgKCp/rWI52S3ig
         toH2RRyJFa5nCKyAUhemTo/KpcN1Sol/MHnT6mreE+/sBMF+rcYuk/vXC7DLEpb1TksY
         40CIWTNqGVX/JHGWNy+FnSxhT2nwChIEo6oEBwK6JgP3c6RVyAmVg8pzY9URuyqe/WIb
         ILI+4NBT8WGoAw3WY0T/6s4zF9RNfmSqRkwAEtpgwUbdKA67MMBMEBigjCTB/EEYiroC
         D+7soLk29vQwyd6m2sF3Rxojj2AfCDcxhi6pqxHyjzb9Vrbdncc8wTMokfoL1xd3TttE
         074w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284504; x=1794889304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vvn0N/Mf2XDKU1UdfH8n9zC897rDJdvpuyd+JGWtjC8=;
        b=cJOMhbrcRkXHvQAMn/4BxiZ4dkE+7BYIiOp0yx76t16OYtoCmYK16vit3CKyKn/7V+
         RZX18EWhk5xKcqRxXIvZFzK+V6YiihEvvNI7NNaRSn3UEpmWHa/thaJLasOijpgauAgy
         TVB1PuaBSVcMshnnB7yh2K+mMeNkx65Em997YGLg0wWaw+5K8mnHbaMcPlRPtIL9aBxO
         XWQywUvLkqh8sLvQSaVAD53QgP9Xl4bARpcTf2/e0xD2466juUnS6Jo+FDbq9eNNUfGu
         c4401KJBM0NUY9KdmZ3pxm34rHJq4JSGO+7LjjgVt6TIexnufNa4AopDxyXjE51OvmlC
         EYjQ==
X-Forwarded-Encrypted: i=1; AL+hErENN8TsLemF2oshcnA3GwGKWXh8C65UThioFd2CWuoaZ3EVZehjjHC/b9bAu0lc3UywWM1HvOfyVh8=@vger.kernel.org
X-Gm-Message-State: APuU4Z999HUq37F01Df38AOUPcIlX6OXlWYbvjpju5UVGBRtNp1Zrrah
	mRkWvKoj+YHZ731JEWMMOl9xzfgyq0SHy7Gzj/6JEAFwGY/YriWVwEys
X-Gm-Gg: AYBFou2/fxhZEULL5xzK7wpG+ussN0nSd9qdBjbY4tfmGGA/xtp/imra5XEa5+MrgDF
	5z0XA2XliL0zAZobMcgRhCR/jU+in0LlENqCcWW6S/hVp5qk4XGQ2ywglAUhF/6ZzqFY/EccFO/
	TNc4eMlFSEKyfqgqhPIX5J929NGDqq9Rqcq+uEs6O5OTZr+lqOG7tAy6D4xNl2GZUpOvWFvR4UH
	nq32D5CLBgIiE/pcuP9/DHqMT72CrALoCcH71jSyMmpWfT4oABCwa8ZqRD+jIlf7ZGq2Vhv1el6
	XW4y/cFDFi0bVrXPC/ZCRNofiUHF3vvyJOV2EjCw7AXe02uIOqxBA1VpBQRdn9AWMC1K/QdHkTW
	RUBnfAq5cveGVSBhmRqwDgNeAVD6wAmJckMbuDloiMErgoq1o3wLutckJgP628Oq07vvPEKpOCC
	cAEd/6coTNIdIyyR0hu+FxgoIof6Qho/VpeHWrkNw2PIsvl6qDI+rMzt4wUbUnUogNVZQMEwZxq
	aYjpdBnTNNy0jshSXlEewdBqDpL5iGD1dT4eUviPOYO7Yzl5MXsjvIVMfzh0kGYlsAuIWbUKa4f
	V0Pf2h3o377RJRRKnbUMMD4ycU0uvTHHeIckLuvqQRqqzxE=
X-Received: by 2002:a05:701b:4642:b0:1ab:e9b8:8a28 with SMTP id a92af1059eb24-1b3b5e167e5mr1932957c88.5.1794284503989;
        Mon, 09 Nov 2026 20:21:43 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:21:43 -0800 (PST)
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 21/25] keys: Guard asymmetric-type.h behind CONFIG_KEYS
Date: Tue, 10 Nov 2026 14:18:28 +1000
Message-ID: <20261110041832.1730924-22-alistair.francis@wdc.com>
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
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

The header keys/asymmetric-type.h includes linux/key-type.h,
which is where `struct key_type` is defined.

linux/key-type.h has a `#ifdef CONFIG_KEYS` guard around the entire file,
yet keys/asymmetric-type.h doesn't. So if CONFIG_KEYS is not defined
including keys/asymmetric-type.h will cause build failures as
`struct key_type` isn't defined.

Guard keys/asymmetric-type.h with a `#ifdef CONFIG_KEYS` to fix the
failures seen when including keys/asymmetric-type.h in the Rust bindgen.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/keys/asymmetric-type.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index 301efa952e263..b77bfa7bd5904 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -13,6 +13,8 @@
 #include <linux/key-type.h>
 #include <linux/verification.h>
 
+#ifdef CONFIG_KEYS
+
 extern struct key_type key_type_asymmetric;
 
 /*
@@ -93,4 +95,5 @@ int x509_load_certificate_list(const u8 cert_list[], const unsigned long list_si
  * The payload is at the discretion of the subtype.
  */
 
+#endif /* CONFIG_KEYS */
 #endif /* _KEYS_ASYMMETRIC_TYPE_H */
-- 
2.56.0

