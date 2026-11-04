Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833552;
	b=pQ6cFlBNP6NaTEIXxzfhKgzlG9gxx3QA02T3lDnWtavkv1zmPk90dbX9COl01/8X4mmP
	 43omUgFpLw1Ru1/hW3SCONf24DIbIeO+ljGuf48JYn50Ia2a7/ruCEaKUMJ/L6A2I5nzq
	 TYoo4gdGCOdRB03YIbAg4LNLql9TN3HYlw2XHLWODXi9Ah2XXiHJTTq3JfdGCm3uKwnwF
	 X8gukSosfMUlvbNLLkkdALpdKuyr8BZGqDqiWvaR8EThvTny69LVMe9+XkohGKDDpUVsB
	 GCt8D5Ewa6pPRe5EMc31ItspfO3Yd8g3YjClwAVXjYuOdr3R3gojP/oxDelLTU19YKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833552;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-MBO-RS-META:X-MBO-RS-ID;
	bh=zk4WUdGtMBpXxFlU2gsTKHL5X57Q6FlmfAkxcOewlgA=;
	b=y40pD86OcGvS0Jrzn6am5Mgiuy3tRfLELi+285Ceq2iHIp+dz5ney4ML3S1kcjhN4Phn
	 4TwqC7vJkYUFy6ymaQMwWu6/gMvbeEE6yi9fm/+/did0vYHMFXErTjALMUuTLv2dssOmy
	 mhmuawbbtko7Bg1lHv1G+AaVSSTj+dT5LNit/bJ2jhBODg+dgRebe/ScbZ4+6+KIuMTLe
	 MIUvkd6m40yZ0oZYiWDAiT63FkpoAXkcMQQqBLhnwhedmZTDvbknUxTJAiTuYbjl9Zx6o
	 7p+L5qn6voxenMxZoiMeL5Q90iC87Cx00XVzT3emIkdTRN/tZloRlXxNztACNn+xjcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Cr5Tno3+;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9AD6082BC3;
	Wed,  4 Nov 2026 23:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B9AD6082BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Cr5Tno3+
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jKgz04t5sz8txs;
	Thu, 05 Nov 2026 00:05:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793833548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zk4WUdGtMBpXxFlU2gsTKHL5X57Q6FlmfAkxcOewlgA=;
	b=Cr5Tno3+fe+947pjEHRbQJWU42djxq9ROJ9nS5yqy0wxIDebBfo8wyXyGiKCENiQcH97tR
	Ra5GdRjEj+yTUtt60z2eM4wRJjF7bs5oDTumNsGUObPqLJgOlZQTac749ZlsuzI3/eF49G
	gkkbIwUrHsiauml+qdeVSv4EO3hfiDJ6Y4Ycd2vUnC/GeYaEe5I8emqatP2yMugVV82+8C
	CN08/j9FVLe8rhl1dbcgRxs5f0CSoWfaw4hgFDVMQ7I2RJ/QNoS77MmwooUvsFxdNtjBGv
	ZFPLYYZ/CL2K4+zX8eDkbXtrMPuYxIrxY67ZleoZHml7J4i4OBABB6ag9tKVBA==
From: Maurice Hieronymus <mhi@mailbox.org>
Date: Thu, 05 Nov 2026 00:05:36 +0100
Subject: [PATCH v4 5/7] rust: pci: add Vendor::QEMU
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-rust-pci-edu-driver-v4-5-20ef027bb707@mailbox.org>
References: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
In-Reply-To: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
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
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-pci@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Maurice Hieronymus <mhi@mailbox.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793833536; l=1273;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=HRhAsT9Seny6GaddcwsH5oWJkF9JcIp3UyvO8eRc4IA=;
 b=stUPfWXStt9A4zT/FGWJnenOAWvAH6mHoJ6cOzSR9fsd55OTNzblZ7itmjdvn4EVD1cf0E9Ax
 O10BMGziEJ+Dt0et4E5lIG0lWs3pMXMUOqOChM4Icw6fzrmegzgnFCW
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: shizh1y38efqmn11hq1ypj6x3zs1u9s7
X-MBO-RS-ID: e88ff492b45b83564d2

Expose `PCI_VENDOR_ID_QEMU` as `Vendor::QEMU`, so Rust drivers can match
QEMU's 0x1234 devices without constructing a `Vendor` from a raw ID.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 rust/kernel/pci/id.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index dbaf301666e7..d17706485402 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -418,6 +418,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     CYCLADES                 = bindings::PCI_VENDOR_ID_CYCLADES,                 // 0x120e
     O2                       = bindings::PCI_VENDOR_ID_O2,                       // 0x1217
     THREEDX                  = bindings::PCI_VENDOR_ID_3DFX,                     // 0x121a
+    QEMU                     = bindings::PCI_VENDOR_ID_QEMU,                     // 0x1234
     AVM                      = bindings::PCI_VENDOR_ID_AVM,                      // 0x1244
     STALLION                 = bindings::PCI_VENDOR_ID_STALLION,                 // 0x124d
     AT                       = bindings::PCI_VENDOR_ID_AT,                       // 0x1259

-- 
2.54.0

