Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079994;
	b=iZ0efHwvViMyI4Cm8As05xh22vi3EHQBjG9Z5AtY+pO+U/XKCoePsYV+064uxDyr/ROr
	 adGqyLl9eKhd4j1FT3Mp+hL5bh16EiwLsz+0XxrflzR+uiuBQDjTZrkiJCba5dCfF9B43
	 S0uwkxz/iWUBTu+bIgCIUfDzGzIaXDBcjP7o9ldH1ED0e4iHci9EjYqN+WbIQMnNijTA/
	 s1pbxoPG8WlGcjlbGJW716ffCB7OonZe8vczazMIifXXwawOzp7mME/B2qdiZSng0hR2v
	 IbsJCipetMKh0vYZq0mmI+TzzkUrWhzWP5DZGbjFNeAZVE8UWYFU1tiWBNtBqFruhaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079994;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PUhSmohhQR9sF9O22bTKllxo1Om2s1tFyt7Vg4qnkx8=;
	b=qC9HFyAR4vJyHaMfzcSx8SX7yL+2x+bgZlrEkiCMwMPzzUDw1o1lkHC3iQdxU21ecSDB
	 zmX+l9fs1Hlw/HSPBLCp3khmKOxu+guc6cRyUFlYDufApCm6gdX7/wzshlygfK802Fbbe
	 IfaL3A2+2rLczhRsrVoc5Gddu3uhRkYq1wMFRVr+DL7BSiK4RB91TWWohSfxN8bsPD7oZ
	 DoykpEGXvC2L3YzJSjzNWOrMV9Yh4QH6KsX6bJ/zoT+nDx6tKl8D0Yoe2I6cVaQAAzgDk
	 sbVGLiwzLJ0HjNhLmrjou6GxDxtpwHK0keY1chStQBp/3bgYtDi/r7VL3y4wtDF1yIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MH76BO9Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F33606A31A;
	Tue, 27 Oct 2026 05:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MH76BO9Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615A21F01825;
	Tue, 27 Oct 2026 05:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079993;
	bh=PUhSmohhQR9sF9O22bTKllxo1Om2s1tFyt7Vg4qnkx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MH76BO9ZsbCRMfTEvc+n6q1yQ15r1BjtqJdyix/zsBdifT/5lXEbrJ93Gfhz4UgbI
	 WD6G5In+K2IvCa+QqMJfR89RAzdWvitPVGsqv+MVEPAkPaeGYqmqI4CtwLfacCioF5
	 FghlUGQ0Q+dmZukfG9HzQu/C59VaiZhWJk0WwpX0YtvQ3yaoQEqFYSwvrRmC+y7XaM
	 AzPg1XKvLZVDZt0YjlQ3DknfvbtT6UX7XxUnRwXsJFtrnT+31wmEFZoh+i2B1yynMs
	 xekaX7OLld7ii6jtcYrGYXa49jYnIvbX/XQOhKLi54+D9rY3dmguTmI0Mhi1WS415D
	 sGTiyG+4/Eeeg==
Message-ID: <sashiko-outbox-186141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/23] PCI/CMA: Add a PCI TSM CMA driver using SPDM
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261027052536.1722081-13-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-13-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:46:33 +0000
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
- [High] PCI/CMA: pci_cma_tsm_probe() initializes subfunctions without conn=
ect()
--

commit 422c44a59294e74ffe91f6512ceb7d64705e55f8
Author: Alistair Francis <alistair.francis@wdc.com>

PCI/CMA: Add a PCI TSM CMA driver using SPDM

This commit adds a PCI TSM driver for Component Measurement and
Authentication (CMA-SPDM) over a PCI DOE mailbox to support device
authentication.

> diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
> new file mode 100644
> index 0000000000000..6b52b129574ec
> --- /dev/null
> +++ b/drivers/pci/cma.c

[ ... ]

> +static struct pci_tsm *pci_cma_tsm_probe(struct tsm_dev *tsm_dev,
> +					 struct pci_dev *pdev)
> +{
> +	struct pci_cma_tsm *cma;
> +	int rc;
> +
> +	if (!pdev->doe_cma)
> +		return NULL;
> +
> +	cma =3D kzalloc(sizeof(*cma), GFP_KERNEL);
> +	if (!cma)
> +		return NULL;
> +
> +	rc =3D pci_tsm_host_constructor(pdev, &cma->host, tsm_dev);
> +	if (rc) {
> +		kfree(cma);
> +		return NULL;
> +	}
> +
> +	cma->spdm =3D spdm_create(&pdev->dev, pci_doe_transport, cma->host.doe_=
mb,
> +				PCI_DOE_MAX_PAYLOAD, NULL);
> +	if (!cma->spdm) {
> +		pci_tsm_host_destructor(&cma->host);
> +		kfree(cma);
> +		return NULL;
> +	}
> +
> +	return &cma->host.base_tsm;
> +}

[Severity: High]
Can pci_cma_tsm_probe() be invoked via probe_fn() for subordinate or
sibling PCI functions without pci_cma_tsm_connect() ever being called on
them?

In drivers/pci/tsm.c, ops->probe() is called not only on the target host
device in pci_tsm_connect(), but also via probe_fn() when walking
functions in pci_tsm_connect() (when has_tee(pdev) is true) or when SR-IOV
VFs are initialized in pci_tsm_init():

drivers/pci/tsm.c:probe_fn() {
	if (pdev->tsm)
		return 0;

	pdev->tsm =3D ops->probe(dsm_dev->tsm->tsm_dev, pdev);
	pci_dbg(pdev, "setup TSM context: DSM: %s status: %s\n",
		pci_name(dsm_dev), pdev->tsm ? "success" : "failed");
	if (pdev->tsm)
		link_sysfs_enable(pdev);
	return 0;
}

drivers/pci/tsm.c:pci_tsm_connect() {
	...
	if (has_tee(pdev))
		pci_tsm_walk_fns(pdev, probe_fn, pdev);
	return 0;
}

Because pci_cma_tsm_probe() only checks pdev->doe_cma, any walked sibling
PF, downstream device, or VF with doe_cma set will have cma->host and
cma->spdm allocated and assigned to pdev->tsm, followed by
link_sysfs_enable(), without pci_cma_tsm_connect() (and thus
spdm_authenticate()) running on that function.

Doesn't this cause a few issues for those walked functions:

1. In drivers/pci/tsm.c, authenticated_show() delegates to connect_show(),
which reports the TSM device name whenever pdev->tsm is non-NULL, falsely
reporting the unauthenticated function as authenticated in sysfs.

2. Any subsequent attempt by userspace to authenticate that function via
connect_store() will fail with -EBUSY because pdev->tsm is already
populated.

3. For sibling PFs and downstream endpoints where is_pci_tsm_host() is
true, pci_tsm_host_constructor() sets sub_pdev->tsm->dsm_dev =3D sub_pdev
via find_dsm_dev(). When the parent device later disconnects in
__pci_tsm_disconnect(), remove_fn() skips cleaning up sub_pdev:

drivers/pci/tsm.c:remove_fn() {
	if (!pdev->tsm || pdev->tsm->dsm_dev !=3D host)
		return 0;
	...
}

leaving the unauthenticated sub_pdev->tsm and cma->spdm leaked and active.

4. If a VF (pdev->is_virtfn) has doe_cma set, calling
pci_tsm_host_constructor() on it violates the is_pci_tsm_host()
expectation for struct pci_tsm_host.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D12
