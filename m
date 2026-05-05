Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04394963CC
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018285; cv=none; b=o088gMY2fCZMDCpifGjKV/L08d7i05s67/Go5J7FbXvSN2DidLuDlTWeBRIYHT+bNtGh6YjS3OfnK5G0wEhdNmF27f7SNqDI2vRuAktUR3EGrRushkdvZZzLD9D3//lSsH+E4yXMgMu9jVss6A2mkt+MTjOSzcGakZEc4koI0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018285; c=relaxed/simple;
	bh=4TbN6/46IjYUSeFQCMrTKuAoDdetfYCwCEBGALYwES4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BjAk5kblJMd9UF9E/Leu6BOkc4BQPmNIezzS75XI+ZqzaEs6OH/Qp2V1/8cFjIyeF5MqVwuLxv27/ju+goiJsjFQYD4ehXeDbczD43DwMN7fUBWanGb7IHWDKCmLY5ZWiYFUt4eB1KqgP0+dUBLvVct+K7Tl0pTKKCTyjKPYxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct/obpcP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct/obpcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549C3C2BCB4;
	Tue,  5 May 2026 21:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778018285;
	bh=4TbN6/46IjYUSeFQCMrTKuAoDdetfYCwCEBGALYwES4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ct/obpcP/lDilEgI5DkQaNCUCJgSDIQRHGOJH7pGQAiUVCgFD4uF5aA52SbCTeZYu
	 94uF0SZNNlrH8gxA4M62CHIT+Yih/h4J3p6fbjF+ivKYTFc4WPdFVRPX59ZCmn6VTt
	 2CAyhazW80+Q/PzKqovzQq71D6xtl3qKTDqGNUCR/8U/R7Eh3pSC9S4ekyeFSOuYPj
	 YS/reRBfxFSm8/qeP1yIYj+qfin3tgdFpUXfhbMZOfiaZnCuKP1KcDzroffzRaV0mz
	 AlwY7zIbp34x98//KPYqHRBG/kbeaMZameh597+mSR2dVIETqZ3c+kuUUCWp6Vn1w0
	 EBWSbLWtfl6iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 2/7] PCI: Avoid saving config space state if
 inaccessible
Reply-To: sashiko@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505200510.2954-3-alifm@linux.ibm.com>
References: <20260505200510.2954-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 21:58:04 +0000
Message-Id: <20260505215805.549C3C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Early return when config space is inaccessible skips device DMA =
disablement.
- [Low] The 'msg' parameter in pci_dev_config_accessible() lacks a 'const' =
qualifier.
--

commit 18b574199dc0470f2784ade2f4883a656c60245e
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Avoid saving config space state if inaccessible

The commit updates the reset process to check if a device's config space
is accessible before attempting to save its state. This prevents saving
invalid values if the device is in an error state like DPC.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d0c9f0166af5c..e71b814153921 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -722,6 +722,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u=
16 vendor, u16 dvsec)
>  }
>  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> =20
> +static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)

This isn't a bug, but should the msg parameter be declared as a const
char pointer?

The function is later called with the string literal "save state".

[ ... ]

> @@ -5027,6 +5048,9 @@ static void pci_dev_save_and_disable(struct pci_dev=
 *dev)
>  	 */
>  	pci_set_power_state(dev, PCI_D0);
> =20
> +	if (!pci_dev_config_accessible(dev, "save state"))
> +		return;
> +
>  	pci_save_state(dev);
>  	/*
>  	 * Disable the device by clearing the Command register, except for
>  	 * INTx-disable which is set.  This not only disables MMIO and I/O port
>  	 * BARs, but also prevents the device from being Bus Master, preventing
>  	 * DMA from the device including MSI/MSI-X interrupts.  For PCI 2.3
>  	 * compliant devices, INTx-disable prevents legacy interrupts.
>  	 */
>  	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);

Does returning early here skip disabling the device DMA engine?

If the configuration space read fails due to a transient error like a
completion timeout instead of the link being fully down, the device might
still be active.

Skipping the write to PCI_COMMAND leaves Bus Master enabled, which could
allow the device to continue performing DMA or raising interrupts during the
reset process.

Could the code conditionally skip pci_save_state() but still attempt the
write to PCI_COMMAND to ensure a best-effort disablement?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505200510.2954=
-1-alifm@linux.ibm.com?part=3D2
