Received: from mail-108-mta253.mxroute.com (mail-108-mta253.mxroute.com [136.175.108.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100982D47E9
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 04:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769832451; cv=none; b=IoYTe7tpr5iAwVNqSwtQb7AR+dYPBJZHBO+vVqxekzjnxVlZieC/9CXJLs4EuuAZdS01T1ta5o9lJWjzJMkjhD7dAhPNy8IF1s/KfR7vqT43wX8UyXdb+3yOK/eADvbe0EbhZVcC9T2CDI1u3xEEwye36xl/H/W1hc6XSj2ya8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769832451; c=relaxed/simple;
	bh=tVYW2g6ELRp255IvVzXYGOfznCgCw4qB0le5ExvsXTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FqVKFpgcdQwoa2p0Zn1+jC7QMDAQDUw7001QzNMp+WXxiP4SEPncj+X+WRzXZL3At7z319RJFXYzHjS411O85Y17+L9PGBqrUT4euu5Ra3Jw55/SlAQ3jtY455UN3JMSKLQEFDq+7Bt38CGOM6p7NsXvUq9ozR3pOFxcV4IFtaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=S+WCoT6Z; arc=none smtp.client-ip=136.175.108.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="S+WCoT6Z"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta253.mxroute.com (ZoneMTA) with ESMTPSA id 19c12373eeb0009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 04:02:16 +0000
X-Zone-Loop: 5b61b25c835187129e101f01686f7e71d9a106109044
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=zSMG6Uz53BiFvHRHiaCYl/tDDKBTcgcG9YFyZ+rdtgQ=; b=S+WCoT6ZWmsVj6ZgiG+x7bERLL
	IRCHdz1nTtnqEnvJH21px0w4sY3MzLLiBR4cFlNKt6jFtff8A2HbjVCTCRG2j8zuG3SVO1xTA26fe
	jB5Hr8SGSn2drd/egxcHc3Ol8R1Suwj5I4G20yfVVBDANMGYZQxIzyIJwosC5hUbd0JiWSH0Y4zxB
	rf8cf8/HrSi6og2ah4yuUznipeV8v8G9xd20WBjicYPwYawlRFDF4/v1TObYNpp0JDu4BkHgU0Wo9
	yVpVEEHzKgCfWIHEyGe6fxZipDDbcuFityid+uFOGYEqNpUFR4Jfn2rko82FcPKU/6PEUpznHr8BG
	feFGbttQ==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH 0/2] rust: pci: add capability lookup helpers
Date: Sat, 31 Jan 2026 04:01:58 +0000
Message-ID: <20260131040200.1242566-1-zijing.zhang@ry.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: zijing.zhang@ry.rs

This series adds small helpers to locate PCI capabilities from Rust.

It introduces `pci::Device::{find_capability, find_ext_capability}`, thin
wrappers around the PCI core helpers (`pci_find_capability()` and
`pci_find_ext_capability()`), returning the config-space offset when
present.

An in-tree user is added to the Rust PCI sample driver to exercise the
new API.
The sample attempts to locate a few common capabilities (standard and
extended) and prints whether they are present. It also includes best-effort
self-checks to
try to hit the `Some(offset)` path when the device advertises a standard
capability list or has PCIe extended configuration space.

This patchset intentionally stays policy-free: no Rust-only
range/alignment checks, and no capability parsing.

Testing

Build:
  - x86_64 defconfig-based kernel with Rust enabled
    (out-of-tree build: `make O=...`).
  - `CONFIG_SAMPLES_RUST=y`
  - `CONFIG_SAMPLE_RUST_DRIVER_PCI=y`

Runtime:
  - QEMU x86_64 with `-device pci-testdev`
    (capability lists are not advertised in this configuration).
  - QEMU x86_64 (q35) with an NVMe device
    (exercised the `Some(offset)` path via
     `find_capability(PCI_CAP_ID_EXP)` returning `Some(0x80)`).


Zijing Zhang (2):
  rust: pci: add capability lookup helpers
  samples: rust: pci: exercise capability lookup

 rust/kernel/pci.rs              | 36 +++++++++++++
 samples/rust/rust_driver_pci.rs | 90 +++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

-- 
2.52.0

