Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89E13A7F6B
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987928; cv=none; b=IGwv32ka5BugYblwaKxSmXqJxa7svck0gAB0CerRrx08egbZDGsXqqVK0zV7CTpUcGsRE6QiPwXz15pq0giDFpfsGL6X6X9KA5aXkreFT2xYVdTYrC9xwEpRRoc/WifMbaq3OxUyfx8XwXvdQeL82pgmQwcG7qTEb8Gy8cQFa3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987928; c=relaxed/simple;
	bh=CMRC8FgFhCAXlDqv71hkhmqISBpnZ+jUpHX522QDT2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I72fKy77F/gaPd7KDeXTFYQz2GdLmQIVKNNCXefdng//bf9YqPs9LEhboLMfeqQ13bjd5A2wA2GOR3ETYuVarbBOfmkl4QtXSDIWq+C4kkt/aHJlAutRsoXVmeYZPEH2QWoIzj5wFGrgAveVHSy5hDdbYDjA86hkYkOxItwZr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itmVbmAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itmVbmAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF5C1F000E9;
	Thu,  2 Jul 2026 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782987927;
	bh=p4SRDHFnfmlAdjjp+NlCKKTCyYcb/r7C38eTNZ4Z14Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=itmVbmAg0Vb6ajE8xFg3FsoCHaiMH41L6Ekxu50WPnnY0at6NkQTQDg2S+iuvC4Xx
	 j2WLxJP5C8E0o3kC7F9mqROwL1+rFIGQSORh3D4Wq9mgE7HcBx1iUVm2ItL+wXneKd
	 yFaKo9EiDCyrX3QYVsN0xd4goGpF0Se6sunfTVrNY02z9HvuXVm75YRSjBkzQEcOzz
	 9+MehpnaaTrKSLxtmP6qTlG5uYCJbq49ZSwZ/RKGpfqpwZ/nZTptfyooWVfPg7hKdw
	 xkgUeKwZWcB8ejlIE141ABHxPM1twkd3JFv7JHsBBpN63xOYXuOtzXdwUSl4xzHEtE
	 SJ3CFe8SHSxXw==
From: sashiko-bot@kernel.org
Subject: Re: [tip: x86/msr] x86/pci: Stop using 32-bit MSR interfaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <178298736191.3843924.4213710231240809260.tip-bot2@tip-bot2>
References: <20260629060526.3638272-12-jgross@suse.com>
 <178298736191.3843924.4213710231240809260.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:25:26 +0000
Message-Id: <20260702102527.2EF5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calculation of the segment address overflows when the number of bu=
s bits causes `i` to reach 8 or more.
--

commit 67dc02af5b380e39ab1fd3fd3aa7e4552b01de23
Author: Juergen Gross <jgross@suse.com>
Subject: x86/pci: Stop using 32-bit MSR interfaces

This commit replaces the 32-bit rdmsr_safe() MSR interface with the 64-bit
variant rdmsrq_safe() in the AMD Family 10h PCI MMConfig initialization
code. This simplifies the logic by directly fetching the 64-bit MSR value.

Link: https://patch.msgid.link/20260629060526.3638272-12-jgross@suse.com

> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-share=
d.c
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c

[ ... ]

> @@ -198,13 +198,9 @@ static const char *__init pci_mmcfg_amd_fam10h(void)
>  		return NULL;
> =20
>  	address =3D MSR_FAM10H_MMIO_CONF_BASE;
> -	if (rdmsr_safe(address, &low, &high))
> +	if (rdmsrq_safe(address, &msr))
>  		return NULL;
> =20
> -	msr =3D high;
> -	msr <<=3D 32;
> -	msr |=3D low;
> -
>  	/* ECAM is not enabled */
>  	if (!(msr & FAM10H_MMIO_CONF_ENABLE))
>  		return NULL;

[ ... ]

> 	end_bus =3D (1 << busnbits) - 1;
> 	for (i =3D 0; i < (1 << segnbits); i++)
> 		if (pci_mmconfig_add(i, 0, end_bus,
> 				     base + (1<<28) * i) =3D=3D NULL) {

[Severity: High]
This isn't a bug introduced by this patch, but does this calculation overfl=
ow
when i reaches 8 or more in pci_mmcfg_amd_fam10h()?

The expression (1<<28) * i uses 32-bit signed arithmetic. When i >=3D 8, the
result reaches 2147483648, which exceeds INT_MAX and overflows to -21474836=
48.

Because base is a 64-bit value, this negative number will be sign-extended
and subtracted from the base instead of added to it.

If busnbits from the MSR is 12 or greater, segnbits will be 4 or more,
allowing the loop variable i to reach 8 and trigger this overflow.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178298736191.384392=
4.4213710231240809260.tip-bot2@tip-bot2?part=3D1
