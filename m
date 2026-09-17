Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ECD4349B6
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630530; cv=none; b=PEFB9yUeImivMyqWJTLXmWWGALst2oHiyGOM720vs0YIWf6j8PyjTns1b8unJi0Xbry2xzFyQwSEuqajNJXEuKTmJENGUDba9HjTOACYGFwPmDQxleyp8eR4lgGmV07/XZtsuNb1lf/qKARx8OWX3aPNjR4lSbvcsbp9uS3FZOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630530; c=relaxed/simple;
	bh=pLY9m/RGw9EbWh+LxVYi1krwLsDiiTlVsMcWmN7H4og=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TtJ9evoUiAVmwlI3r+b1w7H51CX9uHOK2BJjoU5OKXDr/NQKBykyrxbbI3rHf8wCDt1mozbbqmLj12PwbaD+ji1eLxWEqTomr64JF1S5IDMl+zvgoAANKyWp4px1uD7pgY+v5vCN9QGs+/fac3vDc/GWcj6LJ69TVyLBTjTdm+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu55UpVJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu55UpVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47E61F000FF;
	Thu, 17 Sep 2026 07:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789630528;
	bh=3LZu37sJfXaaFwPVZjlwUkVgLn1XG9zeIVWMWkSj+9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zu55UpVJupYMnzxQ2JNf5ooRnQNkAWJ4AHAvztGWzYgmbmdjAkV2GqpHc7It3aOgp
	 4N0f71SH1kelLTieFuujQV7LnZwadWGArMREOL5McM2NL6tS73plVC32DykoNOOoVp
	 78v/FGBRCJjCXhGYNC/zfxxt9aSs7vALhXHcIK0qXPzWfH4kmliRvs8lJ0TMMJSlmb
	 wvyc6PaghXWAnUZ9iEgXwhHwUfETwBiB4CtwxgsRvH3e5/vNqFXb6y6zZyTgpIVZpl
	 0Plk5J77hwrtsg3lyk/d+IQZmdeSSzLLysHon3NHU6sWOSm5FupsQRxC7j6DRgHpKJ
	 QYGmsBY1/ap8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 1/2] PCI: Add device-specific reset for Qualcomm
 SDX62/SDX65 modems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260917071651.14174-2-jtornosm@redhat.com>
References: <20260917071651.14174-1-jtornosm@redhat.com>
 <20260917071651.14174-2-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 07:35:28 +0000
Message-Id: <20260917073528.A47E61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: reset_qualcomm_modem re-enables memory decoding with zeroed B=
ARs
--

commit 697e75cacc91e92df3d44b2fa95b07329f110e59
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add device-specific reset for Qualcomm SDX62/SDX65 modems

Qualcomm SDX62/SDX65 5G modems lack working reset methods for VFIO
passthrough. This commit adds a device-specific reset method for them using
MHI SoC reset via BAR0. The reset method writes to a hardware reset
register and waits for completion.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21fd..e72af7d2c7755 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c

[ ... ]

> +static int reset_qualcomm_modem(struct pci_dev *pdev, bool probe)
> +{
> +	void __iomem *bar;
> +	u16 cmd;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (pdev->current_state !=3D PCI_D0)
> +		return -EINVAL;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> +
> +	bar =3D pci_iomap(pdev, 0, 0);
> +	if (!bar) {
> +		pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +		return -ENODEV;
> +	}
> +
> +	iowrite32(MHI_SOC_RESET_REQ, bar + MHI_SOC_RESET_REQ_OFFSET);
> +	ioread32(bar + MHI_SOC_RESET_REQ_OFFSET);
> +
> +	/* Be sure device reset has been executed */
> +	msleep(2000);
> +
> +	pci_iounmap(pdev, bar);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);

[Severity: High]
Does this unsafely enable memory decoding on a hardware-reset device with
zeroed BARs?

If the caller did not explicitly clear PCI_COMMAND_MEMORY before the reset,
cmd will have PCI_COMMAND_MEMORY set.

The hardware reset zeroes the device's PCI configuration space, including a=
ll
BARs. Restoring cmd with PCI_COMMAND_MEMORY set will immediately enable mem=
ory
decoding while the BARs are still 0, potentially causing severe PCIe bus
conflicts, IOMMU faults, or kernel panics since the device will intercept
memory accesses to physical address 0.

Should we clear PCI_COMMAND_MEMORY before returning (e.g.,
cmd & ~PCI_COMMAND_MEMORY), relying on the caller's subsequent
pci_restore_state() to safely reprogram the BARs before memory decoding is
formally re-enabled?

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917071651.1417=
4-1-jtornosm@redhat.com?part=3D1
