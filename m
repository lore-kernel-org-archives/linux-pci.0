Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D030C35C
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210374; cv=none; b=CearW38XH9BcZ7Q/4gze+7lyLy9Woc8l0W/+pf/xphqFi9ZtoiST/DfDRnQ7ItHeU5YmWpTpCyTTc+JATvjWGHWC2eWNNq9bos/dAtiU+/In4zlunr9EPtTrgZTM5Roa1yM8FN0a0hn170TwmRJ6D6iB8COKHnTcqfwb4tHiIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210374; c=relaxed/simple;
	bh=j3lxGogAEu2m4ODiCYf4W/cmhvK2xVIezXSiFbrV+fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzeT9WUhzxL+lse+6YB3WzqMmqMQTEcGaGQjSvsHtkYwaCjKAdICX8+TEJaFyEtY1GTde5zO6/2oic4CsqLl9oRbxnKrS+5vBVuSn7wseoVCBYskxN7b9ResjkYiKftaHKo+VJ+pX8OsYY+eIbLc5Aw3mEeF7CqXsVRD502Dg7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYPzEgPP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYPzEgPP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba4a1a0325so10539145ad.0
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210371; x=1778815171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV+KKNzPOZuwOP9jOwich0HOmZDeWpgxJKGJYxOCc1E=;
        b=SYPzEgPPEAISbTP4ZX6A+emoUo22JWeiwLrPlZlR9DklqTVIl8Z557D3b2AJ3AEb/W
         RX8DqmMrTG3QX6anU7D5OmBzEnwOLlwAFDhPFCXLylLZXegujZmengVO4xPbqLqpF5Cb
         S3QpS6vZEkzsY3oKH9Tj3gFmItjnpHVR7iCNog1CHZovwXVHlNfrTIk1m3eAwTdKFLUz
         Dsm8mx7xaFU2zv326821qnQsrMJOpv6D7YokAZs8Lq+tDsyNwkDrC9GaQUvyDN/vPXfi
         f+6eNnwDKYc0LpEvFaUGOAiqTyk6qSKDSi6YfV191oQnTqmuYsBLwYSRelm6SRZbxE+5
         VjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210371; x=1778815171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KV+KKNzPOZuwOP9jOwich0HOmZDeWpgxJKGJYxOCc1E=;
        b=ZlwgR6uA1xzoILKIj2Gt12Z/GI/LJtv0Klcf2OXGa814IrEwKdiIYZMRltUJpdJIAn
         IRJSQ0nnlGxXp+xgfcYBiO4AzdCyfd+GIxBAgGdVwV6Z08xC0TNPZdwR+8dSfcKaycxy
         IOLQpkEmq4DIRUm3uz9uoRE+Y8Hg5DQhISFzgM8ed1oVqY88W4QL3IS6Llt8NXvQicyW
         mKsZivyxNkGoRw9Drko0Alebz4aAkWZW3f3zm4gYNLyLVHrfDRa5QIfQWOQ0UpVoGeQI
         OFtfZXyl3nO3VI43UxHZBmfDSeuXKvszQ8siKq3vk14s49S3M5gPvL/N10GOEc7eVOoG
         8HbA==
X-Forwarded-Encrypted: i=1; AFNElJ/KewuyBFH5be4hehxad8hLOcZMCz1fbWQac540WoNIj2z4v53daT5Qgcxykm6/ucq8j2E8i+tMOpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfesm8UGipuU43giENPnI3GhMhwcVnCvhbFGYwQcJklRY89qs6
	HWdIj6wWxPQoVc1QgpCyROBZ4euKBj8PUJDkqWTYBJuiPQasDIb8zI+Y
X-Gm-Gg: Acq92OGdmPclPCRXcoyBDKbkhnDAFOQ8DvF9BPfltMv3R6GzKmrtgO/EDQyp4coVmJO
	/0tKJlJYx6HjXLisDCxTzwvypDBq4zQGnqDqNZABEqzl56VuWAwWrOBmWCzwjWYfufO/akHl9it
	JTV0/kbXA4td6X18tuBDYWmi1TNmdkxH7egZP7Y2M6svdrpQtRYizuDBba+DPC1HMu3LHufHe2s
	7AAf6u3TDKqg1DPuSCki+pKUjkoomLdte3YIeySMhgi7Uaqe7NTAY4Or8NMzxuZrINrpfPVXmoV
	zzVc+LXsFLY1IZbrwIMugzFxHwLLzuzpoG5dE9ewKrlWnV/PMQ77ECguQ02brUkSIRKuv8hmNTj
	feNj7Uw9QCCXaP18HUa+WDLfRsMh/7PzMIPQ5TPBpAsGOWR4rlSQWvVnj2Vg9+ddwc7F5RX9+Wp
	tZbEJvhp1oUbJR5wvl7FOFI5r09wnqwyaVaLaXpUHkM0Cmy6A61XI=
X-Received: by 2002:a17:903:3887:b0:2ba:83f8:7b7b with SMTP id d9443c01a7336-2ba83f87cfcmr97081925ad.33.1778210371221;
        Thu, 07 May 2026 20:19:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:19:30 -0700 (PDT)
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
	alistair23@gmail.com
Subject: [PATCH 17/18] rust: allow extracting the buffer from a CString
Date: Fri,  8 May 2026 13:17:09 +1000
Message-ID: <20260508031710.514574-18-alistair.francis@wdc.com>
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

From: Alistair Francis <alistair@alistair23.me>

The kernel CString is a wrapper aroud a KVec. This patch allows
retrieving the underlying buffer and consuming the CString. This allows
users to create a CString from a string and then retrieve the underlying
buffer.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/str.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 17070dde0e35..764dd5c695f6 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -856,6 +856,12 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         // exist in the buffer.
         Ok(Self { buf })
     }
+
+    /// Return the internal buffer while consuming the original [`CString`]
+    #[inline]
+    pub fn into_vec(self) -> KVec<u8> {
+        self.buf
+    }
 }
 
 impl Deref for CString {
-- 
2.52.0

