Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3882152843E;
	Thu, 15 Oct 2026 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068012; cv=pass; b=uWKK2ji63jT/OVk3TSHfjDBmRGyjMHVE3V5xo3fFVphB1mAVhuApqtgL030BcE4vEVFto+lLYl//My5kmoYC3rulZ+P8SRYEgRtmRtE/8bNVRkQEOOcAJk7YaEwjr2/I+viJM03bJHx5ZIjEgXZm+ucnyLJhq7ZZaPsln+nk8XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068012; c=relaxed/simple;
	bh=xKDG9h3H2MbSH2iEn+dK0pAfPuRHgdctbefS9til6rA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJm8VaZ8nrgDFUUsxDxBhWsanVLENUmSi3hw8EiNwbN3L9K//TTvFRRYl4SS7ugjCXsbw7a7p5CDF8q2qOvct+/5GFtZm4UsRqFN1e5dUeRCCHXF5ytwjgzzOIT163+YvkL0Q6sRzh33hGhfnFttzEKqje0Qyuekm3dHkcEao+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=GL1gIXDV; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GL1gIXDV"
ARC-Seal: i=1; a=rsa-sha256; t=1792067982; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DyhMRqkKihZ1A/Hb4y+nXQwSWXaopISfNqtV+LgAuERUTiCfmotaMwYAOSUfEHvyN/kfnFsnVcyX8alRtOfzzNapgKDEU8s49JsXipCoJCuJjH0nv6isozUAjScH2u0PtyKNBPwiq8yCbG3/fMAJZc2JvpYlwwNqxurRUGi4wZw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792067982; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RAurlbvYi1gTpRSGoDogqwNyUvcm3XilGc7GqT+POP0=; 
	b=lbPLOlyGRWhxfex7N5jKJpq7PNq57D8EN58/OFPNJATcLbiv1isfhAyWgpGqJCOiKb81XLjiAjIeFWt4XTew/Te3TZ0YH0t6vxAnh5nZJGtTXybeAYh+/PYRjcsVFe53S3QyE/hB/w17tQnk4N7s4JLl9BggVX/bcl4zS5FvIM4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792067982;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=RAurlbvYi1gTpRSGoDogqwNyUvcm3XilGc7GqT+POP0=;
	b=GL1gIXDVs3w6KtTRdWBxnhpMv+Fz9cg4ttaHi2h04g92IEzmp74vdmVI2re+93Au
	zLEsu1XDWvfBPX5h+9M8YgAWhSc5lzXgKncKRyEuKtwNcxAcZYD7jEXw808UJp85RfM
	5oPw9NWFSKFrrYKbhIkpAeSkgWbKTXNuHp0kCrGg=
Received: by smtp.zohomail.com with SMTPS id 1792067980479943.4807218210801;
	Thu, 15 Oct 2026 05:39:40 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 15 Oct 2026 09:39:08 -0300
Subject: [PATCH 4/7] rust: io: project primitive accessors directly
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-io-access-modes-v1-4-93611b84b5e3@collabora.com>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
In-Reply-To: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

The primitive accessors, `read8` to `write64` and their `try_` variants,
pass their offset as an `IoLoc` to the generic `read`, `write`,
`try_read` and `try_write`, which project the view to that location and
then call `read_val` or `write_val`. Commit 147b41ba23d6 ("rust: io: use
generic read/write accessors for primitive accesses") made them do so to
reduce the number of unsafe blocks.

Since commit e0454ec1220c ("rust: io: use view types instead of
addresses for `Io`"), projecting to an offset is safe. Thus, have the
primitive accessors project with `io_view` and `io_view_assert` and call
`read_val` or `write_val` themselves. The bounds checks are the same.

This prepares for access modes on I/O locations, added in a following
patch, which make the bounds of the generic methods depend on the mode
of the location. The primitive accessors keep their current bounds.

No functional change intended.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/io.rs | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 03af0590b0f4..4be8c761c556 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -760,7 +760,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
         usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoReadable<u8>,
     {
-        self.try_read(offset)
+        Ok(io_view::<_, u8>(self, offset)?.read_val())
     }
 
     /// Fallible 16-bit read with runtime bounds check.
@@ -770,7 +770,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
         usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoReadable<u16>,
     {
-        self.try_read(offset)
+        Ok(io_view::<_, u16>(self, offset)?.read_val())
     }
 
     /// Fallible 32-bit read with runtime bounds check.
@@ -780,7 +780,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
         usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoReadable<u32>,
     {
-        self.try_read(offset)
+        Ok(io_view::<_, u32>(self, offset)?.read_val())
     }
 
     /// Fallible 64-bit read with runtime bounds check.
@@ -790,7 +790,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
         usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoReadable<u64>,
     {
-        self.try_read(offset)
+        Ok(io_view::<_, u64>(self, offset)?.read_val())
     }
 
     /// Fallible 8-bit write with runtime bounds check.
@@ -800,7 +800,8 @@ fn try_write8(self, value: u8, offset: usize) -> Result
         usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoWritable<u8>,
     {
-        self.try_write(offset, value)
+        io_view::<_, u8>(self, offset)?.write_val(value);
+        Ok(())
     }
 
     /// Fallible 16-bit write with runtime bounds check.
@@ -810,7 +811,8 @@ fn try_write16(self, value: u16, offset: usize) -> Result
         usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoWritable<u16>,
     {
-        self.try_write(offset, value)
+        io_view::<_, u16>(self, offset)?.write_val(value);
+        Ok(())
     }
 
     /// Fallible 32-bit write with runtime bounds check.
@@ -820,7 +822,8 @@ fn try_write32(self, value: u32, offset: usize) -> Result
         usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoWritable<u32>,
     {
-        self.try_write(offset, value)
+        io_view::<_, u32>(self, offset)?.write_val(value);
+        Ok(())
     }
 
     /// Fallible 64-bit write with runtime bounds check.
@@ -830,7 +833,8 @@ fn try_write64(self, value: u64, offset: usize) -> Result
         usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoWritable<u64>,
     {
-        self.try_write(offset, value)
+        io_view::<_, u64>(self, offset)?.write_val(value);
+        Ok(())
     }
 
     /// Infallible 8-bit read with compile-time bounds check.
@@ -842,7 +846,7 @@ fn read8(self, offset: usize) -> u8
         usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoReadable<u8>,
     {
-        self.read(offset)
+        io_view_assert::<_, u8>(self, offset).read_val()
     }
 
     /// Infallible 16-bit read with compile-time bounds check.
@@ -854,7 +858,7 @@ fn read16(self, offset: usize) -> u16
         usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoReadable<u16>,
     {
-        self.read(offset)
+        io_view_assert::<_, u16>(self, offset).read_val()
     }
 
     /// Infallible 32-bit read with compile-time bounds check.
@@ -866,7 +870,7 @@ fn read32(self, offset: usize) -> u32
         usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoReadable<u32>,
     {
-        self.read(offset)
+        io_view_assert::<_, u32>(self, offset).read_val()
     }
 
     /// Infallible 64-bit read with compile-time bounds check.
@@ -878,7 +882,7 @@ fn read64(self, offset: usize) -> u64
         usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoReadable<u64>,
     {
-        self.read(offset)
+        io_view_assert::<_, u64>(self, offset).read_val()
     }
 
     /// Infallible 8-bit write with compile-time bounds check.
@@ -890,7 +894,7 @@ fn write8(self, value: u8, offset: usize)
         usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoWritable<u8>,
     {
-        self.write(offset, value)
+        io_view_assert::<_, u8>(self, offset).write_val(value)
     }
 
     /// Infallible 16-bit write with compile-time bounds check.
@@ -902,7 +906,7 @@ fn write16(self, value: u16, offset: usize)
         usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoWritable<u16>,
     {
-        self.write(offset, value)
+        io_view_assert::<_, u16>(self, offset).write_val(value)
     }
 
     /// Infallible 32-bit write with compile-time bounds check.
@@ -914,7 +918,7 @@ fn write32(self, value: u32, offset: usize)
         usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoWritable<u32>,
     {
-        self.write(offset, value)
+        io_view_assert::<_, u32>(self, offset).write_val(value)
     }
 
     /// Infallible 64-bit write with compile-time bounds check.
@@ -926,7 +930,7 @@ fn write64(self, value: u64, offset: usize)
         usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoWritable<u64>,
     {
-        self.write(offset, value)
+        io_view_assert::<_, u64>(self, offset).write_val(value)
     }
 
     /// Generic fallible read with runtime bounds check.

-- 
2.56.0

