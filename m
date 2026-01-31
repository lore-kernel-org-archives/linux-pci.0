Received: from mail-108-mta6.mxroute.com (mail-108-mta6.mxroute.com [136.175.108.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EFD220F2D
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769873008; cv=none; b=J08RG7nMHnQk6mVJcxy6Ek5uyJd8vhTOY3ZvPlH6ouQLrkJKUyjtkaF2DFpQ2bI+RAzewAgzMZtQOyysln2r8AJMY8zATYuYIBxRXqNh2Rww5r9kimduIfowOs9GajzeCS0XFv2LWiS5++4MSzuDUhJvuT/B/wPKy2px9WSgmOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769873008; c=relaxed/simple;
	bh=qJ7Tx47O6kl+SWx6tO0XFAubfl7B9PjI33fu93OwYHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F72+KQRh9I43lRezQ6MW0AyhyC0KfOO2R+EXKTBgL95we2QCTeJUeC8U0tlELzJh8FLmQT96dOij180l75+HipGHu3hbuRRYBqwxQT2otTtr65yhqp5SWsekS1TlZJHEEJy2A+rz7rmm7WJTpv1ri/JXsNHhgmSJU4hPSTr+pSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=XlxT/S8O; arc=none smtp.client-ip=136.175.108.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="XlxT/S8O"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta6.mxroute.com (ZoneMTA) with ESMTPSA id 19c14a22d9c0009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 15:18:18 +0000
X-Zone-Loop: a8f4aff6e6a3284618faefc0db5fd378339e042cb214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=f/qY8vMWsi1XoCKgp7yD76rZofHTccqwWMQe925Lz/8=; b=XlxT/S8OEu5h7+9swUD2CMTUI7
	etK2EdNJVFkdhAZM2S8caQknSD7Illhzg2xR9ki1OyUPwIilzD8lWEnvRddNkautxGUlnI5u5oE8C
	pLhmrsA46SyyMuOte3rI+gA33dnhSbMXdk413W69f62PWEs2G9ehrhKPY9NqtHF4Rk6d3ZBxmgBVQ
	6NdjsEvMizxoIMLjInhGVp1fH83CdxChIOhauu6XSHrvUU7DmS2p/5bKIvMK4mrcj9Q0BSpAwaCKL
	eMczDrtPvFIll6v9Wcc1ZqRhvwCUKUiscPkU7H/eP89zaW1dtt1gRLs56CUqoCehdn44xm6dPDlEs
	S0cVlmfA==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH v3 0/2] rust: pci: add capability lookup helpers
Date: Sat, 31 Jan 2026 15:17:47 +0000
Message-ID: <20260131151749.1444030-1-zijing.zhang@ry.rs>
In-Reply-To: <20260131040200.1242566-1-zijing.zhang@ry.rs>
References: <20260131040200.1242566-1-zijing.zhang@ry.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: zijing.zhang@ry.rs

This series adds small helpers to locate PCI capabilities from Rust.

It introduces `pci::Device::{find_capability, find_ext_capability}`, thin wrappers
around the PCI core helpers (`pci_find_capability()` and `pci_find_ext_capability()`),
returning the config-space offset when present.

Capability IDs are wrapped in `pci::CapabilityId` and `pci::ExtendedCapabilityId`
(newtypes with `from_raw()` plus a set of common constants), so users do not need
to import `bindings` in order to use the helpers.

An in-tree user is added to the Rust PCI driver sample to exercise the new API.

Testing

Build:
  - x86_64 defconfig-based kernel with Rust enabled
    (out-of-tree build: `make O=...`).
  - `CONFIG_SAMPLES_RUST=y`
  - `CONFIG_SAMPLE_RUST_DRIVER_PCI=y`

Runtime:
  - QEMU x86_64 with `-device pci-testdev`

v2:
- Run rustfmt on samples/rust/rust_driver_pci.rs to fix rustfmtcheck.

v3:
- Base on pci/next.
- Add `CapabilityId`/`ExtendedCapabilityId` and switch `find_*capability()` to use them.
- Document the common ID constants.
- Update the sample to use typed IDs and exercise the new helpers.


Zijing Zhang (2):
  rust: pci: add capability lookup helpers
  samples: rust: pci: exercise capability lookup

 rust/kernel/pci.rs              | 149 ++++++++++++++++++++++++++++++++
 samples/rust/rust_driver_pci.rs |  31 +++++++
 2 files changed, 180 insertions(+)


base-commit: ff0e2f679ab0de50a2e9e88fabc1026bc3be04ba
-- 
2.52.0

