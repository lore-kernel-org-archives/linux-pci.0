Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74D352921
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268688; cv=none; b=Gpgu7kwUSW379GRbFo8htxThnAaQps93lYna382h91L5rfL2dDwLjrQYKsDtAqf6q4ZfLzUOpNFrOwsblLHyhhR7oKDuibcetBWxMAv/h9KYsX6JRyibCIeOnSI7MBxK9T34RX8AX9vKs45SS/Ud0FrVDpPd9AC4h4Uy3OA5hhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268688; c=relaxed/simple;
	bh=579xusswqy24/8BNkTNAejWlYtNidFjK6kzQ/Gxp7Vs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QKrZFIegiqloCF+T2TJAAaJXH/omG1H6kMzFSr8aiieSNPBhro0yxFlOuGF5Kfm9LOuhamK6VP6F4/DxzC/5AAcHelFZmLOSnV46SWrYjgO9ua0Lxyt3Mur691UL+uvASvMizPgB1FBFosX43JMVMDrX4ZlNeqE745eIACxZJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3ZkoWJf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3ZkoWJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912BEC2BCB0;
	Fri,  8 May 2026 19:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778268687;
	bh=579xusswqy24/8BNkTNAejWlYtNidFjK6kzQ/Gxp7Vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=m3ZkoWJfCEMMG9nEBGQCfaUfAVAn/1PZeeEVIJr2RcXNaFF6Ti0yEsf6TNiGxlbnJ
	 xCMvVkzKQPPeE1RM4HUbknOXZKWHxJlyCMmhSmtG2822eudsGPDPJQhoMs7Lnjcg91
	 OgcUkNilox4EQbNEdBpy+yp3q/CnYZekLRWEfsmTCfV9owvzwnuZRDnF283u//7dHR
	 nVNMu7QPilq9vGS5rd44uO6DcixOSkg2Jii8l0XUHbg+gMxPICLdakUl5+xvacwvOF
	 LPiNTsme/58WHNkU70zn5iG0RMEgWwd0CI8wClcZdjlUCYA7nX9PcqhXeoNhTEOal5
	 zk2h2ZpoNT5bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/7] PCI/TPH: Fix pcie_tph_get_st_table_size() for
 MSI-X table location
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508064053.37529-4-fengchengwen@huawei.com>
References: <20260508064053.37529-4-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 19:31:27 +0000
Message-Id: <20260508193127.912BEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Modifying pcie_tph_get_st_table_size() to return > 0 for MSI-X loc=
ated ST tables causes severe out-of-bounds read/writes in PCI configuration=
 space during TPH state save and restore.
--

commit 73d4864dbc8b240284d0329056ab114562107193
Author: Chengwen Feng <fengchengwen@huawei.com>

    PCI/TPH: Fix pcie_tph_get_st_table_size() for MSI-X table location
   =20
    pcie_tph_get_st_table_size() previously only returned valid size when ST
    Table is in TPH Capability space. According to PCIe spec [1], ST table =
size
    is also valid when ST Table is located in MSI-X table.

[ ... ]

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index ba31b010f67ad..de5bd7039cdca 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c

[ ... ]

> @@ -200,7 +201,7 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
> =20
>  	/* Check ST table location first */
>  	loc =3D pcie_tph_get_st_table_loc(pdev);
> -	if (loc !=3D PCI_TPH_LOC_CAP)
> +	if (loc !=3D PCI_TPH_LOC_CAP && loc !=3D PCI_TPH_LOC_MSIX)
>  		return 0;
> =20
>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);

If pcie_tph_get_st_table_size() returns a value greater than 0 when the ST
table is located in the MSI-X table, does this cause pci_restore_tph_state()
to write out of bounds in the PCI configuration space?

Looking at pci_restore_tph_state(), it uses the size returned by
pcie_tph_get_st_table_size() to write ST entries directly into the TPH
Extended Capability:

drivers/pci/tph.c:pci_restore_tph_state() {
	...
	st_entry =3D (u16 *)cap;
	offset =3D PCI_TPH_BASE_SIZEOF;
	num_entries =3D pcie_tph_get_st_table_size(pdev);
	for (i =3D 0; i < num_entries; i++) {
		pci_write_config_word(pdev, pdev->tph_cap + offset,
				      *st_entry++);
		offset +=3D sizeof(u16);
	}
}

When the ST table is located in MSI-X, the entries are memory mapped rather
than stored in the TPH capability itself.

Because the TPH Extended Capability is only 12 bytes long in this case, cou=
ld
this loop clobber subsequent capabilities in the configuration space during
resume?

A similar out-of-bounds read would occur in pci_save_tph_state().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508064053.3752=
9-1-fengchengwen@huawei.com?part=3D3
