Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833551;
	b=MT5C9rArU8pyPY90XEO2qhCS4STJVMY/rmVyDNYZRar64l+5O8jCKe/+Pqu7jlKznoHB
	 K/EC0UTBpixogv1scFPs6jzBPTVUjQX2ftmcBj4a4O1R+2YtLpY981OGcUaiCYqS04N3o
	 2q0/ExwVeZVPni35T/KFtDvIaNnG9xN+GBTvTNzPwTlp3i+isiA5Fqg8sHUPk97LuY4jY
	 7UQl49a53Pl+QEY+oUD8Ag90cgJvURhsbq4zb7D19PlTamhDS2hbkDs+rSearqChSJjCP
	 7V2uRZt+L5+AVOcyoFgCxyihP7ZZ2Sc3Ts1L9pOxorwfpMXiZMxwB67U80dlFTcMb/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833551;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=O7Wi1etGNUVIdurKEPzA6gorENn4qVeeea4blBWClKE=;
	b=wi6XGV9J7dP5c/5Vszjn2hEIKai3VXoC2CJWGCQFPbxwKftMq5+hx0ldWgT+wTg2GpDe
	 M06Cqzzw2tMdM1Tb9STQbpB+Yw3u8FczSv620GcitmM4XzoX5yzfY8vu4gDqeaUltR1zO
	 hcO+ilrBb/ySVah1q1V7DN9AlPJ9RgHWYMYaid3YRFluXnuI0oN3Yg9a5z/kPbV+w3ivz
	 OXug4NqyH1AtP6nQV5lwiwH+TIS731icM+ITxOJNK+vEXtaprpADqhB4yIc8aXnWxLW2V
	 nLffjMaOXi/uoH0d/2SUJyCuAejQoGzFFTuF9xHqCO/4390VdKEbI5DQD5NaDE9mWwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=K2+vGlm1;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC44606EE96;
	Wed,  4 Nov 2026 23:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EC44606EE96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=K2+vGlm1
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jKgyy6dlrzMlch;
	Thu, 05 Nov 2026 00:05:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793833546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7Wi1etGNUVIdurKEPzA6gorENn4qVeeea4blBWClKE=;
	b=K2+vGlm1YQkcJvBQNo+CANBBQA1e4TFrYjLEOuoL3ho55mW4Gx2v0bEb/DJ5g+MKG0ZPBO
	EQIHBTuN+Oj8YJW8mzLZqGnioSEcI8CMeqcxM0O/5XYHQXfJoCwkNYIgoEO+lS/ETOjB1O
	F89meCHepoQ5C9sHihzUYJbbebioFju+3vUQLTQPAqtAPAkQ3vECt/AGGiZ+9pRWxx5pnZ
	gOe5x3t2M4xwA+EpNROadmQyxyIw8m3zCPnIqZs6gKuBrdgSC9fT/KqJ3YITdlzY43FoS1
	N61tLeroNbdSvjLi/zeEQSXClJqboH0VxnnOMicQgHyJGKYBPMSPDM59QIV4eA==
From: Maurice Hieronymus <mhi@mailbox.org>
Date: Thu, 05 Nov 2026 00:05:35 +0100
Subject: [PATCH v4 4/7] PCI: Add QEMU vendor ID
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
Message-Id: <20261105-b4-rust-pci-edu-driver-v4-4-20ef027bb707@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793833536; l=1050;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=AhjbnhWED9YTAm36AFg3tiJVQOaIEb7KUxSljsy47ZQ=;
 b=zgDYFbsM5/oI+rGp9iajpXIB7gAm72Ik0ePwHLBiV9fq1qes2t2TBtSHEB7LiiEpDgex46/7d
 9vK3ZaxBDuuAjiA/1/+/0/BZPJiX32LoWFPV1ZGW7X/56g49xN5AKy/
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-ID: e1b148c86fcd18fb8a6
X-MBO-RS-META: 55j5qk1ejj7iab9tdb3ock5wp8zra78z

QEMU's emulated PCI devices that predate its Red Hat vendor IDs (stdvga,
bochs-display, edu) use vendor ID 0x1234. It is not registered with
PCI-SIG, but it is a de-facto QEMU ID matched by more than one driver:
`drivers/gpu/drm/tiny/bochs.c` open-codes it, and the Rust EDU sample
needs it too.

Add `PCI_VENDOR_ID_QEMU` so these drivers can share the definition.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 030c86dd6d67..cf384fd96f6a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1754,6 +1754,8 @@
 #define PCI_DEVICE_ID_3DFX_VOODOO3	0x0005
 #define PCI_DEVICE_ID_3DFX_VOODOO5	0x0009
 
+#define PCI_VENDOR_ID_QEMU		0x1234
+
 #define PCI_VENDOR_ID_AVM		0x1244
 #define PCI_DEVICE_ID_AVM_B1		0x0700
 #define PCI_DEVICE_ID_AVM_C4		0x0800

-- 
2.54.0

