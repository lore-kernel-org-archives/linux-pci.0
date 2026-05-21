Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2637B01A;
	Thu, 21 May 2026 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406942; cv=none; b=SDe6yMhQXgPVZs99KAlXVDjUTG1TiMhymPp6ZFepjvoPOZ8C0hAs2SRUEvccCccVzo4cvh5err2zwKE0gBbsqsNLQOrfXR6w2hot9nXrNlIQlpXS1sY7gMKnYr2bTTorTGDU0EvDp8vqCgnjHLHgqQYyGj25C2KmZhxUechC4kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406942; c=relaxed/simple;
	bh=30+CXHKZzbMY6HTqt2CGaTc/27ir1Eup+a00Q2x9++c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qd/pesi0VRBuO6t3NbdieQfneeCI04CYH5V3SZOsqG77avQha4sPuDs5sGAEkXyTupKtvZSrgOykN+PdqcNNP7UGrxncQKczZnB8ArhmShXmCyrihuqRm/hsdf4OYtGz8GgPa+PE9djIlLvvKhXOXI9cJ4wrfM/111SGARFhhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mjjb3pTF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mjjb3pTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152301F00A3B;
	Thu, 21 May 2026 23:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406938;
	bh=EUQ1dgH+Jyb+iJ0OBBSC5/6K6i+s/brVe5Q1aK+jsiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mjjb3pTFTRHPO4mbx3Vh8ag9znkvUUe4BtoO8mKwMGVzyI7n3hmU1X7Aw+hWWP2L9
	 8enW+0CfNr8WuhyaEhYmspiUpmZVjIQiDwOjADaF40QJpRhwOgNBwpa6GR+WMM22x6
	 69OskBld1hY/idl8L81q5wULVGwHanbXsraf2fPa61qF8sMPL8JrpLMTbd7vmZe3IP
	 yIM7arsDv017pwldXss0Y8jldP8YfXFR7VpAaeKGeOKi5wf5SE55svl2FbFZXSw1L6
	 +/8xNhNAytYBOhXEXOAS3eWDIswMxnm8pLP46CKxu+vbiyw+Vhgd02ytijb2LGups0
	 GRUHPF59ecDfw==
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
Subject: [PATCH REF v4 26/27] gpu: nova-core: replace ARef<Device> with &'bound Device in SysmemFlush
Date: Fri, 22 May 2026 01:34:52 +0200
Message-ID: <20260521233501.1191842-27-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521233501.1191842-1-dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
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
index 64fe5f27f41e..a1c5ccd0a534 100644
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
 pub(crate) struct SysmemFlush<'sys> {
     /// Chipset we are operating on.
     chipset: Chipset,
-    device: ARef<device::Device>,
+    device: &'sys device::Device,
     bar: &'sys Bar0,
     /// Keep the page alive as long as we need it.
     page: CoherentHandle,
@@ -58,7 +57,7 @@ pub(crate) struct SysmemFlush<'sys> {
 impl<'sys> SysmemFlush<'sys> {
     /// Allocate a memory page and register it as the sysmem flush page.
     pub(crate) fn register(
-        dev: &device::Device<device::Bound>,
+        dev: &'sys device::Device<device::Bound>,
         bar: &'sys Bar0,
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

