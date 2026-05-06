Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D063101C0
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778103140; cv=none; b=CAPn8h2D1Oq86ogHtJNWRCH2PEbDy1dEC/ncc71LZ3jrqnrdq7kuXzUa4lW/cMZAcRcdD3dpIpYPN336mlxbp0gYOn6kA9+JS7b7ka24e3sI3IOIdC7z5op1XVSIwedQGhonqoqplripPARaI/+qf/YS/AO2M59MRpf/gVmYpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778103140; c=relaxed/simple;
	bh=tCNuHOBdG0s8NVD5zV1d6ABZ4SgVDaHWVKez+LI9VKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ij0HP++T266I0ONNdVW8CwWm7Y4ZAYbs4vVZ7K48aIfXbpU0UcHktF5cEQ8HXe4a/qnnldzcZao1P0Job/Xvw05ErHMh2XpW3XkVxXloXF34FBlXm6Qj93HB4j2DEpJ615wfEZBZKAv3thuMdlUszplL8S7Lssfqe2GdWEG5eRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sC5GBgb7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sC5GBgb7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7C6C2BCB0;
	Wed,  6 May 2026 21:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778103140;
	bh=tCNuHOBdG0s8NVD5zV1d6ABZ4SgVDaHWVKez+LI9VKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sC5GBgb7CW1yEgDErjbKeTO1Z3pCDc94ovXKc4wFUK8nqWDNVX5V/ASvMSLk9J1Km
	 FE27pBifqgMgmnfWcvqkNh9ZqH8k4twM8oT7mSEJlnfALADcmOHqZIEek6+dQ1yuDL
	 KFL3OrtRHEDAEQM4t+pGWRfw14sGuiMb8t45CxP2nSQhDw3Xe+retEN0DcGr8eFXNt
	 P0NH+u4Eat27MIExtAnVLODbFRTh+pIxiP5qXA91SG+Q6ubhPEuXm2hs6MKH+Q9zVC
	 9RSTwW6CafCLa3Rvq53fJYr3POyjpKBCdv/fG/blgUJRW46br8+Q/ZqOF+PUCEEPMa
	 5Csr1KWmsnWLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/6] PCI: Enable the enhanced ACS controls introduced
 by PCI_ACS_ECAP
Reply-To: sashiko@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB4393F6FB65CF0A46E8E89B86DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F6FB65CF0A46E8E89B86DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 21:32:19 +0000
Message-Id: <20260506213219.ED7C6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `config_acs=3D` boot parameter parser incorrectly validates th=
e newly added ACS Enhanced Capability controls (bits 8-12), unconditionally=
 rejecting valid configurations and bypassing administrator-defined isolati=
on policies.
--

commit 7640f1b4b51e699ac56a5798f5e8dbb9114e4b25
Author: Wei Wang <wei.w.wang@hotmail.com>

    PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
   =20
    The ACS Enhanced Capability introduces several new access controls to
    improve device isolation. These new controls are particularly important
    for device passthrough in virtualization scenarios.

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 0c159ab59e14b..32e82859089c8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5265,13 +5265,22 @@ Kernel parameters
>  				flags.
> =20
>  				ACS Flags is defined as follows:
> -				  bit-0 : ACS Source Validation
> -				  bit-1 : ACS Translation Blocking
> -				  bit-2 : ACS P2P Request Redirect
> -				  bit-3 : ACS P2P Completion Redirect
> -				  bit-4 : ACS Upstream Forwarding
> -				  bit-5 : ACS P2P Egress Control
> -				  bit-6 : ACS Direct Translated P2P
> +				  bit-0     : ACS Source Validation
> +				  bit-1     : ACS Translation Blocking
> +				  bit-2     : ACS P2P Request Redirect
> +				  bit-3     : ACS P2P Completion Redirect
> +				  bit-4     : ACS Upstream Forwarding
> +				  bit-5     : ACS P2P Egress Control
> +				  bit-6     : ACS Direct Translated P2P
> +				  bit-7     : ACS I/O Request Blocking
> +				  bit-9:8   : ACS DSP Memory Target Access Ctrl
> +				      00    : Direct Request access enabled
> +				      01    : Request blocking enabled
> +				      10    : Request redirect enabled
> +				      11    : Reserved
> +				  bit-11:10 : ACS USP Memory Target Access Ctrl
> +				              Same encoding as bit-9:8
> +				  bit-12    : ACS Unclaimed Request Redirect Ctrl
>  				Each bit can be marked as:
>  				  '0' =E2=80=93 force disabled
>  				  '1' =E2=80=93 force enabled

Does this configuration introduce a regression where valid inputs for bits 8
through 12 are unconditionally rejected?

Looking at the parser in drivers/pci/pci.c:pci_param_config_acs(), it valid=
ates
the requested bits against the hardware capabilities:

	u16 shift =3D 0, max_shift =3D fls(dev->acs_capabilities) - 1;
	...
		if (shift > max_shift) {
			pci_err(dev, "ACS flag bit %d exceed range %d\n",
				shift, max_shift);
			return;
		}
	...
	if (enabled_bits & ~dev->acs_capabilities) {
		pci_err(dev, "Invalid ACS enable flags specified: %#06x\n",
			(u16)(enabled_bits & ~dev->acs_capabilities));
		return;
	}

Since bits 8 through 15 of the ACS Capability Register represent the Egress
Control Vector Size rather than capability flags, validating bits 8-12 agai=
nst
dev->acs_capabilities appears to be incorrect.

If the Egress Control Vector Size is 0, max_shift will be 7, and the parser
will reject any attempt to configure bits 8 through 12. If it is non-zero, =
the
bitwise validation will fail unpredictably depending on the size value.

Will this cause the requested administrator-defined isolation policies to be
bypassed?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB439385689A=
32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D5
