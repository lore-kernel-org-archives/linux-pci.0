Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF3328B71
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181926; cv=none; b=poSRAAdER2MPSwTDOkW+C3xXVvxh+rNO6dCKvk0jq1L8vVXdw4FLROwQdDY1H/ORhLPwYuYmOdxuTLxdBPYhpz+U4mKvnZ3VT5fOvNX7m//bsNDG6n4rqxQm43lNgwDwvnyxQR+lONaLomYcSlAWzdKag5vtWH+5OtHY8bSPIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181926; c=relaxed/simple;
	bh=OOr7jymJjsR39CdsXJQfS3AIoH/kVqxM4l6GBr/dxPA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QvRBJnPPCA4NFVZLOuWw92dGtHitQh2m+UncqOY+pNtS1NfiFfFCIMvMxSmDYCY1pF7ipIputQkd4YUt0qqGT7bqYUlOMNH9kte44WwZysSX//6WPkqn4mlIJbzu0i9rDz+hjKzfvyMhpt47xf5jy3sDqj3bTvYkIEdomddpBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkR5b/TG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkR5b/TG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81323C2BCB3;
	Tue, 19 May 2026 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779181925;
	bh=OOr7jymJjsR39CdsXJQfS3AIoH/kVqxM4l6GBr/dxPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FkR5b/TGZt7cDVjw0LzomwzLsoLdu+OWKKav+ZTZ+UG+xT4IjQXS9l/+Yr+Iv3NzM
	 9NPYQtUpmFsr2/ufzgGsp34MtGgf0k2goPsW+Zka7JDGuYVPK2KrnF4TLq4zJDz2/w
	 0lAivy+zinxYUfgett2vqaAs+jBBIQnEq/vJ6rW0I8MrQYopPoHambF48XBW2XW9Bv
	 W+WLgKOWVvKTsqrI57VTzV7jZzsZ45Q4rYWvbQd5But8DCRKTyY7c26sZER5CdRe7J
	 uD/jnzUGtIIRCbQIaPsxENSJ0zjJ3O3Cf0RQ3cFk+zvkvrL6FunnqvzwC2NHFxxpwL
	 E6CBeYJdTJqRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] PCI: qcom: Indicate broken L1ss exit during
 resume from system suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260519-l1ss-fix-v2-3-b2c3a4bdeb15@oss.qualcomm.com>
References: <20260519-l1ss-fix-v2-3-b2c3a4bdeb15@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 09:12:04 +0000
Message-Id: <20260519091205.81323C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Initialization order bug: `broken_l1ss_resume` is set after child =
PCI devices have already been enumerated and probed.
- [High] Commit message directly contradicts the actual driver implementati=
on regarding PHY power state during suspend.
--

commit 3ebc1e1ccc09940f1b1046dd596cb5ba9e52cf1e
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI: qcom: Indicate broken L1ss exit during resume from system suspend

This commit sets the broken_l1ss_resume flag on the PCI host bridge for
Qualcomm platforms to signal to client drivers that the RC driver will
turn off the PHY during suspend. This aims to prevent fatal link down
conditions by avoiding L1ss during system suspend.

>     Qcom PCIe RCs can successfully exit from L1ss during OS runtime. Howe=
ver,
>     during system suspend, the Qcom PCIe RC driver may remove all resource
>     votes and turns off the PHY to maximize power savings.

Does the commit message accurately describe the driver's suspend behavior?

Looking at qcom_pcie_suspend_noirq(), the PHY is only turned off if no
devices are active:

drivers/pci/controller/dwc/pcie-qcom.c:qcom_pcie_suspend_noirq() {
	/*
	 * Turn OFF the resources only for controllers without active PCIe
	 * devices. For controllers with active devices, the resources are kept
	 * ON and the link is expected to be in L0/L1 (sub)states.
	...
	 */
	if (!dw_pcie_link_up(pcie->pci)) {
		qcom_pcie_host_deinit(&pcie->pci->pp);
		pcie->suspended =3D true;
	}
...
}

Because the resources are kept active when an endpoint device is attached, =
it
seems the stated condition for link down would not occur. Could the commit
message be clarified to match the implementation, or is there a missing
patch that changes this suspend behavior?

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index af6bf5cce65be..75bb6cb5e35e5 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1368,6 +1368,18 @@ static void qcom_pcie_host_post_init(struct dw_pci=
e_rp *pp)
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>  	struct qcom_pcie *pcie =3D to_qcom_pcie(pci);
> =20
> +	/*
> +	 * During system suspend, the Qcom RC driver may turn off the analog
> +	 * circuitry of PHY and remove controller votes to save power. If the
> +	 * link is in L1ss and the endpoint asserts CLKREQ# to exit L1ss, the
> +	 * time required to wake the system and restore the PHY/refclk will
> +	 * exceed the strict L1ss exit timing (L10_REFCLK_ON + T_COMMONMODE),
> +	 * resulting in Link Down (LDn) condition. Set this flag to indicate
> +	 * this limitation to client drivers so that they can avoid relying on
> +	 * L1ss during system suspend.
> +	 */
> +	pp->bridge->broken_l1ss_resume =3D true;
> +
>  	if (pcie->cfg->ops->host_post_init)
>  		pcie->cfg->ops->host_post_init(pcie);
>  }

Does this initialization order introduce a regression?

Since qcom_pcie_host_post_init() acts as the post_init callback for the
DesignWare host operations, it is called after pci_host_probe(bridge) in
dw_pcie_host_init():

drivers/pci/controller/dwc/pcie-designware-host.c:dw_pcie_host_init() {
    ...
	ret =3D pci_host_probe(bridge);
	if (ret)
		goto err_stop_link;

	if (pp->ops->post_init)
		pp->ops->post_init(pp);
    ...
}

Because pci_host_probe() handles device enumeration and triggers endpoint
drivers' probe() routines, any driver that checks the broken_l1ss_resume
flag during its probe sequence might read an uninitialized false value.

Would it be safer to set broken_l1ss_resume inside the init callback
instead, before enumeration begins?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-l1ss-fix-v=
2-0-b2c3a4bdeb15@oss.qualcomm.com?part=3D3
