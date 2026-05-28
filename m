Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573D2FE05B
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779939673; cv=none; b=gMd0eeaXguHb/gKBy+gaNSHlhe+gDse7QarK4YvvW0CS2zamTbC9hQF8Ot2zoOxGhVVkp+bWmRNl13rws3+W/AJQ4e28KxKc7q4QYTZIJCoR483RTj/+JMA+8r/DC04wzx+PF5I57a7A9fE4EkC3Y2gVjSkDPVD5zSwSa864uGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779939673; c=relaxed/simple;
	bh=SzEEPoVvoARGS/qcdE1RCai9UElINv1jJqvYAVj8UXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RgBwX1LsWD+Q0I+roq0biM56kRgTtbVcwE/TgqkHYO6lQcrBvq3oOWbKWV+UoO8vYtPnmogk6+aX5DZTftotqFHj+OrRHAGkJwRJllgfu0jA4svV0bMUVbX5SrzqoNcqiQkYFAVdZpabBEc/nuSi7qAxYjj3STlssiEQfti85Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuZz3oYX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuZz3oYX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC29B1F000E9;
	Thu, 28 May 2026 03:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779939672;
	bh=xkf4ytNH2mcUDwxSp1Uj0lVw/UhwAnwx8SWaQ8oDtII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RuZz3oYXJlaZ/+iTU9oi/jkwczXHuvN4p5bJmXPsd1AH3qfLTD2gkJO1RvfGGaxvO
	 XdZJA3pV6GCpWAuZwsWNr0z3VpXT2lhmQW+M+Ff7xAYaAsYYJmtZX96C7zWrDPkzBx
	 EMaK3aVOiYGvfDT+1tQL12rB8u7i6wZeLmF8TBHTWqWfh/UiVmPd4HzMTiY+KjcBSV
	 DHPH1Mx9T2a7m3+G6/GkcHYXnzPAy87DyUs4JA6jk1XLxrzWpSNRX04c0mzJcV5HYx
	 31xLi54qbtm+Nvawi3KHBVy2d2ug5XwxnTvSqR9MoZN55R6gyCVaZ3ravKcg/2OIn5
	 D9+HJ/Q2908+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Mask Replay Timer Timeout for Realtek RTS525A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Max Lee" <max.lee@canonical.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260528032347.644365-1-max.lee@canonical.com>
References: <20260528032347.644365-1-max.lee@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 03:41:11 +0000
Message-Id: <20260528034111.DC29B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The quirk returns early if the endpoint lacks the AER capability, =
unintentionally skipping the AER mask on the parent root port.
--

commit 33ed73136f45313933a545d6af06c38d893ebef2
Author: Max Lee <max.lee@canonical.com>

PCI: Mask Replay Timer Timeout for Realtek RTS525A

This commit adds a PCI fixup quirk for the Realtek RTS525A SD card reader.
It masks the Replay Timer Timeout on both the endpoint and its parent root
port to prevent an AER storm during PCIe link initialization.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc02..072d1456daad4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6380,4 +6380,23 @@ static void pci_mask_replay_timer_timeout(struct p=
ci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer=
_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer=
_timeout);
> +
> +static void pci_mask_replay_timer_timeout_on_endpoint(struct pci_dev *pd=
ev)
> +{
> +	u32 val;
> +
> +	if (!pdev->aer_cap)
> +		return;

[Severity: High]
If the endpoint lacks the AER capability, this early return will entirely
skip masking the parent root port later in the function. Does this leave the
system vulnerable to the AER storm from the parent port if the endpoint's
AER capability is disabled or hidden?

Could this be restructured so that the parent root port masking is still
applied even when the endpoint lacks the AER capability?

> +
> +	pci_info(pdev, "mask Replay Timer Timeout on endpoint due to hardware d=
efect\n");
> +
> +	pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_MASK, &val);
> +	val |=3D PCI_ERR_COR_REP_TIMER;
> +	pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_MASK, val);
> +
> +	/* Also mask the parent root port */
> +	pci_mask_replay_timer_timeout(pdev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528032347.6443=
65-1-max.lee@canonical.com?part=3D1
