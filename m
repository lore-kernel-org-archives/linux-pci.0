Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03236F42B;
	Thu, 13 Aug 2026 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639963; cv=none; b=rwzpeRH19ERlaq894PCDUtFyX3bPNuQj9zyCu318iEzJw7XJkU5ps2ror7/dAphPi6Cc5J27HWTTv+F3dM/lkqyqwphRneGy6G6LlbG6WkGDiKKvrsNap22rVtUPIsnzWP1WPFAoBiM4/vcwZqG7ARkyxjLUBeqJ6ij2nFc7R+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639963; c=relaxed/simple;
	bh=CMRwenPPHG5s/s4lQ1kLE+DrH2Ae3pwj0zbvd34pDsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPm257q9F7D2t8+e7o7dvUTjXfXBmo+zm7p3Dz06OzmpTya+BhFL8UyH7shy7RO/Mo/N1cpKETPB/UBlm+0vYdwdcJ0zd+BerHnxc6utfoX3NrZxhL94Lh56fVQ6a7ia0Kgmk46y31zmWex/0WW9o8/ksfoYK6pyD/xUC73Vl8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKegMg41; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKegMg41"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D070F1F00A3A;
	Thu, 13 Aug 2026 16:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786639961;
	bh=9UoMXfNqpfbPZJjz2tRZKqItuKXiJcFvw6QDoHD+Yjs=;
	h=From:To:Cc:Subject:Date;
	b=cKegMg41v1uK+BSh2UVVCQwbR6hGIw3ixoFwWNU6X/SL/8TtvZDpAT//UiEU9VAcz
	 QSv6Bqk3OXXMwzRC/M8+D23eInRDByG2UY0wUv1U6+n9AUN8FnaPcrMigcHaUebO1T
	 xcDvyibPWMFxcmtfYpzcZdBOZifvVoZq5MOb5EfKllKZ7x7NQlV5lexmJMbV0Ha2jw
	 2BDa8P2chPMn2qO6K1jiGVEjBf0lFxWkoqNIorRtCf1cUBhNcbg7TpFbiXPXSLoJcx
	 hP57NN3dPaq5cFcBEYYH95sn3TRpUyDWrPm+cNky09m70v1L71pTXtUy6eKg3B39ux
	 /mQ/SsNd5TnvQ==
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
Subject: [PATCH v3 0/5] Rework PCI IRQ vector code
Date: Thu, 13 Aug 2026 18:52:00 +0200
Message-ID: <20260813165234.620555-1-dakr@kernel.org>
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
devres-based approach. Since index() borrows the registration, the returned
IrqVector inherits that lifetime, preventing the allocation from being dropped
while any handler is live.

IrqVector embeds a resolved IrqRequest, making the conversion infallible. The
request_irq()/request_threaded_irq() wrappers on Device are removed since their
&self receiver could refer to an unrelated device.

Add pci_irq_type() as a C function in include/linux/pci.h, replacing open-coded
checks across drivers [2], and wrap it for Rust.

[1] https://lore.kernel.org/all/20260808031120.363869-1-jhubbard@nvidia.com/
[2] https://elixir.bootlin.com/linux/v7.1/source/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c#L196

Changes in v3:
  - Rename s/count/len/, s/vector()/index()/, s/vector_count()/len()/.
  - Remove redundant range check in index().
  - Add missing #[inline].

Changes in v2:
  - Drop the IrqRequestAnchor approach and keep IrqVector as a new type over
    IrqRequest.

Danilo Krummrich (5):
  rust: pci: convert IrqVectorRegistration to a lifetime-managed owning
    type
  rust: pci: resolve IRQ in index() and embed IrqRequest in IrqVector
  rust: pci: remove request_irq() and request_threaded_irq() from Device
  PCI: Add pci_irq_type() to query the allocated interrupt type
  rust: pci: expose the allocated interrupt type

 include/linux/pci.h    |  25 +++++
 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   3 +-
 rust/kernel/pci/irq.rs | 220 ++++++++++++++++++-----------------------
 4 files changed, 128 insertions(+), 125 deletions(-)


base-commit: dbaafe9cc56a996931eedfe043eb34418cc9cd9b
-- 
2.55.0

