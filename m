Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9863793BB;
	Mon, 27 Apr 2026 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327966; cv=none; b=H2pc/z3/h3F8isEb8SvTVNYOQOVKfZrzfWRlYBRV3vO/UTVKCma58NP4oqkEPpqnOeYdnj18Tr2s7ypGZ1P0trRidDW1/gvyVNVrQGRu9YOcqDwIgjDftjhryZV+fmAFlkFINiGZcEca3SPGi2aZZdS7r7YUfWQldBL7RVyb2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327966; c=relaxed/simple;
	bh=VjAUar7iUek881IcjlBLE2afDi6SB1mE1iW+SiRaRgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYVOfz6tiqPUosqjNiHrRGt/zAVNMxJbkU3k21VrlDr9cb0KqiU7JTo/1tAjL9FOiybIq1yOFdqLZS0q2Gj8KUINzpdPqY0os/oWherHD7Zr2wz5Blsmrz+oTDw9oUrxvxWeoK7rWEbUoBlBPKEJLFBerfRJCsvC8N0uPbKZ8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCnJZRBa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCnJZRBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058CAC2BCB5;
	Mon, 27 Apr 2026 22:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327965;
	bh=VjAUar7iUek881IcjlBLE2afDi6SB1mE1iW+SiRaRgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCnJZRBads/lxnPJyOs/wfgySb4LDK/YI9GTuIrbTSkZDDYkhdCWrgrhVIb+8LoGb
	 qGleP9nvxlQYxx7/YOlp7kI+HgtwfZPC6ejrIZCL7Xm1o/2S93HM4+1ynCqG/0QizI
	 JijgQxV1ZP/khPzZNLzpLcSUZo+Tdzw//DiAWxl6TKy1GP5uBme7gJ/7I+7kwCoM/Y
	 KiuyZgij4uT8KjUBzszseotZ2/+nSmH6rj8Scxz0fMn9RKvRSvESUtxYxNa6XpMq32
	 673yrs5Tsck645DlzkvHvU+rPuWJP80lvWxrW3Jc89t/oJSFJBHHA0huwYlikiUru7
	 M4x6oELI2KMHg==
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
Subject: [PATCH 06/24] rust: pci: implement Sync for Device<Bound>
Date: Tue, 28 Apr 2026 00:11:04 +0200
Message-ID: <20260427221155.2144848-7-dakr@kernel.org>
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

Implement Sync for Device<Bound> in addition to Device<Normal>. The
underlying struct pci_dev is the same; Bound is a zero-sized type-state
marker that does not affect thread safety.

This is needed for pci::Bar to hold &'a Device<Bound> (required for
Bar::into_devres()) while remaining Send.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index fe5148f41d8b..6f82f2e6c74f 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -526,3 +526,7 @@ unsafe impl Send for Device {}
 // SAFETY: `Device` can be shared among threads because all methods of `Device`
 // (i.e. `Device<Normal>) are thread safe.
 unsafe impl Sync for Device {}
+
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct pci_dev` is the same;
+// `Bound` is a zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<device::Bound> {}
-- 
2.54.0

