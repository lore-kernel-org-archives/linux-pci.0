Received: from mail-108-mta249.mxroute.com (mail-108-mta249.mxroute.com [136.175.108.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54F2E1C63
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769853388; cv=none; b=KT1KBnd2LBiDTwg95PhgdXMpiDnWJuBUpxphlhqr+0S1XooM3Hn+OjyI0g3pWNNf+UwApoJ97kEdh8Saf2nQPG3y0GYTiPKzBaQ9CrIiZ4DVXkv7oa7hcWu44XncGl7R7OOCk2MVSIZ45Zm3vPzNYEae8lkBHlQbMrjPZF5P5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769853388; c=relaxed/simple;
	bh=a+nw1+hfaoc5pIFOnKAmXoYlRYD13bYV+7poAQx4XQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvo2wQClgghPYk2PhT2mdYbfs2rTqKkeDNT2CsouM6Nt1B3r7unvbu4fSxjvdCDAIXxOCAsA1L36j9JKevSAVetz1StTW/PfnkaZYCT5cn2O15UdRaopxt+GtWaZefnsnVuUjqnjV8D4ADsb1yJyXafUcGD6N2oE2noDLUhZ3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=o+Gh6tDN; arc=none smtp.client-ip=136.175.108.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="o+Gh6tDN"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta249.mxroute.com (ZoneMTA) with ESMTPSA id 19c1376b6b30009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 09:51:13 +0000
X-Zone-Loop: 0d729a8d07ea763cfab3eb900fe7560a32fabbe3486b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7vpF7Hn5BqgJ2gb4QbWYXUkLTdyKNemYuDL0XwzOIJU=; b=o+Gh6tDNEqyvHrx0vP6E60coqX
	DpMkj4BpK8z/M+SakkYZ7BocvqYe4RdJAmtxzihM7CstOnr5PlhA30+VuqQOdeRp52CEGb9fJDnig
	BZQHJWc6HWt0WAcPpZvpjs7hPrE7VGxyRsgi0mBhfUYc4SQRP40+TR2mJ9Seji7WDvAPdj2oD3Wya
	AuW72TVQk7cmvYe6S6Ksa3cYifx1rer5t4GrMl4iLgsC9ALEZPhTf8x09sQRI46SxuIvII9AuZOO6
	irZK+gpEt4GXgQ0bwKyQVhExENIEDjB2nATiCWMspyuxHbgh39f8pMeG0WrFlVxZXCTWWJDEtm8Mg
	dtgEPjxA==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH v2 0/2] rust: pci: add capability lookup helpers
Date: Sat, 31 Jan 2026 09:51:00 +0000
Message-ID: <20260131095102.1273392-1-zijing.zhang@ry.rs>
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

Changes in v2:
  - Run rustfmt on samples/rust/rust_driver_pci.rs to fix rustfmtcheck.

This series adds small helpers to locate PCI capabilities from Rust.

It introduces `pci::Device::{find_capability, find_ext_capability}`, thin
wrappers around the PCI core helpers (`pci_find_capability()` and
`pci_find_ext_capability()`), returning the config-space offset when
present.

An in-tree user is added to the Rust PCI sample driver to exercise the
new API.
The sample attempts to locate a few common capabilities (standard and
extended) and prints whether they are present. It also includes best-effort
self-checks to try to hit the `Some(offset)` path when the device
advertises a standard capability list or has PCIe extended config space.

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

 rust/kernel/pci.rs              | 36 ++++++++++++
 samples/rust/rust_driver_pci.rs | 97 +++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

-- 
2.52.0

