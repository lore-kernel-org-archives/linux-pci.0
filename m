Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425934;
	b=hIAvAQ9o/DoFpggAX9rQUZv49eOpbnhTYzwhtxUC20Q8qATTxh3vXO3uMlf1t/qEc/sj
	 fjxjGfPngD/PU6bEew3bNmogs6FuIWbwXrJUcrIm94aLwGcE2INLdLPr8S9NZL0eFZMNN
	 xBBjdOvqT4/+gPaCu1e21e0XK++powEk8PIqHMaMqrl7aG+AHvUEfzMJ6+u8l7LcbyTcB
	 QxGSB1jkvasfAeTE6oS5ycKKJ8alx5iz76VyDDw8tbGMWY5nEUJoTtuktM+y36wit+3jj
	 q2WaWErsz3pSFRBOobaZaocsGaKP6N+BhAanYPg0jolw02wWNpQAkfclsGa8kNQNcsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425934;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jIvyyl0sunFa4lbMzzxaOdGAcfkWiP45VRxDiVZ1b+Q=;
	b=AcU6YxhYJxOno5aoQRb4+RVlB2/kzRVGqW6yf+CalRhqxrJphtvatx4JJ0Ga67zMGTLZ
	 HcTCkEVBME7Lu9uOD/4NJgpV+CGiC7ODbIVjmX/SOXkDdwifDmwEFbATp6OFkaSwhwfkO
	 g4A3mOK3q3UAyDjIFYhVanw8fmbt7bBbnVY4t/4zB/wc6hACm2JEu/eECPbcUyse9AGar
	 oq5+ssdeZ8oeEEjfd97UPX8zPBn1Hr3xnaukGOI3m3y7Kvcsev+sGc/+Q3LKFRI5uElaP
	 sHH6I+RRUf8CMY2qgySBfjqduFebVyByL2yGbai+m3TtTU/2xxg55b3VtvSWKaAv2SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOYBAA5a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265A606A324
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOYBAA5a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE1B1F00A05;
	Wed, 11 Nov 2026 19:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425934;
	bh=jIvyyl0sunFa4lbMzzxaOdGAcfkWiP45VRxDiVZ1b+Q=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DOYBAA5a6SfgQ0jQh/CBXv6HuL0RId82EYcg9P4CDqYDXafiA2xc6TTDxRsHrzvD/
	 yVZaXXbpvFxMVum5aqZUOILXgQQHhqkDeZSO4a7ShowJaFNs2HvX/Cr7mn1p+xI7RL
	 awyyzT+j6kp8RVC8tBwfDkX9upRwotiJ7xdG+cJIa56pEBfrgVhPKAQz9M8EdmahkS
	 VXmcAtM1qOVB80Wry896afPe/lRJZVaCCVXXk2IfZVPMB53CWiqU2EelhQlPGqmF+4
	 Dpz98c3JZ8S17bGlZPmHkVgSA7rAdYObc6tf++njD9viaGEHmtFbJuY5wzZPehuEQZ
	 y9e8V/Y51ZqGg==
Message-ID: <sashiko-outbox-209579@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/7] vfio: selftests: Verify memory behavior in
 vfio_pci_find_mem_bar()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111192411.4133780-3-dmatlack@google.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
 <20261111192411.4133780-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:38:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Write and read back test patterns before returning a BAR from
> vfio_pci_find_mem_bar(), restoring the original contents and
> PCI_COMMAND_MEMORY state afterward.
>=20
> QEMU's pci-testdev exposes a readable, writable, mmap-capable BAR2
> whenever membar=3D<size> is passed, even if membar-backed=3Don was omitted
> and accesses are dropped as unimplemented MMIO. Probing the BAR upfront
> lets callers skip cleanly instead of failing later DMA or fault checks.
>=20
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192411.4133=
780-1-dmatlack@google.com?part=3D2

