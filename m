Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A283B47C1;
	Wed,  6 May 2026 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104322; cv=none; b=F28bhgMT4/h7w99WUafezYVaieCi9/pxPkzY4tcDbogoaIVEDiyRi6Hid9P5mBl7HVKt8+gGLCkQWOBJV9nnAu0D14Natuo9fpwB67BUN2F7IefYqcFfBsAWAqlMx+rwCDg+kjoE64XKTEOQV54J26AKygUQ7cvEdtxnCeavb0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104322; c=relaxed/simple;
	bh=QpY7OeVzdag9i3s1zOXGyUJCcDhM97iVsWF8/eXysoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFXkbG9XZr7f8G8rSVpon74NLwb8Pm3iaLdUV54cR20XFhvI7G/y2wzkT+lruVV6pNfzh19daHzpxkqaUQei21Q8rfI26XgqkGeqQ6CUDEuD2eP0CdciZhlq0lqV8jR2scVRUZCkhcxZzsOiuV+KMgoyvzFxhv/OA90pwWjkkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzKG5z+l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzKG5z+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073C9C2BCB2;
	Wed,  6 May 2026 21:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104322;
	bh=QpY7OeVzdag9i3s1zOXGyUJCcDhM97iVsWF8/eXysoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzKG5z+l99CxfwRBalOq5RgpE7Kw8jLaOSMQ4Wnr150LD7wUyxnH7TaDhUPmckLRH
	 cayED4QHWEkfYgPB3MPt3uOtPlSTAoF9KuPByKpr34thsdjPAZJ9F8J7S1yfkJ/YwD
	 rDfSaSaoV5M6I1JodfESH8b1njNPE515MU9y8+kboGEcOrTTErBn0eA66NN1ZI3xlP
	 M3C89VzSYUVwc1NMH+RSxor1SQFZBww8uWMNFQPgTntbxw5s/uO8UbV2BuEOGZt0Ta
	 ZE8t4MvpK2Snzp6e5k9cJhxZqN2c6Ue8lijOkcCHIvm4NODpmTn/eAiPJqJa4K/Re2
	 vKIn3jrgQ7oyw==
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
Subject: [PATCH v2 06/25] rust: platform: implement Sync for Device<Bound>
Date: Wed,  6 May 2026 23:50:42 +0200
Message-ID: <20260506215113.851360-7-dakr@kernel.org>
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

Device<Bound> uses the same underlying struct platform_device as
Device<Normal>; Bound is a zero-sized type-state marker that does not
affect thread safety.

This is needed for drivers to store &'bound platform::Device<Bound> in
their HRT private data while remaining Send.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 506731a648c2..aec26307ae68 100644
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

