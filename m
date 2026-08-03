Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A6428828;
	Mon,  3 Aug 2026 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781766; cv=none; b=Z/12tebKP1r0uWgxvKIDrRE6a7vCwAndmOpFl1eFZQmPL7PuJnC18xkOWDUPr+nEIRfkjVKueRgnoGR+rYIQecpH+VWDxzxi5OHAVWrCLfhE3YtFjqyH4/0+59b4OLRiS2e7D5O3NBs3juX9c4vMFvAj7XPxcXslNyRaKBvW9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781766; c=relaxed/simple;
	bh=eVGmriAA+aS/r+kar7JEUft1i9UiSPoC80J+dsm3YL4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HvPCpZahl1CnI2F9x2hJSPkJ1pP5upR1f3uyEQs+KK8PD2ssYwsptQ+Zz1gjDAJzEJbbDzBYOXJYsrgMW/SiPVrHWEF4Koo0LJ/Qr+Xsq9OIKlWORIiXTawUDxPzjybBwikLYnhXUJ6D8j9TTd82iWsVjRgbrCoMBuj9VkqUAlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSnJp/cw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSnJp/cw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673B91F000E9;
	Mon,  3 Aug 2026 18:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781759;
	bh=laRDeu/u+G5mTkVKDOOaCzpETnGMhID6toKmQ14jr7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZSnJp/cwL1wdy79o1lx4lFJdMnBKKTJcsuw2dg5MBsOwBFsrQsAapRXQFvn6hHm6t
	 i7dN1bQW+akH9Pvgr8DGY8+k9wjimFr/6EFazaTfGMqpVP+VPwXsf/ZHC099fUzHyv
	 pTClNYrSVYEEWG6nDeNHXoNqFC0UYnqT/b50lbW9PlkUnbkzM2DsUSHqz1n38bzc3+
	 WlsCrKG8yh31c8o1KNtT3tfZy/cVfUlXTieXX1NO4a7N8G5ZDr5d/59VgdFKDAHt4W
	 JC8bFgwxDAibRiGVQ1L3TDuuX91qZfB0TK/SMIQVVP4/OTU7df2YOnO73iV7T3anvM
	 bItTx6scsD9rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] NTB: epf: Implement MW group translation
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260803180439.1963864-8-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
 <20260803180439.1963864-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:29:18 +0000
Message-Id: <20260803182919.673B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unprotected concurrent modification of shared hardware control reg=
isters before acquiring cmd_lock.

Pre-existing issues:
- [High] The return values of `ntb_epf_send_command` are silently ignored i=
n legacy MW operations.
--

--- Patch [7]: [PATCH 07/11] NTB: epf: Implement MW group translation callb=
acks ---
commit 1b85afed97e44da7b70fd9dff32c501ab6f91e2d
Author: Koichiro Den <den@valinux.co.jp>

NTB: epf: Implement MW group translation callbacks

This commit connects the NTB group callbacks to the version 1 group commands
so ntb_hw_epf can program packed MWs. Singleton MWs keep using the legacy
commands.

> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_=
epf.c
> index 46f37c2dea7b2..8b00550eea04d 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -509,6 +511,43 @@ static int ntb_epf_db_set_mask(struct ntb_dev *ntb, =
u64 db_bits)
>  	return 0;
>  }
> =20
> +static int
> +ntb_epf_mw_set_trans_group(struct ntb_dev *ntb, int pidx, int widx,
> +			   dma_addr_t addr, resource_size_t size)
> +{
[ ... ]
> +	writel(lower_32_bits(addr), ndev->ctrl_reg + NTB_EPF_LOWER_ADDR);
> +	writel(upper_32_bits(addr), ndev->ctrl_reg + NTB_EPF_UPPER_ADDR);
> +	writel(lower_32_bits(size), ndev->ctrl_reg + NTB_EPF_LOWER_SIZE);
> +	writel(upper_32_bits(size), ndev->ctrl_reg + NTB_EPF_UPPER_SIZE);

[Severity: High]
Can concurrent writes to these registers corrupt the hardware state?

Looking at ntb_epf_mw_set_trans_group(), the parameter registers are modifi=
ed
outside the protection of ndev->cmd_lock, which is only acquired later insi=
de
ntb_epf_send_command().

If a user or client driver concurrently configures different memory windows,
would the register writes interleave, potentially granting the peer device
DMA access to unintended memory regions?

This identical pattern also exists in ntb_epf_mw_set_trans().

> +
> +	return ntb_epf_send_command(ndev, CMD_CONFIGURE_MW_GROUP, widx);
> +}
[ ... ]
> @@ -648,6 +687,8 @@ static const struct ntb_dev_ops ntb_epf_ops =3D {
>  	.db_vector_mask		=3D ntb_epf_db_vector_mask,
>  	.db_set_mask		=3D ntb_epf_db_set_mask,
>  	.mw_get_trans_group	=3D ntb_epf_mw_get_trans_group,
> +	.mw_set_trans_group	=3D ntb_epf_mw_set_trans_group,
> +	.mw_clear_trans_group	=3D ntb_epf_mw_clear_trans_group,
>  	.mw_set_trans		=3D ntb_epf_mw_set_trans,
>  	.mw_clear_trans		=3D ntb_epf_mw_clear_trans,

[Severity: High]
This is a pre-existing issue, but do the legacy transaction functions mask
hardware failures?

Looking at ntb_epf_mw_clear_trans() in drivers/ntb/hw/epf/ntb_hw_epf.c:

	ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
	if (ret)
		dev_err(dev, "Failed to teardown memory window\n");

The return value of ntb_epf_send_command() isn't captured, so ret remains
zero and the error check becomes dead code.

Could this hide a teardown failure, causing the local host to free memory
while the peer host retains active DMA access to it?

Similarly, ntb_epf_mw_set_trans() discards the return value of
ntb_epf_send_command() and unconditionally returns 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803180439.1963=
864-1-den@valinux.co.jp?part=3D7
