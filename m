Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C825782A
	for <linux-pci@vger.kernel.org>; Sat, 20 Jun 2026 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975815; cv=none; b=L3NOGeA6z1lfqg6OwV2ckUQoSekkitGL52Al8kdgNvyDNG6P4mxbnXKPelEy9H72ppSB8PgYE7DYwj5xJ7PFC0Eycm+9B8vX1SoBV+EwV5ULOAVXV/cdoaezNn9TFyB1DX7BahNwzIBSC6DOibx1aaOzA4wjy6ZFhukjSlnsX6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975815; c=relaxed/simple;
	bh=U/Ji+34bYjIzy0L+GNnJg5UFaEauOGO4AzpwTe6TSFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KmX8HUcM1UU5MDU3ii9UR0hFKIQed5S47XMstEZtWMCSIZDRZ+CSPE8zLzYPl079kAwVAQGksJxUHyaABrM9HZgCIwFWKRQ5Fhq2Y00W31hzctvOmLTzyAujSd6xqUFbWDsQDw0f4bT5ve7hB0pnDLQadu2MJdKIbsanAD89m1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhTyjc/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhTyjc/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD7C1F000E9;
	Sat, 20 Jun 2026 17:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975814;
	bh=N1NeqN+Tfp4Mm3XxpD84SIFyVbVA+io+U8hXAJzfDf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VhTyjc/AFfjbYEHUIiXzRZi4+aa2MlNubLInzb4KM4wo2R02ncKUFVoZGEDVkqw7b
	 ThpmUwAfiNPetYtGppYk29pTVq8Y4bacE93atcktHRnNYLPcbzgM3HUEYPAMLGCLaT
	 vIfKEP258kemDL7gAGuN6qotVb1+HwRY91X3HCemPkyp37/iLqAjjCWJcxW8NR/OHP
	 H+EgpmSKBKJTNl8FzF+YJ6I/Zufi5FuPgj27XJ9hOW+IfQFYmuplzdUSOppuhjJY4Z
	 wNzAlwasI7aAFcGHtc/ygx6b4Wdelgx0UrfCWrTxCw2zgGGskxmbgnyBQ9eCnFdRaX
	 hRMLs96n2eruQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] PCI: dwc: Implement endpoint DMA channel
 delegation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260620170438.3756593-6-den@valinux.co.jp>
References: <20260620170438.3756593-1-den@valinux.co.jp>
 <20260620170438.3756593-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:16:53 +0000
Message-Id: <20260620171654.4CD7C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Calls to undeclared and undefined functions `dw_edma_request_delega=
ted_chan` and `dw_edma_release_delegated_chan` will cause compilation and l=
inking failures.
--

commit e55470d381c0b56d92a5e22c376824161b53e132
Author: Koichiro Den <den@valinux.co.jp>

PCI: dwc: Implement endpoint DMA channel delegation

This commit implements the EPC DMA channel delegation operations for
DesignWare endpoint controllers. It uses the local eDMA provider to reserve
hardware channels and returns them as opaque handles, limiting delegation
to PF0 and handling reclamation.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c

[ ... ]

> +static int dw_pcie_ep_delegate_dma_chan(struct pci_epc *epc, u8 func_no,
> +					u8 vfunc_no,
> +					enum pci_epc_aux_dma_dir dir, u16 hw_ch,
> +					void **data)
> +{

[ ... ]

> +	switch (dir) {
> +	case PCI_EPC_AUX_DMA_EP_TO_RC:
> +		if (hw_ch >=3D edma->ll_wr_cnt)
> +			return -EINVAL;
> +		write =3D true;
> +		break;
> +	case PCI_EPC_AUX_DMA_RC_TO_EP:
> +		if (hw_ch >=3D edma->ll_rd_cnt)
> +			return -EINVAL;
> +		write =3D false;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	chan =3D dw_edma_request_delegated_chan(edma->dev, write, hw_ch);

[Severity: Low]
Are the definitions for dw_edma_request_delegated_chan() missing from this
commit? Calling undeclared and undefined functions in
dw_pcie_ep_delegate_dma_chan() will result in compilation and linking
failures.

> +	if (!chan)
> +		return -EBUSY;
> +
> +	*data =3D chan;
> +
> +	return 0;
> +}
> +
> +static void dw_pcie_ep_reclaim_dma_chan(struct pci_epc *epc, u8 func_no,
> +					u8 vfunc_no, void *data, bool quiesce)
> +{
> +	dw_edma_release_delegated_chan(data, quiesce);

[Severity: Low]
Does this code also rely on an undefined function? Like the request function
above, dw_edma_release_delegated_chan() appears to be undeclared in the
kernel tree at this point, which will break the build.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170438.3756=
593-1-den@valinux.co.jp?part=3D5
