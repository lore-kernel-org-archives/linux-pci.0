Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB80C3CDBC0;
	Fri, 10 Jul 2026 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672328; cv=none; b=dC85us03zi9uqD42mouwDV1a3UIb2ww1/mgL3DAePZ3iYr4+Y/74b/iEbxvh3gVukaDuBCmhGMZFya5AkUFT0C4F63h11rpJ0mb3hSN2D8CwllJS12SWmECOwgtyfJULGVBMJOD9YIwUt3IVhdJynVfzIEjw4tTtye2aInw+5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672328; c=relaxed/simple;
	bh=zsmqvjIGE+kIwi3lbXc2APYHOfB6GvWHuZe2vwFm5TY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RtZM8+U5jkUEwWn+WA7zRl8MLl5Gh+XHy1TznnSRq9GbAXIbzp7mFaUWYt5knBJSL0NhIsKUg830JPpQ36PWnnBaIWJPZAM5YrCfPAtuLhqN6Rpt7mw36eC5fFPDfsXZu8GhUlokHEYSimaGbSZq4JwELTjt4i160e0rRSn/ku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF3Slxm+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF3Slxm+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198D31F000E9;
	Fri, 10 Jul 2026 08:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783672326;
	bh=KoUaYJJJTzCLwsRsrwobIDFPW2BtE6yXrfgQODLamYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HF3Slxm+htk8FW3C2nRm1+NbQsN1yziBZy5P16NKsLjK+s5bKc6SZujpGGckFgc8q
	 cjbrPV0LzbUoF2jpk1vOVVy0vp0kjrPafI4WfWSxRtrouwebK47VbE+Jqb+ichV0xk
	 L/UqwwL36/8RUpm8X9KRDyUT0AHOKH6QTZs+be1ZAb5wkQh+0RRXzWfDrS7sGm8rP0
	 /KFMGdw7buCPezx1wGFAndiUkhl+DL2YxGcfOQ6PSAhUg/bsCMChe/8hg3tj9oCJMa
	 KSTcfCRV9LbIoW+u383YU5lKAwcSIrq8s/pf0SD0uc8GZnOLE6JC7tDB1l2WUVROA9
	 7NGqXhDq6Sh+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] PCI: endpoint: Add API to delegate EPC DMA
 channels to the host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260710082156.2395844-4-den@valinux.co.jp>
References: <20260710082156.2395844-1-den@valinux.co.jp>
 <20260710082156.2395844-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:32:05 +0000
Message-Id: <20260710083206.198D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but pre-existing API=
 functions `pci_epc_get_aux_resources()` and `pci_epc_get_aux_resources_cou=
nt()` unconditionally dereference `epc` before checking if it is an `ERR_PT=
R`.
--

--- Patch [3]: [PATCH v4 3/6] PCI: endpoint: Add API to delegate EPC DMA ch=
annels to the host ---
commit 1d374b51cba0f1ce466c2d806368e6604aa12539
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: Add API to delegate EPC DMA channels to the host

Some endpoint functions expose an EPC-integrated DMA controller to the
host. The endpoint function should not need to know the backend-specific
mechanism used to reserve a channel locally and hand its programming
interface to the host.

> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/p=
ci-epc-core.c
> index 831b40458dcd8..9c908051aa235 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c

[ ... ]

> @@ -236,6 +243,101 @@ int pci_epc_get_aux_resources(struct pci_epc *epc, =
u8 func_no, u8 vfunc_no,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
> =20
> +/**
> + * pci_epc_delegate_dma_chan() - delegate an EPC-owned DMA channel to th=
e host
> + * @epc: EPC device
> + * @func_no: function number
> + * @vfunc_no: virtual function number
> + * @dir: DMA channel direction relative to the endpoint
> + * @hw_ch: hardware channel number
> + * @chan: output delegated-channel handle
> + *
> + * Some EPC backends integrate DMA channels that can be exposed to the h=
ost.
> + * This helper asks the backend to reserve the specified channel locally=
 and
> + * place it in a state where the host driver may program it through the =
exposed
> + * register window.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the backend does not support DMA=
 channel
> + * delegation, or another -errno on failure.
> + */
> +int pci_epc_delegate_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_=
no,
> +			      enum pci_epc_aux_dma_dir dir, u16 hw_ch,
> +			      struct pci_epc_dma_chan **chan)
> +{
> +	struct pci_epc_dma_chan *epc_chan;
> +	void *data =3D NULL;
> +	int ret;
> +
> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> +		return -EINVAL;

[Severity: High]
This is a pre-existing issue, but while you correctly call
pci_epc_function_is_valid() here first to avoid dereferencing an error
pointer, could the pre-existing pci_epc_get_aux_resources() and
pci_epc_get_aux_resources_count() functions be crashing for the same
reason?

Looking at pci_epc_get_aux_resources() in drivers/pci/endpoint/pci-epc-core=
.c:

	if (!epc || !epc->ops)
		return -EINVAL;

	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
		return -EINVAL;

If epc is an ERR_PTR, the !epc NULL check passes, and it crashes when
dereferencing epc->ops before reaching pci_epc_function_is_valid().

Does it make sense to update these sibling functions as well to ensure they
safely handle an ERR_PTR?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710082156.2395=
844-1-den@valinux.co.jp?part=3D3
