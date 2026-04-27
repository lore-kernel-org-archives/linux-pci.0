Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D53A9630;
	Mon, 27 Apr 2026 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327978; cv=none; b=HJSvEaZ1sN2mEOWugwTbLIAgEnMHXcZKSlNFXbRHPtALWEFRcN0cJHK0hmBwuqid14uO4Dx/l/g38sDpLCwrHbgtHI2jZ3SinMttq1wrCD1O9R0fk88UXRV0E7njUSV4fDVWAOQvsQ9mJZAY9mf7x5ZJf2ImeKI8TDqvAlgb7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327978; c=relaxed/simple;
	bh=yr8B+4rt/53Knez9GYsPy8kH5qdqBUAoWhXDtRNohr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPxKZpmkKVSDqvHQ4RUjAPcI1M4ausUzP+SAIaxRBP7k0iiCdS3nExTtAVmOnasf9yNi1hrxvbPbUDR2df1XU6cMWPfzXuPSN3Tpqqz+7ZIhwD5TQWENfosnUHjuyOrpIFYRpOiDxaQT+RhA6TMSXlC/Myw1eEaSLLySwaEadqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRAZBQDT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRAZBQDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A084C2BCB5;
	Mon, 27 Apr 2026 22:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327978;
	bh=yr8B+4rt/53Knez9GYsPy8kH5qdqBUAoWhXDtRNohr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRAZBQDTvT3S9AqkGWDbTNPEVAS3MP3JPhQQKSCj97OAdzLxXMI+QvTq++4rkUYAl
	 bSVaKBzRYrpVbi6cIHmQe1C2waWZlCuZEGiQd24otVcKb6RGENUB3iWiVqGdr5NVLo
	 NjqGDR/Sp2EXEzzxsegbw0nJLCfhQKkauuxgMd9FGrndfiymSXpB6SgaH9vdenzpru
	 bYpLWBukNn81mIqBXdkGZn9jNfV9Cn5m9/3jWj9qYgZ1UOhQ4xdxfDGk+sHbDbJyN6
	 iDsKtyXXJZRT1vNrFU3I5Tw6WhyZxJigtrZGulBGYNHezHu2ZDIdjXTJ+4gkYQKpNI
	 yfyrqVTAV7Jxg==
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
Subject: [PATCH 08/24] rust: auxiliary: implement Sync for Device<Bound>
Date: Tue, 28 Apr 2026 00:11:06 +0200
Message-ID: <20260427221155.2144848-9-dakr@kernel.org>
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

Device<Bound> uses the same underlying struct auxiliary_device as
Device<Normal>; Bound is a zero-sized type-state marker that does not
affect thread safety.

This is needed for drivers to store &'a auxiliary::Device<Bound> in
their HRT private data while remaining Send.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 5cd10b254baf..8a278ddb5b95 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -366,6 +366,10 @@ unsafe impl Send for Device {}
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

