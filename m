Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70AA23909F;
	Sat, 22 Aug 2026 01:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787362601; cv=none; b=OshB+UNYi5QTRYQa8BAjBXX5m7CM7f0/gvkP78QnBbrRgfwCg9BylqaoYkknRMcXOD6zDJSAbKopeVAKXWB0StIxJ+wt0LfvSbN0zk2yUc1/DN9W4Ght8k+RqLPIgwfx6+I0KGjEfCDBAT4lvfDtFLKFkBYH1rcYXoNtHHNJIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787362601; c=relaxed/simple;
	bh=QaWzR/Hld/OlqlClulgyci54pyt0lwD9VwkfkeCGa5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tlHrW9dw6Qiznv7+SSHGHcoMAS6C19tewTybGQM7VFhusYHclhmahG+eqcFt+dV0oZGXXWJwUyXueZCeUMupJiihexPCUlu/gvkAMdw7RrjK1r1S94XcYHmOmaVxDgiCBGGK99S3zWs98e5wSBLJuC/k0UkphBEov1qy5iLNpNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYM+1Kku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYM+1Kku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182C01F000E9;
	Sat, 22 Aug 2026 01:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787362600;
	bh=QximY4sVsKJCTynYKPIH7e5+on+TcyWO+1toCQv7vpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TYM+1KkuZvIESo4Zwsim1Jow5w0n3pZT1cvePI6vcqo4lhb4Zaex2pDy3nARlPsAK
	 bUa1NT2f8qGr+Z6IknWD3YsLApsTMs8yeRqzcUAtRpFW0ud/11FayaW1UYAyQuNNed
	 fHPJ3ah3gHh4mkyvbMokpmv0DhAZHOiENy1Ngw6VNTUquumJC0ChJLeqXPBDi8m3WS
	 uty10v8RVeBg1+m/IavEG1biEJQljBwycHwy6oJv3S1b9mRvJ8GyIx7kZygG2IKZes
	 kakIXM2FwFMX/jhXDHxF3eWLZuCJ6pTXM1k2IgKvwCJ25zbRJggeejlI13k+/M4mTj
	 7WaY8WkwAae1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: imx6: fix pwrctrl device leak on PM runtime setup
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: hanzhijian <hanzhijian1991@gmail.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260822012205.2459806-1-hanzhijian1991@gmail.com>
References: <20260822012205.2459806-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 01:36:39 +0000
Message-Id: <20260822013640.182C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbalanced `dev_pm_domain_attach_by_name()` and stateless `device_=
link_add()` calls in `imx_pcie_attach_pd()` cause persistent resource leaks=
 on probe failure or probe deferral.
- [High] `imx_add_pcie_ep()` ignores the return value of `imx_pcie_host_ini=
t()`, causing hardware access on unpowered registers and a potential kernel=
 panic.
--

--- Patch [1]: [PATCH] PCI: imx6: fix pwrctrl device leak on PM runtime set=
up failure ---
commit 0d55b3d7e1c6b8341c6d4f378c6f80b85c73e417
Author: hanzhijian <hanzhijian1991@gmail.com>

PCI: imx6: fix pwrctrl device leak on PM runtime setup failure

This commit fixes a resource leak in imx_pcie_probe() by redirecting a fail=
ure
path to err_pwrctrl_destroy rather than returning directly. It ensures pwrc=
trl
devices are properly cleaned up when PM runtime setup fails.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 39790e66b98dc..616c42932faa1 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1975,7 +1975,7 @@ static int imx_pcie_probe(struct platform_device *p=
dev)
>  			pm_runtime_no_callbacks(dev);
>  			ret =3D devm_pm_runtime_set_active_enabled(dev);
>  			if (ret < 0)
> -				return ret;
> +				goto err_pwrctrl_destroy;

[Severity: High]
This is a pre-existing issue, but does the err_pwrctrl_destroy error path l=
eak
PM domains and device links?

In imx_pcie_probe(), imx_pcie_attach_pd() explicitly allocates PM domains v=
ia
dev_pm_domain_attach_by_name() and creates stateless device links:

drivers/pci/controller/dwc/pci-imx6.c:imx_pcie_attach_pd() {
	...
	imx_pcie->pd_pcie =3D dev_pm_domain_attach_by_name(dev, "pcie");
	...
}

If a failure occurs and the code jumps to err_pwrctrl_destroy, it appears t=
hese
resources are not explicitly cleaned up using dev_pm_domain_detach() and
device_link_del() before returning.  Since this can happen on probe deferra=
ls
(e.g., if pci_pwrctrl_create_devices() returns -EPROBE_DEFER), will these
resources leak repeatedly on every deferral?

>  		}
> =20
>  		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))

[Severity: High]
This is also a pre-existing issue, but does imx_add_pcie_ep() ignore the
return value of imx_pcie_host_init()?

Looking at imx_add_pcie_ep(), which can be called earlier in imx_pcie_probe=
()
before reaching this code:

drivers/pci/controller/dwc/pci-imx6.c:imx_add_pcie_ep() {
	...
	imx_pcie_host_init(pp);
	ep =3D &pci->ep;
	ep->ops =3D &pcie_ep_ops;
	...
	ret =3D dw_pcie_ep_init(ep);
	...
}

If imx_pcie_host_init() fails (e.g., if regulators or clocks fail or defer),
the return value is discarded.  Will the code blindly proceed to
dw_pcie_ep_init() and access unpowered or unclocked hardware registers,
potentially causing a kernel panic due to an SError on ARM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822012205.2459=
806-1-hanzhijian1991@gmail.com?part=3D1
