Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791765;
	b=o5ULSO37XYbhx8JvCH70w4kizSJYq19fiNpIfvndFlHcYgK51qp+t3LvDITi7noiusz9
	 UvvqfIhaAqHdl0i47H6QBuQXPMeiv3nvu7gcS4MVSEGsXIXVykWTiZnYQ9NTjitkwOyAX
	 0EixYwoVeBn80hA5cPOyJfPH50D+o/SA1MgH0Sz2+DKOmOsd2Gq8O9qJVTJZ4z2VS+spG
	 3xlihrzhDh10TW63vSMuYdnNxx66FvHsBrYn1/8w4WWd1xAkD1xMoO1wV0yGdhkUT5cMO
	 EcdfOPDIJ4grmlszvfdgRZgTpYu2QbHyh1/ywC3E0sKDZWExKBpEyaj5aKz0Fi1Xh2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791765;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YE+SH2c6y+f/zRzQL3497ygAKwbNPfCh55oU5678X3M=;
	b=k3+bNzuur9vKI7pvU+olT555LuQ9SGd5EjQOUraEq7MFWDq51u0xWHYe+H0S0g3B+kmD
	 u0JC01iE/JETlWXeOyOppjorIwfUBL+ex0NC7hoTFnDpj6uC97AnRfumibB04K/1ggluI
	 ryO4KQyUkoGzkajG25modh3RVxTet1bqKbN1dkTKHFPlXF5t8K1H62KoHWA49/IPlXMoW
	 EVjHKPhvKeFVR9VjiPIxJ3pgpYYjBiVLUlCiUtm04cij9CgIlPZU0yuXoef4NmD/qrsk9
	 W6CQYjgQkYhXJj5WyApvyEcaqaK/0v2WB+Us0Pnd3iKzN+8TcSpb2EHTarBBgeaLnLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNbEjGGu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFA7606A31E
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNbEjGGu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55421F0089B;
	Fri, 27 Nov 2026 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791764;
	bh=YE+SH2c6y+f/zRzQL3497ygAKwbNPfCh55oU5678X3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dNbEjGGuQ11SY7BOlFXK0OZGkCpUWYK8F6OQwLAEq9nWHY3FhQSRu/zhMJpw1URxy
	 vgoTOhXTWZ5Yfc3cBYSIs/SKcRKKrDmvFzRM/SQGnd6LEnTdDOnDNoWvKI+pDHdxAh
	 3ZRe08t9plNFryTb9SgHxsJUMfyyDRfPwnwcBqSgwDXzNsb2AKzCym3xTLS9GiZXS5
	 CAsRgES+LDPBoPunpi0hWWI1NMu7XIBIbhqoDw/qa94bAeREzx/lyXwoAu31ubYINP
	 5pLfyxgAbyUtCiMaU4H7g6rPrMfUy/Ors6XvprQhjOuMPWKMYQbPm//40j01JmQ7sT
	 eETBMc3b4Q1Sg==
Message-ID: <sashiko-outbox-237665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: qcom: Implement .reset_root_port() for
 firmware-managed controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mrinmay Sarkar" <mrinmay.sarkar@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261127-pcie-controller-reset-v2-1-17467b64f5f5@oss.qualcomm.com>
References: <20261127-pcie-controller-reset-v2-0-17467b64f5f5@oss.qualcomm.com>
 <20261127-pcie-controller-reset-v2-1-17467b64f5f5@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:02:44 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] PCI: qcom: unpowered MMIO access in
  qcom_pcie_fw_reset_root_port()
- [High] PCI: qcom: concurrent unpowered MMIO in
  qcom_pcie_fw_reset_root_port()
--

commit d192484df4b90b14ad3c75da5b46d87d0d0f79dc
Author: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>

PCI: qcom: Implement .reset_root_port() for firmware-managed controllers

This commit implements the .reset_root_port() callback for firmware-managed
Qualcomm PCIe controllers by force-suspending and force-resuming the
controller via runtime PM and reinitializing DWC MSI registers.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index d903f10211c23..fe86b8fbc8950 100644
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
> +	if (ret) {
> +		dev_err(dev, "Failed to force runtime suspend for reset: %d\n", ret);
> +		return ret;
> +	}

[Severity: High]
Can pm_runtime_force_suspend(dev) allow concurrent callers to access ECAM
registers while the controller power domain is off?

When active child devices are present (dev->power.child_count > 0),
pm_runtime_need_not_resume(dev) is false, so pm_runtime_force_suspend(dev)
disables runtime PM and powers off the domain while leaving
dev->power.runtime_status and dev->power.last_status set to RPM_ACTIVE:

drivers/base/power/runtime.c:pm_runtime_force_suspend() {
    ...
	if (pm_runtime_need_not_resume(dev))
		pm_runtime_set_suspended(dev);
	else
		dev->power.needs_force_resume =3D true;
    ...
}

Because rpm_resume() returns 1 immediately when disable_depth > 0 and both
status fields are RPM_ACTIVE, a concurrent config-space access happens while
the controller is powered down:

CPU0                                  CPU1
qcom_pcie_fw_reset_root_port()
  pm_runtime_force_suspend(dev)
    pm_runtime_disable(dev)
    callback(dev) [powers off domain]
                                      current_link_speed_show()
                                        pci_config_pm_runtime_get()
                                          pm_runtime_get_sync()
                                            rpm_resume() -> returns 1
                                        pci_read_config_word()
                                          <-- unpowered ECAM read (SError)
  pm_runtime_force_resume(dev)

> +
> +	ret =3D pm_runtime_force_resume(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to force runtime resume after reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dw_pcie_msi_init(pp);
> +
> +	return 0;
> +}

[Severity: High]
Can pm_runtime_force_resume(dev) skip resuming the controller and leave it
powered off when dw_pcie_msi_init(pp) accesses DBI registers?

pm_runtime_force_suspend() and pm_runtime_force_resume() are system sleep
helpers that assume device_prepare() has taken an extra runtime PM referenc=
e.
At runtime, dev->power.usage_count is 1 (from qcom_pcie_probe()).  If the
Root Port is runtime-suspended so dev->power.child_count is 0 (for example,
during a bus reset or recovery when no downstream devices are active),
pm_runtime_need_not_resume(dev) returns true:

drivers/base/power/runtime.c:pm_runtime_need_not_resume() {
	return atomic_read(&dev->power.usage_count) <=3D 1 &&
		(atomic_read(&dev->power.child_count) =3D=3D 0 ||
		 dev->power.ignore_children);
}

pm_runtime_force_suspend(dev) then sets the status to RPM_SUSPENDED without
setting dev->power.needs_force_resume.  When pm_runtime_force_resume(dev)
runs next, it sees !dev->power.needs_force_resume and
pm_runtime_status_suspended(dev), skips the resume callback, and returns 0
with the power domain still off.  dw_pcie_msi_init(pp) and the subsequent
config-space restore in pcibios_reset_secondary_bus() then write to unpower=
ed
DBI and ECAM registers, causing a synchronous external abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-pcie-contr=
oller-reset-v2-0-17467b64f5f5@oss.qualcomm.com?part=3D1
