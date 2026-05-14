Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B01531C8;
	Thu, 14 May 2026 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720446; cv=none; b=oOy3P8EezyJX/uEkO9hI4ySRSrqv9oYXm8MfWpIkHN0qqGJ2ojzPeUmaan4vRSfv63pKctGj4URNDrcWoJXM0PtuHC72GZVYQRpIw38A6gm9axO/VJDlG72O45yhrahIA3ZY2/nBqkH73H9QzH9xiJ5eMQhPkfcjD/Y/4hpByP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720446; c=relaxed/simple;
	bh=c0dvtN3hG6NA848503CiLGO4uQ5N2nrPxiII+aSKRwY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KvIB/3AEGLWD1yycd2TSjHJjuT8pnGkOaVau81eQ0HYQijWO25I2hWaOS8wpJ6O7H2hlkvMwHFX/Q0MyPwjwH2El8ZWYesna12SolRFnp1lErQttjOxwRVSDkY48xFV3zrkxdz3vefZ8XxYZrX6FEJHMyFP5+YH4DVI/AkkCIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTosgnBZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTosgnBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B52C19425;
	Thu, 14 May 2026 01:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778720446;
	bh=c0dvtN3hG6NA848503CiLGO4uQ5N2nrPxiII+aSKRwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JTosgnBZPajai8gk08RhnzAdba4SJkF0nuui6R0J7gWEFtnPzXaakiHCIfY5ME0o/
	 H1tr2qTYjOgqgaOq5Av1E3eSuT9h6GguE72r03LveTp1ynnxIeWeVG0r2L/idn27TL
	 NkWSmtzDPSrnMl9ZVl4/QVQdn8CHSFDXINC/rYTOzqgWR2XZtheWUZUCEgRlKGfeAI
	 UigXMLS4PJhKvHcIyLu1pshpvZXNaIMlIfDzzTpkXOPDgVNqBhTLa9WE9hIkp81k+w
	 MnVRnMELOKQm4YnofwQXN5v8oHciRXNZlgpBFL6ix3wnTyv1WDfjExQ3Iy7Vq+lKvP
	 kBWKRKzKqJi8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] hwmon: add AMD Promontory 21 xHCI temperature
 sensor support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jihong Min" <hurryman2212@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20260512213910.871859-3-hurryman2212@gmail.com>
References: <20260512213910.871859-3-hurryman2212@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:00:45 +0000
Message-Id: <20260514010045.D9B52C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using readb() on a 32-bit PCIe MMIO vendor data register may cause=
 unsupported request faults.
--

commit 9f079250f98377be1d241f6f3c08a14ae44d8785
Author: Jihong Min <hurryman2212@gmail.com>

hwmon: add AMD Promontory 21 xHCI temperature sensor support

Add an auxiliary-bus hwmon driver for the temperature sensor exposed by
AMD Promontory 21 (PROM21) xHCI PCI functions.

> diff --git a/drivers/hwmon/prom21-xhci.c b/drivers/hwmon/prom21-xhci.c
> new file mode 100644
> index 0000000000000..7124824a1f5ed
> --- /dev/null
> +++ b/drivers/hwmon/prom21-xhci.c

[ ... ]

> +static int prom21_xhci_read_temp_raw_restore_index(struct prom21_xhci *h=
wmon,
> +						   u8 *raw)
> +{
> +	struct device *dev =3D &hwmon->pdev->dev;
> +	u32 index;
> +	u8 data;
> +	int ret;
> +
> +	ret =3D prom21_xhci_pm_get(hwmon);
> +	if (ret)
> +		return ret;
> +
> +	index =3D readl(hwmon->regs + PROM21_XHCI_INDEX_OFFSET);
> +	/* Select the PROM21 temperature register through the vendor index. */
> +	writel(PROM21_XHCI_TEMP_SELECTOR,
> +	       hwmon->regs + PROM21_XHCI_INDEX_OFFSET);
> +	data =3D readb(hwmon->regs + PROM21_XHCI_DATA_OFFSET);

Is it safe to use readb() on this 32-bit PCIe MMIO vendor data register?

Many PCIe controllers and peripheral MMIO implementations strictly require
32-bit transactions. Issuing an 8-bit read can result in a PCIe unsupported
request, which may return 0xff or trigger a fatal PCIe error.

Could this instead use readl() and mask out the lowest 8 bits?

> +	/* Restore the previous vendor index register value. */
> +	writel(index, hwmon->regs + PROM21_XHCI_INDEX_OFFSET);
> +	readl(hwmon->regs + PROM21_XHCI_INDEX_OFFSET);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512213910.8718=
59-1-hurryman2212@gmail.com?part=3D2
