Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB251315D48
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 00:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769820408; cv=none; b=GPSvBV+df1RhCXsz5m4MfrPg0fZFCTxSmtqYAh18sD9lwVWMe5b9THg5vfHtmi1rP9DbZfO1alLBP9/SUJVh501Zk+5MAHKD5qWDnuPaRyY57F48Ul6kCpjAHEYvBnBkgQ/5va66bPO78nKOEcVpagSsJGtCd7b+OhalN568+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769820408; c=relaxed/simple;
	bh=8IZRH/xWnQO5OagL5eoF7JKKQW3X5mzsuuoLOSUsY4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iORQEPuZhTPvMZmykukgGqRCN9ebU5/y2WZDY9Yhwdf7hlDbxVpDcmOQyRyK/kixXX/66KFJ9zeJoxmQZmWG95J/x1Rj/t0Hg/w8o+jP+C/Lq4z1WwKvMCvnepCPoDhj0EOGWcy1Er8z43uTK5H8iUt1KzGgjo7sq+BP05wYYes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=fn0w1KhC; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="fn0w1KhC"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 365D8240101
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 01:46:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1769820405; bh=MUb4heDou8veVziSU9l72vANO0/QhyGDNJaSezX/IBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=fn0w1KhCe+DxLKzG2WWFdIIT+w1RvejQS3vQspOQ1SSK8lhkjbqU3VSq7dAsoJ85Q
	 AydUTJydb8SrcJA5eDV9AsMuF0gSP/1Q1ys/rtfYnKrKoeQ/0k5mjshI2EX/RzZ5eo
	 BStDr+xrA68evWF3/Zq9AFI4s5G4bJiM5Q9Q5I2VzZu6F+vh/WLg99sxfo/iwbm0uo
	 DnZ92XjRY9ZPBJP+vX2F3DZrWhB2NP3yY2bmtlos07igHI7FfuUsMdvL35NJMKgpUd
	 HR0euJRSy5IHVfCfEMyytaom2fg7Rx0oG79Hw49brZdrNRl07UroiRtYt3gWGm9gZX
	 kJM8HqOfXv7Fw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4f2vMd5N2Zz6tvy;
	Sat, 31 Jan 2026 01:46:37 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Zijing Zhang <zijing.zhang@ry.rs>
Cc: dakr@kernel.org,  ojeda@kernel.org,  bhelgaas@google.com,
  kwilczynski@kernel.org,  boqun.feng@gmail.com,  gary@garyguo.net,
  bjorn3_gh@protonmail.com,  lossin@kernel.org,  a.hindborg@kernel.org,
  aliceryhl@google.com,  tmgross@umich.edu,  linux-pci@vger.kernel.org,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org,
  lianux.mm@gmail.com,  zijing.kernel@gmail.com
Subject: Re: [RFC PATCH 0/2] rust: pci: add config space accessors (and a
 small in-tree user)
In-Reply-To: <20260130171026.1138617-1-zijing.zhang@ry.rs>
References: <20260130171026.1138617-1-zijing.zhang@ry.rs>
Date: Sat, 31 Jan 2026 00:46:39 +0000
Message-ID: <87sebmzk0i.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zijing Zhang <zijing.zhang@ry.rs> writes:

> This RFC proposes adding basic PCI config space accessors to
> `rust/kernel/pci`.
> It also includes a tiny update to the existing Rust PCI driver sample to
> exercise the new API.
>
> Motivation
> ----------
> Rust PCI drivers occasionally need to access PCI config space (e.g. for
> capability discovery, SR-IOV queries, or MSI-related setup).
>
> Having a small, reviewed API in `kernel::pci` avoids each Rust driver
> growing its own ad-hoc wrappers and error handling around config space.
>
> This RFC is also motivated by the "PCI MISC APIs" TODO item in
> `Documentation/gpu/nova/core/todo.rst`: config space accessors as a first
> step, with capability/MSI/SR-IOV helpers as follow-ups.
>
> Proposed API
> ------------
> Add the following methods to `pci::Device`:
>
>   - read_config_u8/u16/u32(offset: u16) -> Result<T>
>   - write_config_u8/u16/u32(offset: u16, val: T) -> Result
>
> Notes
> -----
> This is intentionally a thin wrapper: it exposes a safe interface and
> translates errors into `Result`, but it does not try to add policy or extra
> validation.
>
>   - No additional range/alignment checks are performed in Rust. If an
>     argument needs validation beyond what the C PCI accessors already do,
>     it should likely be addressed in the PCI core instead of in a Rust-only
>     wrapper.
>   - The underlying C helpers may return positive PCIBIOS status codes.
>     These are mapped to the corresponding `-errno` values for Rust callers
>     (same mapping as `pcibios_err_to_errno()` in `include/linux/pci.h`).
>
> `pcibios_err_to_errno` mapping helper
> -------------------------------------
> The mapping logic is kept as a private helper in the `kernel::pci` module
> rather than inside `Device`: it is not tied to any particular device
> instance and may be reused by future PCI helpers.
>
> Also, the C `pcibios_err_to_errno()` is a `static inline`, so Rust cannot
> call it directly without adding an exported wrapper.
>
> In-tree user
> ------------
> The `samples/rust/rust_driver_pci` sample is updated to read vendor/device
> IDs from config space (0x00/0x02) and print them during probe using
> `dev_dbg!`.
>
> Note: in the current Rust support, `dev_dbg!` does not hook into dynamic
> debug and is compiled out unless Rust debug assertions are enabled.
>
> For local testing, enable `CONFIG_RUST_DEBUG_ASSERTIONS=y` if you want
> to see the `dev_dbg!` line.
>
> Questions for reviewers
> -----------------------
> 1) Does using `u16` for the config-space offset and returning `Result<T>`
>    look OK?

IMO using u16 looks good to me, since it covers the full PCIe extended
config space while making negative offsets unrepresentable at the type
level.

> 2) Is mapping PCIBIOS status codes to `-errno` acceptable for Rust callers,
>    or would you prefer we add a small exported C wrapper so Rust can reuse
>    the existing `pcibios_err_to_errno()` helper directly?

Personally I would prefer a small exported C wrapper. Although the local
re-implementation works, I believe it is an established pattern in the
rust helpers (i.e. to wrap `static inline` helpers), so the Rust side
automatically stays in sync with any changes done in the C side, no
logic duplication etc.

>
> Testing
> -------
> Build:
>   - x86_64 defconfig-based kernel with Rust enabled.
>   - Out-of-tree build directory (i.e. `make O=...`).
>   - Options enabled for this test:
>       * CONFIG_SAMPLES_RUST=y
>       * CONFIG_SAMPLE_RUST_DRIVER_PCI=y (built-in)
>       * CONFIG_RUST_DEBUG_ASSERTIONS=y
>
> Runtime:
>   - Booted the resulting bzImage under QEMU x86_64 with:
>       * `-device virtio-serial-pci`
>       * `-device pci-testdev`
>   - Kernel command line included:
>       * `loglevel=8`
>   - Observed:
>       * `pci-testdev data-match count: 1`
>       * `Probe Rust PCI driver sample (... cfg: 0x1b36:0x0005).`

Tested-by: Charalampos Mitrodimas <charmitro@posteo.net>

  [    0.176714] rust_driver_pci 0000:00:02.0: Probe Rust PCI driver sample (PCI ID: REDHAT, 0x5; cfg: 0x1b36:0x0005).
  [    0.176727] rust_driver_pci 0000:00:02.0: enabling device (0000 -> 0002)
  [    0.177100] rust_driver_pci 0000:00:02.0: pci-testdev data-match count: 1

Cheers,
C. Mitrodimas

>
> Zijing Zhang (2):
>   rust: pci: add config space accessors
>   samples: rust: pci: exercise config space accessors
>
>  rust/kernel/pci.rs              | 86 +++++++++++++++++++++++++++++++++
>  samples/rust/rust_driver_pci.rs |  8 ++-
>  2 files changed, 92 insertions(+), 2 deletions(-)
