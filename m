Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054945;
	b=L/wpuTVqjatgz5IU+sVmdG+AScDKjMDEWCJHDszdalFi6KOl9uAbL8mxDLCuItkwQFbm
	 Qg6R8o3rdiM9sdG0g01VN9iGLLjkTDjo9scL0kJbRfjxL3XHViCNryRghZ25/wfG3MjZG
	 r5sQzVkAiN4NlnRSu5keQQQ/YKnfmso8tkYDpOnEcGSOgfSLDW8McfA+SF7CftdKEx4fc
	 TTnitOi29ShzEnWbBkGACdSpBQ03KJX/Z9taDm/exkl3aCEif8MSpxaYvqnLrXrKhoz0H
	 ClzS+itN1u4H3F/Sg+LQEiEK63igfaQnmENz5vzO6xS4bEXjB4VnlSfN7+y56qJ1lug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054945;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q6WnDZoiaDG7U8sEOPpH0Vweg2uKvoBVyfQsmSBbHTI=;
	b=GS5JMD44VYR/s/OV7+56wi5TizaV4i8H0YaxDt3kFWB6N9RYybzbDhUx7nJZb06JwjBR
	 dLu2uJVnNQJnxJy6JKOfCD0Z/Lupyw4ynE0dKo/UNGW4OGKPWDRmyueww+QUS0Mj6/9UU
	 UdebL+NTbqcePHlkPAh9qd/Tdy2TgbHvCkRxPjyaCN25+d3sdfrpbTaJDmzJknnxSAFLx
	 Z0QAKkxtVR9UnKC8+47k88v5KW0ilJlKePKToG/asMaEYIWaN5xlMPrFKXxkHE5/wGyyp
	 7hmFqit433PrLnbvGTda33PFdtqPv772Smwdzgo2yptU+q4N+4NY5lrp2R0b6ceYK+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e1/QXUE6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B4606A31A
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1/QXUE6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0765E1F01825;
	Mon, 26 Oct 2026 22:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793054944;
	bh=Q6WnDZoiaDG7U8sEOPpH0Vweg2uKvoBVyfQsmSBbHTI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=e1/QXUE6t19Hc7Etd3Xv6lTEsOcYs5Aq01DgMnB2NYBk1VMs55Wux8kM4tBGEbrTk
	 oqXSuAc0oWyBzWJVo6j32k3TETq9/3yv8sBxfhJtkoKnnB/8vfLSNwvSOD3QPKof50
	 mnrHOGP/WAu2dolZZbYr1dmujE0b8QPvj98bKT3A3aU+m3cjG2KJIK5YCvnhyYCr+b
	 AnI+/tkaW0REe4H4k1z+Sux+UEMa0UzKsf7uuISO3VT/ST9AawRrk8aVgL3H/B2EeO
	 y5lundFS84lcEGpR/bjnYeiWAtrtQh4TWj+cluBD5z0i+P353VSvD/M38PuHTr+TLI
	 VylLldvLy0DYg==
Message-ID: <sashiko-outbox-185810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: rcar-gen4-pci-host: Replace sft_ce
 IRQ with AER IRQ on R-Car Gen5
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org
In-Reply-To: <20261026224447.606715-1-marek.vasut+renesas@mailbox.org>
References: <20261026224447.606715-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 22:49:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The R-Car Gen5 SoC PCIe4 controller does not have dedicated sft_ce IRQ.
> Make that interrupt conditionally available only on R-Car Gen4 SoC PCIe
> controller.
>=20
> The R-Car Gen5 SoC PCIe4 controller does have dedicated AER interrupt,
> include it from the beginning. R-Car Gen4 SoC PCIe controller also has
> an AER interrupt, but to retain binding backward compatibility, this
> interrupt is kept optional and added in a separate patchset.
>=20
> Fixes: 5b555a496160 ("dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H=
 PCIe4 compatible")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026224447.6067=
15-1-marek.vasut+renesas@mailbox.org?part=3D1

