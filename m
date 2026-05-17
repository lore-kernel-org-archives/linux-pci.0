Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EF913D539;
	Sun, 17 May 2026 00:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976186; cv=none; b=s92lufAA4643GzyMOOIcYDHAttmjQTDiN1PhYfOMdh+KLF/ZxJo2Rbp1MnUMsHeCsJe3ax+ODcnHlIVw+7xtJ8EtkGuKrD65fq9v3tY97iBFxkE86PTEqT4PSJsk25UWpD6xvsmU5JBG5G3ieoiR6CF/TvuaKvloiMiaUFLWxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976186; c=relaxed/simple;
	bh=jphP3iS4bUVeKEZrR/3bcGO0WxPTi/VkZDmtfppmxw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNGNHJoYAOHYCrRCD0CzpcUz7uSTJ/ijyRokuavcn5EZ0RuSbMlXbIvB9Ced+phMi7UqhPX/rxBhsQO2KVfiyKtoYdAm8LvbftOxnbp4tbaK8Bz3L2wdIkZRP0JW1fMuy0CnODZtTKKB2DiJmOlflsbVPKyggQ9R2YkOB5ffRh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3LjH1YK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3LjH1YK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9543CC2BCB7;
	Sun, 17 May 2026 00:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976186;
	bh=jphP3iS4bUVeKEZrR/3bcGO0WxPTi/VkZDmtfppmxw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G3LjH1YKfqYP+sOnxZ+AGkVNcJmO0PNV6BhZPOqXy+S0X7U8h3Dd6MReAXOAksZ5L
	 NgE/OwWsPNSC8F/jAhyNRCL3/XslzGQpf4Tu3ICjUYDaQDPAW/3g3zKblScaqyz25P
	 eEN/LRIP70aW0O5c2R473huuAWbF7B7UiFi9vAs1su/+BD0v7rgD4zidNVG9k7cON5
	 byrAM0it+O6PnIT1OXWs0FyGym3pSkddsITbmtRNPiAtYceVwRpNgBB6Uu47lphhVc
	 ev6mDRsgr7AAK6QwpcL0IBjWfLX2+zvqbYJ0Yy6BH6YiLiYxC1m7VDlLNkrnCc8bS/
	 Lb08GJfIzHPMw==
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
Subject: [PATCH v3 09/27] rust: device: implement Sync for Device<Bound>
Date: Sun, 17 May 2026 02:00:57 +0200
Message-ID: <20260517000149.3226762-10-dakr@kernel.org>
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

Device<Bound> uses the same underlying struct device as Device<Normal>;
Bound is a zero-sized type-state marker that does not affect thread
safety.

This is needed for types that hold &'bound Device<Bound>, such as
io::mem::IoMem, to be Send.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 5df8fa108a52..c4486f4b8c40 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -467,6 +467,10 @@ unsafe impl Send for Device {}
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

