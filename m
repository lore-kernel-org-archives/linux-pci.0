Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6C3112AB
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778098335; cv=none; b=qs+VVcO2fW8D5NzjV/RON3IJxdi+27Au3HDEnn3AYARIKCaX+d7Ib0jbA+CDG85cFalPG+ra/i6ncpHW0dFRvfB43OO9x2TiK50MBUCk0JCPybYUIcUNOYPtDd9xtWfXL5ImdMr7bJ6mXtiSc2greplq2o/bsEFJ3FBVRrO20dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778098335; c=relaxed/simple;
	bh=OVg2qe5i5WNUg7yaLFymKEWzxUsomGj/L4ynTC1TGL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B4qvT/Eea+fSiE0vmNDVzsQr7HLXsKGyBB8dhJkvLxm6WuZ65qrxVLZ6cQTdKaoxkwX5H0vfdII0x+HllDwYjbcco91jwNyrra7Ag3+KpTTRdcGjivgmLx5Otf6rCa1+umncOuw/D9EpSr2RqWybe/15XpPdyem4CyO12qfhADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0arj79T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0arj79T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD746C2BCB0;
	Wed,  6 May 2026 20:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778098334;
	bh=OVg2qe5i5WNUg7yaLFymKEWzxUsomGj/L4ynTC1TGL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Q0arj79T37exMnv7U3zxqlhQjQQVFwm/k+6cZGt5pkVG8k6toT81MN2aQoUa2OoBK
	 QTXXpt4HtsGfiepCqrG6o9e0n6vW8U4kJQydGD3+8krjo/lS80jPQ9jFjNEMFvwMyb
	 z62DiuSxdM82v2A9GsSykNUqR3kkGH+ChUZlPK23FKYivtD5nD0wtDqeyd/40h6NCi
	 9dOI7KoAsk0ObjnzG1fRQbG1+wzOJ7SBJnFmLIdIVqKNX1iug9kADI8VZFN/qRtSoJ
	 QxTzR3DbXSNq/0i7LxmGZ5SyXs4Ykf/Ex8nyQVcv7j7L4XsRFm1jADlNoNg3QLXyRu
	 YYJofD+sMBx/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/6] Documentation/kernel-parameters: Add
 multi-device config_acs example
Reply-To: sashiko@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB439372F20062A8C25599FE43DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439372F20062A8C25599FE43DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 20:12:14 +0000
Message-Id: <20260506201214.BD746C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The documentation incorrectly advises using single quotes around=
 the `pci=3Dconfig_acs=3D...` parameter, which the kernel's command-line pa=
rser does not strip, potentially causing the parameter to be silently ignor=
ed.
--

commit e6c4062a908e58f90ebe300f02b6a7483906b994
Author: Wei Wang <wei.w.wang@hotmail.com>

Documentation/kernel-parameters: Add multi-device config_acs example

This commit adds an example to the kernel parameters documentation for
configuring ACS settings for multiple PCI devices. It also adds a note
recommending quoting the parameter to prevent bootloaders from misinterpret=
ing
the semicolon separator.

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
[ ... ]
>  				Note: this may remove isolation between devices
>  				and may put more devices in an IOMMU group.
> +				- 'pci=3Dconfig_acs=3D10x@0000:04:00.0;1x101@0000:84:00.0'

Will the kernel's command-line parser correctly handle single quotes here?

Looking at next_arg() in lib/cmdline.c, the kernel explicitly detects and
strips double quotes ("), but it treats single quotes (') as literal text
characters.

If a bootloader passes the quoted string verbatim to the kernel, the parame=
ter
will be extracted as 'pci rather than pci. This will fail the early_param()
check for "pci", causing the ACS configuration to be silently ignored.

Should the documentation recommend using double quotes instead?
(e.g., "- "pci=3Dconfig_acs=3D..."")

> +				configures two devices with different ACS settings.
> +				Note: Some bootloaders interpret ';' as a command
> +				separator. If so, quote the entire parameter to
> +				ensure it is passed to the kernel unchanged.
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB439385689A=
32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D2
