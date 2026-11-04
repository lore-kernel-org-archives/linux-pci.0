Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793834078;
	b=O1AH0KIwQ4n8eD6DYuyBJfT6Tr6KyK+iCXOp/hOVWFzrBJo4189i0Q2AgrXyrcrGLuyk
	 BTX0z7yHJM24WuJd4OnNje3YjDDnkFv8V7Ec26xy+PYYDyT6CkeuBHqQ2VrPvzkKaVwmG
	 2EZeut5k3Z4aA+GHM+Jt4XCJpZdxRtvaIDfxcZ2IMHuDFcUA8oIgLCyt2J7HMZ6MuzzAq
	 6bMyuWKNS7O+TOeX+/ZAYeWNJeiddboVsp0qS43AEyn0kmvSquwPFp906OYA9szVsLTs2
	 xSCgKExgY+U7Ho6KvrKPjjf+Cu9VbhZjp9j5quIJVzPEKHRvdvqSo1FWDUCmN+rTBqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793834078;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=olr2JirJnq052z8Fle5K0wt2TLpL4q9H9iZbSUBUTIA=;
	b=xleVj2WhHmwC4jXME9X+I9FDJJNrQGWcCkCgRTXcLRwgM275SSnMclJBFzFMHhMdPQSd
	 637OdWj+6bvQclf+Wk6bFuSpJ22oR1o06UmV7cutVSncg/MJ2TBiAsCu3h0ypG/ew1M9l
	 E5ixCXjA6Ag4cKaGh5ruqAp2r3YoGAXZrlYDF5sx93XFO/woACzdh51+NCMGaMR484/5A
	 ykt/So/v7eMRgjDTL6uM/xGlnyY7N9R1YuCSolhrr2L7Tw+xjOhiiwkPnLrnJkjZDOZkn
	 zpd8D9rYZYmBxgR5fMRCJb1//tn7YF29Yxb7NrzhDAoW2qjEHBpex3KArZTERQs8Fag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrlsmpLH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6F5606A326
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrlsmpLH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C811F000C1;
	Wed,  4 Nov 2026 23:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793834077;
	bh=olr2JirJnq052z8Fle5K0wt2TLpL4q9H9iZbSUBUTIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IrlsmpLHk59CiJeMRRmBQ4F/vRf7mZKZaT9nUDeaT2MP2nuHhQ3rqDurpBp0N2X5H
	 U6r9URgn788DyEHSXVjGYkTJTXRxVo5M4PhqFfEsbbLvErBbzkbsSDmkzpPquweHb7
	 /DcIAyzSARIQ/tl/8LL7Nm+A33SNVhgJQfljQhQx6LfT2OjXFbA659YVMclg3nIjq5
	 u6C7F2Esb8FcjKAgW2LyEZyPX39LGKvkq99p7YRS9E6WrcZDRVKPdXR4b4U44GYalW
	 MjjcVyeRCe+0ssHriAaXh8bSBBYyqtaeLeipa5/jJaqcO5VeWePFMkoB4r7nktfaU4
	 x5P9Jt6LNjOpg==
Message-ID: <sashiko-outbox-198282@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] samples: rust: add EDU PCI driver sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-b4-rust-pci-edu-driver-v4-7-20ef027bb707@mailbox.org>
References: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
 <20261105-b4-rust-pci-edu-driver-v4-7-20ef027bb707@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:14:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add a driver for QEMU's EDU device to demonstrate and exercise Rust PCI
> driver abstractions without physical hardware. Its probe-time selftest
> reads PCI config space, checks BAR MMIO and factorial computation, tests
> MSI delivery through an IRQ handler, and performs a coherent DMA roundtri=
p.
>=20
> The sample uses `pci::Driver`, `DeviceEnableGuard`, typed I/O registers,
> PCI IRQ vectors, `irq::Registration`, `dma::Coherent` and `Completion` to
> manage resources and wait for interrupts.
>=20
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-b4-rust-pc=
i-edu-driver-v4-0-20ef027bb707@mailbox.org?part=3D7

