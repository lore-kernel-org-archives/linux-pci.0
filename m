Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A83396D2E;
	Mon, 25 May 2026 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741044; cv=none; b=WMQtjIZPbR66NW8veRwe6yQl2bLSMwUQVoW175LbhwFzujMKxZ6fvmSW6dSk5v1jkeI8f8n7hQTGJGFwGgFVgFOIM2bwQ3Gyrf+Ak6HzRbTwJOsa+wJL93deKAnI3rFHuNFSaSV8oDW62HQ+vEa7t5iZoQzQk10uC4LUF2BvsNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741044; c=relaxed/simple;
	bh=urF5Rk5jTMNT+4K+VC8PjkjsSN5q9iMcbGqWQJmJOoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pX3zclWBATEwl1Z8Uc2w0Q96WWBK1LwVo9Qz5cPJPKkjYwEgWR3b+FGMMxkup15+QImo6vkp/ptFSe00iYCKzrrVxtUvjTEGW/KsNH4CAPPL3guvLMyV0VNevboJUokmnIz6UznaeyWu0m/2nCSjSR/+KSmfhdOnuhqR7MLY1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElarxhLU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElarxhLU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40B01F000E9;
	Mon, 25 May 2026 20:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741042;
	bh=3s2zR/dj1pWywn+EHbTTBpMMpSw/+K1EkrL3Cwr8X6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ElarxhLU1zbvsRiXjQE2HRAf9RzqAxiN+/aY1YzYKn0cMizSvwGYZi9PF1PpXaxBw
	 GN5JcQJb13eg1Ff6z1YZ2xnNT86FQ49B1+oVS8CDfslKwOjRd9sIQ3YKVUdEx1KXrU
	 pEivvJkNRHW9olkpHM84adUi00g9ZpOFGpIhCuAwd8qFCU+K6BeA5HVcVFPeF2lnK/
	 6B0TQrgEeerUkPgmUXKVzdmNnkpwIni/5pD04a3pUeG2rGQcr9kVF7EZUKbXA10KwU
	 tBDYO5gySLP9NC5SYrEQiWJ0w24yS74gLlLyydVIppynaFXJObHZxyRc81WQ6e2thP
	 6p/P3Ttt/5ABw==
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
Subject: [PATCH v5 10/24] rust: device: implement Sync for Device<Bound>
Date: Mon, 25 May 2026 22:20:57 +0200
Message-ID: <20260525202921.124698-11-dakr@kernel.org>
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

Device<Bound> uses the same underlying struct device as Device<Normal>;
Bound is a zero-sized type-state marker that does not affect thread
safety.

This is needed for types that hold &'bound Device<Bound>, such as
io::mem::IoMem, to be Send.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 5df8fa108a52..c4486f4b8c40 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -467,6 +467,10 @@ unsafe impl Send for Device {}
 // synchronization in `struct device`.
 unsafe impl Sync for Device {}
 
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct device` is the same; `Bound` is a
+// zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<Bound> {}
+
 /// Marker trait for the context or scope of a bus specific device.
 ///
 /// [`DeviceContext`] is a marker trait for types representing the context of a bus specific
-- 
2.54.0

