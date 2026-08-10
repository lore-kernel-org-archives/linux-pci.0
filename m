Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902D3B52EB;
	Mon, 10 Aug 2026 22:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402197; cv=none; b=aKe1ta9i668XaXegG53+HxbHIKr/KDq2EnfT69EyTDEa0K4ZEj+yCk9mjpme6UoSefVBzwexmi5Kj/99mVw3PCkst4n9cb8g8EWD21wfpNpBV0wcrpGpiAVS9VrROFGvpA3Ztm6SvL3+jfX7wG7t1NRbeena4es4zdR5xpuZ5lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402197; c=relaxed/simple;
	bh=qklzyVeFLzY89YHoQjgLx4uqlsPSD4D0yWGgPKRoPFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKYs150kGzn3ssX6SbPXeI2Spte4T9YJu6yMO8f03IMSTdNUBoB2SJvQYm0E8CKVSyAouB49fleZhamnbncV6MNPAjMC3jmoSZdYGKRFSqMOW3B/HRsq+GTZYTXdGI/SedZHZIIT5cjfMO8UURiITAW4jp8tOjhKjde/UdRzgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqdv8zin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqdv8zin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615F11F000E9;
	Mon, 10 Aug 2026 22:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786402195;
	bh=eeJrdRxXUrqpHD49pSukjrdxkEgjUundKC5UAdKXAy8=;
	h=From:To:Cc:Subject:Date;
	b=fqdv8zinO9JBx0MtGWKIeZGmJK8q1aHWtK1Tw4cnufqyp+Uz8YTbEDy+pjzwbtvMZ
	 KBN409OO+IAj53t+XoeBvUVbEWSmT5ht1Bb2P68FcUxOKR8h0gLD1OkUQt2N0x8zCn
	 a7IhCKvOJkSUmpEsQ8IH7tbJLrnq1+KSgpKJ4up4NS4HRL0cAC3jxYSlyQgPITaLCc
	 5LxNbEPcY498PR/pz0zPNPWn75OF69UrbUEpXMArx5DtjBFcWBXecu3gDGamWHFCQX
	 eyKJqZNBXf7hux+MUHzVmz/t+V6Xm3jhWAhDYpgxLCodqa8b+onAl+/eYS6gPyPoMu
	 wlvxqmUkdYnag==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	dakr@kernel.org,
	kwilczynski@kernel.org,
	aliceryhl@google.com,
	daniel.almeida@collabora.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	jhubbard@nvidia.com,
	ttabi@nvidia.com,
	apopple@nvidia.com,
	ecourtney@nvidia.com,
	shashanks@nvidia.com,
	zhiw@nvidia.com
Cc: driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Rework PCI IRQ vector code
Date: Tue, 11 Aug 2026 00:47:39 +0200
Message-ID: <20260810224800.2314458-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series reworks the Rust PCI interrupt vector abstractions, motivated by
review feedback on the nova-core interrupt support series [1].

Convert IrqVectorRegistration to a lifetime-managed owning type, replacing the
devres-based approach. Add an anchor generic on IrqRequest and irq::Registration
to create a borrow chain that prevents the vector allocation from being dropped
while any IRQ handler is still registered.

Remove IrqVector; resolve a vector index to an IrqRequest directly via
IrqVectorRegistration::request().

Add pci_irq_type() as a C function in include/linux/pci.h, replacing open-coded
checks across drivers [2], and wrap it for Rust.

[1] https://lore.kernel.org/all/20260808031120.363869-1-jhubbard@nvidia.com/
[2] https://elixir.bootlin.com/linux/v7.1/source/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c#L196

Danilo Krummrich (5):
  rust: irq: add anchor generic to IrqRequest and Registration
  rust: pci: convert IrqVectorRegistration to a lifetime-managed owning
    type
  rust: pci: remove IrqVector and resolve IrqRequest directly
  PCI: add pci_irq_type() to query the allocated interrupt type
  rust: pci: expose the allocated interrupt type

 include/linux/pci.h        |  25 +++++
 rust/helpers/pci.c         |   5 +
 rust/kernel/irq.rs         |  10 +-
 rust/kernel/irq/request.rs |  86 +++++++++++----
 rust/kernel/pci.rs         |   2 +-
 rust/kernel/pci/irq.rs     | 213 ++++++++++++++-----------------------
 6 files changed, 182 insertions(+), 159 deletions(-)


base-commit: dbaafe9cc56a996931eedfe043eb34418cc9cd9b
-- 
2.55.0

