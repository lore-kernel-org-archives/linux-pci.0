Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127920;
	b=O9tXoYRFwpunB8Stsivpma5jw8lAX2kat7nY1Rl1c3IYMeYeVtv1lgHeVoRgDDQ/a2TO
	 HUnyfhzmF0OZlAd2SWDqwugSWlBQWK8tecuXrnNctq3YLaaxYKZDZqBbLPIux0DGaL1Ts
	 w29AehMI3RaaQs7AKjXQE1949ea250OH7R0Z93K4alFOG/EYreMiGMhLUGX+9NrH9Azrt
	 h2Vj3fFCQ0daBryfdU1+bwMntlJ4S2kVz/thrJLCh5voTFuZRIRQUpvhEc90LUHkxW4ti
	 vxfOH+PYIrLT2QrhsoxyAZ7H6IGq6NHngrTBYsLHwjq/pmM4USd3Fb3UG/AjifkxKYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127920;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cj8MKy2tc3Sx1JwUpxECQgdXmsrh1YRqOP4Sl+8Dj74=;
	b=5Q6DT5axwzeUHcJoSDXqCyyBUa1JWYF/wXgy42q8LG5chMbCUX1l7eln5JGz/BGz9qpz
	 vLlnrjNZuTOdmSwaNCtZ0S2kXHY+yCayVRBcWfHC1PrbJtgZFkojw4A2ECEXT+kUcLeg6
	 THFcXNKtP14heMO2fR6XbEyIIN24YSE4iy/KUZHQvrTQgzCKxPLy83XDwELqscMLQ57sD
	 uGMss8ykqn5vN+uwh9tZAvLgnVaS3pz9jhVT0gLznOQtUFPFOe6Tg59Y8synC2itf4s1P
	 dCvzZPGkmnipUCfigF9hN4Mp0WfRn8H9TOIzTA9nNYwTe+tM6pV6kuQ6k8Vcugv6OeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NuwjnRJ7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C995606A325
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NuwjnRJ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EBA1F000CF;
	Thu, 19 Nov 2026 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127920;
	bh=cj8MKy2tc3Sx1JwUpxECQgdXmsrh1YRqOP4Sl+8Dj74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NuwjnRJ77VaBWoVlfrRYMOPJitsXnO0CmQ0ewhyBdvVQIUMa/2Lla85Nd6sVLcqSO
	 rBSZstLLajgdg7CE+ZtMUiIPEv7PaFl58FO+wjyZERXsQJXc1P+8EZBEsc/pc0Li1r
	 dSkKtAQNhJuxTDl75YrxBtqZBBY5rTx9XQlDa6MrD3Mm2Dx+CX2hcFoQ7EkEK4jzX2
	 ix5bmcrCXaw7nWXSZsh23FNASS8JJ6jpmZa+nRvl4KCo6luiLjhnX2QZ86aYoWNNTT
	 gsxJFCM+Haoqlx6Fd3JAZz1snnrO7gz1yCU4oh1Hz3OR/4LMVYS79qCG5O55gft1aC
	 rAn9WVkFg2HcA==
Message-ID: <sashiko-outbox-224145@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 10/13] PCI: liveupdate: Adopt ARI Forwarding Enable
 on preserved bridges
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson" <alex.williamson@nvidia.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Down" <chris@chrisdown.name>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261118223704.3286085-11-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-11-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] PCI: liveupdate: stale ARI state in pci_configure_ari() with
  pci=3Dnoari
--

commit ee2b5e1cebde3231a1c9acaaf68c272dbf3c6e8e
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges

This commit adopts the ARI Forwarding Enable bit from hardware on
incoming-preserved bridges during a Live Update, even when pci=3Dnoari is
passed on the kernel command line.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ebc565b4780a1..b5b578355a1b6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3748,7 +3748,7 @@ void pci_configure_ari(struct pci_dev *dev)
>  	u32 cap;
>  	struct pci_dev *bridge;
> =20
> -	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
> +	if (!pci_is_pcie(dev) || dev->devfn)
>  		return;
> =20
>  	bridge =3D dev->bus->self;
> @@ -3759,6 +3759,12 @@ void pci_configure_ari(struct pci_dev *dev)
>  	if (!(cap & PCI_EXP_DEVCAP2_ARI))
>  		return;
> =20
> +	if (!pci_liveupdate_adopt_ari(bridge))
> +		return;
> +
> +	if (pcie_ari_disabled)
> +		return;
> +
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
>  		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
>  					 PCI_EXP_DEVCTL2_ARI);

[Severity: Medium]
Does returning early on pcie_ari_disabled leave PCI_EXP_DEVCTL2_ARI and
bridge->ari_enabled set to 1 if a new device is hot-plugged after the
preserved devices below the bridge have finished Live Update?

When booting with pci=3Dnoari, pci_liveupdate_adopt_ari() sets
bridge->ari_enabled =3D 1 while bridge->liveupdate.incoming is set.  Once
the preserved devices finish Live Update and bridge->liveupdate.incoming
is cleared, hot-plugging or rescanning a non-ARI multi-function device
below the bridge causes pci_liveupdate_adopt_ari() to return -EINVAL and
pci_configure_ari() to return at pcie_ari_disabled without reaching the
else branch that clears PCI_EXP_DEVCTL2_ARI and bridge->ari_enabled.
Because bridge->ari_enabled stays 1, next_fn() calls next_ari_fn(), which
returns -ENODEV and skips enumerating functions 1..7 on the new device.

Checking !pcie_ari_disabled alongside pci_find_ext_capability(dev,
PCI_EXT_CAP_ID_ARI) instead of returning early would allow the else branch
to clear PCI_EXP_DEVCTL2_ARI and bridge->ari_enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D10
