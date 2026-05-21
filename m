Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6139F3E2AAD
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374113; cv=none; b=o97KbOfFVr/0Cx7SF1pSvYbXkLM6USJ1HoRwLKoiZO+/zNG9t5pvqSBFPpApNBqSKqhRVTNqXHcCw6HR+eowEKa7VsbX+ng2qncmJsY3qc1vAL42CbKtCl/H3HnKWtsOMPcMXuV0i7TbznuV1qYZjTbd9W8zmb38dpZ8nD3CEag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374113; c=relaxed/simple;
	bh=unWHAa3Qt8mz8vG5wnlDVzOC4a61HmdWhTxljmOmzpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gbAvFkiHoU8KhVenlU4hCMQSWC+2gd56upw9fcXQK0j6MN9Zv66mBn946CYWXrX3DNVHL9duo7b7yqVW8CEAcqMp96f81ge6erbyFsLGuXvyNQJewfHImcZx4pZgVK8FnM0KuPHj6BS+cEwH0pQFUbF1MEaxTVZxDJHYRuQBOmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyx1WarA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyx1WarA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45CB1F000E9;
	Thu, 21 May 2026 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374112;
	bh=+pRX2z37xulb7NieSD0vJ+8VwcZxBKzaRDQaiGSdB8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kyx1WarAzlAAgOOKJhez+BYMCIB7eISExQItpmBblVDKp3BDSN1ddoHuWh9vWL2LV
	 ywGNow3YiLM0ezRo6Vnpk13gLB3SfQFlo2BERu4WjwkVF1g0tGrA780r4elmuvGap6
	 REFDxCRq8i2YlF/GSgPDisvrwQ9p2hR2cBkl3wRLnKZrJli9mqHcPn3/A8HmcaEOrP
	 /epaqSgr+fBmBXXb4E1+mE6TT/ITboxFJ+mVa/HRrlZb+xxnS2FmRcnm5rlBuwDsB1
	 DAwe/LV6vHhIzt3I/fS7F4JswghNZOyiQpKlq+e1ZVyra+2w7CWW8at8Juf2Jjl5FM
	 zNib4fMivYAHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] PCI: qcom: enable Link retain logic for Hamoa
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: olteanv@gmail.com, linux-phy@lists.infradead.org, neil.armstrong@linaro.org, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260521-link_retain-v2-4-08ed448b081c@oss.qualcomm.com>
References: <20260521-link_retain-v2-4-08ed448b081c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 14:35:11 +0000
Message-Id: <20260521143511.D45CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Setting `link_retain =3D true` in `cfg_x1e80100` exposes a flawed =
error handling path in `qcom_pcie_host_init()` that silently ignores `-EPRO=
BE_DEFER` and bypasses critical host configuration.
--

commit 868652002bbdb8222b28dbec2b0655af97d3ceb8
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

    PCI: qcom: enable Link retain logic for Hamoa

    The Hamoa platform supports keeping the PCIe link active across
    bootloader and kernel handoff. To take advantage of this, introduce a
    specific configuration (cfg_x1e80100) with link_retain =3D true and
    update the device match table to use it.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index b061eaa227b39..8496eb87debbc 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1557,6 +1557,12 @@ static const struct qcom_pcie_cfg cfg_sc8280xp =3D=
 {
>  	.no_l0s =3D true,
>  };
> =20
> +static const struct qcom_pcie_cfg cfg_x1e80100 =3D {
> +	.ops =3D &ops_1_21_0,
> +	.no_l0s =3D true,
> +	.link_retain =3D true,
> +};
> +

[Severity: High]
This isn't a bug introduced by this patch, but setting link_retain to true
here exposes a pre-existing flawed error handling path in qcom_pcie_host_in=
it()
that silently ignores -EPROBE_DEFER.

If pci_pwrctrl_power_on_devices() returns -EPROBE_DEFER when the power cont=
rol
driver hasn't bound yet, the error handler intercepts the deferral:

qcom_pcie_host_init() {
    ...
	ret =3D pci_pwrctrl_power_on_devices(pci->dev);
	if (ret)
		goto err_pwrctrl_destroy;
    ...
err_pwrctrl_destroy:
	if (pp->link_retain && ret =3D=3D -EPROBE_DEFER)
		return 0;
    ...
}

Will returning 0 here trick the DWC core (dw_pcie_host_init()) into assuming
host initialization completed successfully?

Since the probe completes without retrying, could this leave the PCIe slot
regulators unmanaged by the kernel, causing them to be disabled later when
regulator_init_complete() runs at late initcall?

Additionally, does returning early skip mandatory initialization steps like
qcom_pcie_clear_aspm_l0s() (which is required by cfg_x1e80100.no_l0s =3D tr=
ue),
hiding MSI-X/DPC capabilities, and performing SID configuration? Skipping t=
hese
could result in link instability, AER errors, and hardware malfunction.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-link_retai=
n-v2-0-08ed448b081c@oss.qualcomm.com?part=3D4
