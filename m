Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992683164D8
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052758; cv=none; b=JngxSXT1onnoJYJP59D3ixmj39LgW8pB/3hheLpfsztIeGqVqDeoRYtq4h56E63XeV9CoCm06rmLKvN2vED5Kd03ayAobWiJMzhxDXKThaWMhqljT3YJUouO3tx0WPKQVVIJvPrZt3EhTnCFjCES3gQEf9rDYMmh2SIwkmf9nQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052758; c=relaxed/simple;
	bh=8PEe4rlrzayWKyW8hOKOXKoY3hfGtxkgg/sgikDGtEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NjjtzwcA0d6wxHxGAZIu6iHwC3GIMWBRFGRTwfFWE7BsS4yQiECmbnR8nLlb7SYP7EUL2E607b3ZNjR8QQak38cuPCeqfLRuMduHG7aQyOSXd6F7LSBWCWfk/pbWSD2on9Z5Mb6l7xEuTKIJFzMdsomdYBuVJC4pS7J9J/T7d2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBxO/FaJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBxO/FaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CBB1F00A3A;
	Fri,  3 Jul 2026 04:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783052745;
	bh=8PEe4rlrzayWKyW8hOKOXKoY3hfGtxkgg/sgikDGtEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JBxO/FaJ80rGOoPWG+zCvDf5db8vgCNA89n3RkZfUItcMXtK2/JFGciAleGA5fTjy
	 6ZxF/9AhX8/4FUB6WZh1nY2ccpOrWPbDNcNZH2Jq9+4n+wh3xXBNJXHheFQP9Zh3uw
	 qUe1WZhf56MUe7x4sHmi0UXULKcieiQHoSeCO9ANPLW0YcfWbaHOrvvKHA9koCI8KE
	 GG1DXMbujA3PX0s3q2vQCJOStw4ofpPWwcwvBXlXSRIXVVJIWFIeR6Mkd0kX0LFPqx
	 506RYu3d+a6S9RpSlH4bpOBdOzI1feKfDYxQ1nviwFZAb9FwZD32aiTT5R+w8ghfuJ
	 j3M699ArRY+vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/18] iommu/arm-smmu-v3: Don't rb_erase() a
 never-inserted stream node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <9136477b9c737a50cecc38f2ee6704a01510169a.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <9136477b9c737a50cecc38f2ee6704a01510169a.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:25:44 +0000
Message-Id: <20260703042545.A1CBB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> arm_smmu_insert_master() skips inserting a stream whose StreamID duplicat=
es
> one the same master already owns (bridged PCI devices can present duplica=
te
> IDs), leaving that master->streams[i].node zeroed and unlinked from the
> smmu->streams rb-tree.
>=20
> Both the insert error-rollback loop and arm_smmu_remove_master() then call
> rb_erase() on every master->streams[i].node unconditionally. rb_erase() on
> a zeroed node sees a NULL parent, treats the node as the tree root and se=
ts
> root->rb_node =3D NULL, silently emptying the whole SID tree and breaking=
 SID
> lookups (and DMA) for every other master on the SMMU.
>=20
> Mark each node with RB_CLEAR_NODE() after sort_nonatomic() reorders the
> array, since sorting relocates the entries and would leave the earlier
> self-referential RB_CLEAR_NODE() pointer stale. An un-inserted node then
> stays RB_EMPTY_NODE() and is skipped in both erase loops; inserted nodes
> are linked by rb_find_add() and erased as before.
>=20
> Fixes: b00d24997a11 ("iommu/arm-smmu-v3: Fix iommu_device_probe bug due t=
o duplicated stream ids")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D6

