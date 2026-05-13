Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E79319C542
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778631926; cv=none; b=PnrNh4ukpo0i1EmyL2hWJT4bBGW418QP+dyIX0P8+dJVjP0bJsHi4frJ4UqnAw/3Y2JPuqqDOt0ljvBbww4X/e0WdiscBGI2WSmAOmNIIKRqQ9zdYVgWnZNLWF9Bw9W3N+rgYSX1dvoNCFmupxjLrA5BVGcfzEsp/CWiuKfPLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778631926; c=relaxed/simple;
	bh=6mzKBl6KjEpsHZBCdEjRf5ocmdF7DRWjwcoir2Rza4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B0V9OZHDvKT5xdFc5ZYXy4jyAeTuYTaApazIjsSMo/jCBcbHFYYS8ZvA1Vz/xjRdHQ5djyJguhWA59uJZLHEUFTk8Sn5nAciw3IMeVxG8ioqSkwS7hSVkptwaFsaxc4poCoP5AQkBuXb9d5ndEXAR0x3u+ZPkM9uELJqKEcysoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CicQe5s1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CicQe5s1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEEBC2BCB0;
	Wed, 13 May 2026 00:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778631925;
	bh=6mzKBl6KjEpsHZBCdEjRf5ocmdF7DRWjwcoir2Rza4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CicQe5s1YU7/iFr8QMrWqphySlccleD6G3gz5MdHy7z3K2yk4NBlEL70z+JXtvLiJ
	 Y4tOKLPSvOAdRV/YH6fKDp31rqdzKvDoW1OGmknE0B21xG7NhkYJYKPfN5Ni+rbVfm
	 shr0SmusarcHLvTZZE+qaUPy1o3uR7So58OakJzA2i4C/AL9IkjO4Gxg254OeRkqi3
	 IGak3fGIMC6gTXw7oVoV8TmgenKmGNXFKXkGGpfld6VuLre4G2LYdZWq3Udfw3ZlXd
	 pat5Qtwvu4UzWrUHcYw+D/Ztr1HCA86MoUm79OI/x3ZyXMykoB20M4nKCsGjqjWbrH
	 d9u08ZIDh1+MA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/4] pcie/aspm: Add debug logging for aspm policy
 config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511210936.562622-2-thomas.falcon@intel.com>
References: <20260511210936.562622-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 00:25:25 +0000
Message-Id: <20260513002525.8FEEBC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Dead code when attempting to log Clock PM state in ASPM debug outpu=
t.
- [Low] Unconditional and potentially misleading debug logging for ASPM lin=
k configuration.
--

commit 364db9458a74bb3fb257b69effddd2f95f805170
Author: Thomas Falcon <thomas.falcon@intel.com>

pcie/aspm: Add debug logging for aspm policy config

Include additional logging for ASPM and Clock PM state changes
keeping track of code flow and enabled power saving states.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 925373b98dff0..cd23c1462502f 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c

[ ... ]

> @@ -961,11 +964,14 @@ static void pcie_config_aspm_link(struct pcie_link_=
state *link, u32 state)
>  	state &=3D (link->aspm_capable & ~link->aspm_disable);
> =20
>  	/* Can't enable any substates if L1 is not enabled */
> -	if (!(state & PCIE_LINK_STATE_L1))
> +	if (!(state & PCIE_LINK_STATE_L1)) {
> +		pci_dbg(parent, "ASPM: L1 not enabled, disabling L1 substates\n");
>  		state &=3D ~PCIE_LINK_STATE_L1SS;
> +	}
> =20
>  	/* Spec says both ports must be in D0 before enabling PCI PM substates*/
>  	if (parent->current_state !=3D PCI_D0 || child->current_state !=3D PCI_=
D0) {
> +		pci_dbg(parent, "ASPM: Both ports are not in D0, disable PCI PM L1 sub=
states unless explicitly enabled\n");
>  		state &=3D ~PCIE_LINK_STATE_L1_SS_PCIPM;
>  		state |=3D (link->aspm_enabled & PCIE_LINK_STATE_L1_SS_PCIPM);
>  	}

Are these debug statements being printed more often than intended?

Since these prints happen unconditionally before the early return check:

    if (link->aspm_enabled =3D=3D state)
        return;

enabling dynamic debugging will output these messages even if the device=20
states already match the requested state and no hardware configuration is=20
actually applied.

[ ... ]

> @@ -997,16 +1005,34 @@ static void pcie_config_aspm_link(struct pcie_link=
_state *link, u32 state)

[ ... ]

> +	pci_dbg(parent, "ASPM: enabled states:%s%s%s%s%s%s%s%s\n",
> +		FLAG(state, L0S_UP, " L0s-Upstream"),
> +		FLAG(state, L0S_DW, " L0s-Downstream"),
> +		FLAG(state, L1, " L1"),
> +		FLAG(state, L1_1, " ASPM-L1.1"),
> +		FLAG(state, L1_2, " ASPM-L1.2"),
> +		FLAG(state, L1_1_PCIPM, " PCI-PM-L1.1"),
> +		FLAG(state, L1_2_PCIPM, " PCI-PM-L1.2"),
> +		FLAG(state, CLKPM, " ClockPM"));

Is it possible for the CLKPM flag to ever be true here?

It looks like the PCIE_LINK_STATE_CLKPM bit is masked out earlier in the
function when verifying capabilities:

    state &=3D (link->aspm_capable & ~link->aspm_disable);

Since the CLKPM bit is outside the 7-bit range of aspm_capable, this bit
is never present in the state mask at this point, so the macro will always
evaluate to an empty string.=20

Because the Clock PM state change is already correctly logged in=20
pcie_set_clkpm(), does this FLAG check need to be included here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511210936.5626=
22-1-thomas.falcon@intel.com?part=3D1
