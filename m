Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1968F3A8759
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 04:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190528; cv=none; b=GG9CFr9PgGwU0oE8h+mjlYZO3wz2QTOUcxBTFHakfY4L6HnCD4/tkJBcUNhyyUEWiDeHzbbaBHRpp9ThHDDFVXyFmHbd9CYq9kcFM5UWa4HTwlcjvYsU0Ljhay3d3vzEEMWKqHEl+PfmXlr/QU2xf3uQQC3VplDMAZUtIrF1gOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190528; c=relaxed/simple;
	bh=Sy1WvIXNZzEPpwjc7YVfpYSfEwrZ1hfoTml2vuaG2BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/BCsq3jd406XEsEV2rzpdgWnzbHzWN82jECFi9cuFH2V3saKfXKoCE8ax6QRndVbZlyehqwGzc4or6+zWstbEadqHwILXdst6bhQWsZ54oX4YQZ1vpLl7NxyttqPv8R94eBG+BpC1bxZ6iRqj8NpBpwDdDK9lR/7yKZg3M7hTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFQJy7IJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFQJy7IJ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37ce68a54f8so3185379a91.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 21:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190526; x=1782795326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2HszWwujnnA1U0OG71iG4jQJMX7H8oBEpv6QtZgxvI=;
        b=pFQJy7IJsXaRoci+Zu5/69p5qOABwC8p2As62xqJARHmx7at4TUYJLJtN+UfKLD7sS
         ab9CTJIspmcWG3l2xP/Mkw8T6O10mzDyLI+s+aawCmLloOTc22A9aPIwrAxAIj0tUgoP
         bF+GqsRYK+OLzzzZH3Ljs+DC9rs1sKinto/rPIovadXZZqALkDcQtsQUL0bRSqEgtoAO
         iNzocNlrrlt2NgsgoOy/L8f4MsDIeullEGwYguFxUSyIp9wag7MQm96/q+rqs+SDpRzq
         SA6PrY8nkbdk8M9IwAHAMsUy0m0jGJAmRztvxALWg6yZne2LjpcLbz540tbIAlIKaEq7
         qSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190526; x=1782795326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f2HszWwujnnA1U0OG71iG4jQJMX7H8oBEpv6QtZgxvI=;
        b=Nxrfb/PFxnC3Qi/nvv+ucX2jhjmbQr9BF+DmqOXviy9E+kY8TfhKEMGekX7an6KBom
         Atgw0RnclkT6QYG7XwTb5aXpqbNU/wIXaIFILPPMSXtDlrsw1QLNeXwM5xD1ighKgr1j
         9tpTKwoRcZxaQPI2s6U+PEgLVWIWxZT73+1IebOhVlr5ihV8Z3hNAHTs7064WCEtwVdq
         lJGhXmPc0nMRItHflOeR6ChbsJSAJUddb3YlnO0l+NkfyqDaZpFcDiYbjr/OnFTgbkB2
         RXxAGSBvSEAQa18sbDzb825M6ppqS3+0EyCLzswV3pw5xZNMZgJEeFCX1fYkW6NT5tui
         +uIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqa8LFKr7sYb6DnaflmKf0MY8e+DXZL774jI6wk0iIqcjA+Fzmou72Yf6/avNy+HBp2cXSblF3XpdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSePibkiAC1Qd02s2doRqk8ooJ7Q0AM57rMB/Uz3Q4+YEzNWww
	wyAyZc/FKrOCKzWw7hxO6zfVHGYh/kLvq9scwrfg+/oYcM1ZuLfrkBbx
X-Gm-Gg: AfdE7cntrrAG/HI3gmLvSYcYFZzHl4MwlUToSl67/2HzCblyxfRnhH48woe2slFye7d
	3lZG9a6na/uOKjJDxcq7KKlU3zBDP8EWsN2TS+9fQFUPAXFyrYQa4vOgRhutw4l43gRYZkKc0ec
	stEIOypmn47cDIyE63JekmJS1kVytZzNi2ie35PmxWwdmcS9tTtR/T7TZubc+UQsnro0XJ71FLD
	Z6V8rYcX2TQYZ6NLlBWizToClIorRw55frcaq+4lrX8uhMm39XADhlWoWkXxqNtswRYzDSfllAr
	mYG+bbvsHgjjN4GqOJysfYSh7kKVke2vjisfgFL92bIbXFbFwg3zPP7/FjBEtojHvrbiSFhZcHT
	vrQBudodu14Nj34F7md/3V1Fss4CKYQmv3IBm5cRoorjSp3CD9HiQYsoOqrCSMQygOO6P4ujeX0
	ql/7BGtG28GcziyNQIFLcHtUAh01JfHQ==
X-Received: by 2002:a17:902:f70e:b0:2c7:432f:57f8 with SMTP id d9443c01a7336-2c7c759322fmr15643825ad.1.1782190526313;
        Mon, 22 Jun 2026 21:55:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:55:25 -0700 (PDT)
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
	tmgross@umich.edu,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 08/21] rust: error: impl From<FromBytesWithNulError> for Kernel Error
Date: Tue, 23 Jun 2026 14:53:53 +1000
Message-ID: <20260623045406.2589547-9-alistair.francis@wdc.com>
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
index a56ba6309594..1a7221fe5682 100644
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
@@ -256,6 +261,13 @@ fn from(e: core::convert::Infallible) -> Error {
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
2.54.0

