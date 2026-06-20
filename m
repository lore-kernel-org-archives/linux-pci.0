Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB119E839;
	Sat, 20 Jun 2026 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781945176; cv=none; b=c3L8ibwBXIdx5ouec6m5YI215EHyOdYtiNpilm+oiCjpsqh0Zf5TAwOV7IQEc3+QSMBBJLUB2ZTz+Nj602LCecIqulbW7TRoqZwO8Wj3i46agaugeC9Wy/LDJMGZX9xJctxRHGKuZgA4l79tRjQi+lIQxywSbmLbv5joppBNbl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781945176; c=relaxed/simple;
	bh=wWL8LdZ8p4aRtAGdqUW1tSP9c40+jKKSJIYzFD6h5m8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGV0moK8YxxXMrCbAaU0Gq7gmI+MyDUj9GbI5s2DPhnwPStrDIm32f//yHhnAyJOxzcmmsOWsdZqlEls+zvjvsNRjFE/xvXRwGeanz4OpR5aHHvU484cGHlg13vv65bx1tGWysdRak/X3tNUMMgjZoTZBYzTFHQKO6eWOffytss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fxWiveI2; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pfauJrGm; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fxWiveI2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pfauJrGm"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gj7NM3ykXz9v6h;
	Sat, 20 Jun 2026 10:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781945171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sujkIHpCAn/P2Px/kJYkXpvSw+/f/JlIbR14Ld5FEb0=;
	b=fxWiveI2fizhsyOs9HqVFWiYT6XU/XpJT/bioUbwjDMvYuvoqrw3nboYalViV2VjVnFGvK
	ES9GmBS4Iic9kez9GIAOEM1oq9f+Kdv9K20zhLZJU3/7nSOLWo2AHkI0iPaNyOkNGrV4pI
	OpxfZdLjrSA2a41o/T/HOgMkYh5X2yQB4MAn5wQ+AEWEiBOSR+DWiKW4uyfGrume42ZK0Q
	NigaoPVSIXe54ddPjXzFXLYJryM2CmuWZQdcitWtedLHwkLt1NAfeP5i81rp6809AwJ2K3
	VR/w9ZaMyD6warMBt4Bq+UlTZft/LR8mOF1zdtGUDeeCGFUHuWBQ8uysvo1BlA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=pfauJrGm;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781945169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sujkIHpCAn/P2Px/kJYkXpvSw+/f/JlIbR14Ld5FEb0=;
	b=pfauJrGm0N1+8OxBEZb8Yq8Hvgb+fl0KLTalys64voJURC48BcGkU6oCL4+ZO5O02gdGm3
	lATyXGDp86Td0mOF7XIEdTMddDFu7vX8/wtirxTK4g3Lj0ExuOBEc0x0iY4tSiduK28hi6
	XOTX4cnNUAhql5RfemE+kty/rji++XnFj76wN4g4AHlt/TqhZt2MPtMJDRJgQRSp1qASjH
	CsXYWLlpot6TY0LTJTW127fuFJwDKzsMzfXS59+ZJxxTyojUUN5uWfQ+v/msoFDMI3E7L8
	g2+gHkinOqLkuW4l1/hQ1JawkoUQuNrRW1KTwP58msad7bV8eaVSWrjL9aRlcA==
Date: Sat, 20 Jun 2026 10:45:45 +0200
Subject: [PATCH v2 1/4] rust: pci: make Vendor::from_raw() public
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-b4-rust-pci-edu-driver-v2-1-6fd6684f2c14@mailbox.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
In-Reply-To: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
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
 linux-kernel@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781945156; l=1721;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=wWL8LdZ8p4aRtAGdqUW1tSP9c40+jKKSJIYzFD6h5m8=;
 b=IxYXCDevSmZ+UJodbENZDw2iLhVyKKOFUgn33Mc8+mXgAK5oly95kL7yVXlfZsGDCRsgkUvww
 DV4AkMFXEvNAV2IWHjzlglxl99F1zN75LXFR0tSVTSOlihXEI39Dzsj
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-ID: 03af0b95e58ef934e50
X-MBO-RS-META: et4xw4cc74r1kdsw3f57tq4x6pdbbqmg
X-Rspamd-Queue-Id: 4gj7NM3ykXz9v6h

`Vendor::from_raw()` is currently `pub(super)`, so a Vendor can only be
obtained through the named constants generated from the
`PCI_VENDOR_ID_*` defines in `<linux/pci_ids.h>`. A driver therefore
cannot match a device whose vendor ID has no symbolic name.

Such devices exist. QEMU's "edu" educational device and the legacy
qemu/Bochs stdvga both use vendor ID 0x1234, which is not registered in
`pci_ids.h`. Per the policy stated at the top of that header, IDs are
only added there when shared between multiple drivers; a single-driver
ID is expected to be open-coded in the driver instead. C drivers already
do this -- see `drivers/gpu/drm/tiny/bochs.c`, which matches with a bare
".vendor = 0x1234".

The Rust abstraction has no equivalent escape hatch: there is no public
way to express an unregistered vendor. Make `Vendor::from_raw()` public
(and const, so it can be used in the const device-ID tables built by
`pci_device_table!`) so that drivers can construct a Vendor from a raw
ID, matching what C drivers can already do.

Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 rust/kernel/pci/id.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index dbaf301666e7..fe3b0047179b 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -156,7 +156,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 impl Vendor {
     /// Create a Vendor from a raw 16-bit vendor ID.
     #[inline]
-    pub(super) fn from_raw(vendor_id: u16) -> Self {
+    pub const fn from_raw(vendor_id: u16) -> Self {
         Self(vendor_id)
     }
 

-- 
2.51.2

