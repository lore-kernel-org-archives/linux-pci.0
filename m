Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03A29AAFA;
	Thu,  4 Jun 2026 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586149; cv=none; b=HYwx7oFrA5QuzCry9dSq2pvtC6CVMD5dGoNUmpzM3PMZ5Nu3c+KBQKIvbNRa0Gyr4F9bicymGaQCWrmgJQXdrHLwlqCrbaz7Ka/oSa+4UbGdWejNm+/4RtyQfQR0kGj9J90HOaoxvgxtMnxnU8UzHTenPVNIjIWrFp/o+HunL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586149; c=relaxed/simple;
	bh=QOjP6ZsjE1TL0WKoWCuHe7+kuDUKjgniWNGIr28ldP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EpQkA5hwhrsigaWg083oq7hwGz2oeqSZIxB8TknZJJFXglMpPSb/ZoDkry+VT2miOuWjixpZcJVpscoX3SO3uUQpGo+odXYHE54lNQ3uDmuRllFgQCtVtBrP3tWRKAE3hu8V71tHdWiuZWRRIGcqsfvajA+apiH67CKTv8wMMMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoTZR3iL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoTZR3iL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAA61F00893;
	Thu,  4 Jun 2026 15:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780586148;
	bh=tE2GI5cIzyf0fCM416G9gnZvY5JzJMDAtmqVETK4554=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HoTZR3iLpWL5q2tur1v9aCbclvWhk2vkqvU6vvT54lzDZlgjxmCDGXpHc4Kvp0pcv
	 i4z8Vq4JIGjfhu3pLM8o3zjGSICE51CDHNAZblC3EFoX/o0Y1M9Br575azuoUqmfNL
	 JQCp6O4XJwgk0Jfb0juqiLvtJROqVSkNSLivixTD2VhNydJdfvTB0ZuMzoZDPNXqL2
	 xopp/1a+OaaWlqwD1y9eEGL3jYtLH5k/monxjDs9Q2GrflXFAt/VryZWMnzw3SW9wp
	 xItpsKlv5vpa319wTXebvg/zWv7a1BK4d3IFjkNaujmMQQ8JqzTqGTr1SKT6QvbxYG
	 SmslIJdqfIEQg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 02/12] PCI: Convert iov.c to pci_is_sriov_* helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dimitri Daskalakis" <dimitri.daskalakis1@gmail.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260604150153.3619662-3-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-3-dimitri.daskalakis1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 15:15:46 +0000
Message-Id: <20260604151548.2BAA61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Division by zero in pci_iov_vf_id() if the VF Stride is 0.
--

commit ef3219de5f4e200d2b4b6b2b9d4bac7ee1daf6b4
Author: Dimitri Daskalakis <daskald@meta.com>

PCI: Convert iov.c to pci_is_sriov_* helpers

This commit converts the dev->is_physfn and dev->is_virtfn checks in
drivers/pci/iov.c to use the pci_is_sriov_physfn() and
pci_is_sriov_virtfn() helpers instead.

> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 91ac4e37ecb9c..5de26057b99aa 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c

[ ... ]

> @@ -42,7 +42,7 @@ int pci_iov_vf_id(struct pci_dev *dev)
>  {
>  	struct pci_dev *pf;
> =20
> -	if (!dev->is_virtfn)
> +	if (!pci_is_sriov_virtfn(dev))
>  		return -EINVAL;
> =20
>  	pf =3D pci_physfn(dev);

[Severity: High]
This is a pre-existing issue, but is there a potential divide-by-zero
risk in pci_iov_vf_id() when a device has only a single virtual function?

According to the PCI SR-IOV specification, if TotalVFs is 1, the VF Stride
is undefined and can be 0. While compute_max_vf_buses() correctly permits
a 0 stride when the number of VFs is 1 or fewer, the end of pci_iov_vf_id()
does an unconditional division:

int pci_iov_vf_id(struct pci_dev *dev)
{
	...
	pf =3D pci_physfn(dev);
	return (pci_dev_id(dev) - (pci_dev_id(pf) + pf->sriov->offset)) /
	       pf->sriov->stride;
}

Could this cause a kernel panic during the driver probe path when
enumerating fully compliant PCIe hardware with a 0 stride?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604150153.3619=
662-1-dimitri.daskalakis1@gmail.com?part=3D2
