Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B304028E2
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170859; cv=none; b=bJFVYAAVsSGrLOv4oyozxKftyJIEoh/NJU0e3GjGqneXwJXFYml/f79GXACADv+uTEPN1vjYbWE+Bp/8rALBSbR3olNEnxxkfEdyG7VVun/DvWQc3HM3C7qHkHEnc8Ip5KBuCZB22H5GaW53X2htDi7w+5ZzcrUeNx3yyIYwGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170859; c=relaxed/simple;
	bh=iKR1EOlLpV9KyrT4T2sIZa60Qa0hysBbvhhYyeQMTPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vAquqRMlkrqIqMTkZ7no4GFt7kV4ZhCKIHIBYdIVOunO2PUh6/3pHNSoGz3FRSr7nvYXGu9BUW5I+dgFRGuIEkkyhVr9sAZrt3GAlaLt9JLVfKWyeCkGqyPLt1sG5NrcuWVL5lHiXvrjdogfT0RmKVzWl3wGtbSK7oYcCoJplQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE7O+rL6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE7O+rL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1A01F00893;
	Fri, 11 Sep 2026 23:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170856;
	bh=ofQ/GXjxd8ixMR8n9NMZ+sMH/e2+kIbtueY9aWOLsBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BE7O+rL6Y/6wtkpcsg34pxdfCzkKRrM7xv6xZP9JKI+EV5HfILvs3CFxP8UqbD+Uv
	 +SjzHc1l6CnYsZ8W4P7B8ZcLzDQkBJ3XdKd4+QVGhO5MOj2d/nIbysscAMJ6bFLYTh
	 HFhXk04pd9YkMedhBa0tSFsZz8eP2/xFC+EDOZE+slNpPzuVdeCsdNEwbM+fS0C99t
	 dr2VNnTIpq1NHMRSiw10mRuzH2HffoF4Jxr6DmlXtRPZgtbyyJd6DSPren9wJiAaDN
	 oEdtWpCnYCty/7Kv9DFhJHltB/+HuG+mX7zmojis4RVgvRVg+kQ2PQtAXyt1LZ0Fbn
	 2DV+rUyNPJMWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] PCI: brcmstb: Split up complicated function into
 two variants
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Quinlan" <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911233541.1650895-14-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-14-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:54:15 +0000
Message-Id: <20260911235416.1E1A01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An off-by-one error in the inbound window limit check allows one m=
ore window than supported by hardware to be processed, leading to out-of-bo=
unds register writes.
- [High] The MSI target address calculation incorrectly hardcodes the array=
 index `inbound_wins[2]`, evaluating either a disabled zero-sized window or=
 uninitialized stack memory instead of the main inbound window.
--

commit 2fa82ffee79e487108d802c77822d346d0a063c9
Author: Jim Quinlan <james.quinlan@broadcom.com>

PCI: brcmstb: Split up complicated function into two variants

This patch refactors brcm_pcie_get_inbound_wins into two variants: one for
newer chips and one for older chips. It updates the configuration data
structures to assign the appropriate function pointer to get_ib_wins.

> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index 53984cfa2c96f..45e8a9e030d4a 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
[ ... ]
> @@ -954,8 +957,58 @@ static void add_inbound_win(struct inbound_win *b, u=
8 *count, u64 size,
>  	(*count)++;
>  }
> =20
> +/*
> + * This is used by newer SoCs. It configures the inbound mapping windows
> + * in accordance to the values of the dma-ranges properties.
> + */
>  static int brcm_pcie_get_ib_wins(struct brcm_pcie *pcie,
>  				 struct inbound_win *ib_win)
> +{
> +	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(pcie);
> +	struct resource_entry *entry;
> +	u64 size;
> +	u8 n =3D 0;
> +
> +	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> +		u64 pcie_start =3D entry->res->start - entry->offset;
> +		u64 cpu_start =3D entry->res->start;
> +
> +		size =3D resource_size(entry->res);
> +		add_inbound_win(ib_win++, &n, size, cpu_start, pcie_start);
> +		if (n > pcie->cfg->num_inbound_wins)
> +			break;

[Severity: High]
This is a pre-existing issue, but does this off-by-one check allow n to
exceed the maximum hardware window count?

Because add_inbound_win() post-increments n, if a device tree provides more
dma-ranges than the maximum supported hardware windows, n can exceed
num_inbound_wins before the break occurs. The function will then return
this oversized window count.

If this happens, when brcm_pcie_set_ib_win_registers() subsequently iterates
over the returned count, could it fetch an out-of-bounds register offset
and overwrite unrelated hardware configuration space?

[ ... ]
> @@ -1195,7 +1217,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
>  	writel(tmp, base + PCIE_MISC_MISC_CTRL);
> =20
> -	num_inbound_wins =3D brcm_pcie_get_ib_wins(pcie, inbound_wins);
> +	num_inbound_wins =3D pcie->cfg->get_ib_wins(pcie, inbound_wins);
>  	if (num_inbound_wins < 0)
>  		return num_inbound_wins;

[Severity: High]
This is a pre-existing issue, but does the setup logic later in this
function rely on inbound_wins[2] being initialized and valid?

In brcm_pcie_setup(), the inbound_wins array is allocated on the stack.
Later in the function, it calculates the MSI target address like this:

    if (inbound_wins[2].pci_offset >=3D SZ_4G ||
        (inbound_wins[2].size + inbound_wins[2].pci_offset) < SZ_4G)
            pcie->msi_target_addr =3D BRCM_MSI_TARGET_ADDR_LT_4GB;
    else
            pcie->msi_target_addr =3D BRCM_MSI_TARGET_ADDR_GT_4GB;

For newer SoCs using brcm_pcie_get_ib_wins(), if the device tree provides
fewer than 3 dma-ranges entries, could this logic read uninitialized stack
memory?

For older SoCs using brcm_pcie_get_ib_wins_internal_map(), inbound_wins[2]
is deliberately populated as a zero-sized, disabled window. Does evaluating
this zeroed window result in misconfiguring the MSI target address,
potentially causing PCIe device interrupts to fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.1650=
895-1-james.quinlan@broadcom.com?part=3D13
