Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026139C645;
	Sun, 14 Jun 2026 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781452806; cv=none; b=udlkKyJahTPks3pcCaqPcYHzgSUxBZyfL0mvKP340qE30QMMqrTGzcFjDUvIkIbKmQ+tlxPuNzqdd+wb4OQbn7QFNl1s6m0dvGI/CLAYW61KU8iOVhTWPuU8Ux6jh39/rhw/5mO4R3dYopKOBnR7bPDnlZG296DCva8eRGnS0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781452806; c=relaxed/simple;
	bh=h0XchsrNntgeeOKFQsJYEfkDx2B8XkHXEdO9BYyg5o4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WQY66/yei/ldQHkj1WZufeZgTFVw3biqkFFugDl4LoJk8OiwZA3ymLT8BRNCdbFwu56vEfu6/SUOQofcIIm0YRxGg7pRuhC6RKgFUDls6aTZyr6XPWo/QUTbhcmAIumHfg9BSyTRW7z1MYv2nUXYbR3WSkIvulNfe70FK4sOSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=I2NvN7Dx; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kllb2TPx; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I2NvN7Dx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kllb2TPx"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gddHb4WyGz9tdq;
	Sun, 14 Jun 2026 17:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781452795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yYbTPQ7Bbcr9EI3+l9tprIrCcyJs2hx7YOxqS8pGLWs=;
	b=I2NvN7DxyrJoddCOb6ll5ubxLVpQ/trEwhJ5FAUwbpbJIPcJUOvuBDyw0f8sccmnHbwh0q
	BhKDfVT7JJRNQrCuzFv1r57PZkPUmgu8gelk/2gkEztAGL4OqLl3KbTFs6yArlV41MvBCE
	OH4TpZAZys9wrdvPJHJ/VK9YpOKmVoTkgpDvwVici/ddzVccLIpFQyOYXENgjfBeSghHf8
	LnwMdKlTd02IDDfxTPqXuM20rhl8F3o25AfqZO6k9vEVc0K/Zb6nFcqROQa5A/b+Ez7TER
	aXx93efr7SQ7ZBTHi3XXZ+argzgcrQDP9AgQc7ilFMx/DdN3ocxpbx/vjF5Llw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=kllb2TPx;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781452794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yYbTPQ7Bbcr9EI3+l9tprIrCcyJs2hx7YOxqS8pGLWs=;
	b=kllb2TPxqe8O5dNwx60q0uyzN/QKtHFrktRO9NTylAF685W79G/YTTnYau6hR/Q47eiNIX
	HXxbU0dzi7XTmZlMcZvTt02hCX7Q/yjn5ow0ZP+gDco5U5LzWzUgSzbfZ6LYHEqmrXDWSp
	p19LQc7B8RJE6Xk6C3kVam/yyp1k9eCuwmGJQh9W2Vbqv9g9F+oneklS8IspFYQGySDqCI
	gr1LgXEW58kpWdUcdcrK85i/HCharjZ6O4ndGUbWvT8tRvIUfcbszbdH7adpZFqHLF3jAL
	D6GaKAHl7vFVSWelfEXuU/gxeEzyHONOJOwfor0lT+sIRTNm9QMJOR25vu2RNg==
Subject: [PATCH 0/4] rust: samples: add an EDU PCI driver sample (MMIO +
 IRQ + DMA)
Date: Sun, 14 Jun 2026 17:59:44 +0200
Message-Id: <20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0auUzAZq1Q5eRRysSTWLSmpFEO9uc
 XzD/w8kVuEEvXlA+ZIk+1ZQVwbmddoWRqFicNZ56+sWQ4ua04nHLMiUkVQuVmy4sxQc0WQjlPh
 QjnL/42F83w/7DJQyaAAAAA==
X-Change-ID: 20260614-b4-rust-pci-edu-driver-3e50db2dda0f
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781452788; l=2066;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=h0XchsrNntgeeOKFQsJYEfkDx2B8XkHXEdO9BYyg5o4=;
 b=Pv01hfvOFrzwhCjah/sTOHJi8zx1wZc+Q94Am6U79tyP8DKnbVdQukpbiGKu7vdCsrw3L7WB9
 rLqAe39dxWpC0yzWXcwKXA/35ig6KuDPcPzIS4DRu6dNs7TONPrPLi0
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: 9opu7kztk91ktxnrgjr4q7by67j6e6wy
X-MBO-RS-ID: fb5a892fe783984d2d2
X-Rspamd-Queue-Id: 4gddHb4WyGz9tdq

The Rust sample drivers currently exercise PCI facilities in isolation:
rust_driver_pci covers MMIO and rust_dma covers DMA, but there is no
single in-tree example that combines memory-mapped I/O, interrupts and
DMA in one driver.

This series adds one. It targets QEMU's `edu` device -- a small,
well-documented educational PCI device that supports exactly these three
facilities and ships with any recent QEMU (`-device edu`), so the sample
runs without special hardware.

The sample maps BAR0 and runs a set of MMIO self-tests (identification,
liveness, factorial), allocates an MSI vector and registers an IRQ
handler, and performs a DMA round-trip -- each stage waiting on a
Completion that the IRQ handler signals.

Prerequisites, that had to be implemented:

- pci: make Vendor::from_raw() public, so a driver can match a device
  whose vendor ID has no symbolic name in pci_ids.h (QEMU's 0x1234),
  matching what C drivers already do.
- pci: add a managed enable_device() wrapping pcim_enable_device(), so
  the enable count stays balanced across unbind/rebind.
- completion: add complete(), so a single Completion can be reused to
  wait for consecutive events (e.g. back-to-back DMA transfers).

Tested with QEMU `-device edu`;

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
Maurice Hieronymus (4):
      rust: pci: make Vendor::from_raw() public
      rust: pci: add managed Device::enable_device()
      rust: completion: add complete()
      rust: samples: add EDU PCI driver sample

 rust/kernel/pci.rs              |  16 ++
 rust/kernel/pci/id.rs           |   2 +-
 rust/kernel/sync/completion.rs  |  14 ++
 samples/rust/Kconfig            |  11 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_edu.rs | 379 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 422 insertions(+), 1 deletion(-)
---
base-commit: 48b375e482027ba6566107cec40c1b21b453fa4e
change-id: 20260614-b4-rust-pci-edu-driver-3e50db2dda0f

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>

