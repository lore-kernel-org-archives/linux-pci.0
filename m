Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49906374758;
	Thu, 21 May 2026 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406820; cv=none; b=gckiegH18+9qcJBKBc4oo0jXdzqZEAGbJB0CxYFmoJ20+g3gDi69duKoZX4iiGuN7lYwO4TPd7BxBzvl/fa0Ski3vJl4TmUZaZBAxVboiMp/Kx4Y/qLKp0Ke3xKjeLpoasz7NIsMDWQnNsTfV4wdOFC7WP7qaTNMH7XGLa2y3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406820; c=relaxed/simple;
	bh=qTF5Y6aKb7spGXK8meoI5pO/KT/AWjwpH/fzWjglAfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niMprz7aQrMmUJ9VI1aNi/SHBR4kLwVv0AOi1TO1wKJQBcTHXou47BnzPU8JtuiO1t5iA4aaz3+iESoG1u58hR18GMJ5vLsqhv3a3OD+3sGLVHm0+T9odF1mw/oAbOkf9Beyz+kcAhylLLBSVfxiSZuFp58cqZxhhevT48W36ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7zjIvWd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7zjIvWd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6971F00A3B;
	Thu, 21 May 2026 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406814;
	bh=ggJY/UJJUIurxIjGS19alaA47Bxd3KuWm+WJgDSyvC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k7zjIvWd+VGBCSOvUB86+/MHTdB2856fFXG9wO030mFsM1A99tCNEpFMmgGcwOrvH
	 44r/pHNRp4ruC80cSDkePGveT0NqDmh9OpQX8RZIZpcYZBdNm+or0xOOV+3rE5DNDG
	 OU2uCgfW6CbzJ9fE4j5B4MvUIXwnybq1UuUTSxYPMMKfpuo/VZ+En/8NqHGoFpPVW+
	 UPsh+gVmNckJtDgAG0TRJjEXGdFbRhK6NOFyZnQzI44MA5tgIXZ1S5dme7t8d4NM1O
	 fJqAY43w5dpLjN55VwUndsv0L91SXR0De/zlc8GczmH70e27kit8z3drjWx51VnZmF
	 GeTUTOjroaKLw==
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
Subject: [PATCH v4 08/27] rust: usb: implement Sync for Device<Bound>
Date: Fri, 22 May 2026 01:34:34 +0200
Message-ID: <20260521233501.1191842-9-dakr@kernel.org>
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

Device<Bound> uses the same underlying struct usb_device as
Device<Normal>; Bound is a zero-sized type-state marker that does not
affect thread safety.

This is needed for drivers to store &'bound usb::Device<Bound> in their
private data while remaining Send.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
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

