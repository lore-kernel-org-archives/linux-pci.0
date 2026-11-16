Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849098;
	b=Fy3jAWCbdoyO0UGVNUjE/+wP66ATxYxEYiVjwJoxIlvfqa5a7D4fdg/xnT+czn9ZhhQf
	 tXF7pCguwS6qrBR4TOtwxJgeZzf/PUlQ6SiFU30jjBkNLWYsqOIciD+ghkXfKzd2hZV9/
	 41IaOxzaysy9y4CR3dnVx4eyJCjiw0OxqeRsG266/66vovGDFtCwbT1BHmvws49Ig7DHC
	 M4VzMRvzWUPy6TgOi8f6j2vRrCZWugyjR5I9SWpftAqq0pKLlWTmf225T3CmHTw7t0g4D
	 HfsPWAr347zeDPUg7lNXXYZBNNZSHzg3ur5UUgvpnT6lv54ZRXOBki0TD0RFHvxuIbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849098;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EWYJEqFRTUobNmddIbznnQ/OTzWcNzyfTdRi9lSAjlg=;
	b=q9aQLI+Ynyj20fgUHBIcLAmCn/H1wop/3L2TtYTnqcR5e3oM568M17iAsyTdVkIIz+aS
	 SvgdSOB/d/dfkRhw7Rhsk/0zT2mRTPFJwhcGWRQXaN/zuI4lkanb6wukYTPdn47DRSi6O
	 9Phuc3c6Yv4JTI8IE0QxLaauGj0y+1rqHRPMUZYRjsj7sPgTd7hKCcWThSpv+3YEEFwD6
	 SP+ofqdvBm6n7RMzDqT3WiuevvcXOKSPjerJSTLUbsN/WOIX9kDKAkWjQyA4cMwRYSpka
	 h6ZTIhgsL2sDPHd6UrcFTKBzdSOq9fZKzf2SjNYRJgOKdacJLDLm+/Q9BaWoiCt6xiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrB7j3nr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD65606A31C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrB7j3nr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB651F000C4;
	Mon, 16 Nov 2026 17:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849097;
	bh=EWYJEqFRTUobNmddIbznnQ/OTzWcNzyfTdRi9lSAjlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MrB7j3nru+7I7Ba3oWuUt41ZbeZakwJAoh3JGZYBXHu5p+70GdfZlUe7FVopwszZs
	 JcU/wOf9SUhXjfFucqNr1k//OY16EZvoP5I1DtXQgOdQOdG4GpeWBgpK4itbdUFeCl
	 TtRsHDC7GIX9+0YIe8lhGfcFchVMC+PwyKgPHyABwuDduZmFoo7v/OxszI+glNbOUG
	 Vr4gkn/JeY5U1IEXcKxeZnXxsz1pM6peeG55REEISUVd8d24BFN5WPtyLELXj0zN1L
	 33osNCOe1Yz69xwrnewER2fJj4/ykw9mmLZ0ZEEi/M62Dn4sUvlzgobIQiRzziidYj
	 AWAZoFAMawLtA==
Message-ID: <sashiko-outbox-217416@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] PCI/PM: Honor PCI_DEV_FLAGS_NO_D3 in
 pci_bridge_d3_possible()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aviv Bakal" <avivb@amazon.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116165110.2773301-2-avivb@amazon.com>
References: <20261116165110.2773301-1-avivb@amazon.com>
 <20261116165110.2773301-2-avivb@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:11:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_set_power_state() does not put a device with PCI_DEV_FLAGS_NO_D3
> into D3, but pci_bridge_d3_possible() ignores the flag.
> pcie_portdrv_probe() therefore enables runtime PM on such a port, and
> on runtime suspend pciehp masks the hotplug interrupt while the port
> stays in D0.
>=20
> Return false from pci_bridge_d3_possible() when the flag is set.
> pci_bridge_d3_possible() must return the same value for the lifetime
> of the device, and FINAL fixups may set the flag after portdrv has
> probed, so record the flag in pci_pm_init() and check that copy.
>=20
> Fixes: d4c79b63d82d ("PCI: Allow D3 for native hotplug-capable Root Ports=
 on non-x86 platforms")
> Cc: stable@vger.kernel.org # 7.3.x
> Co-developed-by: Zeev Zilberman <zeev@amazon.com>
> Signed-off-by: Zeev Zilberman <zeev@amazon.com>
> Signed-off-by: Aviv Bakal <avivb@amazon.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116165110.2773=
301-1-avivb@amazon.com?part=3D1

