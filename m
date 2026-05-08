Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E22E7635
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210291; cv=none; b=njQdYknFIF9kIYoHAuylpa4Cu7yZiLYoSuSLCSdUOQjuQQY5hWHId/ZEfaNM5IfFyDcc2iMroZAKLswzyXWcyJ40kO4d5ZSTmEHuWtONdO5OJGDAUjabr0Mx8/g+GN69LpirW2hn9mpWhHO6TfXqGRqwOeV+igKvLcuB6NVe5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210291; c=relaxed/simple;
	bh=ERpyWsMPE9+dpw78Rz8jzNcLrivxWjKPOe5Lqw+ayKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAoLSeP+96hJjJ5NkyEoFnDxb+dHpu6CwPU3+BUrDqOurE9ueP8Yz11YYFtI+hPwNJtd+ZHwYax/2rXeFsQzNevUo4wjGW7V02ebijezl0DmwOtqaS/6VmQAe7wvTJ+PL7xx8HqCnVEPxniPyW4tyyH2SM2OwXkoo7/VemNqU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj6Z0kmp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj6Z0kmp"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2baef9f5ecdso1757875ad.1
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210289; x=1778815089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dr4Me0446pI9Lo+v8fcchBIKe8OPGzCDfNPYgvjsMc=;
        b=Yj6Z0kmpi9AVb6Nd8h0wWN5TlgvMLiVNfReWogBnZH4w+otegDoFB5XF2212PfcZ4u
         bCqNS2GxYyMlHd2PTOezbhqkYMycoEuDnnYRh6H4fAHqzDsubjkFdJOFzgC8YWK1bhrB
         Wtg3Wo4wuCg8dkwC3N5FeuNHJFo3fXNnofhPNYgLCg/DFRNnALlGntMPdokrDyb6/T94
         s8Oz9/7E5nborARV7YccVyWYfW54QLNzALiKSXqW/oz/BjFOFrRfHWhp/e6v9SyrjkeC
         pJUj2imTw+UIyyNpBh7OrpI4n136yyhAqUnoVncFUmvmuuxaS+IgCU/5IQWalPXFaCOt
         m4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210289; x=1778815089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9dr4Me0446pI9Lo+v8fcchBIKe8OPGzCDfNPYgvjsMc=;
        b=NZY5FcN3OH2a7L7LrtJSHL2V/XehwyXKz2g+Kn6qJE8oSYgutVRYGANo75xN75trK9
         f9ASxrDi5iqjZRS7BQ+LdS2Htl4vyoBCEfc2pBb236sIoB9vTAb4MGMg+ICB7Wd1b6sY
         3+qVioAPNhYUxIIMmW08+SXfkFOrXWNQhd2VrjcFYOFY8W4Avnz35lKlyfbU8GiDtjrK
         Y/GrpQX4XAmIcaGBij0uWB/Z7Kr+Z5gGof1X9BAob+fWOFru55J+M4ZkCh71ESghQnae
         ZTUCv+zhLZ1mEtlqjE9xlONq9ttUJiLi+1HXERcTwhjOx1qhUFP9tFYrssq6mOb4PeZk
         DVBA==
X-Forwarded-Encrypted: i=1; AFNElJ+ed6s+K4qiwW88MY8wKCsX05WNZiNgQFq6B57DiCvKpjFsIfUOtsF9e/z+rnuOhV3rOkR9mNRhFlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmJciSQpS13g/CwYpnIbBWDn+YY/GXAkOUzSFk1xcaKfokiMRD
	IzSlGU7PdSmmMWnBlcxJA2lsIasYH45wf29w5BtdViKrNJU/8S6aGvV4
X-Gm-Gg: Acq92OHDy8GjxH0I4/RAMkECCS8btviuRoCOHpK9ZuVQ5P9JD+q+5gUExk0G0Q0ng06
	THzAAaPOmdTgR4jNO8nP5e6tGYzj1dfY1+/XnP9R5ycEHM36P9PBPPsW6WA4rHedYM8wJfiGcqk
	CwRvEY0Jim6aGOdnnCy5jo7nDnJ6Ug+v3dghPG7yf2Hjq/26di6QlntBl06CRGraCOeyRVMbi9w
	AM0mTRLrKBW+8/8jJNjSH7vJZvCI97OdjAMfwo2bD1BpafdsgwwCiATscj734vi36w/IFoUbU85
	V7tP9Do/rmXUCtwiqhdwqyt4zh2uTT91X58VBOpGC0pDYqzF7hWD44vz3KOHWuHH+b6urQDvR3t
	26m9pyYNIjLQl0eQOoLPZrZYo28aAP6LN4dkGtGL5hlcOlhhs4GOEANwG4KCAaEF77RgP0z1890
	zDjtEWOZixR+u27mpEX7G4uvXQFMgSXkjc9x8RXjpv
X-Received: by 2002:a17:902:be05:b0:2ba:4a19:fc89 with SMTP id d9443c01a7336-2ba78b485d7mr69407855ad.5.1778210289439;
        Thu, 07 May 2026 20:18:09 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:18:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: alistair@alistair23.me,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	Jonathan.Cameron@huawei.com,
	bhelgaas@google.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	wilfred.mallawa@wdc.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 06/18] rust: error: impl From<FromBytesWithNulError> for Kernel Error
Date: Fri,  8 May 2026 13:16:58 +1000
Message-ID: <20260508031710.514574-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031710.514574-1-alistair.francis@wdc.com>
References: <20260508031710.514574-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Implement From<FromBytesWithNulError> for the Kernel Error type

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/error.rs | 8 ++++++++
 rust/kernel/str.rs   | 7 -------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 05cf869ac090..5463addbfd95 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -12,6 +12,7 @@
     str::CStr,
 };
 
+use core::ffi::FromBytesWithNulError;
 use core::num::NonZeroI32;
 use core::num::TryFromIntError;
 use core::str::Utf8Error;
@@ -258,6 +259,13 @@ fn from(e: core::convert::Infallible) -> Error {
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
index 8311d91549e1..17070dde0e35 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -419,13 +419,6 @@ macro_rules! c_str {
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
2.52.0

