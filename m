Received: from mail-pz2-f28.google.com (mail-pz2-f28.google.com [74.125.228.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2EF356A38
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557924; cv=none; b=YYFw2lFVKioCE0gxnHa22sbk11Qg2AObSKuwYX+iBSMCPwzF2T9HBY94EKMZmj3m9+6qJY6c+gs+Eey6X+CpNvn0e/TTG/42s3/BUmQNqhNA9Y0QwAUk/flxq2UGIKt0JBRl4oroYT06zX3RDFIHASkGeI/2IVYXsJql8lMseUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557924; c=relaxed/simple;
	bh=/+92BewPm2fGZCajyZra46g01btF0erQbcx/NoXKKcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxofAbJEYpdRKvmdQsCVPL4w30O2iRwQWxPARqk4nmDYUy9l/nSAlOEIvjKH0fxysdKiOm2q1BSKqEikzjGDRjQB93icHiZLkPwkC5D+Smw0J2n5aH8X+wSebDPFezkjjPXBhg7x318RrMFdZEzjFk0Rq7A5iV/cCtK6hAGZ5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4JhFYdW; arc=none smtp.client-ip=74.125.228.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4JhFYdW"
Received: by mail-pz2-f28.google.com with SMTP id 41be03b00d2f7-cc745abb731so951911a12.2
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557922; x=1791162722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qUOMnpk1nr1JpJWRK47H9T9y8g0Y/F8pq/bIGmc3L5k=;
        b=D4JhFYdWNqqzn5IOprsUqeNeUZelkUxVp12hkHA1mwPPA9AW6mb8RQ0LO9owX2CnQY
         KRSHYwdigvf3wFS3jaS9tXCXZzLi+FZaJ0JtJVCxTmzjzuURmiqMvPEikZ130uZoKSAZ
         jULcDlftfyYKJmVgOPtN5Nmx+HIFNpKkP2cOT9sZQ8vYvxZsbBeWRVDB9Q+rhm51G0KW
         qmvSChV8cMkVYcMmFrqo9NqTh1f+wRNqrSkSxZiQdZqYCJpb/LKh4Q3GfM+ILWngwadV
         FrSn+hDImA4Adt5lcw0v+VjQdHrBH6r2w6fOoWWkiTB/B51rirtx9iCPElrBISpp9FIr
         vJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557922; x=1791162722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qUOMnpk1nr1JpJWRK47H9T9y8g0Y/F8pq/bIGmc3L5k=;
        b=l0qfcbNKQflB3w7MHETVR4E3LiEeLEMdgbmoRgZKIbTMVbEVgpnNcwXmGohM7/03gh
         dzI120mGng8f18pHGvyVhx2+C/VEj64hZEC2WHW4XbvktcsCwD/eFjAHnoBW4sU8BIvZ
         RRDc/zhQn18TtE0SjHO+3fgnsyn99TsFXR6lk54RcJRVRlGjEqKKxMaCTl6/CwVqLOYg
         1CWpE9y1bbKZUp4Gmr6JP66vfKcU5U59h2iLtJ3hqAKwHOSjQziXVr0ruKogsKg5T065
         igRcvIrn4KigR+C18EDA/3XppvgI+Wxz65b7q24iVfWlp4V4v6nuZxv1lRBCfMY7hIlO
         5wXw==
X-Forwarded-Encrypted: i=1; AKwUvBz7tz7ldAwiuVkymBy7hQh435c3oSp/Zjbtp4GPm5BZsP8iqjMJk2M5QpDYkKwIvaG1ogUAdt3n3u0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKadgPbj2e3V8L5BbB9o5QlNLN8x87Zj59bBtjVKxxw2OuRTIAc
	k8CyKsmsOLEHZsWYKzB8slSKPeI9iEdv4e2K6bIok15d8Nj8nOzaenq1ObnaMw==
X-Gm-Gg: AYBFou3ZhZmPoXHtbejpf/5w1vXW2LTzzXJQuEnVvKScBo08pxHtH4K4jkDoHdODlfg
	M4CAFCGqrFT9TsGx1pn6t2mk4vLk1kxk288dM64BfAFRSrebVKRgMF8SLl7AfI7gHGorvkmv6I3
	lk4wfnQHbvVFSuv6hSlG2C4jmY7EBi3BWo1yRl9ybVohbkuoT4YvZedKIxvZSvs2JJQ+lzzkn3n
	KMDf7Kfg2msQ0YsILQJwYAON9F9c1KG0mxXJ8Q/s5t+bIzwY/SR7DcjPGpZ2m3CsecbpRS9YmUC
	RaF0woBajN/LrGtR5MIRQkX2e204aRAqsKJ6zyiKKUJ7RzNhUiuN5YOe4/fXNqq4eKinObQt0Pv
	0U5yl0bJhJwG9IaRY9sXIRUCUM0rEF+hiOgU6uOYW5hK4n/EaIpOETZkPqv0O/MPaXRhAItx2hM
	bFNFMfeR0auLwuK+U00MpN5snDcgD1+W+Rc908l1Q5N4w1ll2TGAlAUKEM2wnmRIF0AAZns1sls
	3IMWWtF1frllfxt
X-Received: by 2002:a17:90a:516:b0:3a0:b243:3e85 with SMTP id 98e67ed59e1d1-3a0b24344f8mr4081530a91.34.1790557921984;
        Sun, 27 Sep 2026 18:12:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:12:01 -0700 (PDT)
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
Subject: [PATCH v4 04/22] rust: validate: add `Validate` trait
Date: Mon, 28 Sep 2026 11:11:05 +1000
Message-ID: <20260928011123.450800-5-alistair.francis@wdc.com>
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
 rust/kernel/validate.rs | 84 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
index ca2e5abda3e2..991eda67a50f 100644
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
@@ -52,7 +55,7 @@
 /// untrusted, as it would otherwise violate normal Rust rules. For this reason, one can easily
 /// convert that reference to `&[Untrusted<u8>]`. Another such example is `Untrusted<KVec<T>>`, it
 /// derefs to `[Untrusted<T>]`. Raw bytes however do not behave in this way, `Untrusted<u8>` is
-/// totally opaque.
+/// totally opaque and one can only access its value by calling [`Untrusted::validate()`].
 ///
 /// # Usage in API Design
 ///
@@ -108,6 +111,39 @@ pub fn new(value: T) -> Self
     {
         Self(value)
     }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    #[inline]
+    pub fn validate<'c, V: Validate<'c, Self>>(self, context: V::Context) -> Result<V, V::Err>
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
+    pub fn validate_ref<'a, 'c, V: Validate<'c, &'a Self>>(
+        &'a self,
+        context: V::Context,
+    ) -> Result<V, V::Err> {
+        V::validate(&self.0, context)
+    }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    #[inline]
+    pub fn validate_mut<'a, 'c, V: Validate<'c, &'a mut Self>>(
+        &'a mut self,
+        context: V::Context,
+    ) -> Result<V, V::Err> {
+        V::validate(&mut self.0, context)
+    }
 }
 
 impl<T> Deref for Untrusted<[T]> {
@@ -145,3 +181,49 @@ fn deref_mut(&mut self) -> &mut Self::Target {
         unsafe { cast_slice_mut(self.0.as_mut_slice()) }
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
+pub trait Validate<'c, Input: ValidateInput>: Sized {
+    /// Validation error.
+    type Err;
+
+    /// Additional context passed to [`Validate::validate`].
+    ///
+    /// The `'c` lifetime is the lifetime of the borrowed context (`&'c Foo`).
+    type Context;
+
+    /// Validate the raw input.
+    fn validate(raw: Input::Inner, context: Self::Context) -> Result<Self, Self::Err>;
+}
-- 
2.55.0

