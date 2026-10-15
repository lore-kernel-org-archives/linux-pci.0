Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B72EDD53;
	Thu, 15 Oct 2026 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029294; cv=none; b=vE0vkSptmg0s9367jkOSmxNLkhAXT01iiZSJEbI4EBCl2V+tJRCEgMGg7xg111/g2MMk8l7az2Tb6ya3w5loZh4N1HSFy9YhmdFeSQu2mS6DtbyAFELxUPtcWoVTUrTONoTwrrpd2VHGp41ywbH9+x6eClz4R+xb2OwCG9eVrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029294; c=relaxed/simple;
	bh=9p1gQA9vbahq2zxhWgs7PQ2ac78dgWcM5YJSWYUml0w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aPCLWwo6i+8JdDA5nqTzPOnfm/dv76tHsFqnGVhDueREsHzFA+x/3szwa8gqm3Vk40/7CZo+yvIbHtkwSKxjwpFS6OKUhpetxJgPjq8wzuolBustr1KAEGz9uizXd0JcUVJQ/9yeWnsFoan9bvLkCKuBLyfTN5e1kHe+7ciFds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d97mUIJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d97mUIJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEF71F000C4;
	Thu, 15 Oct 2026 01:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792029292;
	bh=ejcmnRENmFa6gc7f5JXb/ZviicwgplJ39hqOQKtQkuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d97mUIJZvLglwVWIJtQ+KK8gUHTw185VCImnfu+7FPRSKSvi8siVZpY7Ec3Hhldy9
	 DRZ9V8iC+t4qf25GCcfbisAPbI8AH9O3UmD5kl69BqwPWehQtcYEGof4ToxIE/6GUA
	 /6bvs0U3DAr8yZEacueaNi/TwwKJc414sKZ/lYGwUUmrgxt/v0zbWpQKWQlBIE4OSn
	 NShcrCf2rTmrYtphWH+D83DjKoeh2D16kurS8nabU6zJk6RHw2PqhQmyuNDLGf+CL8
	 HlrXjSxCkNRahrFuPzPuXG04jcSn9TDKABg8wJcK7Es6egBIVqrt2i34unQhJWAXr3
	 zn14DGlLXL7Vg==
Message-ID: <sashiko-outbox-172128@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] PCI: endpoint: pci-epf-vntb: Use a local epf
 pointer in interrupt setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20261015014402.2976188-2-den@valinux.co.jp>
References: <20261015014402.2976188-1-den@valinux.co.jp>
 <20261015014402.2976188-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 01:54:52 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci-epf-vntb: missing NULL check for epc_features causes dereferen=
ce crash
--

commit 696d7d5432aa89730866d2e53e0d664d75343cd2
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Use a local epf pointer in interrupt setup

This commit introduces a local epf pointer to simplify device access and
shorten repeated pointer dereferences in epf_ntb_configure_interrupt.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index a11f9260ee860..d74402ea10bf6 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -545,12 +545,14 @@ static int epf_ntb_config_spad_bar_alloc(struct epf=
_ntb *ntb)
>  static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  {
>  	const struct pci_epc_features *epc_features;
> +	struct pci_epf *epf =3D ntb->epf;
>  	struct device *dev;
>  	int ret;
> =20
> -	dev =3D &ntb->epf->dev;
> +	dev =3D &epf->dev;
> =20
> -	epc_features =3D pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,=
 ntb->epf->vfunc_no);
> +	epc_features =3D pci_epc_get_features(epf->epc, epf->func_no,
> +					    epf->vfunc_no);
> =20
>  	if (!(epc_features->msix_capable || epc_features->msi_capable)) {

[Severity: High]
Could this regression result in a NULL pointer dereference crash?

Looking at pci_epc_get_features() in pci-epc-core.c, it returns NULL for
invalid configurations or if the driver is missing get_features operations:

pci_epc_get_features() {
        if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
                return NULL;

        if (!epc->ops->get_features)
                return NULL;
        ...
}

If a user configures the endpoint with an invalid function number via
configfs, pci_epc_get_features() will return NULL. Because the returned
epc_features pointer is unconditionally dereferenced in the if statement
above, would it be safer to add a NULL check before inspecting the
structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015014402.2976=
188-1-den@valinux.co.jp?part=3D1
