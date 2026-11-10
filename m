Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284350;
	b=MMQD8H27PsrTgUdK8lKZ6l8LXdTeyGfyr49upD55bj5doVD7HF2G4xHIAZHAUmbSiEyB
	 rvpWdnpB/Xr+4EPNJdw2sXENUGdf0Iee2GKGmnjr8vyxwDQTbq0yp3V1+rQOguXXacoFH
	 uyrnlf+NNjnKLnQ+nkut1oN2NWXSFuW2yYHnT+TssDKbOmszYIkZr+IHn5ADmq/bw0MAm
	 9VbbYv+/TUa7czviiulovw8AJ1vKIoGqhikRLucwdco5rT8xBK2U8m13DH6uinLcHAGnM
	 QHFXsDYwWgzLR7uvhpvLS5jlAT8O1UrWjaVPEynBSX7VpVXH9FUbIy1czGI1+pV1d4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j2kMsOhp92fCLsO0obs3IL9PPq/SCiWUbTQc+uhZCXU=;
	b=PQVchL9ajmGkfQPVvHXWdrcx6UqedIYOyfiICrnEMSHwyP3+8UwefkCqtfnYy0+Zvikl
	 ayjYpImafg718McMsuk2sWrP2Ttb6GfesWWcEIloYFhJjBFaPcDdv7Hf9HHjew39uJnW9
	 PVlLGlPs2ZckpJ8HhPyHFPIoF3KgwyksnI6zMKwhZD27+Sv4WWcFrMLJtIQrD2AfaZblZ
	 Zk6zy0bjrPXA7DWYaM8MtNV3Dy0er9dmPqKJP0o2pD3tw5YDG2AidGgiUCdyhFme3BeKF
	 jVIi8T395jX6+VT0lacTrnZ0lH8OCodr+c1CaI5BIs13SlQ6YP1QSg0An8mZt8ouhwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJ8PRqK+;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4074F606A332
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4074F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJ8PRqK+
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a3c08d6928so2880108c88.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 20:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284349; x=1794889149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2kMsOhp92fCLsO0obs3IL9PPq/SCiWUbTQc+uhZCXU=;
        b=iJ8PRqK+HdX5GWTx2chepwBxt7/0tmVLfODoxHuSSvkvErARbTnFSrboU1gt4eRf8a
         URhuGXpPqS4psk94/0pfgXITuI+/k4KzwyLSiTf63mqrDIAVpkRJRLBSrV/hp/8LQ9tC
         iWRGLNGircSUyiX0MmkrXkICnQpIoZg4ZaJmKXUL+vkoW4tOXcoPDLyKcasvnXEqenw1
         kQud+2iBP4Y4qrhVLIrh017JolN5D2lhp9YVS+FbC5FchrGR2IFOghtO1Jrc55kIqi/P
         Q89o021dj8UypN+i4BRWBlVAdohSH5uFGN7FJUZXFIpHcaP7m8EE0b6QzPTHKjPcMewV
         XUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284349; x=1794889149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j2kMsOhp92fCLsO0obs3IL9PPq/SCiWUbTQc+uhZCXU=;
        b=od3COuzSDVHmBOeI9ke20HPkzj3ADoPVYseGDA8RQMoy0N4uA/tigYik1AilcBXwvO
         b082abMnrrJSV5jSL2CX0FBIJh6M9glWyPtcyO3YmLXQ5MNNufUsOale9mVOmcXZgUlW
         w1E+2iEKq8fbv8MqMcxXV//MNtVD6rSvuON6VAQzc5/jtpjviD1p2+TPUVHAzAf1B3N+
         esca1vgMkvWdqM6MBXUOfDUFu8avZ2uMsXd7rNiVreE6+oqw7r4F3TwTQcj7C6WgmUWR
         /Zv65Vz/9bM+EsyTG2vIkly4eo2SugmNjCMeCRVOCfwS3/hsR7ePcuu7oJRgimKyeat5
         +Gfw==
X-Forwarded-Encrypted: i=1; AL+hErFwqB9XLJaP4gdrfZxgOsNTu4KxtQMf0e/OTxRryBmDwQ3UM3GUDWLtUqZjquV38Hr4y3D3Fz7SRDo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+slrpOQ7rUcPuqyfQuMjH6UVcsK7o1pqu2ewzjqFMLxERb3Eqc
	/03mpi0AHaNvdvZJp9AWo9osvqHUiRV1O9yLmAMJVEov0t9QfYOkNHYb
X-Gm-Gg: AYBFou2zkuMJgRbQNrv9eGtOrADbGyzco4PXY5nlKFYxRRMedxwbzaUvN3H/ArPGvAh
	Zf6IDymS1KcQTZ4nMaLdhZS3s+a1nV9sUTeEQDXLvjy8+3/9NIF4WxevntKp2iAZD7y7e+/ocl3
	NL/UygDH9caN7UulGxwLyRpmPV47AGlFiTlR89YrjoQeOiReQOz47lqEyGog/UKVCQV+hyS0Ag7
	qw0AMJ9zKXgCh123Iu82lxp/qFu/QqbT7mmm73iOL7RI81d81hjz00u4mZYw/43GJcoQ7Wwo1BG
	Cg97oxe91S+c3B84lKfzOfCxI674sBbL0O8p/tx7odUonANRnLzeYFvC0qlsuB0Sv2xtukfgkK9
	87olmhkMppWLNw0bhF6+z50HuqIl5Q17phhGf5a3mKlQB9CNTz/g8RVd1PbXx+KOMtOh7zMK6nq
	UehoUlV8/U2G5T+SOhllQIjgWYtrPQ24V4A+gV3tkCdn9AFsb3xjI9+b5tFn8uVu3sFvdyUL3lh
	E2nqnIWSMJT0/mKNsHug+FkZn7CbqnLid7LSIBVIf1CksUh6GriZ0FZMsO0uFqLWKdNs7frZYth
	3HBTZFxhYAdGaIkJYwrgztxAya1nK5p5OopK/YTFi4/OPys=
X-Received: by 2002:a05:7022:e884:b0:144:e535:3ef6 with SMTP id a92af1059eb24-1b3b6046680mr2240260c88.41.1794284349175;
        Mon, 09 Nov 2026 20:19:09 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:19:08 -0800 (PST)
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
Subject: [PATCH v6 03/25] rust: validate: add `Validate` trait
Date: Tue, 10 Nov 2026 14:18:10 +1000
Message-ID: <20261110041832.1730924-4-alistair.francis@wdc.com>
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
index 5926d0697d3ff..3f5fed5eef219 100644
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
@@ -53,7 +56,7 @@
 /// untrusted, as it would otherwise violate normal Rust rules. For this reason, one can easily
 /// convert that reference to `&[Untrusted<u8>]`. Another such example is `Untrusted<KVec<T>>`, it
 /// derefs to `[Untrusted<T>]`. Raw bytes however do not behave in this way, `Untrusted<u8>` is
-/// totally opaque.
+/// totally opaque and one can only access its value by calling [`Untrusted::validate()`].
 ///
 /// # Usage in API Design
 ///
@@ -116,6 +119,42 @@ pub fn new(value: T) -> Self
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
@@ -196,3 +235,47 @@ pub fn from_trusted(value: Self) -> Vec<Untrusted<T>, A> {
         unsafe { Vec::from_raw_parts(ptr.cast::<Untrusted<T>>(), length, capacity) }
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

