Received: from mail-108-mta59.mxroute.com (mail-108-mta59.mxroute.com [136.175.108.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087A33D4FB
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793346; cv=none; b=FUxqNemgYqGw410ydzv6e784EECnsaiwQemBMys1nPzPIEREq+g5s18tJtSO8DpPgcOsMIgZl3uUStAZxPPiKf1tYddHGKb6BPbzacGrgcZWzdg20RYa48edqxVmTcKiOu8PmRgdk9ZgP4hbJrZ/loB21fQCjFBlS3AxpNfWHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793346; c=relaxed/simple;
	bh=V7fcbKSidne5RUs6RALNFxlbf0ReIDArPlCYbP63yas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFMgK28wcSdgBtzfsE9ZGhWhDHlvxb52p6il9T9jbuUbnscUlJQZz8UXt+DGH14hyufoGeH2irWmBsU9q79nwaB5aDBSuF9d7zOjC8J6sXDFzKjc+8+ITSivypOBATzLoRFEj2bV6Be0pzPg7kHROtTj3+7HSBLh1R1ZL2KyJt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=qhWzeVv7; arc=none smtp.client-ip=136.175.108.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="qhWzeVv7"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta59.mxroute.com (ZoneMTA) with ESMTPSA id 19c0fe29b990009140.00f
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 30 Jan 2026 17:10:35 +0000
X-Zone-Loop: db5cba88097128c3b6f0596e1dc43dea2f97a4828a0e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=dDj7YokTo9eZhB6hv91+hfa74EwqBbkyPLg0woo5slc=; b=qhWzeVv74FnzBexkIERx+ZYsXE
	LXdN92il0yC9pUK19WB3FPQrnkM9Q7omvGeIlwTeojDRsgcxRuwOcKwqEyZ4OlhsTAhKEk+Iho1hF
	+X1g/12+TjjRPiUXxb77NbrScKSxutKEuC0Lm0TfgJeZYL1QDvRhoHvkWgm8LKNGac8YVIeJ2jTQV
	zDd8xUOeqEhhaEt19PUnwmA/z50XGMYL8sIASwqR//8GhAkInTdRfxhVPZGFP4sM6+iwfqknVfmSJ
	XeEg/kD/vGWGGp8peWUWql++ZGZ5/Fm5rlIc28M69nHoOlfm0y5ygd1HvK6M4HyowuuQ2MkNk6JqI
	DwvSeCyg==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	ojeda@kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lianux.mm@gmail.com,
	zijing.kernel@gmail.com
Subject: [RFC PATCH 0/2] rust: pci: add config space accessors (and a small in-tree user)
Date: Fri, 30 Jan 2026 17:10:24 +0000
Message-ID: <20260130171026.1138617-1-zijing.zhang@ry.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: zijing.zhang@ry.rs

This RFC proposes adding basic PCI config space accessors to
`rust/kernel/pci`.
It also includes a tiny update to the existing Rust PCI driver sample to
exercise the new API.

Motivation
----------
Rust PCI drivers occasionally need to access PCI config space (e.g. for
capability discovery, SR-IOV queries, or MSI-related setup).

Having a small, reviewed API in `kernel::pci` avoids each Rust driver
growing its own ad-hoc wrappers and error handling around config space.

This RFC is also motivated by the "PCI MISC APIs" TODO item in
`Documentation/gpu/nova/core/todo.rst`: config space accessors as a first
step, with capability/MSI/SR-IOV helpers as follow-ups.

Proposed API
------------
Add the following methods to `pci::Device`:

  - read_config_u8/u16/u32(offset: u16) -> Result<T>
  - write_config_u8/u16/u32(offset: u16, val: T) -> Result

Notes
-----
This is intentionally a thin wrapper: it exposes a safe interface and
translates errors into `Result`, but it does not try to add policy or extra
validation.

  - No additional range/alignment checks are performed in Rust. If an
    argument needs validation beyond what the C PCI accessors already do,
    it should likely be addressed in the PCI core instead of in a Rust-only
    wrapper.
  - The underlying C helpers may return positive PCIBIOS status codes.
    These are mapped to the corresponding `-errno` values for Rust callers
    (same mapping as `pcibios_err_to_errno()` in `include/linux/pci.h`).

`pcibios_err_to_errno` mapping helper
-------------------------------------
The mapping logic is kept as a private helper in the `kernel::pci` module
rather than inside `Device`: it is not tied to any particular device
instance and may be reused by future PCI helpers.

Also, the C `pcibios_err_to_errno()` is a `static inline`, so Rust cannot
call it directly without adding an exported wrapper.

In-tree user
------------
The `samples/rust/rust_driver_pci` sample is updated to read vendor/device
IDs from config space (0x00/0x02) and print them during probe using
`dev_dbg!`.

Note: in the current Rust support, `dev_dbg!` does not hook into dynamic
debug and is compiled out unless Rust debug assertions are enabled.

For local testing, enable `CONFIG_RUST_DEBUG_ASSERTIONS=y` if you want
to see the `dev_dbg!` line.

Questions for reviewers
-----------------------
1) Does using `u16` for the config-space offset and returning `Result<T>`
   look OK?
2) Is mapping PCIBIOS status codes to `-errno` acceptable for Rust callers,
   or would you prefer we add a small exported C wrapper so Rust can reuse
   the existing `pcibios_err_to_errno()` helper directly?

Testing
-------
Build:
  - x86_64 defconfig-based kernel with Rust enabled.
  - Out-of-tree build directory (i.e. `make O=...`).
  - Options enabled for this test:
      * CONFIG_SAMPLES_RUST=y
      * CONFIG_SAMPLE_RUST_DRIVER_PCI=y (built-in)
      * CONFIG_RUST_DEBUG_ASSERTIONS=y

Runtime:
  - Booted the resulting bzImage under QEMU x86_64 with:
      * `-device virtio-serial-pci`
      * `-device pci-testdev`
  - Kernel command line included:
      * `loglevel=8`
  - Observed:
      * `pci-testdev data-match count: 1`
      * `Probe Rust PCI driver sample (... cfg: 0x1b36:0x0005).`

Zijing Zhang (2):
  rust: pci: add config space accessors
  samples: rust: pci: exercise config space accessors

 rust/kernel/pci.rs              | 86 +++++++++++++++++++++++++++++++++
 samples/rust/rust_driver_pci.rs |  8 ++-
 2 files changed, 92 insertions(+), 2 deletions(-)

-- 
2.52.0
