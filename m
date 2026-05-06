Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03C63B3C13;
	Wed,  6 May 2026 21:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104316; cv=none; b=fh/3DlWMFir0MYMZHub11J98WaNs1xgHdXv3/RAqVlJLyiFBHUjZSQS0c3KlpiHQMwdlUa8v1qfI1OCbF7iv5LMcHzCKZlxsKVNtCZqxZU7AEoiDZnjKIwvks2bUwpVPmvb/v4cqvpit4JZsz6un2z/GZ81MKe/mYd2ANQKM3Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104316; c=relaxed/simple;
	bh=OBpeRj6FSTcG0AEEiVV2B733gMqON0DFwTtw26epeTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLL2Ff3Fv9YbJ2wQo1YmfERjqnfodnwTWiVc7BiDAToN+KAN1kDO3XPtRiDJJZsDfCL/QKqi+WmCzzrlmrSlxcbMI705HnuaEoN4urWXFEgLzsGgjZ5C7O33QWgcePpOmE7kcPyo9oXfG7Xq9hx2dv2lJYxrixd7T2eBNcTR3KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsPl84A+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsPl84A+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BD3C2BCB0;
	Wed,  6 May 2026 21:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104315;
	bh=OBpeRj6FSTcG0AEEiVV2B733gMqON0DFwTtw26epeTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NsPl84A+sPG+5pSao2NU0zfqqTmAskgxFwvco5wPX8g1hdsrAIhdIZFydxZvzbmXp
	 PPR/X1+L5kw+P3BUTYfTQTRdeEsGV7thr/LDuOvuuZtBhKdLXWUea5JE+sUBzM8fKW
	 2oLOFbwA6aXmjbwvP826WGjsTx1xCW6RyVGqa3gIUJI7pKQkGhiApGu7eRWm8JfGdz
	 P7VxvjUPlZqISuuIP+AL/4diFomVLO+Kgw2z4QKIq7sw1HTuwQtbfBzvwEKOu5ix7n
	 nZZf8ccb3hLa9fVEXXUPZTWR4EBspkD49TbXMTlwqau3SCEQxl1GSxLQZZY1zM/5z5
	 tNu6QgCmlqRPA==
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
Subject: [PATCH v2 05/25] rust: pci: implement Sync for Device<Bound>
Date: Wed,  6 May 2026 23:50:41 +0200
Message-ID: <20260506215113.851360-6-dakr@kernel.org>
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

Implement Sync for Device<Bound> in addition to Device<Normal>. The
underlying struct pci_dev is the same; Bound is a zero-sized type-state
marker that does not affect thread safety.

This is needed for pci::Bar to hold &'bound Device<Bound> (required for
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

