Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1100131716D
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778019619; cv=none; b=MLsxMzY9ZLcx2oXxAQBoywz2z12G+MAO2IurcefND6fA7JeUXEF2RuKlHIQ5mFRVXxcNDImvbyvibs3hpO+s0nYZiw/T0OEJjc7lAdv8DuNmQUt6nGPBS1Jq/bMN0BNGpFljq35bSlqTw+klWyHZAMEZvbbwBgR6pK1udG/Pavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778019619; c=relaxed/simple;
	bh=aPMcybPhX6e+NurQaHVI/qlRUWpWRGi6ehPsEe+2Kks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=elI+UpeDVUuyw0GLLajxw7imRW9Sw2Rgb7fnu+NE37ooH/t9SNwPNOQ27MVpA2/kj9/8tgcecOnSd/A9Yma/VQRUI7DZ3+pkyI6M9AhgFXwwCbQGT6+8BHQFUToWa++pktxM7C9CWJjWERu2MNT7qx7MNHJuZCIYiJK6+lx/wEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxfVAnv4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxfVAnv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAC9C2BCB4;
	Tue,  5 May 2026 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778019618;
	bh=aPMcybPhX6e+NurQaHVI/qlRUWpWRGi6ehPsEe+2Kks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nxfVAnv449sKRPSYU/aCLSmAh5cNp9ZnLMMi4LyeTjySKOJUM/ZIiAV5eT8faAY+O
	 4QFdCr8maxjRkFEST1GyRK3lWFy6zpVkkg5IkvFs6rFzVSScxchx5AjmUkC9DjJqFM
	 neTAYXhlsFQNpWimFnTF6wRUs8b7ii8Kl/ICeHmp9LHqCXUgyL1nsZH3R6xQ6AMZ9d
	 Yg7y93pEtFF2X2tHVUIp7t0ZMETHqsaw0sVPU+N7uPFZdurO6irKf7NkLwWbfxgUiQ
	 DSLDVHciIKjY8tf5aoV7ulbRMx/PXfp28c3VcA5HN5hLhlzdKJFZ/UtmBWr/Nei9EX
	 Mj+NDUCOtfXeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 3/7] PCI: Fail FLR when config space is inaccessible
Reply-To: sashiko@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505200510.2954-4-alifm@linux.ibm.com>
References: <20260505200510.2954-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 22:20:18 +0000
Message-Id: <20260505222018.9CAC9C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Logic flaw: pci_dev_config_accessible() executed before the probe =
check can permanently disable the FLR capability.
--

commit dc74511c4dd4719d1b362bacdaab4c551ada9e66
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Fail FLR when config space is inaccessible

This commit adds a check to validate if a device's config space is accessib=
le
before attempting an FLR reset. This is intended to fail the FLR early when
the device is in an error state.

> If a device is in an error state, then it's config space may not be
> accssible.

This isn't a bug, but there are a couple of typos here ("it's" instead of
"its", and "accssible" instead of "accessible").

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e71b814153921..c50418f5e3181 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4396,6 +4396,9 @@ int pcie_reset_flr(struct pci_dev *dev, bool probe)
>  	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
>  		return -ENOTTY;
> =20
> +	if (!pci_dev_config_accessible(dev, "FLR"))
> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;

Could this placement cause the FLR capability to be permanently disabled if
the device is temporarily inaccessible during discovery?

pcie_reset_flr() is called with probe =3D=3D true during device initializat=
ion
to discover if the hardware inherently supports FLR. By placing the live
config space check before the probe check, the system will actively read the
PCI_COMMAND register during capability discovery.

If the device happens to be temporarily inaccessible during this probe phas=
e,
it will return -ENOTTY and FLR will be permanently omitted from the device's
reset_methods array.

Would it make sense to move the pci_dev_config_accessible() check after the
if (probe) block so we only check accessibility when actually performing the
reset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505200510.2954=
-1-alifm@linux.ibm.com?part=3D3
