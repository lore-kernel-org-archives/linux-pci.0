Received: from mail-108-mta177.mxroute.com (mail-108-mta177.mxroute.com [136.175.108.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E482E6CC0
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769857981; cv=none; b=VR8MWP+JT/WvqyBIU5mubV/tvZrfF0dvKv3yQirGNglu2lhMDVcCUNhr7JtxZA2huN/A2t/Am1oU2Sgnm/RWNC0uU+phIOnTCC8ml8bv6ForY42IFKbDYKHq/KSEYiAMznKuCR9H3OknFA9qRBxCPe69vKlOTNTgDOdIL0KNoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769857981; c=relaxed/simple;
	bh=CEkiRRcISY9TvP13X4pK7VlX3Z1H4VrCeU7W9Tb+HrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXt7otcyqRQ13Vp7rvxYFh068df6qt7Jhl+sH9Y6D0zioFBsD/xYklnrXOlYPh3CzF+WRZa7Ibn9WPbYz1ttRUksug4vhbmXefirRGF1YBrRFGB8dhO5nvsunZBGdorDbi7vmjv4FY+lAGGSyX379NpWW6g/RjaLEgpEvqZcuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=hxAuAkts; arc=none smtp.client-ip=136.175.108.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="hxAuAkts"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta177.mxroute.com (ZoneMTA) with ESMTPSA id 19c13bcd2130009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 11:07:47 +0000
X-Zone-Loop: 459eb40c00547b5d04e15eb003377e7c74dbb717ff8d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=SgIWqaGtA0OlLacn62yBlcFOmZTNy7bV0wmFbMo80R4=; b=hxAuAktsuzWKQnvXfnVeZsGfjk
	vKCajuWfySCBiJdwGBQh9Q/ZCRY4urPpn0PFyT1g3ekMwiFbpfupXvj5r8aoEiDhYFkuTSjWFOJce
	YxHhb9BHzKoQSEzLFjjpX6NyfafcmcZt6JYbNE8hNPKJBPHwBeIea2qgSqLCcr8+bEg4WEgsV+/zX
	jyPjlnHKRVlkQrPV+A8geR0k2jjagSSvIfvkzu8R9+5we3Urqp/c9jrc9hALIjnIkWE+J+Lv8VCNo
	odVsU1q/njKRf5wMgmM44ckA///jACRon5s0L3Qj9bpZnaaoLLUrCnx9cPW/FY0RwwFW4O53D6Vfh
	5KHo/5hA==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH 0/2] rust: pci: add capability iterators
Date: Sat, 31 Jan 2026 11:07:35 +0000
Message-ID: <20260131110737.1356432-1-zijing.zhang@ry.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: zijing.zhang@ry.rs

Adds iterator helpers to enumerate PCI capability offsets from Rust.

Introduces two new iterators.
  - `pci::Device::capabilities()` for the standard capability list.
  - `pci::Device::ext_capabilities()` for the PCIe extended capability
    list.

Builds on 
  https://lore.kernel.org/r/20260131095102.1273392-1-zijing.zhang@ry.rs

These are intentionally thin helpers returning offsets only, 
do not parse capability contents, and have no Rust-only policy checks.

The iterators use the same loop guard values as the PCI core helpers to
protect against malformed lists.
If the guard triggers, the iterator stops and emits a warning for
easier debugging.

The underlying config reads are factored into small private helpers on
`pci::Device` so the unsafe boundary & error handling are not duplicated.
While config_space already provides `read8/read16/read32`, those
accessors are infallible and ignore the return value of the underlying
`pci_read_config_*()` helpers. That is appropriate for simple reads, 
but it is a poor fit for capability list traversal, where a config-read
failure should stop the enumeration. These iterators are on `pci::Device`
(like `find_capability()`), i.e. they do not require `Device<Bound>`,
thus they cannot simply reuse `Device<Bound>::config_space()`.

In-tree user `samples/rust/rust_driver_pci` is updated to exercise both
iterators.

Testing
---

Build:
  - x86_64 defconfig-based kernel with Rust enabled
  - `CONFIG_SAMPLES_RUST=y`
  - `CONFIG_SAMPLE_RUST_DRIVER_PCI=y`

Runtime:
  - QEMU x86_64 with `-device pci-testdev`
    (expected: no capability lists).
  - QEMU x86_64 (q35) with an NVMe device
    (observed: non-empty standard list, including a PCIe capability at
     0x80).

Zijing Zhang (2):
  rust: pci: add capability iterator types
  samples: rust: pci: exercise capability iterators

 rust/kernel/pci.rs              | 218 ++++++++++++++++++++++++++++++++
 samples/rust/rust_driver_pci.rs |  14 ++
 2 files changed, 232 insertions(+)

-- 
2.52.0
