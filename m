Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B28F7D;
	Sun, 17 May 2026 00:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976179; cv=none; b=Wktkrje/TkQ7vozYEjnUyZPkBLmmno004ZWoM/wxniq8FPeMxsobl1QnOnjn17xjs1ERn2e3PcCGa5RwvDT8sn2HgDPiQQEEpXRSMyL8+ydErelvETRrpvvGPYweB1lOb21comKfRCHoBaEQpTbWPGtowD8l33OdnFX3kaHHoYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976179; c=relaxed/simple;
	bh=vXBZ1m+8fysk721VWrgfvyV1v4yI6K/pK98VLh+Wlco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1OyUE1LY8E5mpIF4EfYGSIqC8Etf7QC/AsPA0UmN4ND566JxyMGEsX9twQ68ncQEqGymOhaA41sD2lCABux3G2BwtsEmMZpxtjcuJjxrsmuMDt6aZbvmo3v4BB1zJWUF7Y0NxgkoxoIy5Ka0M7v1h4HCHojVcl1XOE01gvrHG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcZfSi2j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcZfSi2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6871C19425;
	Sun, 17 May 2026 00:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976179;
	bh=vXBZ1m+8fysk721VWrgfvyV1v4yI6K/pK98VLh+Wlco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OcZfSi2juglBQgiPDzvd8Y9vFF9b0j1CHTbtFRM+1cmsSHadDL+b7mRVISYOcqN7e
	 SCyGT9kzSZU99y3ETrGRjPfGRicHi3fpwBpubVTgjlpmTPePVIYSPPJMGLheaYO6lY
	 T7UFcah28h4dlS7iCwbKus7uAez2fkkMz8+wKZQx6qFz7Yk1tZHVmCsTeJlbvn6+gx
	 aKMAEbMlBgj36ZBv8XO2lIMoxgOhPmIMCQKS5MY/hdbVZ8G4oJFtrK3q92m3rt0MQM
	 9O7Pc99PXTTWyO3+6S4MUnV/Tkq54+gHBdzvDZNXXWSZG8QSEnGGa/1Pq/gWHlJUiZ
	 pSRrnTUVwbGhg==
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
Subject: [PATCH v3 08/27] rust: usb: implement Sync for Device<Bound>
Date: Sun, 17 May 2026 02:00:56 +0200
Message-ID: <20260517000149.3226762-9-dakr@kernel.org>
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

Implement Sync for Device<Bound> in addition to Device<Normal>.

Device<Bound> uses the same underlying struct usb_device as
Device<Normal>; Bound is a zero-sized type-state marker that does not
affect thread safety.

This is needed for drivers to store &'bound usb::Device<Bound> in their
private data while remaining Send.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/usb.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 794abe06f5bd..995221d327b8 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -468,6 +468,10 @@ unsafe impl Send for Device {}
 // allow any mutation through a shared reference.
 unsafe impl Sync for Device {}
 
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct usb_device` is the same;
+// `Bound` is a zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<device::Bound> {}
+
 /// Declares a kernel module that exposes a single USB driver.
 ///
 /// # Examples
-- 
2.54.0

