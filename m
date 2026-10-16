Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450022DEA7B
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156403; cv=none; b=EVF8oGFqfje3OPgdWs7z00jpgPO2LJ/UTnmjG6HYxqgD9sk0KVilla86saCCo1Iur1xFNf+L37SE2TLqtUd2GDJvbgmTnpSD95NJO0BGMn+FgP2FPQca6AFzhhEXvzz4slGP5LGjwI4pdf4S4rvJlhbaEl8C0Q8UXqOgU0M4pnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156403; c=relaxed/simple;
	bh=qCZNKcKdeHmVz4DTmJQRNVw3Gc404lG66YnsaHB+BX8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=O1oJHLPEKNpRUUY12EN3gnTho628tW0utWy/90mhji4P3vd/JKY57HGos6xI5hZxKn7Vx7d5TkFozWZek160sAdC98t3MJdCHpXQNEJmWZXfZ0fuTUm6EsHFEhQ1lWn5VrAfw08q7ZxU0WSQDXc49i+5HffBjLAHNSt+Y0TzDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy1oUPnY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy1oUPnY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7351F000C4;
	Fri, 16 Oct 2026 13:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792156401;
	bh=A/kWGuTAG97EBEfAM48Lqr/50qJKTLxY9R1omP9uAVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gy1oUPnYw5t4ufhXjrpxBDqtD4YBf7QOs5zZIzZ/lQZiGvwtL3KlDHDaYqV+tAWg1
	 yBC+GJkFHn7HmI+8P15d7xkwxMJTV2VTzeC0tvt0BBsX83oA39mWuWvcOSC+CxVmvW
	 gFfEM2lud8+4PmKMjlJYpTwXWW+37Z5xxwuoNc1USaZV0gIZuwYH4ruLk9Mndzrdgl
	 PqLf2tUc9NY/F3c2mAkgceDEKKAQYTMHndhSFjiUFLj9PFFDuRPpH+Hn7mRbY4efjc
	 F8Z8EZf1NACPC9SM6TmBur9I+589y5oOmomkmuQYY0g9E/go1rfiO2CyxNuAtmfCj/
	 Nf0YHRMsXGScg==
Message-ID: <sashiko-outbox-174374@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: qcom: Implement .reset_root_port() for
 firmware-managed controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mrinmay Sarkar" <mrinmay.sarkar@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261016-pcie-controller-reset-v1-1-51779736cf12@oss.qualcomm.com>
References: <20261016-pcie-controller-reset-v1-0-51779736cf12@oss.qualcomm.com>
 <20261016-pcie-controller-reset-v1-1-51779736cf12@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 13:13:21 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] pci: qcom_pcie_fw_reset_root_port fails unconditionally if CONFIG_=
PM_SLEEP=3Dn
- [High] pci: qcom: MMIO crash due to PM state corruption via pm_runtime_fo=
rce_suspend()
- [High] pci/ecam: memory corruption due to cfg->win assignment on 32-bit
- [Medium] pm: async pm_runtime_put() races with pm_runtime_disable() on pr=
obe error path
- [Medium] pci: dwc: lockless dw_pcie_msi_init() races with IRQ mask updates
--

commit 758a2a2a75785b89801fabff2d094acd8d02d3de
Author: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>

PCI: qcom: Implement .reset_root_port() for firmware-managed controllers

During PCIe recovery events, such as a fatal AER event or other
platform-specific PCIe failures, the controller may enter a state that
requires a full reset before normal link operation can be restored.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index d903f10211c23..744455ae90d46 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1855,6 +1855,35 @@ static int qcom_pcie_set_max_opp(struct device *de=
v)
>  	return ret;
>  }
> =20
> +/*
> + * Reset for firmware-managed controllers: power-cycle via runtime PM and
> + * reprogram DWC MSI registers on resume.
> + */
> +static int qcom_pcie_fw_reset_root_port(struct pci_host_bridge *bridge,
> +					struct pci_dev *pdev)
> +{
> +	struct pci_config_window *cfg =3D bridge->sysdata;
> +	struct device *dev =3D bridge->dev.parent;
> +	struct dw_pcie_rp *pp =3D cfg->priv;
> +	int ret;
> +
> +	ret =3D pm_runtime_force_suspend(dev);

[Severity: High]
Is there a risk of an SError or kernel panic here due to unclocked or
unpowered MMIO access?

Calling pm_runtime_force_suspend() physically powers off the PM domain.
However, because the controller has active children (PCI devices),
pm_runtime_need_not_resume() evaluates to false, leaving the device's
runtime_status as RPM_ACTIVE while disable_depth is > 0.

If a concurrent thread (like unprivileged userspace reading sysfs) calls
pci_config_pm_runtime_get(), rpm_resume() will see disable_depth > 0
and runtime_status =3D=3D RPM_ACTIVE. It will incorrectly return success
without powering on the device, and the subsequent MMIO access will hit
powered-off hardware.

> +	if (ret) {
> +		dev_err(dev, "Failed to force runtime suspend for reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D pm_runtime_force_resume(dev);

[Severity: High]
Does this fail unconditionally on systems where CONFIG_PM_SLEEP is disabled?

In include/linux/pm_runtime.h, if CONFIG_PM_SLEEP is disabled,
pm_runtime_force_resume() is a static inline function that
unconditionally returns -ENXIO.

This guarantees that PCIe root port resets, such as during AER recovery,
will permanently fail and leave the hardware powered off.

> +	if (ret) {
> +		dev_err(dev, "Failed to force runtime resume after reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dw_pcie_msi_init(pp);

[Severity: High]
Could this lead to memory corruption on 32-bit architectures?

On 32-bit systems, pci_ecam.c sets per_bus_mapping to true and allocates
cfg->winp as a heap pointer array using kcalloc(). Because cfg->win
and cfg->winp are union members in struct pci_config_window, cfg->win
ends up holding the virtual address of the heap-allocated pointer array.

qcom_pcie_ecam_host_init() unconditionally assigns pci->dbi_base =3D
cfg->win. When this new reset path calls dw_pcie_msi_init(pp), it uses
pci->dbi_base to write MSI configuration values, which will overwrite
the heap array instead of MMIO registers.

[Severity: Medium]
Is it safe to call dw_pcie_msi_init() locklessly from a concurrent AER
recovery context?

dw_pcie_msi_init() reads pp->irq_mask[ctrl] locklessly and writes it
directly to the hardware register:

drivers/pci/controller/dwc/pcie-designware-host.c:dw_pcie_msi_init() {
    ...
    dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + ..., pp->irq_mask[ctrl]);
    ...
}

During AER recovery, this executes from a normal workqueue. If an IRQ
affinity change or driver unmask operation concurrently invokes
dw_pci_bottom_mask() on another CPU, it updates the mask under
pp->lock. The lockless read here could overwrite the hardware register
with a stale mask, desynchronizing the hardware and software states.

> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -2292,6 +2323,7 @@ static int qcom_pcie_probe(struct platform_device *=
pdev)
>  		bridge->sysdata =3D cfg;
>  		bridge->ops =3D (struct pci_ops *)&pci_qcom_ecam_ops.pci_ops;
>  		bridge->msi_domain =3D true;
> +		bridge->reset_root_port =3D qcom_pcie_fw_reset_root_port;
> =20
>  		ret =3D pci_host_probe(bridge);
>  		if (ret)

[Severity: Medium]
Does the error path for pci_host_probe() race with pm_runtime_disable()?

When pci_host_probe() fails, the code jumps to the err_pm_runtime_put
label:

err_pm_runtime_put:
    pm_runtime_put(dev);
    pm_runtime_disable(dev);

Since pm_runtime_put() is asynchronous, it queues idle/suspend work
that can be immediately canceled by the subsequent pm_runtime_disable()
before the device is powered down. This leaves the hardware active
and leaks power. Should this use pm_runtime_put_sync() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-pcie-contr=
oller-reset-v1-0-51779736cf12@oss.qualcomm.com?part=3D1
