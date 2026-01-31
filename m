Received: from mail-108-mta251.mxroute.com (mail-108-mta251.mxroute.com [136.175.108.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5BF2DC76D
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769858813; cv=none; b=eHk1geZQe5TMKyqmRouoWmXSuIJDSuUHTN3KHE+Du5YzM3gMPxioFMQCMf7+O6odxnaVsY4sxtO8lkYGZHYiUgJnsq6YzZSPRK8e1uiglB2UGWApKdkieI7EkdCGTnH69x5KBtGwvQVT10XYlczLlRxgBU9GRQGqKvP0YSYF3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769858813; c=relaxed/simple;
	bh=QHgqk4BIc53yA+FjvlxREOlKTOEbewygozG40hxdiUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpjN2TBFMmlefcUpWMKvIiqu890GFkuZqxu97MCABKs9QBqXnoZx+pbAhMsOFTrsg2pM8bqrqkWPKurR4WKk8X+Bw/OxZdrnd4Fn7X0fmUkrFk7vfM1e/JD9LPmCpJwkNIldCghyB6rFfQNjjLoP2NqXbLICiNUSM9lgTYJe0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=fjROamJ5; arc=none smtp.client-ip=136.175.108.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="fjROamJ5"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta251.mxroute.com (ZoneMTA) with ESMTPSA id 19c13c973d90009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 11:21:35 +0000
X-Zone-Loop: 36a8548f89dc5688786a4b21cd89a1c8218c560db8ed
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=3Cp9OVxk2isToFuPMnV3upd7n0v7HOTYIasypB8MuaE=; b=fjROamJ5E+6aHg3t9JK/nestBD
	2QPtqsN5mYRG+6l/uoK/uPHKLpL9cCAYII0ufvTb8/u8g9IfeMxq1x9wHcQMFwkFSKDsbXAP0wjgb
	wsEC/FDtwopcsSw/OH6WuBiGal+T8WKereeLxojxpTmkO0vucu61yOHB6NVH9+FJCxgLYgl4huf6g
	TPm4tWpyB7Ppj+xNYmX7K64t2j5nQ/CvcUQ3h6EPsdpb+3mo4dd5KVIvi1aZpModbZezuwxycREmM
	NfYd2cs4oWTKeF1kpRi42xtftOypJKvdVrHi1G6zBMe0IHGtAfHVUfVXpLK3oMg+rcsNlWQFaJKWl
	5R/5msHw==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH v2 0/2] rust: pci: add capability iterators
Date: Sat, 31 Jan 2026 11:21:15 +0000
Message-ID: <20260131112117.1361425-1-zijing.zhang@ry.rs>
In-Reply-To: <20260131110737.1356432-1-zijing.zhang@ry.rs>
References: <20260131110737.1356432-1-zijing.zhang@ry.rs>
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

Changes
---

v2:
- Fix build errors caused by C binding constant types when matching PCI
  header type and comparing config-space size.


Zijing Zhang (2):
  rust: pci: add capability iterator types
  samples: rust: pci: exercise capability iterators

 rust/kernel/pci.rs              | 221 ++++++++++++++++++++++++++++++++
 samples/rust/rust_driver_pci.rs |  14 ++
 2 files changed, 235 insertions(+)

-- 
2.52.0
