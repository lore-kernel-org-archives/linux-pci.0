Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E6F379EF0
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275312; cv=none; b=Suelti4EmHEcrBLGwk5b7PjsAk+hSI8UI2HSjFaOs9aG8iGkZtzjPDSJW4e/Ii5RAFbrFX10Bz0z07KoQUTMhudn3WsVmT/ulImIML9i3ONrkbEfJHuTZgFbvHb6mV+w/2zXr/LYyoj3H2+gMGwcc00ZXWpcHSiIC7PJCL0lA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275312; c=relaxed/simple;
	bh=EBdTULwkW+XU6twMCd6t+6jkzSAwEtmsaGC7Ptk4CsA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cwoagliQWndd5EdjVUJLzvMRCREe7ylJS4qhS5h6/5TcQ2ebeqqvgxSNUGgUWy7X3O3GPzaiR46UEeiFHmFhnk1xn7BC/wnXGjMtRX5D2+iaSE/0052u2UnO+1JcbLKQQNmSE9ljdkAcNofr3nXlaErAjqMhMH6w9DUcrGD4Hes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwYI+eFO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwYI+eFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A9DC2BCB0;
	Fri,  8 May 2026 21:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778275312;
	bh=EBdTULwkW+XU6twMCd6t+6jkzSAwEtmsaGC7Ptk4CsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RwYI+eFOeI7sHlYwy6iThopkB8fdYzEyclWyQYSBJ9TkiSzmNDfbmOwP0FYU7R+Lp
	 MTEaaNxhQvDMfn4lPq8NxiNZHADxu0cx6gZgo68yRlo2+ytANqBpED1dmAl3eiStnB
	 RoB915+qXxNAg4x8Sto2ldZrD74qqNv120eaux6h7TsnoCIq7TgXbURp8wkdwW6e3e
	 pBiwccpyz6ZT9W1tn/5+rSaGTriwCWq4dFCZ8YEmoILdXrX4dZyEJXouHD7h06yIUw
	 iXV0rLP3BHslZQpzsKPhWdJEIYbB8XCJZvrJ+hwCmi2E5nlj6WBxFepY3EFYLoJM41
	 CqSvgp7YasgJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Force PM reset for Qualcomm devices with
 NoSoftRst+
Reply-To: sashiko@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508145153.717641-2-jtornosm@redhat.com>
References: <20260508145153.717641-2-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:21:51 +0000
Message-Id: <20260508212152.22A9DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The local variable `csr` is left uninitialized and later written t=
o the PCI Power Management Control register when the `PCI_DEV_FLAGS_FORCE_P=
M_RESET` flag is set.
--

commit 1f91cbd53469950e5e046d032ea4bd761ddec438
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Force PM reset for Qualcomm devices with NoSoftRst+

This commit adds a new PCI_DEV_FLAGS_FORCE_PM_RESET flag to bypass the
PCI_PM_CTRL_NO_SOFT_RESET check during PM reset, applying it as a quirk
to several Qualcomm devices. This allows devices without FLR that falsely
advertise NoSoftRst+ to be properly reset, which is necessary for VFIO
passthrough re-assignment.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..e0b32eccfcf42 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4460,9 +4464,11 @@ static int pci_pm_reset(struct pci_dev *dev, bool =
probe)
>  	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
>  		return -ENOTTY;
> =20
> -	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &csr);
> -	if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
> -		return -ENOTTY;
> +	if (!(dev->dev_flags & PCI_DEV_FLAGS_FORCE_PM_RESET)) {
> +		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &csr);
> +		if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
> +			return -ENOTTY;
> +	}
> =20
>  	if (probe)
>  		return 0;

If the PCI_DEV_FLAGS_FORCE_PM_RESET flag is set, does this leave the local
variable csr uninitialized?

Looking at the rest of pci_pm_reset():

drivers/pci/pci.c:pci_pm_reset() {
	...
	csr &=3D ~PCI_PM_CTRL_STATE_MASK;
	csr |=3D PCI_D3hot;
	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
	...
}

Writing uninitialized stack memory back to the PM Control/Status Register
could corrupt hardware state like PME Enable and Data Scale, or inadvertent=
ly
clear Write-1-to-Clear bits like PME Status.

Could this cause unpredictable device behavior or lockups?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508145153.7176=
41-2-jtornosm@redhat.com?part=3D1
