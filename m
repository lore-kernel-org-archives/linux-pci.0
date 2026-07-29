Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620C21D3F5
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 05:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301670; cv=none; b=De8sfVp46mLA0FG4ucpUnLkkMndaIuP8fAVJMEa6y+c2pC89XBvywE/mE7GAHyBiJXqGuc0nirdfn5R4WsJrw7WGcZH7qxnN7A7BxudXrb8rq5rXwOXhxM3nPLXRgo9CJhKB68LCvmZiUWl5V68VgL4mX0Orc925AReAaCHdaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301670; c=relaxed/simple;
	bh=6hRsQnd/YtnX7CEDreacFh59Ss5SH7KF8LxiUlFLHys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KaZBPRpXJwAzCCnbZehPrtNLl+4q8pz3drD/Y2Dk5KJBrg++qL96/2pk6XYYjm6UBjlRYu56PvAJN0aKNnjR9en037trVcbak0LtADWzh7/MFCPgGYW7G8gurHsrbPq23P9f66PRp3mNZnmqyZJOf/nXJ/eVUW6kXdxbCCunLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfUIsumN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfUIsumN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE2E1F000E9;
	Wed, 29 Jul 2026 05:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785301669;
	bh=5EoKZ7Rbhy4eZomVSjAXBwiZHfBeSN6f32f9liHYE4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MfUIsumN22nywDWHnZVw0Fzr0WwLSdrJ421RDX7gOLCwOKVNgc0f38ZDL6odn7i+n
	 nJyuWcHI3q6unCp077tSRLKmWha57tjTYk+T8K0InJjQK/58AsgWKPNsugo2yZtVYi
	 BF2UcO/ft+208u3dPBJi2fKL6eCIAkbxz5iiydzLiAr3BQaMEbtYs7S0Svwt6oRjEG
	 Xap/sggiOX9bEmzOPfpsUNXJyfltEtWakJnrSf46odiVkR0AaByEmcEgFnAIm0uIfi
	 htb4l4rtV1zvZyeiet31kVb2KQfVouCAlJ5LZQaUbXaFFIUNhPWJVC+V3+BGK7USUx
	 2+D8vAdFFmV2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/5] PCI/ERR: Add support for resetting the Root
 Ports in a platform specific way
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729-pci-port-reset-v9-2-53570b92064d@oss.qualcomm.com>
References: <20260729-pci-port-reset-v9-0-53570b92064d@oss.qualcomm.com>
 <20260729-pci-port-reset-v9-2-53570b92064d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 05:07:48 +0000
Message-Id: <20260729050748.DCE2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The Root Port configuration space is restored without being saved =
before the platform-specific reset, leading to permanent loss of runtime co=
nfiguration changes.
--

--- Patch [2]: [PATCH v9 2/5] PCI/ERR: Add support for resetting the Root P=
orts in a platform specific way ---
commit 2b1b6bf7dae47cb5b5ce9a84251ceb7b5b08de2c
Author: Manivannan Sadhasivam <mani@kernel.org>
PCI/ERR: Add support for resetting the Root Ports in a platform specific way

This commit introduces a reset_root_port callback in struct pci_host_bridge
to allow platform-specific root port resets during error recovery. It
modifies pcibios_reset_secondary_bus() to invoke this callback if available.
The commit message states that it will save the Root Port config space befo=
re
the reset and restore it afterwards.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee615..12e099489690b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4841,6 +4841,19 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
> =20
>  void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>  {
> +	struct pci_host_bridge *host =3D pci_find_host_bridge(dev->bus);
> +	int ret;
> +
> +	if (pci_is_root_bus(dev->bus) && host->reset_root_port) {
> +		ret =3D host->reset_root_port(host, dev);
> +		if (ret)
> +			pci_err(dev, "Failed to reset Root Port: %d\n", ret);
> +		else
> +			pci_restore_state(dev);

[Severity: High]
The commit message states "save the Root Port config space before reset and
restore it afterwards". However, is a call to pci_save_state(dev) missing
before the call to host->reset_root_port()?

Calling pci_restore_state(dev) here without a preceding save operation could
restore a stale configuration saved at boot or during the last suspend. Can
this lead to the permanent loss of runtime configuration changes on the Root
Port, such as ASPM link states, dynamic AER masks, or Max Payload Size
adjustments?

> +
> +		return;
> +	}
> +
>  	pci_reset_secondary_bus(dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-pci-port-r=
eset-v9-0-53570b92064d@oss.qualcomm.com?part=3D2
