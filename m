Received: from mail-108-mta198.mxroute.com (mail-108-mta198.mxroute.com [136.175.108.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9582253A0
	for <linux-pci@vger.kernel.org>; Sun,  1 Feb 2026 07:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769930422; cv=none; b=GeUgtfnyrLM5zp7qpGmANij1PtNkMlVQbNksUmgyxkro7dssSsAczU1nZVHLz3LyaJ2c6p+OhxGIM2T5sfr3fTyDvOQd/0f0VdQdUGqEwJFi3X0Q6t3oH7rUoZUtA3IHDcQxhnqgkrHgS+wAVUyJauG+DwkOPKx/szAHeXLu0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769930422; c=relaxed/simple;
	bh=GCRX04VpP+qJgLBFiML5wKKuenqLI/qjmztUj9LLBVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzFoOAxpPZDusEIoAFdxHQs/26O4j/h5zqBdsYD8nePTHmasoQgIRjPLzDJF4S28nYzbvOuJ/JW8kGyM7cMd9Ml03QYdl+oFEes1CuDHq6RBDC61it8KQtLazcFswod6tuljFwM39draBAH+t2h8hqyrpTHlYQB+TwIxIhvDWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=ndUM6wKN; arc=none smtp.client-ip=136.175.108.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="ndUM6wKN"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta198.mxroute.com (ZoneMTA) with ESMTPSA id 19c180e3cce0009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 01 Feb 2026 07:15:12 +0000
X-Zone-Loop: 6f14e0f0f5c051f7d5eafbf4d6fd5f01a50e700d6784
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=Gx5FYeRpxQNsoWPS/k8xvkPOg2OQ1fIBFTrPBwA+MSk=; b=ndUM6wKNml9PzDNCX9YgYVQk7O
	iPL0RqMugLmxx4zu0fx93ix2bVNh+yVjVczNF4S6E3367gvq3nODvnt6c17/Tv+H8wGm/duE/7xKa
	5LDfZXrsiHWjfGPO8jqqGDb8nVnQf1khyjJIcTGdfRr4delY2JO72lYYAeaenWutjU4F7tI8xvdnG
	GctjJRi36ccTpIZjBHJogMNqzOBvsC/zVued3MiOfsDpHrotq0DaOwA7Z6tkfY3k4VdejRP0l3Vaw
	m/0R6CueRUUhoClO/loPVuw7kKH95hRtI1HbgfRS2jUiNKMS4SiO0fTDZN+Sn828J2VwwzfMVMhJR
	DpSWDacg==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH v4 0/2] rust: pci: add capability lookup helpers
Date: Sun,  1 Feb 2026 07:14:48 +0000
Message-ID: <20260201071450.1614172-1-zijing.zhang@ry.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: zijing.zhang@ry.rs

It introduces `pci::Device::{find_capability, find_ext_capability}`, thin 
wrappers around the PCI core helpers (`pci_find_capability()` and 
`pci_find_ext_capability()`), returning the config-space offset when present.

In `pci::CapabilityId` and  `pci::ExtendedCapabilityId`, Capability IDs are 
wrapped as newtypes with `from_raw()` plus a set of common constants.

An in-tree user is added to Rust PCI driver sample to exercise the new API.

Previous versions (v3)
https://lore.kernel.org/linux-pci/20260131151749.1444030-1-zijing.zhang@ry.rs/

Testing
---

Build
- x86_64 defconfig-based kernel with Rust enabled (out-of-tree build).
- `CONFIG_SAMPLES_RUST=y`
- `CONFIG_SAMPLE_RUST_DRIVER_PCI=y`

Runtime
- QEMU x86_64 (i440FX) with `-device pci-testdev`
- QEMU x86_64 (q35) with an NVMe device

Changelog
---

v2
- Run rustfmt on samples/rust/rust_driver_pci.rs to fix rustfmtcheck.

v3
- Base on pci/next.
- Add `CapabilityId`/`ExtendedCapabilityId`, switch `find_*capability()`
  to use them.
- Document the common ID constants.
- Update the sample to use typed IDs and exercise the new helpers.

v4 (current)
- Minor doc/style nits.
- Use early-return style in `find_*capability()`.
- Use `dev_info!(pdev, ...)` in the new sample helper without `as_ref()`.


Zijing Zhang (2):
  rust: pci: add capability lookup helpers
  samples: rust: pci: exercise capability lookup

 rust/kernel/pci.rs              | 150 ++++++++++++++++++++++++++++++++
 samples/rust/rust_driver_pci.rs |  27 ++++++
 2 files changed, 177 insertions(+)


base-commit: ff0e2f679ab0de50a2e9e88fabc1026bc3be04ba
-- 
2.52.0

