Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF5155C82;
	Sun, 17 May 2026 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976166; cv=none; b=UPz+Vo8F52SyVfC8fHv3VBEVIqpLGxkdwLY4L9IG84vBn/m7dNEK1l33b4lZlDm0cSeNRTkcOvCzNRAQh8M1Zx4yGJxmAm1eYCx746m7aLf77c3JhRqct8S8Fst5+6xUFp5zdh0Revae9bQM6dfyyz89AgURDea6I0j38Nh/0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976166; c=relaxed/simple;
	bh=pFsDAZJQFVe3zG12qZeSTm+jZ6D6JDn04nnAPXgf3PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcXcI8VOgDWc9RCtj5CAsRDHHa40Mqs73xFQ+NVcxS0cQuc0m/1rrLkKEKwFqdaIL8LwHwohl53vaDVlJzAZfk7jkOehZzFNEQk0DNgUNbhzJBl5hYpRvV5lqsLb9dERgbjpyQXZcxsv8XurzbwS+8g9qM3KfZx6KtzxHGP+If8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ6VFVih; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ6VFVih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AB3C19425;
	Sun, 17 May 2026 00:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976165;
	bh=pFsDAZJQFVe3zG12qZeSTm+jZ6D6JDn04nnAPXgf3PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJ6VFVihEjkppZxTVCUiCDxe9Bw9mFzgeUJYkhmqMz/KffcfSEc0UEAhQTs/aCRuf
	 1tFjv+22mJlj6hqTg8s37w1ogAGlelk0QgUkpfF9l7N4dUJaespLqVuPpDeCGjfysy
	 HR+usZ5jl6OkvhTFbsgA45RwAXpf+qpY6BVKQNQijYbyoOaYcSZlndeSTXR32xztPK
	 EiLt2XNGQB//dW2xtdz8+3rbdNTKW88SelVfi/+KZpbylg2pBRHpAl0IQtQYAw18nK
	 pdRjR5brVxsrmv+1N6sv88mJUsWP3gQhDhwb9lYStB2CARazdedoHAkZIs9Bsu90ES
	 Ufo48htyCDQRw==
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
Subject: [PATCH v3 06/27] rust: platform: implement Sync for Device<Bound>
Date: Sun, 17 May 2026 02:00:54 +0200
Message-ID: <20260517000149.3226762-7-dakr@kernel.org>
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

Device<Bound> uses the same underlying struct platform_device as
Device<Normal>; Bound is a zero-sized type-state marker that does not
affect thread safety.

This is needed for drivers to store &'bound platform::Device<Bound> in
their private data while remaining Send.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index a74d2f6c8f02..a72ad5366931 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -565,3 +565,7 @@ unsafe impl Send for Device {}
 // SAFETY: `Device` can be shared among threads because all methods of `Device`
 // (i.e. `Device<Normal>) are thread safe.
 unsafe impl Sync for Device {}
+
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct platform_device` is the same;
+// `Bound` is a zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<device::Bound> {}
-- 
2.54.0

