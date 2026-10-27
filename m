Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089225;
	b=IzOhQDvZheOpesbf9RE4aO0ukG82lh0EvvfFwpOSi9bIQ1pl6QEocixEHuIJ1q1Fl/7Y
	 7a2IsW8aco/s23NzO7XOZqvoQUZpzy1DjkYMqVKfBUYQmcZN868I5HyOj+0ak63Ue85bx
	 s13tNF/2OQ2/hWx5DFO9cjeB/HrVpasi/FkpOneO+Pq5oAwnTNzi8J9HY7poupPdv2UH5
	 Dt1ULMReKSPblJS3cG71O/h/4kfNhW6nUH+aIH72X8eyUFqBe+n2Cvp7K+iXVEtp95BA6
	 uAta78pz+FF+hEJE3EUwYbgaGaKvscAICiS5dEobygqEMEaTTfPFcbo5r049Qav3CmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089225;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Dc6nTbgetndJa/rEduwSnVZsvBL0h+BNt60D8sM05u4=;
	b=PqZqZDY7RfPMUVrbG4P97N879DXjTUcxGVF+VsZSPDgSeZK0+8mNKkC5uReXNoU13+KU
	 ZkkybKrx8/O9HFbIYvfKE+xQuKr/Ehed3A/BPWQwv4Qk//Qs8qRuXW1lBGZPqLInhYL+3
	 6rAaRbTauOM138vv3NSY+fTRn79hhTG2RDqNZkGYpjw3gSaJtVa2WK7Wo2QUUW8n+Gsos
	 PJnnFEq/kYaibmelpi2aD06k+vUWrziyE4qmGUzrHm3MNG6DOWb5Hm3EkgcTEWJgm4eS1
	 NKK3JvFRXhS7aL68FVZlUz5J57P80rnUSMUQD34MELSQPz/52mWb6A6MZeVxj26fSJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X66XoZki;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C079606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X66XoZki
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1301F01825;
	Tue, 27 Oct 2026 08:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089225;
	bh=Dc6nTbgetndJa/rEduwSnVZsvBL0h+BNt60D8sM05u4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X66XoZkiui+uOtFx6VYcmJJq/xNmu5dvh2ryXC4E3g2C6CWkWKyU3ZpzI6O7/7hAK
	 LliASgVHCh9LW74M3dpoeljgFV5HwO4i8ODDNZHPkW/7WS9f8hL3GQp0aD1dZtqyBU
	 5NvDtb0sz2O8kGMAEmGAqXZd/EO32sE5cPt/1phDyxaZ4a6vGNrOWn4eGnwWedSa11
	 yzquAXH4ZC85PfFttssd34m3c4vlcjK+4y4nG4lMwkVjjr636BBzWTM0zHYgwWhg7s
	 7F1HPUe1aso2NqcemFNw4vkR/4R7pX63x8TfF3V/NGDhgLIVGR2wTPrBdTdXgrvGiU
	 Q65tUUIAUM6yA==
Message-ID: <sashiko-outbox-186281@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] pci: Support preferring MMCONFIG for all config space
 accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Triplett" <josh@joshtriplett.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <a7d2b402784a409f5564c1fdce77a41e09f29280.1793087687.git.josh@joshtriplett.org>
References: <a7d2b402784a409f5564c1fdce77a41e09f29280.1793087687.git.josh@joshtriplett.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 08:20:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Even when MMCONFIG is available, PCIe currently defaults to IO-based
> accesses for the first 256 bytes of config space.
>=20
> IO-based accesses are serialized, and can cause substantial scalability
> issues when initializing a large number of devices on a system with many
> CPUs. (Those often coincide, because many systems have PCIe devices per
> CPU.)
>=20
> Add a `pci=3Dprefer_mmconf` option to use MMCONFIG for all config space
> accesses. Also add a Kconfig option (default n) to make that the
> default, allowing a boot-time opt out with `pci=3Dno_prefer_mmconf`.
>=20
> Tested on an AWS c8i.48xlarge system, with 192 CPUs, over five boots
> with and five boots without.
>=20
> Without:
> PCI init 266ms
> Boot to minimal /init 726ms
>=20
> With:
> PCI init 213ms (~20% faster)
> Boot to minimal /init 661ms (~9% faster)
>=20
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/a7d2b402784a409f556=
4c1fdce77a41e09f29280.1793087687.git.josh@joshtriplett.org?part=3D1

