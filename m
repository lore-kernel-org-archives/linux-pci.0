Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441896;
	b=MzrnXZ59LO0kW8Gm+3fZ9QErtbMcYQZmYd39FXQxd2VtugbBeAWihWR27ZBNDKddcxNM
	 28zie6AZVc2lKbtBSFA0EZ5FMrj3/RfKItjt9ZqD5WzWbrBcIUCcIpoL8kd+T9Xk6faOK
	 E5bSyZUJ4Cu4qUgRbjJQygFZrbuM0xrQRqSc3FP7F5sZsqXS0iEnpxY/7wu7MkZ3t9QtM
	 lfyztJ6x2MmrgO8OSIrBW0BEr/HuE8qxUDHZJzP4muQSvwmfQw5TwPxQRwv2ciFtOz0MG
	 k9Iyo/uUFCxmd/5W+2Jk9EbUSBHVV3urKHoo2+RaDmIBGuEPhFem372a10Yh5C4RIXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441896;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kfBe1/5XoykBqSalY164NPXwKWcEFObLiOpkSHQJvTI=;
	b=EfhjYkaFfGU2fu0n+9uAQnYoe7HCDdlUfDzwXpMPsXfkZoDN7d96Ihx3/xNhxmXTLWn+
	 HDag5q9IMMrwlgd+2zeCD4GHrdMfiMqo62AgKvR8bdMAggxgw4fv9bUVpZz2bAm6fs6l4
	 JrPmvCP0zJEhcE0uYrdCmIdDOOVES6EDbywNrhMCGK3TESEMKX/mktxKnuoOLo6qoy5WX
	 QlVc3oiDZIR5zT44UKWf3NWHwADA1EOmXvowNMTdangn7leXnyDe7X9RYIgqQZXSsaAN3
	 eEIzr9oGvL4PTporBZcEAR+vu+xvIFJ1cWjJzM8itlJ/VRgxGcstg11LO90Sem2wZ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dem6N9Gu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F00B606A31C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dem6N9Gu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999561F00A05;
	Thu, 12 Nov 2026 00:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441895;
	bh=kfBe1/5XoykBqSalY164NPXwKWcEFObLiOpkSHQJvTI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Dem6N9Gu0gv4xwxlVxtv+ssKp715/bgX/5Lv7YodRyMQ970zaNSn3TxKz5HdUwrlk
	 CK+RZy+L3txrsLd5jQCSxBfVazED/31gDaTEtKXJbdgei89NroH+FRcLzcX9h03Hc4
	 39dCdE8GDMDvriAlNzWJDaHTEhm5AlqlOfgMOOA/6CCgj56V/vQqTXbzw6o/xA+vV2
	 GrsFrNa/dxTZANvR1sfgVbKeJdtE7ZpPtEYELi4q5k73axHveW6IrA41rxN+Faa1Z6
	 /0pHb7KwTuvxAMzH9cPFsfPfgVnC8z2vFqhhGn+3jzT/SUGeqau1e7/zdZREjL1zFD
	 DDjfFTN9MuSvA==
Message-ID: <sashiko-outbox-209880@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/11] rust: pci: add typed SR-IOV PF registration
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111223337.508989-8-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
 <20261111223337.508989-8-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:04:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Zhi Wang <zhiw@nvidia.com>
>=20
> Rust PF and VF drivers bind to separate PCI devices and may reside
> in different modules. A VF driver that calls PF operations needs
> typed access to the data exposed by the PF driver. This data must
> remain valid until VF driver removal completes.
>=20
> Add VfRegistration to register a pinned object in the PF's private
> data. VF drivers can borrow it after checking the requested Rust
> type, using a higher-ranked closure or a covariant lifetime encoding.
>=20
> Keep VfRegistration usable when CONFIG_PCI_IOV is disabled so PF
> drivers need no configuration guards around their registration field
> or its initialization.
>=20
> Capture the core callback context in the initializer. Reject active
> VFs and an occupied registration slot before initializing the payload,
> then recheck the slot before publication in case the payload initializer
> created another registration. Publish only after all fallible work.
>=20
> During registration teardown, disable SR-IOV and wait for VF remove
> callbacks to finish before clearing the pointer and dropping the object.
>=20
> Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # include/linux/pci.h
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111223337.5089=
89-1-xinmengs@nvidia.com?part=3D7

