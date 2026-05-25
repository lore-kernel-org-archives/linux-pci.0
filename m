Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71F7396D2E;
	Mon, 25 May 2026 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741036; cv=none; b=fLzyBXcnd7UBzIMuXLCX3h+dHwY3vrhiZHb0dqdcWzDuuQH5zWA6WGxnW0+y9+Lvu9GYwPEGAxVexaAARqKyKrNPTMOq4xqrOmCQoxlRUdOMZVwfF4idm1lEU+DnG6ZQJnVc+TTfmDWlSi9YFFs+XjVGkMrAEf+kGAzpamzTi2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741036; c=relaxed/simple;
	bh=QpOSs/EphbyzeReYezQJNbQQg8W/3eJTmGEltj0uFeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6sql5iF6n/SATPlfEs/yb5YS3BUlPqhRXCHiyqf3rddTOKRavmQNZjNTJBm3ZynCYDIwi+aPmFS8BXz7MGITZk2C/11Q1EAfaaGtgTmol9ACQO9dpJZKK7MV3L9q3OKyRwhxwreDXtD0OzPW+imasP/84kBz65MBXGUFQD47eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDJiCTd5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDJiCTd5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42FF1F00A3C;
	Mon, 25 May 2026 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741035;
	bh=FsXPjNDjSp9++e5VYHQ4V4V9GNNCrz4C2Wggi5ivyfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZDJiCTd5pgbF79ZrJHPBOcYWcEHXu0Cp0Ig2cMHXyrL61ywlKBxQChATWj+n4jwfu
	 H2qvptgpw35wA7RbrFxMSENCDp0QFO2MRcgMGPIseiFFrHghfFnxV21rVx2qjGsGkx
	 fdQW0Y6gnZ5sOqrAQbupBYnDIAAnR54lCRDX9KhjHNg9ty8pslwzJgyDt5KqBO7AP8
	 0FlV8zIAjXpFSUe6ihcvBp9loDh752+VJAv3sPx1IabB4xh4QMaPOPG7YoUMfPen73
	 zfL0tLomSMC8+p4B78UqvjPGpHE9seL7MjM2+OHDwl0G1el1BAcbMRvk5bVTjWpj+8
	 amJBUKzf5GKVw==
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
Subject: [PATCH v5 09/24] rust: usb: implement Sync for Device<Bound>
Date: Mon, 25 May 2026 22:20:56 +0200
Message-ID: <20260525202921.124698-10-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202921.124698-1-dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
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

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/usb.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 88721970afcb..6c917d8fa883 100644
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

