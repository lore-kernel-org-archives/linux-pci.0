Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365003BFE24;
	Thu,  8 Oct 2026 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440102; cv=none; b=qZ1EObd/XWhNfQ4CT2n+Fo2r+qLdSscNPvAtvLaGUzIPSX/U7Y55yjHy8ffCJZB0F9SB6OSQuI+Cr4c24gH+Q5r3qLhsolVHiHiG8qoAe0BIu8xIZu0/1K8RG/Q6vj9/LEDb0R99mZb4U3EbyUgvduegKyj/9QYSlZ0KwZkhd4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440102; c=relaxed/simple;
	bh=8pOatxKJF/3Yj3BLIg/B0+CMVQPYWE3JHtVzO0jlSS4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ex6RznVC2v6T1PYRJNbADEnLVhVYgZOwMw0a4IFXi4ffJB0tVk2+0f9yCVCE3i8G2iad6nxRVu1HwtnQuVa3Vg/2RaEkuDfeLciD7/JBScbfCiWCicUm5ZmjVHq8OV3BKQKom3NziBh3d8coq2MMq7uqYtSu3j6LvPXJdboNmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV9xVGso; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV9xVGso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12161F000FF;
	Thu,  8 Oct 2026 06:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791440100;
	bh=TdDTX7ULALDFhFjGMhgkC9jDr9HhwKF/marGrwYH8Ls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hV9xVGsofdTrbQ0DaxGOoPGQTnxznZ0SbmuNwiN5H//5A9dAWBGE7dITNJxYMRkn5
	 +BXV8DN9ZUWPeK3LLmMKQ/xNZH2AExOSBw5rX79m4Frtp6ilFaqfrb7skcbNG+JLQN
	 8zqAYojPwPFXCs7NDNhCa9+TDSulaQtN/Bhc9Sfl+nwVBusCYbHbwCxHyHNnmLpYAA
	 nxxgsb1MwFLpvXJTqe4vs2FwejP3JmkqePzXvMfm2Kw05lCWPCrjaXMSSZPmcOcA4U
	 Ocyg2GAm9aQItX+OVwG2eQ7hDCUi99qdZFFjlDs8DRbXAAQnx9EPJcgVD/pRI1+kkk
	 HLjAvv7CTrKOQ==
Message-ID: <sashiko-outbox-163673@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/16] tsm: Remove the device from lookup before PCI
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261008055955.4014342-10-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-10-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:15:00 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tsm: race in tsm_register() error path leads to UAF and NULL poi=
nter deref
--

commit f9b77b7469552ae6078c3a47333908a88eec2474
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

tsm: Remove the device from lookup before PCI teardown

This commit modifies the teardown flow to remove the TSM device from
lookup before tearing down the PCI state. It also adjusts the setup
flow in tsm_register() to handle PCI registration failures differently.

> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -56,26 +56,25 @@ static struct tsm_dev *alloc_tsm_dev(struct device *p=
arent)
[ ... ]
> -static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
> -						 struct pci_tsm_ops *pci_ops)
> +static int tsm_register_pci(struct tsm_dev *tsm_dev, struct pci_tsm_ops =
*pci_ops)
>  {
[ ... ]
>  	tsm_dev->pci_ops =3D pci_ops;
>  	rc =3D pci_tsm_register(tsm_dev);
>  	if (rc) {
> +		tsm_dev->pci_ops =3D NULL;

[Severity: Medium]
Does this unprotected write to tsm_dev->pci_ops introduce a race condition?

If pci_tsm_register() returns an error early (e.g. if a driver incorrectly=
=20
provides both link_ops and devsec_ops, returning -EINVAL before acquiring=20
pci_tsm_rwsem), a concurrent userspace write to the connect sysfs attribute=
=20
might trigger connect_store().

If connect_store() evaluates is_link_tsm() concurrently, this lockless=20
assignment to NULL on the error path could cause the compiler to reload the=
=20
pointer after the NULL check. Could this lead to a NULL pointer dereference=
=20
when accessing ->link_ops.probe?

>  		dev_err(tsm_dev->dev.parent,
>  			"PCI/TSM registration failure: %d\n", rc);
> -		device_unregister(&tsm_dev->dev);
> -		return ERR_PTR(rc);
> +		return rc;
>  	}
[ ... ]
> @@ -96,15 +95,22 @@ struct tsm_dev *tsm_register(struct device *parent, s=
truct pci_tsm_ops *pci_ops)
>  	if (rc)
>  		return ERR_PTR(rc);
> =20
> -	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
> +	rc =3D tsm_register_pci(tsm_dev, pci_ops);
> +	if (rc) {
> +		device_del(dev);

[Severity: Medium]
Can this error path lead to a use-after-free if PCI registration fails?

Since device_add() is called prior to tsm_register_pci() in tsm_register(),=
=20
the device is already exposed via class_find_device(). If a concurrent=20
connect_store() finds the device and proceeds to pci_tsm_connect() before=20
this error path cleans it up, it will attach the PCI context to tsm_dev.

When this error path calls device_del() and returns, the __free(put_tsm_dev=
)=20
guard at the top of tsm_register() will drop the primary reference to=20
tsm_dev, freeing its memory.

Because the attached PCI context stores the pointer without taking an=20
additional device reference, wouldn't this leave a dangling pointer in the=
=20
PCI context, resulting in a use-after-free on subsequent accesses?

> +		return ERR_PTR(rc);
> +	}
> +	return no_free_ptr(tsm_dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D9
