Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01E345754
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780639; cv=none; b=WuZqXE0MXbxyatZED8dQj0/t5TYUAm/Wa8/ONalAPwl2LS6ZrP5XnEOM7NpcrKvD7ChcCqwp9mWxUsKJzp60BmEqaLZDLclmsBl4ETZVUMKrjomSbzR3fceyfbqdqrDiKRQ48w/nieeCdIcJEEiquNrVRmYH65fk87sHMu3OWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780639; c=relaxed/simple;
	bh=FppKemrwtWk7l1BEg98yFq7nk3dgLMRXUW1h9vBpl4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMY0rRVU/jj+9d6gGAocFg1hre5LJyFKoHGnKoAVZNPgoUjxehp2EQtvbacrXJAXSNDVbtN++npUe/2+RNVk44s+CiUCOxHESK/cwRAoVwuWOvzzJrWjrWl4jdO7Ge9jKeCaO1EUyifV6vAJ093uf+TiGnKb7GsWiamhcrGnH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqI6ICbz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqI6ICbz"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c0ec27cad8cso569349a12.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780637; x=1771385437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viBpYkVWc9cE68UFiQJOVrqrE/EpXnGovXyJD9hjSPs=;
        b=AqI6ICbzsb2BaM28dkfJzC1s0VCKby2Jjh0sYOshnzToGY8D4kJ+W80yGkWmBMtNpq
         uxV0fch3G3Canly3z/cAKYQdhFpd8wfRtpwc345q9o2hIX9EeiW9dmZdQZYgWNBBWby3
         W6oVJDGwtLxxeKosU8VGgQrR6PTQxTmgugZZt3n0X4XqlJw9mR9RknD6FbrT1emihhtd
         aA3ZLWp0V5xaYgDBLmWyOE3JmD+falHdgj7vwLcksen/3XzqW2Fyw/ULq39gZ80+9hUq
         yysM1hPLQppWvNe1q1G4m8EQ4ofLDLTKthYHFzydo7x3N+sDtBwc08mdUt0T2bQi569V
         nMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780637; x=1771385437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=viBpYkVWc9cE68UFiQJOVrqrE/EpXnGovXyJD9hjSPs=;
        b=bZQRSvOblE73BZvt3Z0OrNd9rq1bN01OffMnXhNCyssb7iy7sWc5UBGkzgsZQ6XQkO
         O/A871L3PN3YdmrBrs+u0gmxcwzo2YYKYvrSTcuiaoPO56DFqn40UWtgVWb2LM7uuDaE
         gCCeC6g+HPgCD8nCxDVZC43B9QGpl/HbwZPBk1g2f6orJmlf8QaWvfriY1+xnS8fcnud
         qUNdzJMPC1UcKjfip603E0hrm+Ho3+OQZEM8WhpGKJjkSmrc4j/aY2Sl0M+fCzZhqHZh
         ke69zKE+QKVgAuLKktpPHZyDl+WNTGfwxcMWfHO7e7XNA+C2cXXEjbplMm9Xevr53JCH
         Ew9A==
X-Forwarded-Encrypted: i=1; AJvYcCW9LV+I1i7rEugD0b/dLNw9APtgHiVijTjwmztGzxll8wWD3K0eJe5q4NHjeRMD4t8KnjQTT+Z21Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywl7S3JbVya2tfQhrG6JoHHaiLAAonp7SCKxemRiKugOJaA9wg
	KW/WryQGdE0rfAIVaAvzv8GcW9kKqssCKxaAYbJVtga4SRfS/ZmEj7mw
X-Gm-Gg: AZuq6aLCH13xp2a+J7Ckcjn0iJDLgZnMjkkXukRH6w5iwUX+pzdLnqSQ+k7eFMbhD9V
	RaRoGB2gdemVzeyvC9lmNaHTS4V1Kww3Aa4XgoaJv8vjCmxie1tQLhuEXMfg0bBFRxuVE0RGMKb
	jZ5Iytp0k1QOQHvCM7gfHHEltHYrd0IjjU4OQ2Lifs5z2hyEufyNM9m09Uj7nZKtE3X+xLMT+z2
	/mzZL/Q2b09GUuq20OloJD97Sj3WR2XzfX7rng5ici+oXT3pXIDhTh8etqnoJbNz2sSCMreCCSH
	6Yh2uFNGbLyeARpZPokNIqetoePUkicbwYxInVM5/NkJpO9TxA92L4P+e7FN+nSdxuphbJvL8jx
	rxPYcz6CmOZYqo+nsl5Z6C99wyRRL0eftYc2Hglo4fMYrkA3BckLWZsEyw9vhxgQDPnCYoE6Ikk
	5l2MTloEdlG7LS2+KcCxT1JDsdhWjr1DcrIjuWeu3WzA==
X-Received: by 2002:a05:6a21:a92:b0:342:9cb7:649d with SMTP id adf61e73a8af0-393ad01e8f0mr17914368637.26.1770780636948;
        Tue, 10 Feb 2026 19:30:36 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:30:36 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	ojeda@kernel.org,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v3 07/27] rust: error: impl From<FromBytesWithNulError> for Kernel Error
Date: Wed, 11 Feb 2026 13:29:14 +1000
Message-ID: <20260211032935.2705841-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
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
 rust/kernel/error.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 258b12afdcba..569d9d032ab3 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -12,6 +12,7 @@
     str::CStr,
 };
 
+use core::ffi::FromBytesWithNulError;
 use core::num::NonZeroI32;
 use core::num::TryFromIntError;
 use core::str::Utf8Error;
@@ -251,6 +252,12 @@ fn from(e: core::convert::Infallible) -> Error {
     }
 }
 
+impl From<FromBytesWithNulError> for Error {
+    fn from(_: FromBytesWithNulError) -> Error {
+        code::EINVAL
+    }
+}
+
 /// A [`Result`] with an [`Error`] error type.
 ///
 /// To be used as the return type for functions that may fail.
-- 
2.52.0

