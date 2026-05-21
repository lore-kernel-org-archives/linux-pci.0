Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B82372684;
	Thu, 21 May 2026 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406807; cv=none; b=U0XUF/KoIZb3YDxpTnCRSiUvKcv+p+ZQdIOjH5BSQh6RJJHSqZwgRq91YjuUmKoqwDEfe8cVIaSG57HUIJFdD1m2whVbUvFe+EI60e6PTE4gKT1qLSeoVzBkSUIrr66YnmQ0jZdXAWU9j/ezqNU6qChlLlOu41Dx9CcVZFhs9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406807; c=relaxed/simple;
	bh=6bmHwQfqzUdZCNWXIzrI0o/hWjRhRCEEbytqokdPs9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHrQDaWJu8LMwzUPJiQJe5182fCD54czoJldfKAeT72YJuOgaOdFy/VETazAlWCBeja5WFknA4xhH5rpqKIy6t03SXFZsyDQZeWwAi0pYNFcxrd2QZ+TMojCGX617GpG8wwnH6WfyO6s8uSwy6fScyLDOIM5q28+v7nGhCw4D+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3Mxnpbc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3Mxnpbc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B64C1F00A3B;
	Thu, 21 May 2026 23:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406800;
	bh=DC62fw7JzD1U4MkR4ipXU/wF9jbNm3QIotQzvyRxdaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h3MxnpbcG3xWduuC6xAGxuv0HSg4TkMTQ0SebM/4Ct1eDr9HphgDjzdiW4noIVcuM
	 jN8NuHh1qYeeS873aE8AUQelobDdVW+U85QqhRPXwN+3CkcHySG9PtRLQDAfcQEyX3
	 KQTccLlRMvyqUobI9HpVPtbl09hOHaEOvzIxNzfzfGqN9R0OtnYPffvXUIeUbQlWX6
	 mNFuHmRtC1hJvuvdkka6Bi1BBHcAPM8T4PA0ICjFD4XyEZANQOi4OdsocvDIveO9mr
	 XpbctJ2g1SeV9akfJ6O8SLDR34Xkre5OhKOE893j5q6O+VFsSzXwPjcIDd/HoZqT0M
	 haHASIf1W8Ayw==
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
Subject: [PATCH v4 06/27] rust: platform: implement Sync for Device<Bound>
Date: Fri, 22 May 2026 01:34:32 +0200
Message-ID: <20260521233501.1191842-7-dakr@kernel.org>
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

Device<Bound> uses the same underlying struct platform_device as
Device<Normal>; Bound is a zero-sized type-state marker that does not
affect thread safety.

This is needed for drivers to store &'bound platform::Device<Bound> in
their private data while remaining Send.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 975b22ffe5db..106a5ed57ea6 100644
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

