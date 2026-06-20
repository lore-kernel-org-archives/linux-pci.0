Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6B134CCF;
	Sat, 20 Jun 2026 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781945176; cv=none; b=KXsvnqgMKDYsdGW8tMmllD2ZYyBIoq6ouTh9UaYhOoKJ5cB1/FbjimVdNyjDDWNZBfABajj6Itdgak4yWUvbEKnY8FbMm/1m0bXqBhmGDv7bTk9elVEPeY4GtJ2CsMZkbBgr1PIQqW5y9zPmWjzOc+kC6vgqn8S460I6JyMsyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781945176; c=relaxed/simple;
	bh=6nqss1l3ev/3sit74VdIkM5GGxRFuIkOx4jO20kcGXQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V5ZMnsEc1sSIcXHLUPPp3mfuo8BOequjP39al4bqUuYQjngv0oGe/AH9gjwPVXRb3q/fbDQs8phMT/kC/FSl9iGIgZWlejkTXBf/9wpw1AznntR3a7+SvF2DuOpb1N/0KyQlfge4mj0cPuM1XPOHOCEargYg5xwClgZE5buribo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BfCWXyc7; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JUDzEuLL; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BfCWXyc7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JUDzEuLL"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gj7NG3T26z9v2T;
	Sat, 20 Jun 2026 10:46:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781945166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h1QJ9Equc8tKbbmFENVxpXzmHN1NGTj2yMDa2jezDJs=;
	b=BfCWXyc7g2ku8hG2saMGfNDRXAG82usX/+lbJnEXW4y5IY0fHM+/o9vORVt7i876W8zURc
	mx5YzEEhA89GyAIf+LTDurBjwNTSK5SGbw1XYZFqN7985qScglE89pUX5N0SPqFUNogXZg
	SJAvHkW/CZyZ0vn76nEUIcv+FnL5dNwY9p/A/Og0d6RXPHQ2S6RZlgLD5PUSRi7ON7+jnc
	FDj50LU8DJ31wUod8o6/GjCao8sdHFkaGGIv3SIgTcD55YBa7dI5May0qvQ9WmJ6wgezQR
	pQB73+UtDGQrHd0YwVFEx6JABKnorQ38vOw0N6DhiAZZ0PRRqn3KYIbLwsZpWg==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781945164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h1QJ9Equc8tKbbmFENVxpXzmHN1NGTj2yMDa2jezDJs=;
	b=JUDzEuLLz1wTgmmNeBJcILDhbQhHf6MkJiBiB9LCRnYCLekV8U9/6LJ/BM8a4sINdBAhZL
	52TeGLHCEgfQfA3UD+RmfbrnOVi9abSydJF4oTl6h59T7cNJ2J44Q1vm51RzFGlpFrvEwU
	KplxtUXmqoIZXEnpWV5HvR5KPRXcsCkBKvUtllGCdnkm1osMUaFtjNIilulSxpH0jE/W7B
	4NVGNLlvyQCZD8PZOxPaQtfUxdbt3Ux3sUNaJ3a4RYOZq/eo2Yn7wMaduGMdOk89/9epEf
	m1zEGg4y9HLlFeC2I1Oz2rtntClkF8BSKax2UWnYyFpYsteHv0qIJ5bOqeUROQ==
Subject: [PATCH v2 0/4] rust: samples: add an EDU PCI driver sample (MMIO +
 IRQ + DMA)
Date: Sat, 20 Jun 2026 10:45:44 +0200
Message-Id: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr0Jm7Zi2/BhdcQ/DgtIBJlFKptBgC
 He3cgGX7yXf+3YIJEwBHtkOQpED+ymBuWTQje00ELJLDEaZSlW6QFugrGHBuWMkt6ITjiSYU6m
 cNc61qoc0noV63s7ws0k8cli8fM6fqH/2bzJqVEh5b4qbtuW97Op3yy/rt6uXAZrjOL5MFH+Pv
 gAAAA==
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
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>, 
 Fiona Behrens <me@kloenk.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781945156; l=3166;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=6nqss1l3ev/3sit74VdIkM5GGxRFuIkOx4jO20kcGXQ=;
 b=Z1+a2WYdroe4SSxG9vELsGNKCTh3iyRc76+xkr/1u+BfCB9u7d76W00yh3CmrlA1VgaHMnNXg
 slH7FnxyNoADk8e8PGGEjGOnVNdUAlaUCP/EBeL6p3BE0uTTgHXYWFc
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: q3iy5gocqgjbsk5t7cs4aaq4b7ttmwaa
X-MBO-RS-ID: 736fa75921dc2ac4960

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
Changes in v2:
- pci: Vendor::from_raw(): collected Reviewed-by from Gary Guo;
  wrapped code identifiers in the commit message in backticks (Gary).
- pci: enable_device(): collected Reviewed-by from Fiona Behrens;
  made enable_device_mem() #[inline] and added a cross-reference to
  enable_device() in its docs (Fiona).
- completion: complete(): tightened the doc comment per Gary's review
  (emphasise "single", drop the internal-counter detail, drop the
  complete_all comparison).
- samples/edu: take &EduDriverData instead of &Arc<EduDriverData> in
  init()/test_irq()/test_dma() (Ewan Chorynski).
- samples/edu: simplify wait_until_compute_has_finished() to forward
  read_poll_timeout()'s error via inspect_err() instead of returning a
  hard-coded ETIMEDOUT (Ewan Chorynski / Miguel Ojeda).
- samples/edu: Rebased on rust/rust-next and adapt to the updated
  pci::Bar / device::Core lifetimes and pci::Driver::Data<'bound>, and
  obtain the BAR via into_devres().
- Link to v1: https://lore.kernel.org/r/20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org

---
Maurice Hieronymus (4):
      rust: pci: make Vendor::from_raw() public
      rust: pci: add managed Device::enable_device()
      rust: completion: add complete()
      rust: samples: add EDU PCI driver sample

 rust/kernel/pci.rs              |  16 ++
 rust/kernel/pci/id.rs           |   2 +-
 rust/kernel/sync/completion.rs  |  11 ++
 samples/rust/Kconfig            |  11 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_edu.rs | 378 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 418 insertions(+), 1 deletion(-)
---
base-commit: 43a393185e33e573a374c1d4f7ddf6481484ef8d
change-id: 20260614-b4-rust-pci-edu-driver-3e50db2dda0f

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>

