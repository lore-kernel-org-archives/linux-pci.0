Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252DD3A872A;
	Tue, 28 Jul 2026 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260317; cv=none; b=MVONKNOxs54QiaSS5oTh0ZbIk7zxNmhaFFiIGE6lNsLLAJKJ1KKHESgrq5qkSYXFrG6YdhTZr6j6YlZUUYXhg94QpPPd+Q6/AOuMQR65b+3E2kQ8Nz6jnUhUsPWBt+BZ8OKAfCzIYEpf2ZkRSNLEIPMG8Usfb3GQ8BfdoeJer2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260317; c=relaxed/simple;
	bh=BrHoqps16R5WzCjuWrj5wJfoOJ+RoThtrlhKVBvelFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UPxl4xABpHDx9BwOYeGatqVFslGZmELsi6I3egc3+w/DL4BvqPz+QueOmzS/4v+GY+Nq3my2ss9Ifrm9Qyl11eXMMcko+kff8E2p0CiUEyyUkZT4KkCNN/vXx77tem3OmxD2CawEfcH7nEZ/7g+HxN9U/KQHIWRE0Y5vwm1CaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx1aiUeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx1aiUeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7795C1F000E9;
	Tue, 28 Jul 2026 17:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260315;
	bh=p1gGFpXUGp1YYwT1Z4jKS90VbXuUtXBHI4qiHt359Aw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cx1aiUeB75LYo7TxKQ+cZ5Lk02yQoDmuo1SkLlIVKswZVfaim8kInDqIsBPhaqWX8
	 14ldwBtUgAiqp96sA2AD5F2Lhy3vjH1D4WSiDU5mFmptLivNBC115fa3SxZPK1pWWj
	 Pc6TO8mWRxnVi7c3UWs8bAZn/xtLg0DYdgBGiR9yPrGnoMWpNj2AJbGgiiRD0hU36L
	 fow5yt8jahAUVZQLdGJHP5aNsTQCHTMTbGoLqdDaPBZCAaDz5RW3jo7SU/c4e2rUtq
	 6V0Q+GTivPzspVe4gjDAcnb3h/VO5DEiNCFMplfZUlaUrVMkYKHKcrhPrPlSTmiu3A
	 TwtFx3jPNoRrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI: endpoint: pci-ep-msi: Let non-first EPFs use
 embedded doorbells
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260728172306.2751813-4-den@valinux.co.jp>
References: <20260728172306.2751813-1-den@valinux.co.jp>
 <20260728172306.2751813-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:38:35 +0000
Message-Id: <20260728173835.7795C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of doorbell IRQ and message memory in `pci_epf_tes=
t_unbind` leads to a Use-After-Free.
--

--- Patch [3]: [PATCH 3/3] PCI: endpoint: pci-ep-msi: Let non-first EPFs us=
e embedded doorbells ---
commit 5b37917c476823bd8dce57c08e171daf54ed33f5
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-ep-msi: Let non-first EPFs use embedded doorbells

This patch allows non-first endpoint functions attached to an endpoint
controller to utilize embedded doorbells. It removes the restriction that
only the first endpoint function can allocate doorbells, falling back to
the embedded doorbell path directly for subsequent functions.

> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci=
-ep-msi.c
> index a123a189b4e65..5ea7eef9794f7 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -199,28 +199,31 @@ static int pci_epf_alloc_doorbell_msi(struct pci_ep=
f *epf, u16 num_db)
>  int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  {

[ ... ]

>  	/*
> -	 * Fall back to embedded doorbell only when platform MSI is unavailable
> -	 * for this EPC.
> +	 * The MSI-backed doorbell path currently targets the first EPF attached
> +	 * to the EPC. Let non-first EPFs try the embedded doorbell instead.
>  	 */
> -	if (ret !=3D -ENODEV)
> -		return ret;
> +	first_epf =3D list_first_entry_or_null(&epc->pci_epf, struct pci_epf,
> +					     list);
> +	if (first_epf =3D=3D epf) {
> +		ret =3D pci_epf_alloc_doorbell_msi(epf, num_db);
> +		if (!ret)
> +			return 0;
> +
> +		/*
> +		 * Fall back to embedded doorbell only when platform MSI is
> +		 * unavailable for this EPC.
> +		 */
> +		if (ret !=3D -ENODEV)
> +			return ret;
> +	}
> =20
>  	ret =3D pci_epf_alloc_doorbell_embedded(epf, num_db);
>  	if (ret) {

[Severity: High]
This is a pre-existing issue, but as this patch makes it possible for more
devices to allocate doorbells, can this lead to a use-after-free when an
endpoint is unbound while a doorbell is active?

Looking at pci_epf_test_unbind() in drivers/pci/endpoint/functions/pci-epf-=
test.c:

drivers/pci/endpoint/functions/pci-epf-test.c:pci_epf_test_unbind() {
    struct pci_epf_test *epf_test =3D epf_get_drvdata(epf);
    struct pci_epc *epc =3D epf->epc;

    cancel_delayed_work_sync(&epf_test->cmd_handler);
    if (epc->init_complete) {
        pci_epf_test_clean_dma_chan(epf_test);
        pci_epf_test_clear_bar(epf);
    }
    pci_epf_test_free_space(epf);
}

If the host sends a command to enable the doorbell, a doorbell is allocated
and an IRQ is requested via request_threaded_irq().

If the user then unbinds the driver via configfs, pci_epf_test_unbind()
does not check for or clean up the active doorbell. This means free_irq()
and pci_epf_free_doorbell() are not called.

When the endpoint function device is later destroyed via configfs rmdir,
the epf_test structure is freed. However, the IRQ handler remains
registered with the freed epf_test pointer.

Does this allow a remote host to trigger a use-after-free kernel panic by
sending an MSI doorbell interrupt to the endpoint after unbind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728172306.2751=
813-1-den@valinux.co.jp?part=3D3
