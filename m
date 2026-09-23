Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0FE582BA1;
	Wed, 23 Sep 2026 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194804; cv=none; b=ra3xgy6fMrnqZU6hiiEVlTAVgiZTF39NcJWb1JDrdLtk7OxVNOmFLqLgt1HfGBbpB/dglQPkVQEB0KCNoa9GEbD9QCGjuMxbvZ2rTgMe9Qa60PtYVZYRqWd2/5JxPWi7iPmiBMo5oWxzt/qlV31eIs96XtoC70fLisnuFSE27dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194804; c=relaxed/simple;
	bh=CCJGe9S0Su9A25toxHmo33xiyT7JPF82KK7HQgLSpjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kJJddsTlnTrwnB6/iQb3qQq9kn4kR5+VBwqLb0rMIqyEKj+gH37gfCC/jdqg76M1vsAB7kih2G6p11vIPFBqXoLVmZkP4VzezriHw8eHAYvSppye7hCDeegi81nTpWzvJ25R5NlWaDyp1FbfG+jlgaAn4W89uZxqY7gaGNHg7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkCUlKVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkCUlKVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9082D1F00893;
	Wed, 23 Sep 2026 20:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194797;
	bh=CCJGe9S0Su9A25toxHmo33xiyT7JPF82KK7HQgLSpjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VkCUlKVNz51yIXboPDdIqBU7BhQPIlnVCfQ+Es7MdOoKySJzQMX2OpfWx4vavTnS6
	 9oqnz19t60X8InqvCjFJeWkPXxXBNo0nD/imjijMnp10MZZ8DPWbJHee+sBZ/PbejR
	 qvewH41B2x4cMXpUNZUjlOkpocY1nFCBR+uQq/k40oqdYfw4/xgS6F7J8ZftAvF2Zd
	 Fu03yPg5MkfB+T3cL4zJ0Y+6+7XePzUou6eXl++L1BlVvW61iiUt8nv/O/bE5eLfhF
	 R8EKs5DNIeHvFQvBunXS7oaUJj1c9+/Y7hlHLlDahEKXOl4QMyectoskYuytsj76A/
	 iKtm9Q46dxzmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/17] iommu/arm-smmu-v3: Don't rb_erase() a
 never-inserted stream node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <76c5f9dde30269995ef842a12a3a5e1ebaa3e6df.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <76c5f9dde30269995ef842a12a3a5e1ebaa3e6df.1790188510.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:19:57 +0000
Message-Id: <20260923201957.9082D1F00893@smtp.kernel.org>
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
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D6

