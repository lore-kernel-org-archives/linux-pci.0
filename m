Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6140288C81;
	Wed, 12 Aug 2026 05:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510929; cv=none; b=AcmufUart7GsWazHdZ6WLvpr88l735uXVcD1GIonJcTZzXSFZU0PYxyZICoBPUheRMJEt94uz5Yc6JTXLWgQqO/mztbZBNQSFmrqcgvZE7duIXQWHaa0/v0o1A5n3dn9M0WK9S3+f7s9iEucgOdr/VCNkl3T/BX9xxvbnNThoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510929; c=relaxed/simple;
	bh=D9kc14B1clzKwP+SchUHDs4+94qaxCSuyat7J2rC1DU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m62TwE9RYISXHExzBaOZT6p7ZAFkBU1rCTCyKHP9vXMlpfr/awz5171SNF191i8CuGDQO3whrcCBUnris3Hlafh7ncyM8oL5gjOd7VbsW+kiZnVeERw3EcLoL/X3yNOd58ob3ntQdZzjR4TmrwLKmpMuG2aq9Ttdoopql3aqtnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Awz/QVtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Awz/QVtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A88C1F000E9;
	Wed, 12 Aug 2026 05:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786510928;
	bh=tm0MZavT61deTs8IiIXuKfY/Hv7zZg85ilA8nX9ymEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Awz/QVtkq7n2i9A/ZWvGoU+T128WHx6VGJyAdY2gsboPjkxX8lLcUufMDYPdaWdyR
	 /TICM/z8K44+B84pmSlSVoCIc5iNYVOLePPLzGL9p3b0dg7c0B3/YMNC/BYSy1FRuB
	 ToBIT0OmbOZ3BqlaRciHVz3suPZ1GWybFV0jZfSNeianCJb42vZzXp4zhq/HcyvfnO
	 Igt+6TRIS5VWdd6UPJQjloNHiFw+CQJydjFv2TP8xPK/3e7BbIsFRTf4yQLl/yM89x
	 Cupy7iurtAkToxdN+K67GwOOip9y8XDSzV4vqYjYYrciXQgA7uBfV7jktXo6jesihY
	 aQDXNZp0JURtA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/5] vfio/pci: Refuse to reset an SR-IOV PF with
 enabled VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Williamson" <alex.williamson@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260812045325.2733631-4-alex.williamson@nvidia.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-4-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 05:02:07 +0000
Message-Id: <20260812050208.2A88C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The vfio-pci hot-reset interface VFIO_DEVICE_PCI_HOT_RESET does not
> take into account whether an SR-IOV PF has active VFs.  The VFs appear
> on a virtual bus, which is not enumerated in collecting affected
> devices.
>=20
> Move the burden to the user when active VFs are present, require that
> there are no VFs present on SR-IOV capable PFs in order to conduct a
> hot reset.
>=20
> Fixes: 137e5531351d ("vfio/pci: Add sriov_configure support")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812045325.2733=
631-1-alex.williamson@nvidia.com?part=3D3

