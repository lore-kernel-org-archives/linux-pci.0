Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193D48CFC;
	Sun, 17 May 2026 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976152; cv=none; b=jmsmg3j/yUPSTIy+WqLisDX1MstOYISHqmfNFnxnhIqcsKgD/Ig6O0Ge9aq2SLBk5YS2RfD3XP29PBtzYpXH+bnrTKVvqoJDMFdexn9dVqk75mHDEG37XPGH0LuSw0S1bMzPWXmo0hwsj87MpoonqDwSM5Nwix3/XDfdupA4ahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976152; c=relaxed/simple;
	bh=MiTa1Y3ctLD1p+Ro2FWBi35sXSPkj2y1USn1OwULC3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klstTL7zDOv7Y2QqFjH5ub0rpxT24tBsQtAnQjYNLS9arjl3b/DN+0APolZaAij8cxX35lhEMkm1emAsLbliDPBc5kNzeh6UVCCkNuSZVpbuqe69+Fuai6gFip/O3iXgefUyJQwDdsWI5FB9mqB3MKCR+2usq2Jp5mqL+MIffA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YT0czcZK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YT0czcZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B89BC2BCC7;
	Sun, 17 May 2026 00:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976152;
	bh=MiTa1Y3ctLD1p+Ro2FWBi35sXSPkj2y1USn1OwULC3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YT0czcZKQzPcHLoOTHR1H2cDSg4jW8AJwxOota4SINaY8FxX44G4NsdabpN9JJYlc
	 7148Jc4M2RQBFwqsHZVnaW5cYniKVfI/d00jQF7TU6ni+7cVrsNU90UtkgYb6V4SaW
	 89bvv+wth1oBYTgOik/qwaQYyAWf8D8XmF7jhej7DEjdKssZDJotluFPZ0sCgNuQO7
	 YbWkYZyyuglebR46feDCPIjtaMPlaTdZ2PVSAcpZt2FolspSoZPxa6nUUdBpT6LDRg
	 RwPEgDKxv8uSfq8RV4UFmLjhCqVfSYT5ZTWNvfBb0AYpZnK1SQQ75dQxG+AsMiO6iv
	 9ChTZTBlGpU1w==
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
Subject: [PATCH v3 04/27] rust: driver core: drop drvdata before devres release
Date: Sun, 17 May 2026 02:00:52 +0200
Message-ID: <20260517000149.3226762-5-dakr@kernel.org>
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

Move the post_unbind_rust callback before devres_release_all() in
device_unbind_cleanup().

With drvdata() removed, the driver's bus device private data is only
accessible by the owning driver itself. It is hence safe to drop the
driver's bus device private data before devres actions are released.

This reordering is the key enabler for Higher-Ranked Lifetime Types
(HRT) in Rust device drivers -- it allows driver structs to hold direct
references to devres-managed resources, because the bus device private
data (and with it all such references) is guaranteed to be dropped while
the underlying devres resources are still alive.

Without this change, devres resources would be freed first, leaving the
driver's bus device private data with dangling references during its
destructor.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/base/dd.c             | 2 +-
 include/linux/device/driver.h | 4 ++--
 rust/kernel/driver.rs         | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 5799a60fd058..be59d2e13a15 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -593,9 +593,9 @@ static DEVICE_ATTR_RW(state_synced);
 
 static void device_unbind_cleanup(struct device *dev)
 {
-	devres_release_all(dev);
 	if (dev->driver->p_cb.post_unbind_rust)
 		dev->driver->p_cb.post_unbind_rust(dev);
+	devres_release_all(dev);
 	arch_teardown_dma_ops(dev);
 	kfree(dev->dma_range_map);
 	dev->dma_range_map = NULL;
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index bbc67ec513ed..38e9a4679447 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -123,8 +123,8 @@ struct device_driver {
 	struct driver_private *p;
 	struct {
 		/*
-		 * Called after remove() and after all devres entries have been
-		 * processed. This is a Rust only callback.
+		 * Called after remove() but before devres entries are released.
+		 * This is a Rust only callback.
 		 */
 		void (*post_unbind_rust)(struct device *dev);
 	} p_cb;
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 3506b4e8bff9..d8898f2115d5 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -193,8 +193,8 @@ extern "C" fn post_unbind_callback(dev: *mut bindings::device) {
         // INVARIANT: `dev` is valid for the duration of the `post_unbind_callback()`.
         let dev = unsafe { &*dev.cast::<device::Device<device::CoreInternal>>() };
 
-        // `remove()` and all devres callbacks have been completed at this point, hence drop the
-        // driver's device private data.
+        // `remove()` has been completed at this point; devres resources are still valid and will
+        // be released after the driver's bus device private data is dropped.
         //
         // SAFETY: By the safety requirements of the `Driver` trait, `T::DriverData` is the
         // driver's bus device private data type.
-- 
2.54.0

