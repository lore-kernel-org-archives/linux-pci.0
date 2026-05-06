Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53FE3B47D6;
	Wed,  6 May 2026 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104444; cv=none; b=oQrJiM7CllIFfuz2JVMsJzpviHMbnBNBYEcfuO9OueYiwYymgGtqvXyJJbjoRzrQABShVD1rcANtzlFybCkyOlL+J92dcpIaFTIf1UjV4R6YRy5mFTruKaqLI33e4FRrmnZyhAM8yAmJj8uEtxXIjn6qmEbXlTSXKn9h4tUqbiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104444; c=relaxed/simple;
	bh=ehe2nY6HcH6JtRvtBxvkGvdAIzSzQ7wCS3Ek50X1INE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElsiCnp0hrqnSvjsMvIVXmoMfqFi9P6O/TuuX/0YyZXB+brwI8rGnmCFIoFNq4GnLoNXKyO9Nz+OTj4F9DQt/9LxSAQc3/Qn2ZAxXhW8xTeXu48BFe0ziECnJvZkHn1+qUPqO6IqPbnppL6ogLHWno6oyivvZpGwIgHUX64A/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7xsYTEE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7xsYTEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212AAC2BCB0;
	Wed,  6 May 2026 21:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104443;
	bh=ehe2nY6HcH6JtRvtBxvkGvdAIzSzQ7wCS3Ek50X1INE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7xsYTEE7d1id01Jb752U8+IgHd50N19/BGVX0reUOcFzLeDHNo4ZO/YSkUZLsKji
	 FjsIaU9q1pgzRMnxSFWO2kJRh9gcjJwqjDVzzNTB0oc2vFQnM9de07nvlwNX5fNyIF
	 5lMqoCwIgxJyjJest+36C1lDqa/0kbPY/cberHsa3UyI/jt62WNnLrEFvlU6y4evN4
	 mHQoqUbmOw7Kgf5tYGCmgSnSvyJlWJTPMqwQLxwFwKj8dPW6xx71WuRrOnQEzJSerU
	 GbVjmmYJXgXQbJEeHz0RRtUYsRb9dFC27IWnElrIewo19aHlpNzfGi6rNpuoY71cyZ
	 FB7pSrAGDZG8w==
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
	daniel.almeida@collabora.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 24/25] gpu: nova-core: replace ARef<Device> with &'bound Device in SysmemFlush
Date: Wed,  6 May 2026 23:51:00 +0200
Message-ID: <20260506215113.851360-25-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506215113.851360-1-dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
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

