Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423134;
	b=qTAcV49uObGZwl8X4aFvpnfCaGDdBtxB78ykcf0JZEpp+olRz1w9zLAGYaL2YgocXv2j
	 mMJkBe/oFg8ETy9gf4BBHpPfWhxOJci5oZF8E4CW+kKKFhC6LuwNilbdLHtT+W+qZ2LIz
	 WmmRByrOe0vl/bTdTPTxE+/aI9OQF7vbepLrOXXTGUaq20DI2oGbfHpyioDk2mJGIWiXg
	 PcgHLt5JjjfRBFusyRZP5dJKnQkS3OKDzUmFF0wfeXGj5nbGCL9KqNrjujG8E2gFX7Efs
	 WBrRoY19wLaxFDq+68B+6lHlsxZRFz6XbCssWqUdF865rzghFB/sMDrR/O2X+QVR3bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423134;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mp94C+00NVGBJRDhVo069VqEYTrMNQsZJQOKfi3NnMk=;
	b=yZ/hZWk5nsxRL3nBu1Fyt4Hvoa7WtarxfYGZLDRsO46V0JqG43IswibmqYhgOiacITYd
	 V61Avc17m7eK5tQxERdMxUDMPU7E7lvZbvchqt9X4Rj4JQ4O4FWdy5grkIpe1WlwgyrdK
	 h89TjoZkmqJpemQAdejXOTxysHh6Z7S1i66gotDI4UZLKscdy7oUWI0GCvKAqHcGrgsUG
	 cYl+hGCzaBxqniEc8ITxrL59AdHUsgBRKqwSe9rUD3pEy+sxnrKgYcuSJ0Pz8jUp8N8jZ
	 GfZZe7p0Kzbrczv3eXt6rLsvQjS4oyJe8J/TSmZBRyjpFf/6BHfq0NQOLtNhkE+/Omg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BvBAXzA0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F260A4ADE
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BvBAXzA0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BD31F000C4;
	Mon, 19 Oct 2026 15:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423134;
	bh=mp94C+00NVGBJRDhVo069VqEYTrMNQsZJQOKfi3NnMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BvBAXzA0J3s1PMapsVw9jravlzGpala/YHLSImrnz/taIR56fWL22IA28WNnk0Do6
	 dyS0jcO//HYw0s7Q+oEL8An1H8dbat6556J532RyksK3twd7A+rsxJxyRDTRPM0eQq
	 KDC/Socqt57ALIsCkGwRVtSoJk8dAO1G7OqdmjX3eGXJ/We9sS0nX+0a0PPwdlncaO
	 3ZEZRYrXpEn8BwkTRZWDMnxKOevMH+wuSe/y564d4yYTmTOKgD2o2LHwAadeffLW3I
	 qeZEeGld/SPOXBzgX/+eTd5GNQX8eYRBb5YSUm2Pqc6rhae8MI1tNfVLL/kPEjlVc6
	 LHGqBXB9fszGQ==
Message-ID: <sashiko-outbox-177675@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] PCI/ATS: Ensure pci_ats_supported()
 is PF-aware for VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019135441.1420968-456-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-456-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:18:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Pranjal Shrivastava <praan@google.com>
>=20
> [ Upstream commit 4f2cd6091ac41566a7300f5a4590d20a99aaa8bc ]
>=20
> Update pci_ats_supported() to additionally check the associated PF's
> status when called on a VF. This ensures that PF-level quirks and
> untrusted status are correctly propagated to VFs, providing a robust
> support check that aligns with the kernel's PF-centric ATS configuration
> model and is immune to the timing of VF-specific fixups.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-456-sashal@kernel.org?part=3D1

