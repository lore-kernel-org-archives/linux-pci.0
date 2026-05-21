Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720236B048;
	Thu, 21 May 2026 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406795; cv=none; b=cWCQNLKG5oZk1Xf6KCEfefc/einlG9FgJYcVA0QAOUqAwtV6Qbm1ZgK44O3RIBfRJYWrSttIt7oGr0rtbTdULgTeoteqcmYZVKdRvR+6awBlcIVeC9mKB/m68Y6aOXX3n7AFzmohFayoE6lgo6tI681AyOgKu9N5apC+afXgAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406795; c=relaxed/simple;
	bh=hna61WJP0RDs57bd7mfxmd4QbdnJ1KjrGXp6F69Aw3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDe1sOH/mx7OgAsFEv+6OI5w6GBfshddF9lffdyaJGu0AUiru2xERgTXkNBkRzstniLG3zJyFKxTuLtZSnGVGJWINoTIhe5Ye3LxPxP2uRKACYfxTdFWaH29qME90Y+UbvCtYuWT/L7Pefbi5mrBMcuCQ9VK3rHKNq++6K0ZhIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4T/GfN/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4T/GfN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57BC1F000E9;
	Thu, 21 May 2026 23:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406794;
	bh=OzXy2w5PU87H6eEYeVna3xlZ4hqBInN6XC1Tl8qUBhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E4T/GfN/f+kR6XhUcjg+MHAVda0eVSfgw/EN08wOOSCdVo+vuOuvK8aT3NOZYZFvM
	 QJ7GGYCTexmXpY42uhRXiZBMwYzaMlQoq3wGTGqs6wUjDMvv5D2Gt0wUKYQebx2lKk
	 eVljZW+UZkJW5xn063yrlLF+wRVGrQBi68+ib5dBEA2abmJBQ6/Txbr04ZNKTQMC2Z
	 CACaX8f9Xv+PmtR84JjFP2DrNxmGRsrMgJg00nMx90Kzv26+txTxyAy9qqgLtr2gIp
	 TipSCDNOIIH19V8asPoqGxdcKn6DmwbqY1Z7v5xFKKoS4/v0q2kMnRljjPVzuPvNgv
	 l5qiHIKvou2Nw==
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
Subject: [PATCH v4 05/27] rust: pci: implement Sync for Device<Bound>
Date: Fri, 22 May 2026 01:34:31 +0200
Message-ID: <20260521233501.1191842-6-dakr@kernel.org>
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

Device<Bound> uses the same underlying struct pci_dev as Device<Normal>;
Bound is a zero-sized type-state marker that does not affect thread
safety.

This is needed for drivers to store &'bound pci::Device<Bound> in their
private data while remaining Send.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index c743f2abb62f..d214a861375d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -528,3 +528,7 @@ unsafe impl Send for Device {}
 // SAFETY: `Device` can be shared among threads because all methods of `Device`
 // (i.e. `Device<Normal>) are thread safe.
 unsafe impl Sync for Device {}
+
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct pci_dev` is the same;
+// `Bound` is a zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<device::Bound> {}
-- 
2.54.0

