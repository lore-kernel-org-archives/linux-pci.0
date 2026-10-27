Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104324;
	b=BI8xT/RozegMkfW7E7w3BUJw01+pyCodf0Lf/u/+hPoFWNIJMan/AfGQh88kkzhkGd3+
	 sjAScdMYR5oPnl4qYCmINY08QRQ9Rxyg6lP0fs8+tjuGo7bquAZY+CBEcyEY+mBayF8A+
	 bM8hWBXBohfWAn1+QBuYTH8neHg6yMvdOobfY8jI7a4wp5aKIzBqPmGeM+q0YH0WHZxPn
	 M3vAgQ2y/QYXmMo/wJ2RwJyRlwHvx5soG13aNPH8cVJvqjwR6YGYBgOaN7pANgqVpYPHD
	 EJtyypDSJtF5MXudB1no0L3ThtZm0mvRWHqpfHiyMbdRlxs3kTmUWx7b/yMaiSZ/Vbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104324;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tUPP5EnXEOh3ZR/xT7ZzPJBKDXOO2vVmY0jIu+wIj+c=;
	b=TXwjpCRx7Vnxy20S7EmGek03Ukw+26UVE2/ky++xG0wyAimQGu7sHR3TbLjRwYm8bU1o
	 F9aCqRAFc0RPRYLbFVwqHroBXsAZZK0bqkQOG8FWNkeLRQPuscZXDxnj4zLi28y37Ds/2
	 HItQPGKZnud0PVQwsp0uuY4oGRuYfwOBJcNQwR4XmyovVH1NzTjZLSD60UbBEVeEalqgL
	 xxDrAZ+U9JMEjr9HFZYKdV6OMbRUVv13y/r9tXJYsbAZ66dWqwBboqg6EjR20UwhHn1fe
	 F6IWcdoy2dvdBm5G651aZMZ4d8CToMlka3aA6i/GMDMuoZIwG68Lkt9CjSvi/lbpnXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OezvACpr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8AC606A331
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OezvACpr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D241F01825;
	Tue, 27 Oct 2026 12:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104323;
	bh=tUPP5EnXEOh3ZR/xT7ZzPJBKDXOO2vVmY0jIu+wIj+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OezvACprxhxwlQ2d+kJimbsRvqIGbTO6QFovHmxP7EaZUfliDj3qfhd8HlwwcGEVI
	 9jogdd+s6bnVMcx6l9GBTAWL9WtyaM7lGcG7lnHoUkmqNYSR9tx6vW/oe23dT2VYu0
	 kXur6UqZry7R0sGO2LsJD2LWZWYaNoXRk3d8xRw+Vz2I4o1enM4i5fiqtAbpcvk4/l
	 juiGucu9hDpBjf8E12SI09emQvWZQ5Pf5pDDWcKoMYN9fGesY5lDv8Gqm6g55QhKD8
	 26U6om/PVXS/NkAoH3k/a6FmEzS9EMM05L4Z6VY1RfYi+pWrZ4K+If5IqO3P3hD3JH
	 568ewlVgmFSBA==
Message-ID: <sashiko-outbox-186550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/16] PCI: dwc: intel-gw: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-10-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-10-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:32:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> intel_pcie_link_setup() is called from intel_pcie_host_setup(), which
> runs from the .init callback after the controller resources have been
> enabled. Replace the capability search with dw_pcie_get_pcie_cap().
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D9

