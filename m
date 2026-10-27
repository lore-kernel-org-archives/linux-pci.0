Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078769;
	b=OfXup8mnUxYnmU+ctxNjyw7Wuc+Nbu5KbDJnPAogdAeD6Wkh7pgwgf+ErPFvyBpJJNTy
	 t8V/uqMqKC6oZQGGQixr721TDHWBEtVnK9YQwHb1FHy8YkfRmpczBH/rmXIentZzcNv8d
	 o7TVxp+w1onWi61BebkOypl4IfXw1eoS0D5LD2a9mZrqPv1mZHJH2ckI2L5zx+bUKdZUZ
	 vkzJPMWXjSeZNOj0dnSWTncQZQ/E1kt8DxJBpggFeD6LTHNp0SwcNgOyeSdu+V4WlbTax
	 7vgf0OYKmCke6uEUvzDYYx0VKUU3+HbLP2o140MooSHr/+NMmDNZvhov+zCeJ7zn5eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eTYRu2Y1roqXLFBUgarJRm+ifHHaPTOIT3dhmjarsSs=;
	b=4TMhVe3FGbMKeXO/JMVN8T8OJJ1rG3uqYE74HN/57GN/5sB7u5NNhd6FTBaTNgP9cwFC
	 zb5vAo+1npUMF6T50dFaZLhlgZ571SjgDPTRnURooZG5SFH9CcQh6vip4XH7NuceNU6Su
	 Ngov+EbCxXPoxinG9wmjeYQeLl4aBfVWaLuQEqHM50UV/WgdvU9E7MCcm1ZHVyg239tiK
	 V96wICfbWgsFyjAo6gnJedry+OU4+s0F9Tw8iEVAL+Nv38JToKoN06mu25cES3JDyofeL
	 5rF/6OQZJUABmiHQBule0laTOfRrtLj9gynFMkbSiqTD8yetFTphkiMyA/ankGGDrGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="H/C1bj0T";
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98D606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC98D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H/C1bj0T
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so2756727a91.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078768; x=1793683568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eTYRu2Y1roqXLFBUgarJRm+ifHHaPTOIT3dhmjarsSs=;
        b=H/C1bj0TDgjnC8GPypZRFILRml3B0fcwWkwh9HJFodsXetyf3QYY7hYT7aE3UAA7iH
         NpcUsHkwq5tIVfMeIWX8EyD97R+Y+2kdS8/H5ts2Nwni9FaM6t13N4vF5Q71VrQpe1TU
         RruVcKusMiOprAucGuOBbsLxXRA6UJNTTshPovKcdv6mSCJoaBL6wCYNDCK+8M+kBlo6
         OonCx4f10IXEP6oGydwdokS8NzrgyfXV4vAxG4qI/wF4YvmKv4S+kG6LTXDrETA8GoaA
         MiM4ZcKwxKhp3X8Ctc87Gh1q0gpk7+Qq392DuUEY1JGu+t9IRwGBfearOgXFpZ9WW2BC
         qJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078768; x=1793683568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eTYRu2Y1roqXLFBUgarJRm+ifHHaPTOIT3dhmjarsSs=;
        b=zDDtJoX3V+/wQCD5H2evckyXLmHFzhWbnPh399qH1/BgQbLZKwZ0mhC5JztIyKDEdq
         fcjpYYtci0C8JgW//qPQW3HU7VQcTOlO9ENwGIcc1Sxp+Fu4XIGJc12tP8mR3uKPMHh9
         Vna/kVoNh9ms54Clm33LGDcj4TElQZYo86oY01vbqcMiE3pKKrDKFNcZmg3c5LDlobe8
         jJAA6hQ+Bgup/F22o08OvPHWvJsZLJN8Miipa/FHI3ssKqpbDM3n8EKBAz9zjBint1hm
         LLPRqxvgpOoaQAAoeZnVmmwQAfBHJopVsqNEphKSElwWDrcNbJiY2v47B6rdfG7e01aM
         BmOQ==
X-Forwarded-Encrypted: i=1; AKwUvBykBdygf+vLHxzq4yvPURdbolL4Ptpwo80emtlPflJJXsfmxY1HBKUFscSrK0BKFhQcIzqPsdr8TmM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8JFMctP+b/0GGmZwO7l4zF+231MdAikbH/gnL4pXqTOfaBGIY
	Z0cdVu7Qz8LuQYNShr57WjiFVg1PUO9YLNoq13MNOm5xoW744XO/Zfip
X-Gm-Gg: AYBFou2DeYnJTSgER1WwXZeAs7kXupRIQPcxVrvzgADGd2UC6Eu9xG5dXUEwDeKee/h
	IideikGGOn9LVyYfNhf9uxF7tLHxBaHBDVHy1ZeV6jzr7nMLquyoKRIso0HZY8vi4QIf3CgwOnr
	uOQdIo+nYkPo1JafH9JxTmJRxGXBeqwZu7AtHFrr6hcQUiwXeOWGiwLmNBF8+k3flRGyebUF1w5
	63U3LN/6NHfLpzLWfvPfZf/NjrUklRPmGfCeLMlh+oiF7dWQ28gzPs1xTtkIetiXZZ3M8O9vLfa
	xVdha3bZJZ4pacbvO23VzCdZX6HklCA7aSS7b38foNT8+bLm9OfXNNOAKfG3OaW7p3/dAkfnwRa
	JijEz+oRxvxl8sDJqqtS4SXlIggKQqxvzqLWjMxx3H0BSoztz/+4nj4o+U5eJ6S8aL8/S5m10Qo
	re+28Oe967166sBLmaT8PWjBDhDJRTb2c6nPTMoOx9lGLOsmovOyydy3AeJnYig0FfP++0uyEXB
	iNi9/6ATprH/2CQx99ThG+JqUkFcWvw5PE9H9sBLocpO33vLaxvT3PeyFlZXJgBYdDSTGt/pg==
X-Received: by 2002:a17:90b:1407:b0:3ad:eb4c:26fb with SMTP id 98e67ed59e1d1-3adeb4c27b0mr4785981a91.23.1793078768021;
        Mon, 26 Oct 2026 22:26:08 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:26:07 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 03/23] rust: validate: add `Validate` trait
Date: Tue, 27 Oct 2026 15:25:16 +1000
Message-ID: <20261027052536.1722081-4-alistair.francis@wdc.com>
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

From: Benno Lossin <benno.lossin@proton.me>

Introduce the `Validate<Input>` trait and functions to validate
`Untrusted<T>` using said trait. This allows one to access the inner
value of `Untrusted<T>` via `validate{,_ref,_mut}` functions which
subsequently delegate the validation to user-implemented `Validate`
trait.

The `Validate` trait is the only entry point for validation code, making
it easy to spot where data is being validated.

The reason for restricting the types that can be inputs to
`Validate::validate` is to be able to have the `validate...` functions
on `Untrusted`. This is also the reason for the suggestions in the
`Usage in API Design` section in the commit that introduced
`Untrusted<T>`.

The `Validate::validate()` function allows additional context to be
passed, which can be used as part of the validation process. For example
comparing data against already negotiated information.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Message-ID: <20250814124424.516191-4-lossin@kernel.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/validate.rs | 85 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
index 3c1fe37624573..3d1c4107fa8fe 100644
--- a/rust/kernel/validate.rs
+++ b/rust/kernel/validate.rs
@@ -11,6 +11,9 @@
 //! APIs that write back into userspace usually allow writing untrusted bytes directly, allowing
 //! direct copying of untrusted user data back into userspace without validation.
 //!
+//! The only way to access untrusted data is to [`Validate::validate`] it. This is facilitated by
+//! the [`Validate`] trait.
+//!
 //! # Rationale
 //!
 //! When reading data from an untrusted source, it must be validated before it can be used for
@@ -56,7 +59,7 @@
 /// untrusted, as it would otherwise violate normal Rust rules. For this reason, one can easily
 /// convert that reference to `&[Untrusted<u8>]`. Another such example is `Untrusted<KVec<T>>`, it
 /// derefs to `[Untrusted<T>]`. Raw bytes however do not behave in this way, `Untrusted<u8>` is
-/// totally opaque.
+/// totally opaque and one can only access its value by calling [`Untrusted::validate()`].
 ///
 /// # Usage in API Design
 ///
@@ -119,6 +122,42 @@ pub fn new(value: T) -> Self
     {
         Self::from(value)
     }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    #[inline]
+    pub fn validate<'c, Context, V: Validate<'c, Self, Context>>(
+        self,
+        context: Context,
+    ) -> Result<V, V::Err>
+    where
+        T: Sized,
+    {
+        V::validate(self.0, context)
+    }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    #[inline]
+    pub fn validate_ref<'a, 'c, Context, V: Validate<'c, &'a Self, Context>>(
+        &'a self,
+        context: Context,
+    ) -> Result<V, V::Err> {
+        V::validate(&self.0, context)
+    }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    #[inline]
+    pub fn validate_mut<'a, 'c, Context, V: Validate<'c, &'a mut Self, Context>>(
+        &'a mut self,
+        context: Context,
+    ) -> Result<V, V::Err> {
+        V::validate(&mut self.0, context)
+    }
 }
 
 impl<T> Untrusted<T> {
@@ -190,3 +229,47 @@ fn deref_mut(&mut self) -> &mut Self::Target {
         Untrusted::from_mut_slice(self.0.as_mut_slice())
     }
 }
+
+/// Marks valid input for the [`Validate`] trait.
+pub trait ValidateInput: private::Sealed {
+    /// Type of the inner data.
+    type Inner: ?Sized;
+}
+
+impl<T: ?Sized> ValidateInput for Untrusted<T> {
+    type Inner = T;
+}
+
+impl<'a, T: ?Sized> ValidateInput for &'a Untrusted<T> {
+    type Inner = &'a T;
+}
+
+impl<'a, T: ?Sized> ValidateInput for &'a mut Untrusted<T> {
+    type Inner = &'a mut T;
+}
+
+mod private {
+    use super::Untrusted;
+
+    pub trait Sealed {}
+
+    impl<T: ?Sized> Sealed for Untrusted<T> {}
+    impl<'a, T: ?Sized> Sealed for &'a Untrusted<T> {}
+    impl<'a, T: ?Sized> Sealed for &'a mut Untrusted<T> {}
+}
+
+/// Validate [`Untrusted`] data.
+///
+/// Care must be taken when implementing this trait, as unprotected access to unvalidated data is
+/// given to the [`Validate::validate`] function. The implementer must ensure that the data is only
+/// used for logic after successful validation.
+pub trait Validate<'c, Input: ValidateInput, Context>: Sized {
+    /// Validation error.
+    type Err;
+
+    /// Validate the raw input.
+    ///
+    /// `Context` is additional context needed for validation. The `'c` lifetime is the lifetime of
+    /// the borrowed context (`&'c Foo`).
+    fn validate(raw: Input::Inner, context: Context) -> Result<Self, Self::Err>;
+}
-- 
2.56.0

