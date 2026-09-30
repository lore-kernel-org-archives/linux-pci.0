Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C224E3EF6
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780800; cv=none; b=TehyQyUC1Wio9mI1OMS9HAOTewskfRqFQFHPn+/m4Jd4T42wLg7aNuHsqG9ddN21+qfqTMrYpBl2VgeS8C+O6U5mp2xQBUHHvTUiUEBp7M4HP0hwTFo2KquWMnViRiGvJKmKIk83dADzFNJisP40xFC1hs/o+tthgyGx7dIzC2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780800; c=relaxed/simple;
	bh=7DWwSI2Mnq6pUtg9d20CGQwz1+F/VnzQdyBdQOzOTGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kWY/GMlMsYyw2jS338z5QeSwvq7lEL0fhM0ybRXvBTDarH+hGT6zPCWEpQmiJbZU/H34mf2uX39BuIPfJpItfO99XyC3WFx1eoa8yPraTFcPnGg4yw7Ym2RrMy3SqWd52SxaGT0FNOUb+hMb1MTCbGJDpqegdX+TaG/V596dcA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpgQaWJq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpgQaWJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35FA1F00893;
	Wed, 30 Sep 2026 15:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780788;
	bh=iHo9TwPPP7GD5eX0C2msl8K4Ss64RPFXGJEGALVj/Qo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FpgQaWJqKZ9KpBo+A1CnsEInES/ev+rAsQj5J6H8QpBqTcwXVZGH5wtjHwGx12qHQ
	 Bj/PQV1ZckeBwwX/+i3OK1KHj9P3L1s/8FyNECEzwK/Jr4925P876W/Wv0geDsIZiE
	 qPvG6BeYkQv/ZUxtaThJwRWeX2EJeidwjk3YAmCzlA5H840DpBmHYE8VYC8qs8ynRE
	 pZM5twlYkD+py0hhyUkPDaUp/jkBnHDzbtTrNJ7tmpg4fDLrgTmOruEb5YlutSvaqi
	 Jkk2u5xf3VC9AAbxfrrRFtjmSqrspJUvDRAG6V0bQSjWOLmrlEIKbWOCw/tHm03NC+
	 eBTRh9L8oZUGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI/ASPM: Clear ASPM Control on links without
 common ASPM support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Roese" <stefan.roese@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930144650.3701516-3-stefan.roese@mailbox.org>
References: <20260930144650.3701516-1-stefan.roese@mailbox.org>
 <20260930144650.3701516-3-stefan.roese@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:06:28 +0000
Message-Id: <20260930150628.A35FA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci/aspm: cached saved state not updated after clearing ASPMC
--

commit d667f086616b3d0999815c8db89e04e4d40aea30
Author: Stefan Roese <stefan.roese@mailbox.org>

PCI/ASPM: Clear ASPM Control on links without common ASPM support

This commit ensures ASPM Control is cleared for all functions on a link that
lacks common ASPM support, processing downstream components first. This
prevents devices that enable ASPM by default from keeping it enabled when
connected to a port that does not support it.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index f8e64971c6c3d..13d7a6d3f6ad3 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c

[ ... ]

> @@ -947,11 +959,17 @@ static void pcie_aspm_cap_init(struct pcie_link_sta=
te *link, int blacklist)
> =20
>  	/*
>  	 * If ASPM not supported, don't mess with the clocks and link,
> -	 * bail out now.
> +	 * bail out now. A device may still come out of reset with ASPM
> +	 * Control set, which the rest of this code never touches for
> +	 * such a link. Clear it, downstream component first.
>  	 */
>  	if (!(parent->aspm_l0s_support && child->aspm_l0s_support) &&
> -	    !(parent->aspm_l1_support && child->aspm_l1_support))
> +	    !(parent->aspm_l1_support && child->aspm_l1_support)) {
> +		list_for_each_entry(fn, &linkbus->devices, bus_list)
> +			pcie_aspm_clear_aspmc(fn);
> +		pcie_aspm_clear_aspmc(parent);

[Severity: High]
Does this bypass updating the parent's cached saved state?

By clearing the ASPM Control in hardware but returning immediately without
updating the cache (e.g., via pci_update_aspm_saved_state()), it appears the
parent bridge's saved_config_space will retain the stale ASPMC enabled valu=
e.

If a non-ASPM-capable device is hot-added, and the system undergoes an AER =
or
DPC reset before any power management event forces a state save, could
pci_restore_state() use this stale cache to erroneously re-enable ASPM on t=
he
parent port?

This might lead to completion timeouts or link hangs.

>  		return;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930144650.3701=
516-1-stefan.roese@mailbox.org?part=3D2
