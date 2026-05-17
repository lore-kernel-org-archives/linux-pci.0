Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235091397;
	Sun, 17 May 2026 00:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976159; cv=none; b=BS+NpRXnejVU4k21H2lEr6O8gQIL/VaHi0CH9aLpjqk6NP3YRfBqFaRLYS5kcKRMQ87v7pbhesY6igbywMYRY8sx5DCeh6FXS1zDJfROCieamYp739IGi8JHuxQ08onOWQLIvi5p/EmvMCSKYw0fng3IiHV2WYe4eko8ElUQ37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976159; c=relaxed/simple;
	bh=thZLruCPSaROEe6IzJj9ZMFO1gnnVjj8Zyz2NwmRVyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiL9ALybstOjd2ZZenmzcl9XyKeFQ33GOgQ2avLf1Sn/zvqns3qG9U9wSNAj/U9gzdK/a3PQ4aQm+6vyxASmMLJtxfmb3wKU2gkFNcV2vWYR9IiTZbR30yAxmQuuDHG+r9jok7kYz6CcY9fbXmkG9LOrANdIGKKHPDGISHyYoZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF+bC/vD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF+bC/vD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68435C2BCC9;
	Sun, 17 May 2026 00:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976158;
	bh=thZLruCPSaROEe6IzJj9ZMFO1gnnVjj8Zyz2NwmRVyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fF+bC/vDs3AvLgPCt2CDg4WxoOW7JSKP3CFOmWFUnEecHXdgc7rBTDqf6hW2DEg7Z
	 SGx66WRKIo4bWIUZRT4f9l8XWYLLfOh1KJPbpEmAT0aiJ2pBKc0YNu2EzjnYT21VNV
	 UHRL6qQ9KmEVesC4/TzjHxBL//VAujQVYKpFi2ztrfM5QQeuNOKV7FThR1N4OKy99O
	 AXx+JKz2DxumUVVMFgwxJUK9V+r71xfvgZZbGuelNTr+77A+zprDbFFBzkPpKr04g5
	 YigUGXgKqPj8Ymrv3VQGuPd+UNd7dkqvJdtAluejdkFQVJY7IEHz20qkbvmjmQNITv
	 JvyUJe2eV+62A==
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
Subject: [PATCH v3 05/27] rust: pci: implement Sync for Device<Bound>
Date: Sun, 17 May 2026 02:00:53 +0200
Message-ID: <20260517000149.3226762-6-dakr@kernel.org>
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

Device<Bound> uses the same underlying struct pci_dev as Device<Normal>;
Bound is a zero-sized type-state marker that does not affect thread
safety.

This is needed for drivers to store &'bound pci::Device<Bound> in their
private data while remaining Send.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index ffaf05bf9aaa..c06ac3fb2a64 100644
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

