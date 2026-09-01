Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4C3438B7
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224717; cv=none; b=lGeMU22FA1o73sQuV/HNC2ZMepR/aV4g9nr0yRJSAVhA3PpnN+L75fNEJyTasyCxfkovbEStpGIQbeLqHKAIfQFDnaG3qAMu6B3k6Bf1+h+WODrNngWog3Uyvsf86tq6RWTmkj3JNcAIWp2aAetckw+QzQWTaOpb6kX9Q096Fao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224717; c=relaxed/simple;
	bh=S/AOyWuaiA3NHvzmTE2CNReBuvvkbVK6T+Yewj+2g5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmJDP0hBvHbmwh8bIe4hJSRvYOUdB8wSr5wEMnAiiF8OTBwUEidei57qRQTSLc/gbZ3BbsImLcQO/adoX8O5in7Z8FZ/89Iqg6kT3P16AAhJplI8ZZB8QWJtLC69ZVLWTTZcNkhieR/9TSdktW+gv9t1Ibk8I7tR5efodex+P00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fd+bz32y; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd+bz32y"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so5782276a91.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224711; x=1788829511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZxuwZq03lYI2TGgQtjkc9QJfZ6xOq7ziiudQrg9Xx9o=;
        b=fd+bz32yCWvfXhKEUaxlixgV3kiy6TsUmNr5WbxryVjQpBcFI46cP5ABP7pCz5XlBU
         3s0W9Rv+ct6iQSD08ircYVhfzpDJmh6EwZwD/GHWzMGQ8h7D8KgjvTR29luloQFpgtNt
         mt5c8n7k9kDfShQU06bWnRXsxv/KOVQwoZGRslhvCjYo4lf9h2Qav4vK0Gm5B1e4SnhF
         St+MQG0l1tM5umdMm4zGBSlgnYTA7RZuS8/TM7yp2GR1qy/6G3m5q2Cl9B+6LhnVuHRO
         Lq0WTaNI9lk5BNmNIujFUeTBROi8DFqEneJIhS+RM/icgq+oCc5txVxH1AJ6PGSH0FXA
         muAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224711; x=1788829511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZxuwZq03lYI2TGgQtjkc9QJfZ6xOq7ziiudQrg9Xx9o=;
        b=r1K5JZ4rdou5Np5cbL2SIDvIOWVssMoSJwquyWL166GquWJpe0GOe0syIBbqetJIRm
         zFR7QZu3U5HOzdCGKPsMJ6w1oweXBmWUpQ/v8ekwtRnyMaLohSdIotrLUYNoG6aEeMOK
         4uSFO6NyhkCoBFviSJu/V+lQ7BxT89To+4hdyvQPTe+mHwQ8gwIZYWxXAOcRKo8CMsoT
         sYnxe+MlF4AL/bTQt89HclkV/dwtNIWVzgrZcykVVIHefwBHA/XYvzl5cBNVYC97ry79
         8ojN+l54iZev3J3EdP5YwOZurTvvR45iZHP8aWkn1mQPhR7Ljq5+yveU5zO1ssUwP3UC
         fhHQ==
X-Gm-Message-State: AFuF++lJT/5N+S6rn+jV3Ru8ElC3fF3/MYqE7kYzJnxJ709ugKGhjFWw
	8UjluimQmXnKe3bNQtO59Yjuo+dsPwliMLUwMZMFu+NZTd95lDAKVf7Aga6LdA==
X-Gm-Gg: AYBFou1sY+P8JWbKnQPPk5O4Wz/L+c2cxwjWfzIkIcVhzKEESXYkdVfgUeFfCUHV/e5
	fIIhgnRRIQ8mqCxrBu/6HMU+TejnivYyygzfC7SmXL0kdScxnu7UG1meeMabk/gL7uE7QMlmPtp
	ZmMXm5jGFym1D2T9ggnJEkK0Sb23YSJ9LiTeYfLcEEydLXna8YZ9LnCHtcwL08KV5ezFQyiu8RD
	KJNXCqTzfoS46OhrIFAVgpdJkaIegxVRdy81L2UOc9B8Jo50+9AycLVkqylC/pMDYaEA/7g/vOF
	LSEfA44xfFfs2UWS6p+y9iDUNxKy6aw83KNJovD/uI3V0kIvfcfonSYwiq6kSAgJLUVLsexC8Tb
	LWelH4mWzkKZsum607MOkQdqi8Wws1J7zDi8tQpfde3RNliU3xJePe0nYNvlfp/Vq+ltLWP8ykW
	miE1fCTS9FNSF+FoNwe1GKFU7ur6cXC2zFH7tK6a2iNhqF11r8RNSo5p9oakGJNAVw12ILTUKju
	aPm0r3+bf/iNBGm
X-Received: by 2002:a17:90b:5281:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-39907aff83dmr6183862a91.5.1788224711002;
        Mon, 31 Aug 2026 18:05:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:05:10 -0700 (PDT)
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
	aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 08/21] rust: error: impl From<FromBytesWithNulError> for Kernel Error
Date: Tue,  1 Sep 2026 11:03:34 +1000
Message-ID: <20260901010347.2614656-9-alistair.francis@wdc.com>
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

From: Alistair Francis <alistair.francis@wdc.com>

Implement From<FromBytesWithNulError> for the Kernel Error type as we
will use it in a future patch.

As this is now generally available we can remove it from the test case
as well.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/error.rs | 18 +++++++++++++++---
 rust/kernel/str.rs   |  7 -------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index e52793f77196..84e6466f54c2 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -12,9 +12,14 @@
     str::CStr,
 };
 
-use core::num::NonZeroI32;
-use core::num::TryFromIntError;
-use core::str::Utf8Error;
+use core::{
+    ffi::FromBytesWithNulError,
+    num::{
+        NonZeroI32,
+        TryFromIntError, //
+    },
+    str::Utf8Error, //
+};
 
 /// Contains the C-compatible error codes.
 #[rustfmt::skip]
@@ -358,6 +363,13 @@ fn from(e: core::convert::Infallible) -> Error {
     }
 }
 
+impl From<FromBytesWithNulError> for Error {
+    #[inline]
+    fn from(_: FromBytesWithNulError) -> Error {
+        code::EINVAL
+    }
+}
+
 /// A [`Result`] with an [`Error`] error type.
 ///
 /// To be used as the return type for functions that may fail.
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index b3caa9a1c898..a556788bcc5e 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -433,13 +433,6 @@ macro_rules! c_str {
 mod tests {
     use super::*;
 
-    impl From<core::ffi::FromBytesWithNulError> for Error {
-        #[inline]
-        fn from(_: core::ffi::FromBytesWithNulError) -> Error {
-            EINVAL
-        }
-    }
-
     macro_rules! format {
         ($($f:tt)*) => ({
             CString::try_from_fmt(fmt!($($f)*))?.to_str()?
-- 
2.55.0

