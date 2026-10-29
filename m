Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301877;
	b=JdfPDCWZ7TKDO11lusD7uzNnbpPT+zyGXy8I/NeEqgNWbCABd67P7PuWWyJcge3YLgTK
	 4jqvFfXwZa9YH2uoH7gofbsdzf3mkLAh/Lp8xSNgqynQKdinRdg6BfXscsPNOCdoNnamm
	 SLI6nqqtF+yup8NH2Kt4weyKv0oywJEAaVorzGlvDIZpZAZM1hsZCZah7dlVBFjKRdQ1v
	 OtRNmNcpdhwAyqSUj1oflnzC5rfAsn+TD55kUq3WcgcMC22bDE1EupoHcX3BjKp3/GHPF
	 KA30/p0DsziOS34WLB7YtFcS2fUECaMRuo8SsPNQN0k8r20o6GfGEZJ+ZxJV4ljkDtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301877;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lB2upTFq2qd44ZXJD5kkvbKB6B6F1W+wcTXuQ8cJYvA=;
	b=s1KVmXCwQDu/BpmiNUNP154PdmtIJaIkek7r96zPGbEUfi9lwhi6ERbt9lNazRzzWidR
	 9SF1e2stwh4EK3eFuK6eQ8V4o2ysbBSgutt5PPRrGGTffyVoSfaGQW0scsMpgzcGaybd9
	 qm/4NQqKvySJM8lj0OXRWPUDH+oNNrjKaPczpbtatx530KBaEKMwCjuKVxXY1vNyNlVYd
	 JfTuFRaY0V0iVX+bDuAnEtPJ85gZ2KecD3ckToy+r1fQ5fXgtDCKr2suimVINwHg92dje
	 7UfqFCVMhZW6qGiUWRkvSCEVEwuzSEVJ3JUeN3cksN/or8We7QN93wCeaM9UXOu4Otw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9iXdtNT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B533606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9iXdtNT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95701F01816;
	Thu, 29 Oct 2026 19:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301877;
	bh=lB2upTFq2qd44ZXJD5kkvbKB6B6F1W+wcTXuQ8cJYvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R9iXdtNT0vt+HSkWjsaDLgAgDA2EXKhRfdPHD6YHnoW37uupnS83VsDe/RHrQXSJG
	 5ELBj+XoV35LvsnxheYJayTh2tTYezOaPnLdtG4TXADdErTPP3tD9tO7AUrezcFRZy
	 FcRULCmEtIzuB0K078ODp1mMt8jejIJfLVAPaIgCVZOCK8/C2poGwiPMq4GaVwcIwp
	 3E+/cyfKdvNxMDF1ezUL/H+VOMmY/Fjo2jWGAxvLtpgwNlHoPk1JxQVW+cVGsx0Lcx
	 vuqGeXOurPFD4tZdtvgsOX6USgkxulAcZPfqXzbDoBOPG3XlNZ7KPxLElvYeEYpNeN
	 IXPIFbbHX1CwQ==
Message-ID: <sashiko-outbox-189872@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] PCI/sysfs: Use user config accessors for link
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029192032.1325629-5-thepacketgeek@gmail.com>
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
 <20261029192032.1325629-5-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:24:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> max_link_width, current_link_speed and current_link_width read the PCIe
> Link Capabilities and Link Status registers with the kernel config
> accessors. Those don't check block_cfg_access so a read that races
> with a reset goes to the device mid-reset and can fail or return a bogus
> value.
>=20
> Use pcie_capability_user_read_{word,dword}() instead so the read waits for
> any pci_cfg_access_lock() holder (e.g. pci_reset_function()) to finish. F=
or
> max_link_width, this means inlining the pcie_get_width_cap() logic
> instead of creating an additional helper with this single calling locatio=
n.
>=20
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029192032.1325=
629-1-thepacketgeek@gmail.com?part=3D4

