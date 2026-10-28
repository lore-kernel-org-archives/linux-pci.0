Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157329;
	b=0H+xHpnY9hVe4kFVtNsUSQwXAfpF1I8DSiKbBycVSjQCT05c357o35USVruVo6nSMaGb
	 OIYo6IxIaVquB57znuKnuyFlpzGuBVeCK2gcMKGAWCwsIezVOm9abx6pniI5cc9p3Yaxu
	 NkswSYgmlDcVqLLIxPb6nspPGIuBOlGr8fJD5bCRcpol1ppzG1iAVS8JDnbfFnVIb39zM
	 e9qytfqSt+6PX7LJJ61l4oZi2uYcUZ7h57YxEyRH+Zkdh5X7nehryRYBUZPUP/FDxLE5V
	 eVYfyIfW9+30nFc8fmkd+oocsF1F5uHcxE8c/5Fwad/6da6MOA0XoMB5HdCTuUj3GeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157329;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JKVE0oHbGCK3KEheqHakd016WqeZ7tntTKiPfLYIsd4=;
	b=w2xKkVJcmVAeZUtseGxNenpU1kq3vEEKdIBFmS69JmaCZIMjhavmIMRcjITcWgStEIFM
	 lrLOtL4ofu2iRagrNHVYmAP2oMXMWlGTmhzYbtvCqn38222lrIN3qNoYTM/KbIYY019Or
	 Xmh3GDoahUdF4QP49GvOd2ZuAnR8oukJ+7c0rubDJDN5/XJpFiHUP6q6uuEJe7tXzKkGX
	 wkfTSuqBEUIkRmtn23K14zHf3sK90iTldCq28Ig59jJnZNfVW1n9jmS2s2LHln/gKjjTV
	 c4IcRBNhfwZ2Q0GjRd7wpPkNI6To/Z/YtCLu92wKWwr6mDdyQDYtwo/L5k1lHzUi1fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iu5NUdQz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D55606A31A;
	Wed, 28 Oct 2026 03:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iu5NUdQz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3B01F01829;
	Wed, 28 Oct 2026 03:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157328;
	bh=JKVE0oHbGCK3KEheqHakd016WqeZ7tntTKiPfLYIsd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iu5NUdQzyd7a65Ku7fJTWRV6m0p2do9Nc/2AJoVNOZJ8x/+qEsVuXsHO4hcXq8ZRh
	 Qb6v2CdqHDwdFXPILzwmPmA3FmGjyQVxKBKPJlt91xPR/r60oVIJDw6+p0n5QDkwis
	 Ksn/qvTJdAdajxJT1oOx2S9YPAudrYYLNY+kiTeG9liPpVK+vllNbk1eUpWHunYx9v
	 U6W+e6/qGXHvA5VWBmqaGOtgc67E++1XrC6nvEtUKIUkfJd633umj7+nHQLfif9Our
	 DU2lKE8+lami6PdQsZmOpB0wbrmLYKjHf/MfU170DApb/WinuidsiqQ+MdiFePL3fz
	 8i0UtSgno10lQ==
Message-ID: <sashiko-outbox-187403@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/16] PCI: dwc: Add pcie_cap field and caching
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: imx@lists.linux.dev, linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20261028030652.2917756-2-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-2-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:15:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: dwc: unconfirmed offset returned in dw_pcie_get_pcie_cap()
--

commit c6fcd840cdb57dd351ea1787cae915ad3164fb13
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: Add pcie_cap field and caching helper

This commit adds a pcie_cap field to struct dw_pcie and introduces a
dw_pcie_get_pcie_cap() helper that lazily looks up and caches the PCI
Express Capability offset on first use once confirmed via a DBI read-back.

> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 6d788aa000117..dede6b3966585 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
[ ... ]
> @@ -832,6 +834,42 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_p=
cie *pci)
>  	dw_pcie_writel_dbi(pci, reg, val);
>  }
> =20
> +/**
> + * dw_pcie_get_pcie_cap() - Return the PCIe Capability offset
> + * @pci: DWC instance
> + *
[ ... ]
> + * Return: the offset of the PCIe Capability, or 0 if it could not be
> + * found or has not been confirmed yet.
> + */
> +static inline u8 dw_pcie_get_pcie_cap(struct dw_pcie *pci)
> +{
> +	u8 cap =3D READ_ONCE(pci->pcie_cap);
> +
> +	if (!cap) {
> +		cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +		if (cap && dw_pcie_readb_dbi(pci, cap) =3D=3D PCI_CAP_ID_EXP)
> +			WRITE_ONCE(pci->pcie_cap, cap);
> +	}
> +
> +	return cap;
> +}

[Severity: Medium]
In drivers/pci/controller/dwc/pcie-designware.h, the kernel-doc for
dw_pcie_get_pcie_cap() states that it returns 0 if the capability could not
be found or has not been confirmed yet.

However, when pci->pcie_cap is 0 and transient DBI data causes
dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to return a non-zero offset cap
while the confirmation check dw_pcie_readb_dbi(pci, cap) =3D=3D PCI_CAP_ID_=
EXP
evaluates to false, pci->pcie_cap is left as 0, but the unconfirmed non-zero
cap is still returned to the caller.

Callers that guard DBI writes on a non-zero return (such as
rockchip_pcie_enable_l0s()) or cache a non-zero return in driver state (such
as tegra_pcie_dw_host_init() setting pcie->pcie_cap_base when
!pcie->pcie_cap_base) will then consume or permanently store the unconfirmed
offset.

Should dw_pcie_get_pcie_cap() return 0 when the confirmation read-back fail=
s,
or should the kernel-doc comment be updated to match the implementation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D1
