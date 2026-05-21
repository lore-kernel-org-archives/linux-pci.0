Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454831F98E;
	Thu, 21 May 2026 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406816; cv=none; b=bVId08gCfSBDTMLHLGVpAQn/iEXkK7hLvgSymj49yDyTIUy/HsntgXO1ygAjSNd5MFDKQvHdtHoEhn16stSuepf3aYk1n+b2DjILt6juDTTRKKAumxYPCUfBL6S7zMISf8pMFZoeguYWKinNrwJSpkjWvbWWj2YcVKvHEeSpM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406816; c=relaxed/simple;
	bh=MQaVY3wn5Fr9Ki7syMwZESRCGHvN5F5kTZE869GysQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obwnz0U1002/M90aN1Jae1VC8B+l0r0sQc2LJyt+Bnwnj1GY/03Ze77E8SADd+wahoh8qaJjVUCu+2ZAJMaKDSugtANYi459KPSeC6Nem2Fx03uIrBUcraSNwlVW7yoeseJ1gGmZPiIBScLma/7mTTjCakDcmWJ58FB6UXL1zEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRztFjac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRztFjac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B531F000E9;
	Thu, 21 May 2026 23:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406807;
	bh=ZhrVRWnv8zNdxXcPSXmUKIJuAuNCE6ADfKvZitNDWSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRztFjacPD5/OZIzlRctcJhFSCoVS8vrrtffhaKXdEOrFCj6CHm3C75ntBkDGQ799
	 xm9dUNxesoukHHbiIEatxULSbbMrslyqWAu8qItUGWxu34th1NP3nF8QPW8KJSYZx1
	 +M3y91d5/7ufqBNSO7fVsl4c15Toukv76GXuJQijBKTaWLKnSTGsq7WODnCR1XXkka
	 YqgeIa8LK/KuUt5u+rJGWpXnyy3UyvFTNx8cHiTo6VqxR4Vq8ZuWoeuR3kYa9nXLK6
	 5NppZmRhG+CZo6XJv+eHIlL//GPbxqmWZ+vxjlmsttWwoLOBHFn1npbcx9T/GaMUz6
	 WKdylY3qxs3Qg==
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
Subject: [PATCH v4 07/27] rust: auxiliary: implement Sync for Device<Bound>
Date: Fri, 22 May 2026 01:34:33 +0200
Message-ID: <20260521233501.1191842-8-dakr@kernel.org>
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

Implement Sync for Device<Bound> in addition to Device<Normal>.

Device<Bound> uses the same underlying struct auxiliary_device as
Device<Normal>; Bound is a zero-sized type-state marker that does not
affect thread safety.

This is needed for drivers to store &'bound auxiliary::Device<Bound> in
their private data while remaining Send.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 4e83f9e27d78..df2c97423dcc 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -369,6 +369,10 @@ unsafe impl Send for Device {}
 // (i.e. `Device<Normal>) are thread safe.
 unsafe impl Sync for Device {}
 
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct auxiliary_device` is the same;
+// `Bound` is a zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<device::Bound> {}
+
 /// Wrapper that stores a [`TypeId`] alongside the registration data for runtime type checking.
 #[repr(C)]
 #[pin_data]
-- 
2.54.0

