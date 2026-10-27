Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078870;
	b=sDLZxPcBaCA8pn7WoQ+4IMBqkpfMqLnGp1ExTg2ckpzWthuW5EPe465aq02KAD5ncnIg
	 AQ+K0w0tuklq8uHSTNjHQXD9irNUniuBGXmbrh2sIc6I9EV2WIJk8wxYmOo1VI9gvwmuS
	 9kBOWNy5UMw7qZgjVNpFIuqzCWlF+4GMn60y8IczbMYwRt8QFpBWgAfjvyDH0h7h9bKzM
	 lzDOcjv/xjjge/cWf0gvrtXKr5bNtXlRDRM1B+jb8TJpSOzbbQyaPEtWrPfbEjD7wvI95
	 Rd7ME6cG5mKOHFWzDlwcoSX2AUfpvKU/BlM2RHwuRELAMAHZUJtv16wXlfJA9ueqtKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=P7IfzXkbn43Kai19cdAjvLuF45ACUwtP7aIH/dWtexc=;
	b=ZmoBOhwYbW7ksNJBFA2TmQx0rY85WXdf5MTd4mYFGUJfDlwKQSYL/TXtB9sV1w8vzcQj
	 pjeTDzf0Kvs+rFy0OKY5lyH52EYqBTtKXs/9frnu7ijqVArHWqAHOOmkmEkmJAHLUJx6y
	 dcUYCY+8O53KbWCt53LHB8/PATi0UgXeRHA8jhbkVKdytWQj76hC3//VGc392lLsO6zv3
	 L30aB3Bij/GY3YusO+RYPEQ1rIaSGW8RIMQsd3Wx7R6TJzC64YicQyp1uzp49mbV/1bfO
	 Ce9JUjhyWfe96U85XeI4DMDlqdKmwoxlFp5KBlfMMxKklLW1NTlSumCtnYAxfOu4PwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PF4IgPN+;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A26606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7A26606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PF4IgPN+
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ea7987517aso21110535ad.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078869; x=1793683669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7IfzXkbn43Kai19cdAjvLuF45ACUwtP7aIH/dWtexc=;
        b=PF4IgPN+O2yd9wXr2qH5K+4G+44oaiGN20455XJNmjyPtfjphP9o6G3tqmRmp8oL2z
         yATrn0qYVAwvLry2u1ihPm7McSZqCee8ovT3RnvH++uncD2xCkNS7aczxtTrwt38VEwD
         mklotekkc6itG2R87or1pqQOmEkepPOQ6HgjMnZp8Broc5zW7WcnXwxXew12rt5bJWOU
         Pm0c/weN6KTl/YFVj1BZLSVd4W3S4LBmlAfdZZqPUcRhQ1Zvw8n0xYxU2uyuJx8QB+qD
         Z9RtSqAPT63SrRDyQB7e0QdHm1ZIj57yUqKlQl2nrL7xqMQHp8WYLgfC7+eRRWICA5rX
         JSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078869; x=1793683669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P7IfzXkbn43Kai19cdAjvLuF45ACUwtP7aIH/dWtexc=;
        b=AV1Z5Lw7LxbBwksIhPt+INZyCRSRJ1QrYH8hlyXFdvrD4uwkxpq77lf0EH/lZawrLc
         P3rMQ/0wbrKf8hWvacil+zMpqGCkGS4sHHZVtqLM01RWmRV3OiS9YPC/rKSCO608A5cA
         lb4ckb4w1RWFs8tjS5GwEf2e8T0Qek5jZAt2c1qgn/UCTVtiCenSn7KBB+aFNcxGfvRV
         xlzzoefpG5P+Hay3kCUKL5H3vs7NKLm3iMGy4whg6OA07bIfKvbgVsZlifb5T3b1MipY
         QYexixXmxqc1LjDXXFCt2AlwQz6i4N4wLWQaQ4GeHi1fBt3HM4ago3tlmpIpajRNiOlG
         DTdQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2PKiUbEpog7t+fCCc6lVwU9wiAtlfzFGcBU5Z3T+3VD7Xg+zKqSFXoo0NhycSRs4kBimx4heAXLE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/GC0RnNk+UpulfqGPTy9gWAlFIhKA7yUFrj8+F6rDvgvFIPpu
	YVGUUE4QnqNM29H4svDwtxS3HfPSkMOJ9ySNwCTZCiOSdQ6ojBj8vsJ4
X-Gm-Gg: AYBFou3KvCWKbjMqid4Of8cFdjBScgW21OrqXcuOK22DWOCA4o/sY6NqICzV3489UsF
	S6WxQrIwR4qgteJF6Z+HYtEQx6y2ChyGImKzbHgKmHtIyik0PwjxnNmp/lVqyjybPt5d+eZ1nHF
	lTEcV6sW44KUsdtANO5FPd0vOBTqYEfGtAXWjutDu3lFx1+Nz4A+47IgUjHE0T0R+Z4oknuMs7O
	ZbckGhtXwSu+vgGJIXH1Ih/ZdIjB1DpRD6HhVbf0AzpgtWamClX2I9vAIXGGYJ+k/kDkKmOOdIK
	ZNozdCInhT0fbsZakqFmDbTAFWznW4WWuCTo2ZDQbZ2STnXoUCmnDFKUZbebfu8AOXqnNk4VII2
	xsdC3fRnB4CLGwS2PCnod9lRh2jSWSPKuiDcL7BqzULmAwmALK6gxFMJnpqcVt+2diXaYBtfssX
	8wYE/5u+F3L5T5WJ9hNrkl6L5hgUK/9rRbJgf0vu03PYkoP/AcZ+hpBGvOyRAbK3RQ9Lwcn8P7k
	R6e7uD7NquYQugCxDR9YeyP22xeoYb4UBp4b6x5GndD/4CC7VsM//j/iLN2fCo1boTYPlPKnQ==
X-Received: by 2002:a17:903:37cf:b0:2ea:825a:7f6d with SMTP id d9443c01a7336-2ea9c63ec24mr74776015ad.13.1793078869241;
        Mon, 26 Oct 2026 22:27:49 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:27:47 -0700 (PDT)
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
Subject: [PATCH v5 16/23] rust: kernel: Add crypto hash bindings
Date: Tue, 27 Oct 2026 15:25:29 +1000
Message-ID: <20261027052536.1722081-17-alistair.francis@wdc.com>
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

From: Alistair Francis <alistair.francis@wdc.com>

Initial support for the kernel crypto hash bindings, which will be used
by the SPDM library.

This is just a few functions that the Rust SPDM implementation will use
in the next few commits.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/hash.rs | 145 ++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs  |   2 +
 2 files changed, 147 insertions(+)
 create mode 100644 rust/kernel/hash.rs

diff --git a/rust/kernel/hash.rs b/rust/kernel/hash.rs
new file mode 100644
index 0000000000000..1800065d98767
--- /dev/null
+++ b/rust/kernel/hash.rs
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Western Digital
+
+//! Wrappers around the Linux kernel crypto hash APIs.
+//!
+//! C headers: [`include/crypto/hash.h`](srctree/include/crypto/hash.h).
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/crypto/devel-algos.html#hashing-hash>
+
+use core::ptr::NonNull;
+use kernel::prelude::*;
+use kernel::{
+    bindings,
+    error::{
+        from_err_ptr,
+        to_result, //
+    },
+    str::CStr,
+};
+
+/// Synchronous hash transformation plus its descriptor buffer.
+pub struct Shash {
+    shash: NonNull<bindings::crypto_shash>,
+    desc: NonNull<bindings::shash_desc>,
+    desc_len: usize,
+    desc_capacity: usize,
+    hash_len: usize,
+    name: &'static CStr,
+}
+
+impl Shash {
+    /// Allocates a hash transformation and initialises a descriptor for it.
+    pub fn new(name: &'static CStr) -> Result<Self> {
+        // SAFETY: `name.as_char_ptr()` is a valid NUL-terminated C string.
+        // `crypto_alloc_shash()` returns a valid pointer or an ERR_PTR.
+        let shash =
+            from_err_ptr(unsafe { bindings::crypto_alloc_shash(name.as_char_ptr(), 0, 0) })?;
+        let shash = NonNull::new(shash).ok_or(ENOMEM)?;
+
+        // SAFETY: `shash` is a valid `crypto_shash` handle.
+        let desc_size = unsafe { bindings::crypto_shash_descsize(shash.as_ptr()) } as usize;
+        // SAFETY: `shash` is a valid `crypto_shash` handle.
+        let hash_len = unsafe { bindings::crypto_shash_digestsize(shash.as_ptr()) } as usize;
+        let desc_len = core::mem::size_of::<bindings::shash_desc>() + desc_size;
+
+        let desc_vec = match KVec::from_elem(0u8, desc_len, GFP_KERNEL) {
+            Ok(desc_vec) => desc_vec,
+            Err(e) => {
+                // SAFETY: `shash` was allocated above and must be freed if the
+                // descriptor allocation fails.
+                unsafe {
+                    bindings::crypto_free_shash(shash.as_ptr());
+                }
+                return Err(e.into());
+            }
+        };
+
+        let (desc_buf, _desc_len, desc_capacity) = desc_vec.into_raw_parts();
+        let desc = NonNull::new(desc_buf.cast::<bindings::shash_desc>()).ok_or(ENOMEM)?;
+
+        // SAFETY: `desc` points to an allocation of `desc_len` bytes, which is
+        // exactly large enough for a `shash_desc` header and its trailing
+        // algorithm state.
+        unsafe {
+            (*desc.as_ptr()).tfm = shash.as_ptr();
+        }
+
+        // SAFETY: `desc` is a valid `shash_desc` buffer with `tfm` initialised.
+        if let Err(e) = unsafe { to_result(bindings::crypto_shash_init(desc.as_ptr())) } {
+            // SAFETY: `desc.as_ptr()`, `desc_len`, and `desc_capacity` are the
+            // exact parts returned by `into_raw_parts()` above.
+            let desc_vec = unsafe {
+                KVec::<u8>::from_raw_parts(desc.as_ptr().cast::<u8>(), desc_len, desc_capacity)
+            };
+            drop(desc_vec);
+
+            // SAFETY: `shash` is a valid handle created above.
+            unsafe {
+                bindings::crypto_free_shash(shash.as_ptr());
+            }
+            return Err(e);
+        }
+
+        Ok(Self {
+            shash,
+            desc,
+            desc_len,
+            desc_capacity,
+            hash_len,
+            name,
+        })
+    }
+
+    /// Return the name of the hash
+    pub fn name(&self) -> &'static CStr {
+        self.name
+    }
+
+    /// Return the name of the hash output
+    pub fn hash_len(&self) -> usize {
+        self.hash_len
+    }
+
+    /// Computes a one-shot digest into `out`, which must be exactly the digest
+    /// size of the selected hash algorithm.
+    pub fn digest(&self, data: &[u8], out: &mut [u8]) -> Result {
+        if out.len() != self.hash_len {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: `self.desc` was created by `Shash::new()` and points to a
+        // valid `shash_desc` with a valid `tfm`. `out` is checked above to be
+        // exactly `crypto_shash_digestsize()` bytes.
+        unsafe {
+            to_result(bindings::crypto_shash_digest(
+                self.desc.as_ptr(),
+                data.as_ptr(),
+                data.len() as u32,
+                out.as_mut_ptr(),
+            ))
+        }
+    }
+}
+
+impl Drop for Shash {
+    fn drop(&mut self) {
+        // SAFETY: `self.desc` was produced from a `KVec<u8>` allocation by
+        // `into_raw_parts()` in `Shash::new()`, and `desc_len` and
+        // `desc_capacity` are the exact values handed out at that time.
+        let desc_vec = unsafe {
+            KVec::<u8>::from_raw_parts(
+                self.desc.as_ptr().cast::<u8>(),
+                self.desc_len,
+                self.desc_capacity,
+            )
+        };
+        drop(desc_vec);
+
+        // SAFETY: `self.shash` is a valid handle created by `crypto_alloc_shash()`.
+        unsafe {
+            bindings::crypto_free_shash(self.shash.as_ptr());
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index a3c54971e9dea..f7db5975e7621 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -82,6 +82,8 @@
 pub mod fwctl;
 #[cfg(CONFIG_GPU_BUDDY = "y")]
 pub mod gpu;
+#[cfg(CONFIG_CRYPTO)]
+pub mod hash;
 #[cfg(CONFIG_I2C = "y")]
 pub mod i2c;
 pub mod id_pool;
-- 
2.56.0

