Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514D341057
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557910; cv=none; b=jE2d5t148CKLopficpBQckpaQ6plLb4CSV4psRm82cKigp8Q/bjCR45zi5b5IgxRb76B/y0Av4pHMhyMx/8nE1ZGYobV35O+0BHzK/2tGZBSVv68qcIm+GTa/v8i7oU6tfRfDzUIz6Xsp67MU0PTJLJjrv0JYMBmD+wxqqunL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557910; c=relaxed/simple;
	bh=p8JwPgU1xRJyWiaWo5PEfMwIN7CbI4fAQ4CChCA/yRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2PbiHMn9nDUoiLIisVBCqurf14BacoB4ZzTjELiBK53pgQTIv66T5LunDWTFikRFzUGLPkxWReewgG4SkUQlzLKl+hZcokbZG/6dRJcpDJT9wNtNepHE4KR/UUqDeGP6Tx4rWm+h8f7mn48QoLWGe87gGT+IFE4kUJYEtdsN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6oOqcmx; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6oOqcmx"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so1304217a91.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557908; x=1791162708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mFJg0vsGWvqBUD55IaY5ElA+ee/UB4gcWuyrn3oaq14=;
        b=p6oOqcmxH3HazDcB8ksy116zY3USdrFkdYDYQy5LX0uhE2w8Jx/T/qgCduZ+6nFjbh
         YGYzkU1n+ZZ8Bb2ZcmmqX+D7rP1BbHd9bqiikDbggNXc4aKKdrEU7k0G/hqlS6jKN8oh
         PPJhcELqcg7L0dxGWvnTjatOim30eaEUOCEK4dZVSbGj0SkVhxzg1bQHyiqE3yaXKgM8
         U5h+ygvH69s7LMKL4gPn63DcUQw1gIjaYgVvuHCiAdQfO5zTIE4XVog/rwQZj3MKdxgo
         tfR3umCcI4IXAdWx/RGkiMRisknQehAw3qV8Xxq7mW2b5PFLUzh/Jysdin3QjdnfuT1O
         GKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557908; x=1791162708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mFJg0vsGWvqBUD55IaY5ElA+ee/UB4gcWuyrn3oaq14=;
        b=1CKA5BSGHihWsTh5wrBWjonpOBjzZ3jS7x2mbXNUp9Lj1WPdFxKQnw+ZND/+lrfLXQ
         253TmwiSi2x+M2BANhqL9cviw7RtAm3ddN12XRBiuUkbUiDJCG3L3bUv4BI4Yk9KTT0C
         8tB0kaK8u9TGgB3taIFxH6WlCEvgk3lMD9at82+THDH9qB3fIVFVJzU/MNL8apXYRMf0
         n8ufMSU6GKhC9safOH/gg78b3ViawDo0W1byC3YkcMOjWxiOKX+9PmImcPCyR1PlYrBS
         5IalB4xZxelEWRpbaGL9wT+XRwFP4OUKsnYNPpnjNnm04LVMFrvvzeZIBK77JYYxBQAD
         31Nw==
X-Forwarded-Encrypted: i=1; AKwUvBwAR8Jt8L1dZryR8S6J07XqOzJSicQtzhKOXRqXiHEqcr1HIcb4vKaqzbtAhpvrmwZs6nG1TfMKzdY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJv0oVX99C+6c23dy5EmubNdv7l/B8WdzwRGhQqFCGsX4riqnTZ
	TT0sxseDTjb9BWFJ3in0KiETZGp3n0hFFVU//5HK3+M1GOEWncYmwsk4
X-Gm-Gg: AYBFou1VAKqUoWCG4/Uj2aybqkuvsXtOsrG9iF/QE+QB0aq5vEMbDPJkJMPXmzxUxuH
	me3SQUUNu1y/MQFm8Yox1E6LY+FM1tIcIMUfuqjwT7lQwZnTaEyydhqtegstZ1gFmCgcNVQR2Ai
	O+qQphD06cQCBUZeb34bRi1LauesdpFADdqyF5GRExU16FP65KPLDWQmb0HUvcv6LfOcksHSwYp
	wuyIaLYnj8SLiMLl7eRIPSbt5FtjdLorc6WEwNlS9Y6mnNXW3tSC+85QukijBAXGUuocC+mJTt5
	JbRHpVfR9Y0VaIC7Or3DF9TcckkZQvqtLAamW73dDTElU1E+sadpOwefjt5m58O51BkXbvYbbvv
	ywPg3OMluMup+JZz7rIZ0eWuO0BMym9UIcU64sr+ehofiS2UJ+UKWmMMdYS1qnpT8/zQ5R161hq
	nplfEHcLK5YDwJ33XKtDJASIzhCrNSfR56p/PJij0gyUl/tFswV+mzl/qketPa6/gxnrNcPN6fe
	CCsEflEkgyI62ql
X-Received: by 2002:a17:90a:1149:b0:3a0:9c9d:eb0b with SMTP id 98e67ed59e1d1-3a09c9df050mr6698377a91.58.1790557907473;
        Sun, 27 Sep 2026 18:11:47 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:11:47 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 02/22] rust: transmute: add `cast_slice[_mut]` functions
Date: Mon, 28 Sep 2026 11:11:03 +1000
Message-ID: <20260928011123.450800-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928011123.450800-1-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benno Lossin <benno.lossin@proton.me>

Add functions to make casting slices only one `unsafe` block.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Message-ID: <20250814124424.516191-2-lossin@kernel.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/transmute.rs | 71 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 654b5ede2fe2..68e96c635ed7 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -2,7 +2,10 @@
 
 //! Traits for transmuting types.
 
-use core::mem::size_of;
+use core::{
+    mem::size_of,
+    slice, //
+};
 
 /// Types for which any bit pattern is valid.
 ///
@@ -227,3 +230,69 @@ macro_rules! impl_asbytes {
     {<T: AsBytes>} [T],
     {<T: AsBytes, const N: usize>} [T; N],
 }
+
+/// Casts the type of a slice to another.
+///
+/// Also see [`cast_slice_mut`].
+///
+/// # Examples
+///
+/// ```rust
+/// # use kernel::transmute::cast_slice;
+/// #[repr(transparent)]
+/// #[derive(Debug)]
+/// struct Container<T>(T);
+///
+/// let array = [0u32; 42];
+/// let slice = &array;
+/// // SAFETY: `Container<u32>` transparently wraps a `u32`.
+/// let container_slice = unsafe { cast_slice::<u32, Container<u32>>(slice) };
+/// pr_info!("{container_slice:?}");
+/// ```
+///
+/// # Safety
+///
+/// - `T` and `U` must have the same layout.
+/// - Every bit pattern that is valid for `T` must also be valid for `U`.
+/// - Neither `T` nor `U` may have interior mutability.
+#[inline]
+pub unsafe fn cast_slice<T, U>(slice: &[T]) -> &[U] {
+    // CAST: by the safety requirements, `T` and `U` have the same layout.
+    let ptr = slice.as_ptr().cast::<U>();
+    // SAFETY: `ptr` and `len` come from the same slice reference.
+    unsafe { slice::from_raw_parts(ptr, slice.len()) }
+}
+
+/// Casts the type of a slice to another.
+///
+/// Also see [`cast_slice`].
+///
+/// # Examples
+///
+/// ```rust
+/// # use kernel::transmute::cast_slice_mut;
+/// #[repr(transparent)]
+/// #[derive(Debug)]
+/// struct Container<T>(T);
+///
+/// let mut array = [0u32; 42];
+/// let slice = &mut array;
+/// // SAFETY: `Container<u32>` transparently wraps a `u32`.
+/// let container_slice = unsafe { cast_slice_mut::<u32, Container<u32>>(slice) };
+/// pr_info!("{container_slice:?}");
+/// ```
+///
+/// # Safety
+///
+/// - `T` and `U` must have the same layout.
+/// - Every bit pattern that is valid for `T` must also be valid for `U`, and
+///   vice versa, so that values written through the returned slice are again
+///   valid for `T`.
+/// - Neither `T` nor `U` may have interior mutability.
+#[inline]
+pub unsafe fn cast_slice_mut<T, U>(slice: &mut [T]) -> &mut [U] {
+    // CAST: by the safety requirements, `T` and `U` have the same layout.
+    let ptr = slice.as_mut_ptr().cast::<U>();
+    // SAFETY: `ptr` and `len` come from the same slice reference.
+    unsafe { slice::from_raw_parts_mut(ptr, slice.len()) }
+}
-- 
2.55.0

