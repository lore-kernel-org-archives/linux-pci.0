Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996920;
	b=w38Syrzwd5xGCoXxKpaiyQdiwc+XolxwrqdKoVywyd9gmVN91hZh+45PMpxjNaLVOYjC
	 Xqud+niTRZ0438BSfeqeu/EytES8AX5S9/BaIAMrn5GnTwL8hHP58uotqGkqWWaeBYRkv
	 VV+XutCWOSyEKr1ARWXGheVsRMp4mY+2ZhFd6JnppOJvgmn97fKHWfBsTBUXArCnsJKy1
	 hKJxqnTYHRrm7RFiPpgyDL8j2pBfi8jhytqbtMedlUKNk4B1G2xTCKBCh/nOleCGk+kQC
	 ISYvktkHqbQWgaXAL7LvdNPo+6R9GyfrcE7x6+ys8B9+KygkGWd70SMYYOl5te6QVzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996920;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E/+nx8YvAJte4zARCLVtpwB4vfLrLWWzc65MNjNRvVY=;
	b=5gHnMl0Hrc91nl6RDuUisjq0LX7VYjvmXQXEb+akuPWDa/tXkS3J8ypaY4K5jwHS2S+v
	 EutvYh6ev8gI+Jlo63I+xiVKAmyXHECXpWYwEA6K0dnjZBw91Zmp5XGrO7Yfysdny1ahc
	 W0eTtIMRZpAvZrIP/Mv8AaxM5IlxWn4Si9bVe75+06bur69uS4eYKzoZzm2fOjI0H+Jnc
	 sVLeVf97ZJNHNDb1lrxj3nG0aa2Rlaz8ZdjlvH41sNZ3ceJwOyJ6FIIwnZEMpqHAIUPaL
	 C2bSmyVl3hMUUitw5hfo0Frq0M4T7AOCa+x6YvVUyF0VX5i+RNrmjRKQiLGiL39KU+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HHT/IeY/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E36B606A320;
	Wed, 18 Nov 2026 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHT/IeY/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC43B1F000C4;
	Wed, 18 Nov 2026 10:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794996919;
	bh=E/+nx8YvAJte4zARCLVtpwB4vfLrLWWzc65MNjNRvVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HHT/IeY/kvq1xPtNhjCfPDyjS+bo0XYmFLuJlIuV98hO63SEl6MBGNXaHoqEWYWMO
	 edOV3OT+3p2IQbslciTFvyVxDaAQIsLZX0D+GNtmphqpPu8NrY2xq2fI58PLNRkMeW
	 qYmmUTjxOWDzbYaU/FNwTx0GFl2/07CiGKMfmbJrISekrUpn3ojDfMmPtBA2rNBZ0+
	 ddE3nOcKbS2dXRRhatyvtp7ztpvCdHk0uzCQJCM5Bj+ZCdasENUut+DtUUEMgq8DkI
	 1LWHYWlUjXLTD3YQzLId+SXO0ZWDugsjyPbypObRot6QmonNwly7xXtsP31p3MS0S0
	 xjA8y6mfwy8oA==
Message-ID: <sashiko-outbox-220669@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 07/13] PCI/TPH: Add pcie_tph_set_st_entries() batch
 ST entry programming helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118091238.45992-8-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-8-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:15:19 +0000
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
- [Medium] PCI/TPH: pcie_tph_set_st_entries() disables TPH on partial
  write
--

commit 8c13933953bfa21006225cd4609cb9e61ae70514
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Add pcie_tph_set_st_entries() batch ST entry programming helper

This commit adds pcie_tph_set_st_entries() to program a contiguous range
of Steering Tag table entries in a batch while disabling and re-enabling
TPH once per batch, and rewrites pcie_tph_set_st_entry() as a wrapper
around it.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 51a065d83104b..c8b867dd233d4 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c

[ ... ]

> @@ -344,29 +345,47 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, uns=
igned int index, u16 tag)
>  	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
> =20
>  	loc =3D pcie_tph_get_st_table_loc(pdev);
> -
> -	switch (loc) {
> -	case PCI_TPH_LOC_MSIX:
> -		err =3D pci_msix_write_tph_tag(pdev, index, tag);
> -		break;
> -	case PCI_TPH_LOC_CAP:
> -		err =3D write_tag_to_st_table(pdev, index, tag);
> -		break;
> -	default:
> -		err =3D -EINVAL;
> -	}
> -
> -	if (err) {
> -		pcie_disable_tph(pdev);
> -		return err;
> +	for (i =3D 0; i < count; i++) {
> +		switch (loc) {
> +		case PCI_TPH_LOC_MSIX:
> +			err =3D pci_msix_write_tph_tag(pdev, start + i, tags[i]);
> +			break;
> +		case PCI_TPH_LOC_CAP:
> +			err =3D write_tag_to_st_table(pdev, start + i, tags[i]);
> +			break;
> +		default:
> +			err =3D -EINVAL;
> +		}
> +		if (err !=3D 0) {
> +			pci_err(pdev, "failed to set steering tag: %s table, index=3D%u, tags=
=3D%u, ret=3D%d\n",
> +				(loc =3D=3D PCI_TPH_LOC_MSIX) ? "MSI-X" : "ST",
> +				start + i, tags[i], err);
> +			pcie_disable_tph(pdev);
> +			return i > 0 ? i : (err > 0 ? -EINVAL : err);
> +		}
>  	}

[Severity: Medium]
Should pcie_tph_set_st_entries() call pcie_disable_tph(pdev) when
returning a positive entry count i on a partial write?

If a batch write succeeds for the first i > 0 entries and fails on entry
start + i (for example, when start + i reaches st_table_size so
write_tag_to_st_table() returns -ENXIO), pcie_disable_tph(pdev) writes 0
to PCI_TPH_CTRL and clears pdev->tph_mode, pdev->tph_req_type, and
pdev->tph_enabled before returning i.  The caller is told that i entries
were programmed, but TPH is now disabled on the device and any subsequent
call to pcie_tph_set_st_entries() or pcie_tph_set_st_entry() will fail
with -EINVAL because pdev->tph_enabled is 0.

When i > 0, re-enabling TPH via set_ctrl_reg_req_en(pdev,
pdev->tph_req_type) instead of calling pcie_disable_tph(pdev) would keep
the programmed entries usable, or else the function should return a
negative errno whenever it disables TPH.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091238.4599=
2-1-fengchengwen@huawei.com?part=3D7
