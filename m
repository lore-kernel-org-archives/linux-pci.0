Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925FF2DE709;
	Sun, 14 Jun 2026 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781452804; cv=none; b=Mfok2GYsMdEjKsoDfRpnKlKuN7CN2So7B+/Aoa1domekmy1EiKabVwFU090WePCN2cCk4GLCIZfQRfIFLmOq0jZ8yw8SL6enicaSDbjxagm1kBN+364FSFgnMdFjroxUZoN77Os+WP+xERSCfKiI+1LyWeqnCN46iFwkV2KiwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781452804; c=relaxed/simple;
	bh=tGCLsqt5ok3HZPG8PlNhuF2WCNGWutHwrwXu1hIjsnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqQ6kVl/V2IuMGO1TnX76w3JGuHwHPoUoqqYl/mIaxseJSy1o8BplkDMHIQTrfN0gVI6fzobisjn6VUd9wYWKXuhMkQQxjJb9ErKAak88Nlp49zzJRyw5HUnLAh44t/kNsjW3ejXbqm5v7HACDL0mHy+R+IiXyxdtFGJMcEphos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tB90jiUk; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=r/2/+gyq; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tB90jiUk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r/2/+gyq"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gddHh3VC4z9vGY;
	Sun, 14 Jun 2026 18:00:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781452800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZFwPhL76Qqpk9oAMaFnJIH0KC6sjbUVZOFc8eY36/g=;
	b=tB90jiUkjYH94JWtkDuQmWomJWu0/1V+BcJyU1/Mif1WPaBQzGL342F2hdqdYjfLicdkQL
	oN0PfIEludKCD8Fd+wX3AwFF4EMDfTAA/6eiSW3Nfevmx6Kko1+G1newmh8XlEkS5ABXdF
	0WR9P3P9kriyGMgn3u9sEIX9gRJRSsYtvyyxkqzxNQFJq23SV3SHuJyhA8YZkkEkVTYekd
	WKGyvoKHNLcUWrZCaShkGhDuTu8m7efywXBgGGi67aQwVdvqJRkBtVbMaF3+opWFT6w3Uj
	BTOFXJr5g90LlDY+ZozWnmzACFe/zjTZpHC345N//Ou83ZVdkx5jwKA7mn3/ig==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781452799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZFwPhL76Qqpk9oAMaFnJIH0KC6sjbUVZOFc8eY36/g=;
	b=r/2/+gyq+FWIiLQDIUUtFfDXshLI45/1S5B2YbTS2bao4rRJ0mENSVGVS8RN4i/LLAYi3T
	YW0TJaltZnNMNr2m5KaGupbaeoGVtln3LSEqNaVCknxjpx9/5b2mfGN0zPVkvEV92RaPFJ
	Q20eXqMGTTV24hKfZ586rTV5lYMaXciUmHy6gq8xeJ3TyWgu0OezjtBffSA/R/RB13bS0N
	e/+I2GoGrTmkuoSlp2MqaHPXxxJ07hOMWVFVrQLrY3t06/QPazTRqgctlvWxp+PEyll0qG
	/suKIJffbV/PTS569Y0rftgdQxLvXs5flWthSdBbsVZEeB2PcaTzsrqJq33VJg==
Date: Sun, 14 Jun 2026 17:59:45 +0200
Subject: [PATCH 1/4] rust: pci: make Vendor::from_raw() public
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-b4-rust-pci-edu-driver-v1-1-e3f2471b595c@mailbox.org>
References: <20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org>
In-Reply-To: <20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org>
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
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781452788; l=1663;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=tGCLsqt5ok3HZPG8PlNhuF2WCNGWutHwrwXu1hIjsnk=;
 b=wv01xKbHMiLe/ZNNl2R0R5M3htQAUhv/VnkeXDGEEROi6QvJvU6D4JjCuzqay6XyB47YkN3kZ
 u0hUAKB5ZCKB5ftt07nk1ufzli+tunm5UNPivn2BH20caav8aepmktE
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-ID: 3dc17c78845b7b2faa1
X-MBO-RS-META: 6pgfsb4riy4hrp6bze4q3rqxj5ejcafn

Vendor::from_raw() is currently pub(super), so a Vendor can only be
obtained through the named constants generated from the PCI_VENDOR_ID_*
defines in <linux/pci_ids.h>. A driver therefore cannot match a device
whose vendor ID has no symbolic name.

Such devices exist. QEMU's "edu" educational device and the legacy
qemu/Bochs stdvga both use vendor ID 0x1234, which is not registered in
pci_ids.h. Per the policy stated at the top of that header, IDs are only
added there when shared between multiple drivers; a single-driver ID is
expected to be open-coded in the driver instead. C drivers already do
this -- see drivers/gpu/drm/tiny/bochs.c, which matches with a bare
".vendor = 0x1234".

The Rust abstraction has no equivalent escape hatch: there is no public
way to express an unregistered vendor. Make Vendor::from_raw() public (and
const, so it can be used in the const device-ID tables built by
pci_device_table!) so that drivers can construct a Vendor from a raw ID,
matching what C drivers can already do.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 rust/kernel/pci/id.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index 50005d176561..bd3cf17fd8de 100644
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

