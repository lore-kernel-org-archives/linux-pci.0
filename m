Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FDB3B47DF;
	Wed,  6 May 2026 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104342; cv=none; b=SdSKbMBrlI8raeSTQtaFGFL2MP3cePfcZ8okjI15RAlFCcy5WcnJEf+7Hs65FGot3MUe7dEHNrE33xMH/oYRGf9jQn1YQ73mA7S+Cd/FXX0vkaz/Pon+QlLuGQtYpTjYPtj789Ledw8fnZMf+lg8sYR0CPvNI3RkYDold91CqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104342; c=relaxed/simple;
	bh=hUk/06OQ65XIhi8xFZ1jZmeWHhNf8K96MP/3Shol3Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VssihG86EQrnt8dmyDSnHSXclpZR7tPljMDQ80/4T2/TvRfXqAqvJCP6H1K4DdDfBKEByKW/PfROkY/B5ntGAF5EKuYr7dytO/7XUYohzRdfwVMpo1SB/OPLJIZC8xL+KFH38MEhlulwjjNrSwLjA/Efb+jxD8nkGa5B1p9ZCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZ9aLErk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZ9aLErk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F25C2BCB0;
	Wed,  6 May 2026 21:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104342;
	bh=hUk/06OQ65XIhi8xFZ1jZmeWHhNf8K96MP/3Shol3Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZ9aLErk/O67CVVusinDvzXa1zZ5Sq+jvu/KVH4Rk7wBUsOzZrUHRywvjFM77FVbC
	 B9HnyoZUNJ6seAgoqMFl/CX3/wHHPzhML+1d21x26xlbFULJ3Y03JM3BZCDXoWCcdg
	 m5DTmSTVAG0YPC/wy6XNBPONWu2vPkwjI8Wyt4v+Rx8vNNgqkxO8d4rD8X/ABVTYD1
	 Gcul3KKNU84kySZx3AaquiOf/tvaOmS17Tn1gu7z4Ug3ZCPE67Nm+nkk8stuX+0PNx
	 XWim4gydo+hn1jDezUf3CkiWQsPG+EqsliZJt9Y+LMxAudTkN8C8KcSaDTAyBxuP5/
	 J8W4a+SXhik8A==
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
Subject: [PATCH v2 09/25] rust: device: implement Sync for Device<Bound>
Date: Wed,  6 May 2026 23:50:45 +0200
Message-ID: <20260506215113.851360-10-dakr@kernel.org>
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

The underlying `struct device` is the same for all device contexts;
`Bound` is a zero-sized type-state marker that does not affect thread
safety. Implement `Sync` for `Device<Bound>` with the same safety
argument as the existing `Device<Normal>` implementation.

This is needed for types that hold `&'bound Device<Bound>`, such as
`io::mem::IoMem`, to be `Send`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index cee61638b08c..fbbb297cf2a9 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -498,6 +498,10 @@ unsafe impl Send for Device {}
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

