Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC622EEE8C
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790534005; cv=none; b=mQBchEYiv+QPxV/+bYE6t6SpKgtAlNPD7kQA2/ORIjifN8mp29ITJzbLVcGrYVvf7Fo+ACdwMR3FAUoSVHAuPIw8GMle0IYB5MI5544OIXNp0wKn32QAsQ+YiD9eLjGlowOaHfDAjLKxnFzLkuZ02f3ocWet2E0hgXejJzM9Dbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790534005; c=relaxed/simple;
	bh=sGRiO3U4q4QMCIF6L/EgdkiK3dpYuG+EsLb0hXLAuSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vB4eyM9jLtSI+imjbvQYx5oQsXmjl3/Uro8SGNonGA9qmFp08fzJePrdKBlhozsT+o174AXfJZ2damnTeu/tRKZHcGdpsmFudIbFWl7LF9t0eLMcpYKtlG63lwNnRG4ysjxu+lezJcTjt33+uJekoWC7yYr55h+5RN7F0xM2OPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChKz6Ew6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChKz6Ew6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA57E1F000FF;
	Sun, 27 Sep 2026 18:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790534004;
	bh=iUhdbnSJmwmIWd98ZfCinAp5gQ5LMiC9YnO79azl1ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ChKz6Ew6KFQPr7RdbQWxMy99U6BpEeOySVC1gJJAHDtOOfXbbqKhwhPitMKRcaay9
	 Bygoe59Obou3fWit6GxdiLGCEhrlvM3B5AY9JBPAD+B5uyiRNoYqxiopFadOAx6cfl
	 9MQN6DskqhoOb/6Pj2cfBPlL47gXmTKuDeYkjl70cr5MKuQX5Y9ltcW0iXC4S1wf2b
	 8dQ1T5cqaUACRgZ3QmciLG4On2KdrhpzZWyLaPhA7120f/fmoYLz1zdLHP3MZZHOQU
	 AJEbO52htU1THsRO4iLBO+33LIRjmX979vH8FvudxgJH8gZ2xJOMrIhabNM8R3rcyf
	 cZdWKpJmPvKHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] PCI/AER: Enable baseline capability error reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <42a76bec58f9a844ef8d8405abafd6680b7f2ecc.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <42a76bec58f9a844ef8d8405abafd6680b7f2ecc.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:33:23 +0000
Message-Id: <20260927183323.DA57E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci/aer: uncorrectable errors dropped for non-AER devices due to D=
EVSTA clear
- [Medium] pci/aer: leaked mask/first_error state to non-AER devices
--

commit 29da5e077bdaa4990a1072f7b27ccf2bb9cae518
Author: Lukas Wunner <lukas@wunner.de>

    PCI/AER: Enable baseline capability error reporting
   =20
    This commit enables PCIe baseline capability error reporting for devices
    that do not support AER. It relies on the error enable/status bits in t=
he
    Device Control and Device Status registers. This completes the kernel's
    support for native error reporting.

Link: https://lore.kernel.org/r/20260826212619.GA1566339@bhelgaas/

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 6bc843ab9b37f..62376aab4b6f1 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
[ ... ]
> @@ -1182,8 +1183,11 @@ static bool is_error_source(struct pci_dev *dev, s=
truct aer_err_info *e_info)
>  	if (!(reg16 & PCI_EXP_AER_FLAGS))
>  		return false;
> =20
> -	if (!aer)
> -		return false;
> +	if (!aer) {
> +		pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
> +		return reg16 & BIT(e_info->severity) &&
> +		       !PCI_POSSIBLE_ERROR(reg16);
> +	}

[Severity: High]
When a Root Port receives both a correctable and an uncorrectable error,
aer_isr_one_error() processes the correctable error first.

During this, pci_aer_handle_error() ends by unconditionally calling
pcie_clear_device_status():

pci_aer_handle_error() {
    ...
        if (pdrv && pdrv->err_handler &&
            pdrv->err_handler->cor_error_detected)
            pdrv->err_handler->cor_error_detected(dev);
        pcie_clear_device_status(dev);
}

This clears all error bits in PCI_EXP_DEVSTA (CED, NFED, FED, and URD).

Because this new logic in is_error_source() relies entirely on the NFED or
FED bit in PCI_EXP_DEVSTA to locate uncorrectable errors on non-AER devices,
won't this cause pending uncorrectable errors to be silently dropped?

[ ... ]
> @@ -1455,6 +1459,7 @@ int aer_get_device_error_info(struct aer_err_info *=
info, int i)
>  {
>  	struct pci_dev *dev;
>  	int type, aer;
> +	u16 devsta;
> =20
>  	if (i >=3D AER_MAX_MULTI_ERR_DEVICES)
>  		return 0;
> @@ -1470,8 +1475,15 @@ int aer_get_device_error_info(struct aer_err_info =
*info, int i)
>  	info->is_cxl =3D pcie_is_cxl(dev);
> =20
>  	/* The device might not support AER */
> -	if (!aer)
> -		return 0;
> +	if (!aer) {
> +		if (info->severity !=3D AER_CORRECTABLE) {
> +			pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
> +			if (devsta & PCI_EXP_DEVSTA_URD &&
> +			    !PCI_POSSIBLE_ERROR(devsta))
> +				info->status =3D PCI_ERR_UNC_UNSUP;
> +		}
> +		return 1;
> +	}

[Severity: Medium]
When aer_process_err_devices() processes multiple devices in a loop, it uses
a shared 'info' structure. Since this early return for non-AER devices
doesn't reset info->mask or info->first_error, will it leak state from the
previously processed AER device?

This leaked mask could be used by pci_dev_aer_stats_incr() to filter errors,
potentially dropping statistics for valid errors if the leaked mask covers
the PCI_ERR_UNC_UNSUP bit.

Should info->mask and info->first_error be explicitly cleared here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790531238.gi=
t.lukas@wunner.de?part=3D7
