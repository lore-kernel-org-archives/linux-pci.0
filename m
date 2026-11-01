Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793500179;
	b=37O2Q0pTwEioW81kHoRnHrcoUeghCyDTMrK+NdVh1zs4jjzVNLHfQm3WykshSCmMRBtz
	 UGgd3LYv3cDdEKWKaEYww4E296zlNOgY8Jx/BWbFxp/QofrI2OVr0Aor/J48VAq3MIwpp
	 Jfnm0aB6UT2YmtluxQ6Si7PlZY35efUIgzyEVYJdcUTrU8PqoXjOACZjebpzk/PpqZ57L
	 ztBtUop0iTEQ02Fby7fYRvqmFRTl6o0EPWM1BQq/QgxmMjecrLTOPSEwvVgUiBCagUCXR
	 fpRp8m74b/Tq0JZyRbovA+SNY+nXmsRQXKWCabp04zqngddOZDTzRgnvmf2QNnqZtPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793500179;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QwJRDbNXrwnuk+VCI9U8YTSAjZbY4VYhmhDhTn6RkZA=;
	b=1kADG405SHzdrWgY4c2DiULkv1vUt2EB5HwkNgKaobWaQgf5btoY6wSAylyNOJxJpPNk
	 BoV1cvKycNjKxeq86K35jRT1Zfh/KmMLr2HIlTiUwtSwtQLzv93iISPEQwoHXP625CMZC
	 889QJBk1x/Ji/GA81szKP1YK+kI1AwLOSkj3evurKPyiIvL5tOfKXvkZ4Gi0ADm4uK792
	 j7sMyJPDO3yL/K5gn9nnjD5q+I1O9JgJH2tXfd+1q9QI0OOOYNfuLValRCpXE62w6TOVW
	 HVLZBRHbVvkGkTNGXV8SGOPdSpiefhgbqqIr6ONQJgck0pl2BPCwnsc8IPje3S4w35Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AT/olQc8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC19606A324
	for <linux-pci@vger.kernel.org>; Sun,  1 Nov 2026 02:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AT/olQc8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECCF1F000C1;
	Sun,  1 Nov 2026 02:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793500178;
	bh=QwJRDbNXrwnuk+VCI9U8YTSAjZbY4VYhmhDhTn6RkZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AT/olQc8Ey05eYaY3BgQsXJHqmcXrBnwZqoGdg16yCHHUViTIfj0LzI+iin1G+PD4
	 uC0QpFqmScitW4BFajDH1qYVUEn7HlPqqL3L6PL9p79PWOnf7c5Ek85fjnTUwFMaP4
	 yEaDsy5mCwC+HdEfCog/JzSVuxym3dZZwtGvc1VSIqdPEwIc9KiEe2CePvbdRwCs9E
	 oLhLTw33hvtS+kgsZlVqXT5a6qCk1DXjLk0y+uRB+wmjuFT8YBtutdc91ZLSI69goe
	 g1m8P9X0bFg3j2cuuBaH3fEL/cfB0uNbGzgI2qV/ITubo0FPJ++0RXK123lHoYHuE6
	 EP3UHgYot7JyQ==
Message-ID: <sashiko-outbox-192249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/1] PCI: hv: Spread load across CPUs when selecting
 effective affinity CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261101021928.52649-1-mhklinux@outlook.com>
References: <20261101021928.52649-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 02:29:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> In a system with multiple devices with the same configuration (such as
> NVMe controllers), the affinity masks are the same for all such devices.
> Linux typically must select a single CPU from each mask to be the effecti=
ve
> affinity. If a fixed algorithm is used, such as picking the first CPU
> in the mask, interrupts from multiple devices are assigned to the same
> CPUs, while other CPUs are not assigned any interrupts, producing an
> interrupt load imbalance.
>=20
> On x86, the "APIC" IRQ chip avoids this problem by spreading the
> interrupts across the CPUs in an affinity mask. It tracks the number
> of IRQs assigned to each CPU, and chooses the CPU in the mask that
> has the fewest assignments. Because Hyper-V vPCI device IRQs eventually
> parent to APIC, the spreading done by APIC accrues to Hyper-V vPCI
> devices, so all is good in x86 systems.
>=20
> [ ... ]
> IRQ chip (GICv3) to actually set that single CPU as the effective
> affinity in the virtual GICv3 hardware. As a result, IRQs are spread
> across CPUs like on x86 and interrupt load imbalances are avoided.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101021928.5264=
9-1-mhklinux@outlook.com?part=3D1

