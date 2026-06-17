Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1123BB664;
	Wed, 17 Jun 2026 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781728802; cv=none; b=dHavZNIrFBwtN4mOmqbjmVynkxsZ40XppV1AoqDWbxO1riHyNws55nwNODdIvrRmafqSVXHBTw2x9JHSLLn4ETcle/wrKs4QX/9dtRgqVMmRlES98kzYmU4LBzTqZI8rjhI0JMqMiuA1TzAc4e6w5FAYpwvsineN1NbgII2l3t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781728802; c=relaxed/simple;
	bh=MvRWJdZBJDCMlsltvMQXYatKobmI0Mk0zpqaH8Mi9IY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bDCF3MMIoJD/hGgRzBZlt9tXlVyqvD0El0/s7FzoJssBMaJwP0UdWNozZBTb9KEPa4z3B5A0flIoB136bYP63JvQT0Mew5qeNYaMmeKb8P1xOBxAUDNx7lq2ToPV1hpPA2v8/RBqoht1ifkrA9LMBbMOBq154Z5I9JaFNYx6Xhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKVBuR+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKVBuR+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6F81F000E9;
	Wed, 17 Jun 2026 20:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781728801;
	bh=yMxmwowVoF8q8JSxd1es/1GoqGp9neqjMH+XqQmm/Dk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NKVBuR+ygJD1clUdKIw83mBfLj/Zg3TaaW4jlL0kgdtCnCDsSXqZq1VlNp43Q8OkG
	 brSKBHH6KzywF3gUOrTtwNs0b78Pd+qm06w8P8Fqbf4JEIEDqDpQUMc7EEr7z+bzVh
	 7enKidVXIcXIObzM+pCh1PPzKf8psmkIKXtJZF7bPnRCRd+PcO5mDqOW5Bv15PzAJv
	 nlTS5GjiSZDwfDiA0A/4qilkl0sR2Xbz6auzuWJ+GXUyCt5vZ32KdUgLA0Yk/cUu0h
	 wDVA6iKLskzlj2+nMG5IjrYDd8sgmDUS2dAH+Kl2uMrYpvhSMUvaxpWqBakf/MD/rh
	 i724z3OJhdnow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] PCI: Use standard wait times for PCIe link
 monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260617-tegra264-pcie-v7-2-eae7ae964629@nvidia.com>
References: <20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com>
 <20260617-tegra264-pcie-v7-2-eae7ae964629@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:40:00 +0000
Message-Id: <20260617204000.DC6F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of chained IRQ handlers and IRQ domains on error p=
aths in multiple PCIe drivers leads to Use-After-Free.
- [High] advk_pcie_wait_for_link() fails to guarantee the mandatory 100ms p=
ost-reset delay before configuration requests.
--

commit 1edbe267835d4abccd02c4abc064267f402a8ce2
Author: Thierry Reding <treding@nvidia.com>

PCI: Use standard wait times for PCIe link monitoring

Instead of defining the wait values for each driver, use common values
defined in the core pci.h header file. Convert all drivers to msleep()
and use the existing definition.

> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pc=
i/controller/mobiveil/pcie-mobiveil.c
> index 62ecbaeb0a604..e8346851c49b6 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> @@ -218,11 +218,11 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pci=
e)
>  	int retries;
> =20
>  	/* check if the link is up or not */
> -	for (retries =3D 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> +	for (retries =3D 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
>  		if (mobiveil_pcie_link_up(pcie))
>  			return 0;
> =20
> -		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
> +		msleep(PCIE_LINK_WAIT_SLEEP_MS);
>  	}
> =20
>  	dev_err(&pcie->pdev->dev, "link never came up\n");

[Severity: High]
This isn't a bug introduced by this patch, but is there a potential
Use-After-Free in the error paths handling these link bring-up failures?

In the caller mobiveil_pcie_host_probe(), if mobiveil_bringup_link() fails,=
 it
returns directly:

	ret =3D mobiveil_bringup_link(pcie);
	if (ret) {
		dev_info(dev, "link bring-up failed\n");
		return ret;
	}

Since chained handlers are set up earlier using
irq_set_chained_handler_and_data(..., pcie), returning an error causes the
devres-managed pcie struct to be freed. If the interrupt fires after this, =
won't
the active handler dereference the freed pcie pointer?=20

A similar issue appears in nwl_pcie_probe() if nwl_wait_for_link() fails. S=
hould
these error paths unregister the chained handlers and call irq_domain_remov=
e()
to prevent this UAF and resource leak?

[ ... ]
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controll=
er/pci-aardvark.c
> index fd9c7d53e8a78..272c5c8fc1e5c 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
[ ... ]
> @@ -350,13 +347,13 @@ static int advk_pcie_wait_for_link(struct advk_pcie=
 *pcie)
>  	int retries;
> =20
>  	/* check if the link is up or not */
> -	for (retries =3D 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> +	for (retries =3D 0; retries < PCIE_LINK_WAIT_MAX_RETRIES; retries++) {
>  		if (advk_pcie_link_up(pcie)) {
>  			pci_host_common_link_train_delay(pcie->link_gen);
>  			return 0;
>  		}
> =20
> -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> +		msleep(PCIE_LINK_WAIT_SLEEP_MS);
>  	}

[Severity: High]
This is a pre-existing issue, but does advk_pcie_wait_for_link() fail to
guarantee the mandatory 100ms post-reset delay before configuration request=
s?

The PCIe Base Specification mandates a minimum 100ms delay after a conventi=
onal
reset (e.g., PERST# deassertion) before the host can send Configuration
Requests. The caller advk_pcie_setup_hw() asserts PERST# and delegates the
post-reset delay to this function.

If the link trains rapidly and reaches L0 early, this loop returns immediat=
ely.
For link speeds of Gen2 or lower, pci_host_common_link_train_delay() is a n=
o-op,
so no additional delay is added.=20

Does this allow the driver to issue Configuration Requests before the endpo=
int's
100ms initialization period has elapsed, potentially causing enumeration fa=
ilures
for compliant endpoints?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-tegra264-p=
cie-v7-0-eae7ae964629@nvidia.com?part=3D2
