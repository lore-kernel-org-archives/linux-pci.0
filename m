Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293351;
	b=JLZSLlFy6kK7+0i6KE9KZtS2AwZwUFIbumM+ePeqavgeFWebany5GAiBZyWZPIPrIMN1
	 YhjimKYJ5i7TJdimOQq2hAKOtLj78h9pL2A2nkLCnoDzkIKg5H3ifmlt/k5jA2Of3rmTp
	 ZdmUGcdIm3K/LjAzt4jazJXC4ChDfArd3HWEUR7Jfzxx6avx6wgAJmfSHyGsTccjWQA11
	 X9Alqoq9zSBD4fRteQ9b7rZwFhvJ23ikZVZyS3XxR3k6zXsu0XWKS6l8MiqJGNJnphfh/
	 ivHbBjlSPHudIh2m3bj8eDCTHNK3ftx9H9fwBkSfQpnAORfSo4GVLStj0cx3rN4ExcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293351;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lJAg6pTzYftcb7EvzvSXtzcSbncYDjzewwa8/nd4Wp8=;
	b=jDXKr3wb9tnDNkphim2UPLOxjqlZvzjv9+XIp65FbLyx2zR/FYXP+zR13/qo/9uRgmGZ
	 NsI4LguN9xYh8behDxEEyNFhS8qidda3PRhnXijtupKCDrHxSTRaB1BEtaCeeL28t/iPY
	 t1PABjDnfkKyA8X7Y3J1OkDMOYxqHkgN56gewedw9U37CKQ4Awc9J5VWXLuE7FjeXA5vv
	 VAmodh4XVeONeLdIat6nbVFqANs//OADfOvLpxfU+RHOHLMZprj9bRSS8sziMlGJJGzKv
	 P+vA9Cwnf2oKN07cqCvbNiAYehRsa1h06aC90GU2/953vIjx2S/2GLrvLMge1GWVI1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alNAeAk0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032C606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alNAeAk0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE64D1F01816;
	Thu, 29 Oct 2026 17:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793293351;
	bh=lJAg6pTzYftcb7EvzvSXtzcSbncYDjzewwa8/nd4Wp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=alNAeAk0dRXDUdLXH/GHhpDnDMkLJ7TV9Z1AJQNQFLS+CCgdRHMfxwwaqIehQZe/y
	 GdBUmec1XRbXfe2ScMr+OijLfnx41wxJem25w53zW4+Ux4B3OA+GAhK6fMlZhib+CR
	 q2cXtXxj/+SQ65MQtliAZV/xwOhECLcganF1aUPl8JE7Il93Q5arc7PWq7rOK6VJci
	 xbavwO/cNC2MVjgLYHjeIkRFnt+sk/vYJBh8L3UoOeFmP4zhwP/C2RhZ98P2m9d2OT
	 I+Z+18FkDAX6GAz2tIRBH6FN8jhcRsga2rdfWUYCKhvKu+a83m181L/Z1GjY3OYsYP
	 uWyj+9nEQlBug==
Message-ID: <sashiko-outbox-189706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] PCI: add QCN9274 to reset quirks and KVM MSI
 domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029163713.1366077-9-jtornosm@redhat.com>
References: <20261029163713.1366077-1-jtornosm@redhat.com>
 <20261029163713.1366077-9-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:02:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> In order to have Qualcomm QCN9274 (PCI ID 17cb:1109) completely
> operational from VM environments, add to:
>=20
> 1. quirk_no_bus_reset: Disable broken bus reset, as with WCN6855 and
>    WCN7850.
>=20
> 2. pci_dev_specific_reset_methods: Use the existing
>    reset_qualcomm_wlan function. Unlike WCN7850, the QCN9274 is not
>    initialized at all without a valid device-specific reset method.
>=20
> 3. kvm_msi_devids in pci-kvm-msi: Enable KVM MSI domain support for
>    VFIO passthrough to VMs.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029163713.1366=
077-1-jtornosm@redhat.com?part=3D8

