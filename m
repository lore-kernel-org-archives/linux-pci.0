Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895499;
	b=jXoFCnmRViuENnLxaw8uXIbANzKYFTW3vpvZmFakBW5/uL6pe5pZNIRKcU1yVsabkqfe
	 0gpL6NogjaobNVOa8BzIp/NX/Khoa+zC2EmJEeRRuWiT7eMvc5yigXsB1BZbaA9LJzWy4
	 LEWaGQhtoNj+3YVYRssMa6F34Ci43xmk6hyd6TDqrOF7rG1D3tmhnxht1fcmfz0F+nsZF
	 QEeLiwgTfd/nY2cS7vpnDolamoXlE7R+3ylkfFwwemuo/F0A6K7V8HUuQ73U9SVCDC0j+
	 DCz1eJ7BSXdDTkVbi4VvoKKpA9WxmvJ8iC3iRU6aIIGKg748WC3fspe1Ota2Al6Cnhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895499;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4dKBswYpCBDBxURqQHaNkyoRiBCt1pIuzEKHz0f1tfw=;
	b=b8dLeZtcr8b3x+uu7iAqO56TJmk8KgHtYm1IRJVxYQBXMNEzjetpmhYkZvNzaK0L68vZ
	 NXA8odd2SC1Oi6ulz0FkNEjkYY6UgHepLA8t2UKAW4U3G7yk96LEF9wsqjIJsLA1yaN+Q
	 PvluStXJ1AhT5v33bnHXjR87zmwZSCxI2hfagNQN2n+YGvBr6sIttPjDwyZlGXffHDHY4
	 j8zjB3I4eXUIGZHIEZFt6fBJEaSl66EIJMUvrdx9v8mkxHEbKY1So1ccLERODYwJlkpxC
	 pN6a4VGgrCNzF//OFAu5GIdnC1N4JS0KE7m5VMfDk35oCIMxkW+oQDz2oOYe/tIwVZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCeBzF5h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E51606EE99
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCeBzF5h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADA41F0093A;
	Thu,  5 Nov 2026 16:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895498;
	bh=4dKBswYpCBDBxURqQHaNkyoRiBCt1pIuzEKHz0f1tfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gCeBzF5hQlRTbKb2aXHXkr6rXJtqSj6KoB1eJt5Xya1OrEcOOkZsk5FAyp95v9R1H
	 tvHLM7z8m+VkCKovtFqTS+qEfpbfCBOFfh3fPrHy4KQfl/AywnpsjGem8jfZ7ic3Os
	 YXMZLeoEi829OoAaryOi0N5A7CJVIjMZpOOOeZVbrRpI1LcrUTGHx05jizm6dYcSel
	 Sm9ayuzl4/XzLh21gznwok/MXjJtQWHWjcPWks5BpnUvMyushem32Vckk4h/MjODjM
	 +X44WeudgzKXqPBVay+5Zjuxt8AlfUXMYQTM8VT2TA9k5hDXKJKY3e7VcfnPOdHplC
	 +83D4ddRsszbg==
Message-ID: <sashiko-outbox-199465@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 08/10] PCI: of: Set fwnode device of newly created
 PCI device nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103155540.365294-9-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
 <20261103155540.365294-9-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:18:17 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Device-tree node can be created when CONFIG_PCI_DYNAMIC_OF_NODES. Those
> nodes are created and filled based on PCI core information but the
> fwnode device field is not set.
>=20
> When later an overlay is applied, this confuses fw_devlink. Indeed,
> without any device attached to the node, fw_devlink considers that this
> node will never become a device. When this node is pointed as a
> supplier, devlink looks at its ancestors in order to find a node with a
> device that could be used as the supplier.
>=20
> In the PCI use case, this leads to links that wrongly use the PCI root
> bridge device as the supplier instead of the expected PCI device.
>=20
> Setting the fwnode device to the device of the PCI device allows devlink
> to use this device as a supplier and so, correct links are created.
>=20
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155540.3652=
94-1-herve.codina@bootlin.com?part=3D8

