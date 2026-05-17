Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C415687D;
	Sun, 17 May 2026 00:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976247; cv=none; b=BjPmPvTqPXa5VxaiNPEd9ekNd9A8M4cAiGlkYYCOlYgBwTB6ATsYzi8hT8+54a47PABRtKNG3i4eNsylukkPANH7J616uDIRw+PZCB9aPxOzWjBKVVw+faUENk2/mTfRnXwilz9nRY0e4/3v4laocEt6D7mAHXL0zMRtC98Qcws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976247; c=relaxed/simple;
	bh=of0MbEhw7cKYbmfkTdKZz0ARgZj1SGnPtOq6mxurdos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqeXKJ2bi34E/qOxQTv5mO/wax1LSw0b/hLfe/4FSFCl8ZCtGpWoiAhw/ULhFP4u0qFqTGxTDGbKwsbf8Xunm/jtvCf6SYRcN3vtJWB2/Ow9PFqZgl5OF6RRQQ/HZRvGjj1jgh3wo8X9Q/2R+E+N6/N7qfAFngLzHkhOfw4xw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8hgS6Ur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8hgS6Ur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FFAC2BCB7;
	Sun, 17 May 2026 00:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976247;
	bh=of0MbEhw7cKYbmfkTdKZz0ARgZj1SGnPtOq6mxurdos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8hgS6UrmBkobZ9Gx9vMiyYNBZM1t975QQn/bSBNFau3UGhl27s71cvHNdAaLgot3
	 vfHTiRswyQF32xOgxaDzHrvP8DEy+8FUi+2S+jCE2srHsOl512QrKsVVFhkaAJCAYi
	 AwIR3YJCL3q6oTDsRBMM3vanSiQEk6jif8bsF8MhKwScIV5GIKH84BAwDE+yrN7/8V
	 qdxoLtfKYCKyILpIxaX6sVs2Jv1MQoVV1iNWERIrfGf/hDj+YXJqkn65id542T5bgf
	 IlOSjyzthUkbw4zqDxk25KOnKt0C5XCDezpB/ZMg3oJvIfWf4JsimLcOArVm4sRqDw
	 Dcht6cspeZfjA==
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
Subject: [PATCH v3 18/27] samples: rust: rust_driver_auxiliary: showcase lifetime-bound registration data
Date: Sun, 17 May 2026 02:01:06 +0200
Message-ID: <20260517000149.3226762-19-dakr@kernel.org>
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

Make the Data struct lifetime-parameterized, storing a reference to the
parent pci::Device<Bound>. This demonstrates that registration data can
hold device resources tied to the parent driver's lifetime.

In connect(), retrieve the parent PCI device from the registration data
rather than casting through adev.parent().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_auxiliary.rs | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 7b15a107fed4..84d18bbfafc5 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -52,14 +52,15 @@ fn probe<'bound>(
     }
 }
 
-struct Data {
+struct Data<'bound> {
     index: u32,
+    parent: &'bound pci::Device<Bound>,
 }
 
 #[allow(clippy::type_complexity)]
 struct ParentDriver {
-    _reg0: Devres<auxiliary::Registration<ForLt!(Data)>>,
-    _reg1: Devres<auxiliary::Registration<ForLt!(Data)>>,
+    _reg0: Devres<auxiliary::Registration<ForLt!(Data<'_>)>>,
+    _reg1: Devres<auxiliary::Registration<ForLt!(Data<'_>)>>,
 }
 
 kernel::pci_device_table!(
@@ -85,14 +86,20 @@ fn probe<'bound>(
                 AUXILIARY_NAME,
                 0,
                 MODULE_NAME,
-                Data { index: 0 },
+                Data {
+                    index: 0,
+                    parent: pdev,
+                },
             )?,
             _reg1: auxiliary::Registration::new(
                 pdev.as_ref(),
                 AUXILIARY_NAME,
                 1,
                 MODULE_NAME,
-                Data { index: 1 },
+                Data {
+                    index: 1,
+                    parent: pdev,
+                },
             )?,
         })
     }
@@ -100,13 +107,11 @@ fn probe<'bound>(
 
 impl ParentDriver {
     fn connect(adev: &auxiliary::Device<Bound>) -> Result {
-        let dev = adev.parent();
-        let pdev: &pci::Device<Bound> = dev.try_into()?;
-
-        let data = adev.registration_data::<ForLt!(Data)>()?;
+        let data = adev.registration_data::<ForLt!(Data<'_>)>()?;
+        let pdev = data.parent;
 
         dev_info!(
-            dev,
+            pdev,
             "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
             adev.id(),
             pdev.vendor_id(),
@@ -114,7 +119,7 @@ fn connect(adev: &auxiliary::Device<Bound>) -> Result {
         );
 
         dev_info!(
-            dev,
+            pdev,
             "Connected to auxiliary device with index {}.\n",
             data.index
         );
-- 
2.54.0

