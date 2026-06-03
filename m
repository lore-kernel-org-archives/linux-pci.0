Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1936C37B032
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513058; cv=none; b=qEUALrVJOXDpIoWwqQmzERtc4qygWXtUzekrNYwQ7scCH0BR+THiqcabcg+v6sWl2pD7ziwqNChClpkRkrVCJixqdgAGoPrekWFACCqE0dy7b8ISWd9bqaTjLjaK4gAqKLcuiNfbpVFKufq2bKbUCzqzeQ7oxnX8vHCuZrxHVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513058; c=relaxed/simple;
	bh=pQz0E4Qc4xzf4zEZ5sPKARkF9z1aQY3BVTzIZik1yUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RTGfwSqn6SrpK2vahU/bEsinA/RvEy5rwAR00dqaSOu3F80wsPFEyXCwSI/85gur/XwykR6uJxOf5WZkqGviuuOHiDjKZIYNJXQT10z+8Adv+pWe0nOIX08bAXr2A9aKb9l3kBzyGbHH06R/4Ei1KiKdeIsJjVF+Zx9Rq/sFB+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBgEuva0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBgEuva0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8345C1F00893;
	Wed,  3 Jun 2026 18:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780513056;
	bh=6fXDeLFX3GDITAYiI8KbIz+K8tVYY/oMn+qRV0lAxbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hBgEuva0OhaesxSmOL63ft6PStaJrZKY8RxapyQVxhrwUSFN6mTziSLLBOOrNymvy
	 Bu87TCDaoDDmYRhGMmJCIbIgWDwRxaFefor8pQqHyApaFtjID6YhI7CvjtejP075tR
	 Mg8jG3Mp3hqvELfBLcA6NfcL0qPAEYMTdlSnL5Y0m8U9cFuyIb6pCkWWRO3wNFKtlF
	 CTOXQyq7zUjReUnkO1JLyF1MlkgbQr31GLn+EwkRIEt2ldvYvcmQV8qMaDSIe5wJcC
	 2ifcdGq2Jjxfk39gAAGkk2UmfeT6U4OHym/IpPHtQ0otAV6jvj+yjqT3BZaJN23dl/
	 1CB7nxhSl8PDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 3/3] PCI: Fail FLR when config space is inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260603181647.2215-4-alifm@linux.ibm.com>
References: <20260603181647.2215-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 18:57:36 +0000
Message-Id: <20260603185736.8345C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The config space accessibility check is placed in pcie_reset_flr()=
 instead of pcie_flr(), leaving direct callers of pcie_flr() exposed to 60-=
second hangs.
- [High] The PCI reset quirk delay_250ms_after_flr ignores the return value=
 of pcie_reset_flr(), which masks reset failures and completely breaks the =
PCI reset fallback mechanism.
--

commit 4e372ed957b10d82d85382f347de3e515a680bbf
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Fail FLR when config space is inaccessible

This commit adds an accessibility check for the PCI configuration space bef=
ore
attempting an FLR (Function Level Reset). This is intended to avoid potenti=
al
hangs on devices that are in an error state.

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

[Severity: High]
This isn't a bug introduced by this patch, but does placing this check in
pcie_reset_flr() leave direct callers of pcie_flr() exposed to 60-second
hangs?

Direct callers of pcie_flr() (like network and storage drivers during error
recovery) bypass this wrapper. They will still experience a stall in
pci_dev_wait() when attempting to reset a device with an inaccessible config
space. Should this accessibility check be moved into pcie_flr() instead to
protect all callers?

[Severity: High]
This is a pre-existing issue, but does adding this new dynamic failure path
break the fallback reset mechanism in delay_250ms_after_flr()?

Looking at delay_250ms_after_flr() in drivers/pci/quirks.c, it executes
pcie_reset_flr() but discards its return value:

drivers/pci/quirks.c:delay_250ms_after_flr() {
    ...
    pcie_reset_flr(dev, PCI_RESET_DO_RESET);

    msleep(250);

    return 0;
}

With this patch returning -ENOTTY when the config space is inaccessible,
the quirk will falsely report success. This causes
__pci_reset_function_locked() to abort early and completely prevents it from
attempting fallback reset methods, leaving the device in an unrecoverable
state.

>  	if (probe)
>  		return 0;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603181647.2215=
-1-alifm@linux.ibm.com?part=3D3
