Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878E33DEF2
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190468; cv=none; b=q3dZjdmXAWJkaS9gG2hxY+1AyJBA64zPCaqq43+cDJcMo07NIJbF7yjyPIwjo92RU8GzxX8ZbkbI4l3DWLOt8OoSRVVwY2PEECTDD/Qk3ZunyjHztFcv3F1hO9T4Zg99PzWqXbEgK20f4RQ9u4bKDuDEvtvqVtUNKfIK4GKDq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190468; c=relaxed/simple;
	bh=I7Eg9TZVIwhnpK+ZqS5PPnmgj8VTqwlD03DXcjwSxlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2122MZEexEvbTV4enQpM9aSSTqSJUcHGKa0YwhY9dHcd1IsaviAbUc3OHJFPGvhMPaXrC8Yp22KlQFhYIHX2Od0YMMrUR+5J0QgUA4foqoIWd5QfoR6XrkztJvCxkHTo9PJMniN39lYwhAbfept3GMhH3pNwhzMcgb/l6zqMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW+y05r6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW+y05r6"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c7c684353dso4045525ad.2
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 21:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190467; x=1782795267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx28JPVuyxeseCDpMYT7ZYlVOLpmmCqBqgah6lMJbOw=;
        b=GW+y05r6PH0MOe1MP9yLR/u45HHE/f8LJ8fe6TybDeeYQ+bRQXKM6ifQ5X1bWUqDsH
         HiOvzMmJS7G9BK8zUYGRB4pbI1ZZzroIrokZyhoxi1GAvpg8jbddgLEvjIaiJe/YgsNm
         hS+soJYRU7V4rklOzGtp1KbFz0MQHsgbAqM38inBfCoWowTE4s+elnEiWYCBBrHVrwMY
         QpQRFPwBzJvpS5uRP+Mv7QOrAA9N4vvkNi0i8oXaOOCY8nBEVoI1t3ZBDk45oEohplnt
         +DfDm3ze4AEJdBQdqp0KMnQoAAgGPdMCJuU2A3K9vFL+sb87MbSkrWUJGp7L6vnT8HdH
         Rvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190467; x=1782795267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xx28JPVuyxeseCDpMYT7ZYlVOLpmmCqBqgah6lMJbOw=;
        b=WGi6EFqTGJI2+0nUFwphGfTXM+KXg/JZtxOXMG+dqdhwiNGe9eZsfJJUNN0Q3y7dxi
         h8pBGxnx2TiUCQsK0QSzpUWwxpQvwSgXrUd2PBRGyt7RRi4qhy8sCOIObBbTeCL1gNKD
         tF6b/0V0V7oKCHZWSE9U3OCXK9Q8UTnJPDuP+ft1AzZpz269JN3fV+OEQ+YqvWqvb2tO
         YqbMASOIanCvaj1kkOV0PuFTl4JpEi+l7l3Jm9WNpjXB5Dn70Dlq0/DTdaK6i7I+nYPh
         2sYPMjD6UDIqTzvp7wiLzkBluV7/nFeFSJAWUSlREuGF/c1UZbTLTY4II20t9Yll1lTn
         UOww==
X-Forwarded-Encrypted: i=1; AHgh+Ro9IFh3KX3i1e7rlAZi3KnC+zET0nmGBjpXrIDHwH49e0tXvRsfMmPa6a0nOqBR8SnozI2BSfGb8lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBDcf/4HVRbFleafhAi8vgxMp0mLGTMHDCsakRK+5KNsqIzefP
	Onzd6CuoN9O7B1rHCpWXeotBmZFB0QYQ3Fka7wSZIZc+ssBq8Uqa/UNG
X-Gm-Gg: AfdE7ckG67+pofwCFcYJ6he94PZ5wpZgr0UrWMVxSC0n8vkkZBZquT4bOgv0bAWU/gy
	gZ4khuJzKIOvC3wLsty12ZdHdnWRkbkwTYzfwBPpgCQ259XB+jsimBtkQb1Gm6Ry/7+kMVFVXp6
	rfrdanx27NvVosJbd+uU23+0JiOQ0jAFP6s34GhOi/URQvoUgxV9pn5YbD+DW9XFyEEAg5+NHFe
	Vn/SZFuwjQsXfzGWO+ol1CQ4oFq7+BDAE3/TVDToV+DW59tBMXr2pTLDZzKkJ+Cd1u/r3VeGdXn
	wbMWiGpba3SDX2NeyZ5474KBDTODDmajg81sTVn8Xmb6Kl1rpIbJWpet2mNQ9yvmhcp4Lqe/WqG
	R3hKzGv9Q6vUALN8IjklU3H4t1TysvH4VHUaYlrdJcCsWmhNERrFTUG7vz6kTHt9pzmoPDw08bF
	ycw4M/Skqy04lXjNIJqVZ9iUjjn/hpCA==
X-Received: by 2002:a17:903:3d07:b0:2c2:be43:39bc with SMTP id d9443c01a7336-2c7c9a02a86mr9155795ad.22.1782190465984;
        Mon, 22 Jun 2026 21:54:25 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:54:25 -0700 (PDT)
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
Subject: [PATCH v2 01/21] rust: transmute: add `cast_slice[_mut]` functions
Date: Tue, 23 Jun 2026 14:53:46 +1000
Message-ID: <20260623045406.2589547-2-alistair.francis@wdc.com>
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

From: Benno Lossin <benno.lossin@proton.me>

Add functions to make casting slices only one `unsafe` block.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Message-ID: <20250814124424.516191-2-lossin@kernel.org>
---
 rust/kernel/transmute.rs | 59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 654b5ede2fe2..c1282fcc9e65 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -3,6 +3,7 @@
 //! Traits for transmuting types.
 
 use core::mem::size_of;
+use core::slice;
 
 /// Types for which any bit pattern is valid.
 ///
@@ -227,3 +228,61 @@ macro_rules! impl_asbytes {
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
+pub unsafe fn cast_slice_mut<T, U>(slice: &mut [T]) -> &mut [U] {
+    // CAST: by the safety requirements, `T` and `U` have the same layout.
+    let ptr = slice.as_mut_ptr().cast::<U>();
+    // SAFETY: `ptr` and `len` come from the same slice reference.
+    unsafe { slice::from_raw_parts_mut(ptr, slice.len()) }
+}
-- 
2.54.0

