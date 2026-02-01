Received: from mail-108-mta80.mxroute.com (mail-108-mta80.mxroute.com [136.175.108.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBC6221555
	for <linux-pci@vger.kernel.org>; Sun,  1 Feb 2026 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769931786; cv=none; b=c2RI/nWm/G7AvyHm+O//2Ly/a3BGBYvKAi40x1Id/wfDvDEgRO0ArkBxhsb4N0tBdeLohUx7AsVVh2OyY9YTiuuGnrltUj/md+OayQxoLH36ua6ZP7g3/DqQ5Ty4eQZU4CJKzRpJxfp4HgCq+aVdQDSXNu2yiVMxAXuz9w5UfnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769931786; c=relaxed/simple;
	bh=hmMS9KNIJJylSYSFdt1/q2zGsVN9JCQY9ZwD8sXWwcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AAtkM7nUTZvrWN3f6rDZ40fzkjB8te9Ocie3cKNMl4DnOH0bV9c8yRedMKEm9XksHjCVqptohnab8UEbXWAibAZUoFnpJMWwQXYeX+tQsspfj5hiLwvyGW2rGK9mNxDYxYT3+Xe/REfgTVhxTfdX1dTLvJpKXSSnBACIw+UHp0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=lfKMrKM2; arc=none smtp.client-ip=136.175.108.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="lfKMrKM2"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta80.mxroute.com (ZoneMTA) with ESMTPSA id 19c1827af190009140.008
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 01 Feb 2026 07:42:59 +0000
X-Zone-Loop: cfedad1477bdb46092519051a4fa53c6f24d336a1925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=aM6jPDBZlrQVK5kMpT4Y9h5OWqr6qQdsD6gUqfF+UCQ=; b=lfKMrKM2qY4riKYN4vbVvJVfcf
	Ikv0RkR4m+HFa2IDPCjfpKieQhOEnLdbu54XK7cqsYrKp6MrqhZmlIoG8nVDV1sFa4INwBEBwVSr+
	8POs1fZBWh7XBFzUJmfgYg/tt8HOzCovBIBRdTNb0SVdaUZuTt6j2FH0897xAlEXBdkz2ijDVKI0x
	YB6UxX9da+w6RZMy+A0MjrGTdXeO67kPAlIiREkQYqnJvo3PHW79ELSb4JJtkzl+pz4dzre/niVUc
	7+A9OTNcuwZDxnsHqxR87tJlNQc8Okgc6mFF1CfUSDMz8Gx0UKkLYpdK0LbHBrpQF1OeIGXa2yP5R
	vG8B4KdQ==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	dirk.behme@gmail.com,
	lianux.mm@gmail.com,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH v5 0/2] rust: pci: add capability lookup helpers
Date: Sun,  1 Feb 2026 07:42:46 +0000
Message-ID: <20260201074248.1629393-1-zijing.zhang@ry.rs>
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

Previous versions (v4)
https://lore.kernel.org/rust-for-linux/20260201071450.1614172-1-zijing.zhang@ry.rs/

Testing
---

Build
- x86_64 defconfig-based kernel with Rust enabled (out-of-tree build)
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

v4
- Minor doc/style nits.
- Use early-return style in `find_*capability()`.


v5 (current)
- Fix sample build by using `pdev.as_ref()` for `dev_info!`.
- Use `as _` in constant definitions.

Zijing Zhang (2):
  rust: pci: add capability lookup helpers
  samples: rust: pci: exercise capability lookup

 rust/kernel/pci.rs              | 150 ++++++++++++++++++++++++++++++++
 samples/rust/rust_driver_pci.rs |  31 +++++++
 2 files changed, 181 insertions(+)


base-commit: ff0e2f679ab0de50a2e9e88fabc1026bc3be04ba
-- 
2.52.0

