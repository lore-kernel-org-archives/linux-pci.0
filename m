Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279DB3BA24F;
	Fri,  9 Oct 2026 05:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522700; cv=none; b=ZphRf0/W8zuYkSepCwzvZISJjhhzJo+LXFcPtlLz3XWBN1i9i9Ssyp+W/HsjT3X8MniMh0+XzaCGQpQm3BWwc4CK8Njq6zKNN8w2VXM9iCsZMAPwglXRWq6r30q4ftouDHBhDcIvMMIE+zI8IfIWfyhzDh26cDLYRpEA/z6ElHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522700; c=relaxed/simple;
	bh=1mlWF6mnpQDAgswGjSF2N3eEsmYsYEy4DCBHbcFHCyw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FqE4J964wie3em161uxdfcNWYvGvhknx8sxktPIkcuK2XpXKejgjTT+juB06xMgpauyj3RFW65o6eJWl2Qzup/2HE0IFH9/beH3yQIaxqyGux7YBIsZfs1xwvxIcRc/BAUInyPvloaWyo90VPfhFkG+tzcEtYA+mqYXedh2vXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElvzljLT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElvzljLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A630C1F000FF;
	Fri,  9 Oct 2026 05:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791522698;
	bh=4x32zqvyw4q0f/aMzN8vwCdfZDJ/xnqIbhYGpedP7X4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ElvzljLTu6vFjqZFqsW7IzHadz71XEDelkmg+yKWy5bH61dLdiJeKbuTDc8U24hyK
	 T+0K+A0HA8kPBBT39ZREqlrJybAATnQe/1jmWwIzSASbxITh6zMGszzaGbDTr/7jK4
	 VLrXRSpdMz9fK45ja2TD+k0kR4ik7NHCPJZGsXL1KL6YaIJxUp2fYiOHebuyYEkg4K
	 C/7zgz6GoTFO4NAgFqghvvRlPSg4rHOcVI9+h/hpPpvZX4Wb+Jw73F/hIqsrJGPxRC
	 xgllOVKIMVYITJB8v2hu514QdBXDTziNnTdRcvcaK8A1tmi88exq2GV2Yeke9Dm9q0
	 IJGvXobE8Dqcw==
Message-ID: <sashiko-outbox-164873@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/7] PCI: endpoint: pci-epf-vntb: Export endpoint DMA
 channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20261009045949.1109871-5-den@valinux.co.jp>
References: <20261009045949.1109871-1-den@valinux.co.jp>
 <20261009045949.1109871-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 05:11:38 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] pci-epf-vntb: Build failure due to non-constant expression in offse=
tof()
--

commit d7f27f0fe4a25aa5e8eb677eb623fec735ae8a53
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels

An RC may use endpoint-local DMA read channels to transfer data directly
to an endpoint DMA address once both sides agree to use them. This commit
reserves read channels, describes the controller, adds a dma_bar configfs
attribute, and maps resources through the selected dma_bar.

Link: https://lore.kernel.org/r/3tgny5jkxjw3foqgkohlgmw4lh4trv63swgdc3kvi7q=
xzpf222@avh4tiacqn2a/

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
[ ... ]
> +static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> +				   struct epf_ntb_dma *dma,
> +				   const struct pci_epc_aux_resource *ctrl,
> +				   const struct pci_epc_aux_resource *resources,
> +				   unsigned int count)
> +{
[ ... ]
> +	dma->ctrl.magic =3D EPF_NTB_DMA_MAGIC;
> +	dma->ctrl.revision =3D EPF_NTB_DMA_REVISION;
> +	dma->ctrl.type =3D EPF_NTB_DMA_TYPE_DW_EDMA;
> +	dma->ctrl.submap.bar =3D barno;
> +	dma->ctrl.length =3D offsetof(struct epf_ntb_dma_ctrl,
> +				    chan[dma->rd_ch_cnt]);

[Severity: Low]
Will this cause a build failure on Clang? The code uses a runtime variable
(dma->rd_ch_cnt) as an array index inside the offsetof macro.=20

While GCC may tolerate this as an extension, Clang strictly rejects=20
non-constant indices in __builtin_offsetof, which is what the kernel's=20
offsetof relies on. Could this size be calculated manually using struct_siz=
e=20
or a similar approach instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009045949.1109=
871-1-den@valinux.co.jp?part=3D4
