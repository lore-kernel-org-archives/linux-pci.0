Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2808F2A1B2;
	Sun, 17 May 2026 00:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976302; cv=none; b=Fzk2GxAHUdvFmbcSrotjQqY13G3y0UzHJ1OnsKWqbtkBvpMQNGb63lQHEN/50qOQ8j5+xTDDgKTmn5MX3m5gqcc5dfmlzWqrdrzUq1M5PH95ak2h/DzTRPwc2pBYhBLuip8ipXiFiJJkytdqLaGO4Gly7qoHpSUXK1AuBvdwozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976302; c=relaxed/simple;
	bh=ehe2nY6HcH6JtRvtBxvkGvdAIzSzQ7wCS3Ek50X1INE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrNUjFC6QgiUEOn4MbrvelKySsokqtqRnbDgB71RJ0esmq/a/zRoQX0wiGhAvAwXztY0qL6STVaHkm8NK3FdbM1u0YMyFvgGD3XgTCqQ6Id/gedWq+k5WjhVl6Bwy70yuBiPpqbYNGLFKHcTN7+DeE8Eg+stGL3Bo/OEqQLZW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7aiy2r7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7aiy2r7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E364C2BCB7;
	Sun, 17 May 2026 00:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976301;
	bh=ehe2nY6HcH6JtRvtBxvkGvdAIzSzQ7wCS3Ek50X1INE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D7aiy2r7oo0iPytnjP0pt1IKE4F/dc5QxF5FfcbSKml8e3mjR3HUOxcU6bNiFsBeB
	 Nv+D7WffNPx/JTwYE0oaM1o92DJsVj8Mn+CAv+f9vHOjs/t4jUzScq9Z5kmp2hUkax
	 sCZEhfSdopK3faNe7yoTUzZE7CqJSa7QQOoF/4b6JB60IstBNBFq/stQ1JdfyBgHmO
	 fnuLYv4qBDC+7uxzlnYj+b1H0UdE9tOqXrzcBgvbg5e7W8BxfKyOlQ3SDMo4hY1TAD
	 Xbmh9AaYi9s3snx/k4O03BcQAvjT1tQRLOKHuwe0Bpu8IiTRY0kJUldcu4PKaGUQrE
	 mE2HIXdKUDlew==
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
	tmgross@umich.edu,
	igor.korotin@linux.dev,
	daniel.almeida@collabora.com,
	pcolberg@redhat.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH REF v3 26/27] gpu: nova-core: replace ARef<Device> with &'bound Device in SysmemFlush
Date: Sun, 17 May 2026 02:01:14 +0200
Message-ID: <20260517000149.3226762-27-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517000149.3226762-1-dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that SysmemFlush is lifetime-parameterized, the ARef<Device> is
unnecessary -- a plain &'bound Device reference suffices.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/fb.rs | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index a707fbfe3ced..e22dec12ae7e 100644
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
 pub(crate) struct SysmemFlush<'bound> {
     /// Chipset we are operating on.
     chipset: Chipset,
-    device: ARef<device::Device>,
+    device: &'bound device::Device,
     bar: &'bound Bar0,
     /// Keep the page alive as long as we need it.
     page: CoherentHandle,
@@ -58,7 +57,7 @@ pub(crate) struct SysmemFlush<'bound> {
 impl<'bound> SysmemFlush<'bound> {
     /// Allocate a memory page and register it as the sysmem flush page.
     pub(crate) fn register(
-        dev: &device::Device<device::Bound>,
+        dev: &'bound device::Device<device::Bound>,
         bar: &'bound Bar0,
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

