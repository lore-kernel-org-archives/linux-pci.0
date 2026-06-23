Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4253A960F
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 04:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190643; cv=none; b=p3UPvfBaszZO0ShvO/52wNf5QZatXm/rCFQW4w2VijcGxAsNbx1CY4K0c/wWjomwNyNqya7hl74ceIu3VT4uFqFIussT3B8yx/sdT8FMKIaX5YjXS7zbFliLbXJMleUEpJM1pFEYWTqmbSjOvjI57SJLPKgDN/02k7dUYlsgKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190643; c=relaxed/simple;
	bh=b1p8QYDJtGAUMfQOZ7yKfgv3g86cSUtLRbu9pIoZySA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/fm7lu9+atzTJA9y+Ihif+tq/LkeaNEf6XsWg/yzOm0/E58daGfcMuw+HnSZRZPEzisMgDvInTWrJO42dgPOMIeNvxX5qJTgulS9m8tapsqDWxMa1b3Au/jsIa5vNmbZl0s/x1PvmQB8uQAVCGnLbrXNEKb3hW5IgvdXojzNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7w8ssGZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7w8ssGZ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso4599208a91.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 21:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190642; x=1782795442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk8SrCAuPrpKQay4vKvsDXzhAFJImT5ZIR9RIcxuUy8=;
        b=Q7w8ssGZZupMkR2wFzIAww+68cYnEOyRtEja//m35Pr2fnc17UvxpsbMjZ6xhUxSok
         weggbBQiS2LOqg+WEvjaaJjN7Ad6R0vkv9UrjGHDdH+0whVG7qgj5mZg4B7Z9J7j6iZa
         7fRcB2C3DVFuWphbqQ3HxBEG9NPkIPP1Nc6z/6HlyjkRfEgQrrSk69B1LyNEhJxEBdLZ
         hXRN10j206jvmbuIz1deqpZc7BE7TYCniKwgKtP8CFsv7I8apLubV9BJ7H/owG2tXixD
         jD3gtJX4r3borNlw5m5QB+gFr7nZ/6VrRwfpQy9qCRw6V5auORLXEUcllqOrXpp08eMy
         k6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190642; x=1782795442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xk8SrCAuPrpKQay4vKvsDXzhAFJImT5ZIR9RIcxuUy8=;
        b=BwAhbcHDRPo52T5s//I7akgbffT6zVRcP0UsTl0duSGVWobnVIMHM9gHjagipfdXB/
         bq7YCvGMwwGTRZfqOX9FzaTivlH2NxoXa1SuPsqzNHTaXCMQxjp6g1Q1TP7Twcvhu6je
         88j/3HS1nonMPQBgks6TWXETYHOtUefEs/N1vHPdDgtYcq/E7ICqXms5KX7qQqoo27iK
         q5rNa1IJUkhmWYOI5xowNFfNRtEssKq1nO2Gc4jNYSECcv9kmRjwJ93YUgoFPY+zv5sF
         pkAI/UwU+lu3Pf0TTb2bXccH8sOJ/8vWEdKaKB7+Su/9+BQj9VjLwNmdxqOZqMTEXTBS
         6Kgw==
X-Forwarded-Encrypted: i=1; AHgh+RoTLj9NpZimChE1+s1w9vOl389J7nw+cMtqNhtyXTDtP+xdEmawX5N9Rmgf9Rw6L3HcHZoGamfFG6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpTkwH4je+EwDBaBAb3Deh452c7nvMKK3zKr1nbRzeYoIo4vxm
	GSoZaOdd0WW8QfBTgRPBPQf/Y77tbvCX/QQafwqM4Fm7Owvcx/Lwo6zC
X-Gm-Gg: AfdE7cmaXlfnRbLfvX5DsJV11n4Pp3aZP3wauRBU4gpfuoyDGwocU8QfdT9I8d1+vHO
	5DbV1uJYPX1D0EHM0STyyFlbmTN5DPt19bdV4W41MGq8YE5UVb/1usMqwEayYDdvdOyfTAbhUC5
	YGUkqIK+XF0jtEi8JXdKP1rQQvV191U5QtuHUPkMukd5YyDtHziAvuuJdBOqYZRcFTZZQU5p8NH
	15SI8Av82ZdMXtoegGxdoILf1zo9Y3BrXXaRMiCMUlQ/kwIaVsXll5KF28AbkKkqvXfmlt3RJO5
	rp/jwgnsWMOA5wx/UV6ih8OuRMPpum/Q+9NbhcqviiSjS8XLBkmY3G/qkLHjY/Neqr4a9E3LXnu
	ltbQa7umMoJZnaclN3/4Hnf8tyGfiv93jbG/+OFJD+qdBFh9FGWO+8WXbJw5Bq+uzhClr62FcOs
	o/z1SZHSRkvDqClbFUTEqYQ83XqHzCEQto31ZnlUqg
X-Received: by 2002:a17:903:2b07:b0:2bf:2e06:2ebf with SMTP id d9443c01a7336-2c7c76d610dmr15796005ad.31.1782190641888;
        Mon, 22 Jun 2026 21:57:21 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:57:21 -0700 (PDT)
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
	tmgross@umich.edu
Subject: [PATCH v2 20/21] rust: allow extracting the buffer from a CString
Date: Tue, 23 Jun 2026 14:54:05 +1000
Message-ID: <20260623045406.2589547-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623045406.2589547-1-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair@alistair23.me>

The kernel CString is a wrapper aroud a KVec. This patch allows
retrieving the underlying buffer and consuming the CString. This allows
users to create a CString from a string and then retrieve the underlying
buffer.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/str.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index a556788bcc5e..3fd8a218547f 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -870,6 +870,12 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         // exist in the buffer.
         Ok(Self { buf })
     }
+
+    /// Return the internal buffer while consuming the original [`CString`]
+    #[inline]
+    pub fn into_vec(self) -> KVec<u8> {
+        self.buf
+    }
 }
 
 impl Deref for CString {
-- 
2.54.0

