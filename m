Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1637D3B3C00;
	Wed,  6 May 2026 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104336; cv=none; b=MsGspQAXR0S8BU7J2jBRbI9fpL7RFUXcBdRItJSB/Ci7ps9T9exN2HYNpEPFgWUdtJW3sXH90c6qpZ4JPn6IA1jDHE5WTHeuNdBMwJvomeC9YtgR2Xy9iWrczYNhIFM1j35XeGApVjtRPazGuPtwu7JhNP1qtdqAeSub5ae69po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104336; c=relaxed/simple;
	bh=CJzXzWucM829+MDBDBZxsfVoUlMH9RIMYpxWLe+dI5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpzoPWyhQ1f3sIOX7wbrGKsF78B6w+Bs4hBPeuGCWcPM+sUkE8lMFiUttpQFGZi7r+z48SXZHrUgYU8MLJLaKvIWF/mDyfPwB3zClaCEGam4ESuasSRbXaGKaerPECCCDgYuSoK5n9kKjMQiUkXGvw9zISkPDsx+CaHwuqnXxu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqiWVNkr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqiWVNkr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F378C2BCB2;
	Wed,  6 May 2026 21:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104335;
	bh=CJzXzWucM829+MDBDBZxsfVoUlMH9RIMYpxWLe+dI5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gqiWVNkrOAoUEQgxyKxXgOhRxSopfd85M2KuZiGUg3Q9+CBan75GNvs50HVzvOT/2
	 QyUOlNTGtIV7uCejdqwiTzlDr8pe4WmFWjdkJdfstXxPIQCZs31DpJYiuNOCO0ZU+o
	 D+mxt5xuFZc6VV7kzDwV7C0FPzGBoqJz/4zX91UXjgL9AinumpyM+GljwaZ1To6Acr
	 Kg+UklkEy6NjaBYwVCYK3o+dOAIUDi1MeboX+ama+VPAzdxGvMzgl6c/IDTWGHMEtD
	 LyCuPWtyucJb96lH/hMXT6YjMflOSTyafjXudZtyitRHVl01VLNA6139XR4sAOA+ve
	 n/DB5C2AVPBKA==
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
Subject: [PATCH v2 08/25] rust: usb: implement Sync for Device<Bound>
Date: Wed,  6 May 2026 23:50:44 +0200
Message-ID: <20260506215113.851360-9-dakr@kernel.org>
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

Device<Bound> uses the same underlying struct usb_device as
Device<Normal>; Bound is a zero-sized type-state marker that does not
affect thread safety.

This is needed for drivers to store &'bound usb::Device<Bound> in their HRT
private data while remaining Send.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/usb.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 9b9d3ae41087..442e456fd2d3 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -467,6 +467,10 @@ unsafe impl Send for Device {}
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

