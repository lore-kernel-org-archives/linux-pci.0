Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBDC3AE183;
	Mon, 27 Apr 2026 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328074; cv=none; b=EbfthtNvB4TxPoj1Ur6859Z685sXecFI+ZRmzZmL6I2at3mEoNj2uys112MAV9mOrikqpOGWZ26sGFqYFQrxkuv8xyBk10QfPK+ckxdy6Rn011B1ODESv+LFztRVZND5WduJvk/CmOb9mC49D+DlUqZfNcI1nV3hkJq/Xkn1xo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328074; c=relaxed/simple;
	bh=3Y4jgtQFS1dMkKwizJ/kytTN4rfwuMJ6Fr3rkFzLank=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i46AdG2uuoAKjRnzLJo2csfCXW/i42aEEDtkHsZ7DIM0pqqVFug2EP+JSYUOuqrStUvHHfCRYL2OQC1YAkATTGdjFrAyyky46vg0BGcbslvxtf9PSzEBvrbfJRDEt5DV1qCm71Ll86VgzDxP5Q2Wv8Ya8WH1VXmJnCfbIL7fc70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4Wy1KVG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4Wy1KVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90922C19425;
	Mon, 27 Apr 2026 22:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777328073;
	bh=3Y4jgtQFS1dMkKwizJ/kytTN4rfwuMJ6Fr3rkFzLank=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4Wy1KVGfeNbp6Dt+rvDiw8edx31HNXJTJqeVmBLQ4y5ANPxgjDpgr61KAeWXJ/jC
	 6Vns2yDV17GvYmbiaG3DXD4NfG/9eyGdP3OuF4XFtE0OPfg+XgYqKaW26Ukoc8FI+s
	 pE44TP/BrjMZsmA+mzo25XeLlGNx6VblNyrbZ3kGqIV1OjN3m7PEo2Xqn8BBDPg6b/
	 sjAY4OkBNam75q9uxZPdPNK7qIR8h7WUkjRQEYoELitutB7KsIUMj2phUwEW7tHXn3
	 5KTFo/gvhoxUHpiJ8uMN6JuI8cwmrTy5FZp+y9emB+oXf6PS1NY4aLfOlSmJVVnBGE
	 fgLFqIwoBZMEA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	viresh.kumar@linaro.org,
	m.wilczynski@samsung.com,
	ukleinek@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	abdiel.janulgue@gmail.com,
	robin.murphy@arm.com,
	markus.probst@posteo.de,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH REF 23/24] gpu: nova-core: replace ARef<Device> with &'a Device in SysmemFlush
Date: Tue, 28 Apr 2026 00:11:21 +0200
Message-ID: <20260427221155.2144848-24-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427221155.2144848-1-dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that SysmemFlush is lifetime-parameterized, the ARef<Device> is
unnecessary -- a plain &'a Device reference suffices.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/fb.rs | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index cbc42e98afca..e5a2c9d42f27 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -15,8 +15,7 @@
         Alignable,
         Alignment, //
     },
-    sizes::*,
-    sync::aref::ARef, //
+    sizes::*, //
 };
 
 use crate::{
@@ -49,7 +48,7 @@
 pub(crate) struct SysmemFlush<'a> {
     /// Chipset we are operating on.
     chipset: Chipset,
-    device: ARef<device::Device>,
+    device: &'a device::Device,
     bar: &'a Bar0,
     /// Keep the page alive as long as we need it.
     page: CoherentHandle,
@@ -58,7 +57,7 @@ pub(crate) struct SysmemFlush<'a> {
 impl<'a> SysmemFlush<'a> {
     /// Allocate a memory page and register it as the sysmem flush page.
     pub(crate) fn register(
-        dev: &device::Device<device::Bound>,
+        dev: &'a device::Device<device::Bound>,
         bar: &'a Bar0,
         chipset: Chipset,
     ) -> Result<Self> {
@@ -68,7 +67,7 @@ pub(crate) fn register(
 
         Ok(Self {
             chipset,
-            device: dev.into(),
+            device: dev,
             bar,
             page,
         })
-- 
2.54.0

