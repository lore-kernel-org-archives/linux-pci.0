Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018B38D41A
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224669; cv=none; b=lANPUPKjBOcaOkhjUdKTNQMvVt978qRERBucPOOM3rxasxSmdcdCnQhx4J6je16B9jaIQ1DvwEV/ZeOPZO2zaJH/ZzmW0nbeLzgojqwwsgArRvmgOHTzeoJQ6agisjuKNZAFA7JO93j50yVOvTclVFBSthrqRAfvWpG9CoTeGbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224669; c=relaxed/simple;
	bh=BiaV76NHkxz06E8kYtTux48D14DxjulaUaglF1xarVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGWwe4nG0qHBgp/ufYJIRirhUsKJBogPdOimlkZBBO+2XEkaxEW6Y+zeoeHskoxZDtR4TKKab37wV5Fp1YXT9kLtsgXv4FPLiG7e1VtSKGUD5wSShFYxA0GkXN9AYb6D3GyNGEie4elYaun2tx1hfXQlqPeBdYLB2BwjOKNRLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQCg7ZlO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQCg7ZlO"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38511175ad3so4281710a91.2
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224666; x=1788829466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Y85wCLF7sPuzEoPMS3iNY9FbVM2HqAZF/UVKCQfhZk=;
        b=FQCg7ZlO5dP6o1Jmz76SfkFYqPGzEpZizZfVOWQ9mU0SfidARzmD776FAT7MTh5m2M
         9tCZY/tJx22nt3GeC8eznD5oKRkxbaXyMJ6RmtlIW71yX9ZCt/YNz70Dd1M1zWw5pyHp
         FKBkXsMooV0n+9HNYBoHrATgB/4LKH2LcpYK06yMJWA2w6a0Ah/PFPDM9jfCZSSk+FZh
         wRwv+m+9QG7j6Vp7bmEIDAd0ZJIO47kWZLLHPJCsddGdxLYwJngLB0gi7lYMMFMii258
         YKH2XdZoeRXeHXWP0woeAenbo58lPuqsjCYKMWaTiH5N/0D1RHdcdjb24Dj8VwNmgDlW
         IQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224666; x=1788829466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Y85wCLF7sPuzEoPMS3iNY9FbVM2HqAZF/UVKCQfhZk=;
        b=cIfSj9AhmwaNX0QYC2fWlTt7WoR8ffzeitkRwuT+g5KTSwMg2mWLNN+h3DCQB3EM8Y
         24GLkzlFmPjIBPmPA0CJEdL7jaV2JFzz7wdEgNXUsRA3zGIjHWTKUpbjPIW2QGelYitu
         U3ADBu6MaPXR+Ch/7uYVm776pfm+m2V1pCtWI4CCBoSXjGpLRVRf79UfW9A+cqbg0/gz
         NLcUfsXdxZHpY5y1A4SsvjKJni/70FabzAnr/HVNPI1MYsOozHOhnPNNZkimV6T/meMz
         7O6XcMTIaaJB7CODF6czXfuAjjsv1XRpERl03OkjG4XLIqJyW2mKIeeo/GOq8r9k6Vws
         GtuQ==
X-Gm-Message-State: AFuF++n5ZRr+y8WwHVnbeiOPWnNrT8kuBKT1QjT/EBA8LSzOky2FNemR
	wpMG7sG33pT8hCDma4bTn6FsWs5RFaBHbTNcxDTvY5eUCFg8c5lMIX+p+sIvJg==
X-Gm-Gg: AYBFou1etyaayQHHolOaZicJjlpnvELNyMWpzWKKzaKq0iG784T0v6EVqSJG4+TxGv6
	weWkKFHZ+y0cf8MYbQenuWO3iOvn5X4LclChIzT2SSHwjqvvP8uezZtxiSuLvl1Y5RQHCBmXPuY
	DaFSuwOzYzjn1b5lvswkGu8bIl0gQDURGXtDPLPnOm2fFwoH4xzF6HPq+HZaV+Mxbe6KUtc+ZVR
	K7MeQ9syaL7WdZAiJflEDL20bp+ybuyzDsJhrMgNlKEK3Pn9qof2ImziDaXt+1BThuTwtNnGIQd
	domEW8fFar3eaurvG+0G9wzXW3JdgBbcNN+FjKb31CiyFJYGqCfmRO4vfwuBSOLbahVICSKJTic
	m+/lI9GKFZjRXFEg/5tMYQ4xtFW0T8mh0lFyztULoCbEpB350A30Im+1wXx09IZugQEuO/zLHKj
	tzR39+4LA2dvC6h+w+f1XzF4B4MiWCmO5Wf5wMTQm11hgjg+b0Tnw7+3caeQGiQ8nFLJOSHj3pg
	PpyKQ==
X-Received: by 2002:a17:90a:e7d2:b0:398:9bd4:d15 with SMTP id 98e67ed59e1d1-39907e73facmr5625095a91.20.1788224666148;
        Mon, 31 Aug 2026 18:04:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:04:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	djbw@kernel.org,
	rust-for-linux@vger.kernel.org,
	lukas@wunner.de,
	alistair@alistair23.me,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	bhelgaas@google.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: gary@garyguo.net,
	ojeda@kernel.org,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com
Subject: [PATCH v3 03/21] rust: validate: add `Validate` trait
Date: Tue,  1 Sep 2026 11:03:29 +1000
Message-ID: <20260901010347.2614656-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901010347.2614656-1-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
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

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Message-ID: <20250814124424.516191-4-lossin@kernel.org>
---
 rust/kernel/validate.rs | 70 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
index 2b28625c25ef..663681b633c8 100644
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
 /// derefs to `KVec<Untrusted<T>>`. Raw bytes however do not behave in this way, `Untrusted<u8>` is
-/// totally opaque.
+/// totally opaque and one can only access its value by calling [`Untrusted::validate()`].
 ///
 /// # Usage in API Design
 ///
@@ -107,6 +110,30 @@ pub fn new(value: T) -> Self
     {
         Self(value)
     }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    pub fn validate<V: Validate<Self>>(self) -> Result<V, V::Err>
+    where
+        T: Sized,
+    {
+        V::validate(self.0)
+    }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    pub fn validate_ref<'a, V: Validate<&'a Self>>(&'a self) -> Result<V, V::Err> {
+        V::validate(&self.0)
+    }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    pub fn validate_mut<'a, V: Validate<&'a mut Self>>(&'a mut self) -> Result<V, V::Err> {
+        V::validate(&mut self.0)
+    }
 }
 
 impl<T> Deref for Untrusted<[T]> {
@@ -146,3 +173,44 @@ fn deref_mut(&mut self) -> &mut Self::Target {
         unsafe { &mut *ptr }
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
+pub trait Validate<Input: ValidateInput>: Sized {
+    /// Validation error.
+    type Err;
+
+    /// Validate the raw input.
+    fn validate(raw: Input::Inner) -> Result<Self, Self::Err>;
+}
-- 
2.55.0

