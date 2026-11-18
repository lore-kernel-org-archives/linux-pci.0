Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016427;
	b=TY3fBFzr1zZisEi0euTGvT4t7l/aAFO84SxsR68rpj0vizRb0rnUsA2Cp+s76Kd58+8b
	 Tck8mzbx6HUwBxAHrc7vscQO4AtYMuNAnbZDTdYmeIGwsCZWgaoE8A69/zUsJ4rZB/atb
	 JlJ4/VgcKlj5MUn5hs/SrpC1Y3KpBJSQUcXsL5BPJw/y72kYVabb0k5CjnpRJEXGwH5Li
	 FgdzU8Yz0sfl2Pdn0IpjV3MWVagUIRAUR4zq92OqsdzMj0ZzZtD9gkJDOmGtbD5EsOHIy
	 EQcmwAwzv/B59YFrxImE1xaVHn57SOBaHCpI1krFbou9rbgbBDW9O22XeSl8HFr/PzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016427;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XZRADTVJsKmBl7kqbVioRbrVexYrtmAcvXROG6qIG8s=;
	b=vcI7dYJd0w2oX+t6SFgFOSiF8xz7dwXFiEkmpe2TQoCsqXVpUFkDnGUZfqAOBN5y4cMI
	 3K7T/ZAJFTvAbvWqu/2NhQ2/hFOSxNK4c6dFQ/WS0Hj8zrphSR6pwGujySsI/O57ugmt2
	 XziiEzE7hIJKrn3Jwn6Vmqb1RGjjYq4if2y2X2+2GNsGgyahikXFir9lcKOGBjkpB0bee
	 Is9LmIlMmGuUY1m9f+tgEVDhvSres0NiPhzvEWNhsfzP+/+10KLdTrQVaQG8bJXQvswG4
	 Xz1AGyR0lPTELDVcy5tTJ3ku1fNKXuL7cuJQofx9DYHHnUYD8x+Y+6KDzkFspXOvH4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBjD6C+2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CB8606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBjD6C+2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B541F000C5;
	Wed, 18 Nov 2026 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795016427;
	bh=XZRADTVJsKmBl7kqbVioRbrVexYrtmAcvXROG6qIG8s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DBjD6C+26aSerpkp5YfVJFOXxxbl6HmjJBAP1Y/PiUNS5S2TeziEndAGW5r1L+1DI
	 FC6WF/38aZcVYL0zPDfdozxQY+1YCWUoE/pUNxjxyIN1P7Q0hD2yMrGoCcmBpWsFQR
	 cMXtBZ+eAD28NcYq6nfmJ97R5lMwAzCaTuf3WhTW4QpAEGQEop7Px+ubKvEwzU/AP5
	 bsJLUd/9pHNFZGI7JUI5bEx6m2dQ/R2jjJqNr6qPhbacCXnZEwZI1lDWKPCCT/NzCQ
	 6EZF/Wx8QVB/kxW7ka1dAC3aTC1g+Giyyb/P8NlP6XX827qp769hHggpN5IeOwyYx9
	 GMq//3d8vJp2g==
Message-ID: <sashiko-outbox-221352@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Encode corrected PCIe port type with FIELD_PREP()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gokulkrishna Sekar" <gokulkrishnasr@gmail.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261118153505.95686-1-Gokulkrishna.Sekar@harman.com>
References: <20261118153505.95686-1-Gokulkrishna.Sekar@harman.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:40:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> set_pcie_port_type() validates PCIe port topology and corrects
> invalid upstream/downstream port type information in the cached
> pcie_flags_reg value.
>=20
> When performing these corrections, the code clears the
> PCI_EXP_FLAGS_TYPE field but writes PCI_EXP_TYPE_UPSTREAM or
> PCI_EXP_TYPE_DOWNSTREAM directly into pcie_flags_reg. The
> PCI_EXP_TYPE_* values are decoded port type numbers, not values
> encoded for the PCI_EXP_FLAGS_TYPE bitfield, so the corrected type
> is stored in the wrong bit position.
>=20
> As a result, the cached port type may not match the corrected
> topology and subsequent users of pcie_flags_reg can observe an
> incorrect PCIe device type.
>=20
> Use FIELD_PREP(PCI_EXP_FLAGS_TYPE, ...) when updating the cached
> field so the corrected port type is encoded consistently with the
> format used in the PCI Express Capabilities Register.
>=20
> Fixes: ca78410403dd ("PCI: Get rid of dev->has_secondary_link flag")
> Signed-off-by: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118153505.9568=
6-1-Gokulkrishna.Sekar@harman.com?part=3D1

