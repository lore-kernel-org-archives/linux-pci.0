Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1236A373
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567914; cv=none; b=JmhIwNXN3l53HRXY68hFnCRy5ZE8exIOkSDeHvphVXqy1s2KNu0/s2orO/zEBDfg8iZjBy0efmf7KIjQWz3FMpRoNG4DiqHwiJdBg44Aqd/Ck+VoRjEwIAqeIwCjgOfhrQn4190XGF0YTiei1ern0p3GI7i/tKFieUgA3IffWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567914; c=relaxed/simple;
	bh=OyKJAj08bQpNz5P5N+DLP4FOwmDTwu/zfGUs5wFfOHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AQnWbNpjDn4ZU8vgcw9sO+ILPG/PnxFAeQUife9xOFhUfV3xVsx9jGfcRqnZ2sYqIFN0fHqoTH36YwOInqQkDa98k2+66CEr9+aTVoZ9x7K+hDQ8PpZKwvY6SKNOZoMkgd1iVjS6trzQlpT7B1FxK6l2Z48JmwJ1DS9lrdMfgE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvbHjrZ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvbHjrZ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E40D1F000E9;
	Mon, 15 Jun 2026 23:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781567912;
	bh=OyKJAj08bQpNz5P5N+DLP4FOwmDTwu/zfGUs5wFfOHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UvbHjrZ/lc773mpplce6qtIU6cXVpN9Ij4FGtPzrxPQkvAOCxLdqvgtUxrcHqaQX7
	 ZjJoMJMOeLMeU2S++yM1Am7zO8o8I+R23HJcPNd9oDOqTLFNUA2kpth2EpHPPc5Zcc
	 Q1ejUIRneCRKHQP41mVkMPSu9/GryH0Q1dzC9M1ezEbUoSWAQ6vsu8AmljZmuDLHfc
	 vEx2tT4PVaUbdAwxUqYoJHmWrBjYaiEHeXuGb4lI5mY4H4WwwQOBrxNXeLZh1BDJdv
	 QpR+2iF51xpn/9HVKO9mAIP6HAxqvV77ZdEdwDpPKulkw/eBB7mHLwehzGl196VzxR
	 0eqcORzwHrvtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/4] PCI/ATS: Validate STU for VFs in
 pci_prepare_ats()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260615235037.259909-3-praan@google.com>
References: <20260615235037.259909-3-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 23:58:32 +0000
Message-Id: <20260615235832.9E40D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> While every PCI Function that implements ATS has an independent ATS
> Extended Capability structure with a Read/Write Smallest Translation
> Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
> driver to configure the STU on the Physical Function (PF) before any
> any Virtual Functions (VFs) are created.
>=20
> Currently, pci_prepare_ats() bails out early for VFs, assuming that the
> PF has already been correctly prepared. However, this creates a potential
> mismatch if a VF is subsequently prepared with a different page shift.
>=20
> Update pci_prepare_ats() to validate that the requested page shift (ps)
> matches the STU already configured in the associated PF. This ensures
> early detection of incompatible configurations and maintains the kernel's
> policy of consistent STU sizing across all functions associated with a
> given SMMU.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615235037.2599=
09-1-praan@google.com?part=3D2

