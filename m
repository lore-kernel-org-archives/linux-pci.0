Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F0C3793BB;
	Mon, 27 Apr 2026 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327972; cv=none; b=LNI7Mwt8YiLXTErZ3nNoZWk2D2DOtmSrHpGVPTRimpsRBm76W21RB2ujPmfeooeZn9po+aC5aZw3FUqtLS+oOFbwElmd2ldREjkwMRprJwnVaWkWA7O2AS+sdz4J6Ah5ZaoOfM/3jYb3Z2YjjtK3hlEk23T+NAq6dYaIGKmoZzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327972; c=relaxed/simple;
	bh=ZL0zZCof376hKMo9gCVpVeB8x9AGCrUGR4sSsGtHfmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNXzx/f/IATUdoCQGba8IUCGKoaX4IXICDxR0v4RXfz/6XGs/pC8OesGvjfdA6RJ48aqfP2UolqcG9pk9i6xxepFHPb43oEULySTCIfBxF8tMHB1+eFN/4B5DY12OGZWJgELqkRqo9Qy3rFqiFvBc9ZpBrN22RpMF9+JFdq2NCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhs4XRkL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhs4XRkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDFDC19425;
	Mon, 27 Apr 2026 22:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327972;
	bh=ZL0zZCof376hKMo9gCVpVeB8x9AGCrUGR4sSsGtHfmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhs4XRkLdj6f/yxZNfHY6NuvcXE6SzB2cRVRxBtKOZ+l1bM47Btenuklj8PnO7Euf
	 khfDpJdzT032Ikvv4at1RhXzxCH+/+1Uvn3f7KoeMRwvTKb+zkfMZUb7u1o/pCbF0d
	 /dEr7ZJPu53xD9cenRMXcnCj8FI+xI+R4kKbUj6YbyPkIH9SsuNQaDDYtB7ifcWCS0
	 gGzh7PfW+xelHhV9gbUUJTnsKh7Zt0j6wVOd87hRgmZwoLvA/OLNIh+TCTHjl8t+Cx
	 /C5H5XJL/M7py5KzI5XsYcqHQpa4xfxahE7QsRiLg7qI+JtkTIyO5t2GIE48cKwSEh
	 hsBF0GHxBhvdA==
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
Subject: [PATCH 07/24] rust: platform: implement Sync for Device<Bound>
Date: Tue, 28 Apr 2026 00:11:05 +0200
Message-ID: <20260427221155.2144848-8-dakr@kernel.org>
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

Device<Bound> uses the same underlying struct platform_device as
Device<Normal>; Bound is a zero-sized type-state marker that does not
affect thread safety.

This is needed for drivers to store &'a platform::Device<Bound> in their
HRT private data while remaining Send.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 1585b6a1ac45..ae648304eb5b 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -564,3 +564,7 @@ unsafe impl Send for Device {}
 // SAFETY: `Device` can be shared among threads because all methods of `Device`
 // (i.e. `Device<Normal>) are thread safe.
 unsafe impl Sync for Device {}
+
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct platform_device` is the same;
+// `Bound` is a zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<device::Bound> {}
-- 
2.54.0

