Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B113E30C168;
	Fri, 26 Jun 2026 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466367; cv=none; b=K2PjP1/Xcj3akOidomtiXlFePrm4GksLu0C0KPoNIR9mJ65YFtVfH3hjFYq2hPDSieybL1tM01mRm6MQI6GMmWOcDbf/0nqCeyacRWN9Lo8qmSmrH3AJR7lg79kJJRk7F0/GuYmQRj1cRMAlzAGswojgk5iAca2PNCor/74A8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466367; c=relaxed/simple;
	bh=3u+evhwVpWlcCgyaSo9s3ExGfObJmNuE1TryFWI/FPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fkV2pjPcBe90SmfdbVZTx1iqJjQYIiSir/3QiQlYbn5YrTdA5Wm0zttVB7ii73huHq3cpHPATLXNcfIhHLloDeQEBesoPfKSUsfat2e4kI3gSgXUEJ6mCKdKx53S1lZrG5a8AASjvsDEv9d3I3O/8xIYEqL4GKqoOcg7ct0Cdto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUwMsEEH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUwMsEEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF75D1F000E9;
	Fri, 26 Jun 2026 09:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782466366;
	bh=UUX+1yjjUNwClEZqRp+nFhRVsZRk/4sc3rX1ISojAO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YUwMsEEHhOfIFUs5tIAUjgalU0EYxCH6m5GP8i9q4PRLNCcOsngOtodaHE9bbEqMr
	 MXuPvRk+nHllV7sQUEm90KQTrZM991as0wUyywnsmgxErMs9e6LLZMOLOoekhG3JF3
	 /+No7NLTb148XQHf7rTfNmY+WK+OjvpAKmcrtgExl/o0qxtGTAPwWYjF7E9VFyUYHV
	 Bd1SqUJuvkGrRZZaRr67QsHW0Hd6vE3Hubf3rUrAju5g8s8ry8HsqXvKztrZayKDt8
	 qxKITDl8O79N/osAfgQWQd4l8PV9MCKu0TZdRVh52Qmp1XBLd2k8uHdgHvaW4WCKsX
	 Oxj5+3pbDSEAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] clk: en7523: add support for dedicated PCIe
 PERSTOUT reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Marangi" <ansuelsmth@gmail.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260626092029.3525264-3-ansuelsmth@gmail.com>
References: <20260626092029.3525264-1-ansuelsmth@gmail.com>
 <20260626092029.3525264-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 09:32:44 +0000
Message-Id: <20260626093245.DF75D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Concurrent read-modify-write accesses to the shared register 0x88 =
between the clock and reset subsystems will cause lost updates.
- [Medium] Removing the PERSTOUT reset deassertion from the clock enable pa=
th breaks PCIe initialization for existing Device Trees.

Pre-existing issues:
- [High] Missing spinlock in the reset controller to serialize read-modify-=
write operations.
- [High] Call to the sleeping function usleep_range() inside the atomic clo=
ck disable callback.
- [High] Stale register state written back after sleeping, clobbering concu=
rrent hardware updates.
--

commit f7fec9791d69805c2bca6f3b03a2e7c0e7f0a28c
Author: Christian Marangi <ansuelsmth@gmail.com>

clk: en7523: add support for dedicated PCIe PERSTOUT reset

This commit adds support for resetting the PCIe lines using the PERSTOUT re=
set
by updating the reset map and moving the handling of these bits from the cl=
ock
enable and disable paths to the reset controller framework. The reset logic=
 is
inverted for these specific bits and handled internally.

> diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
> index 1ab0e2eca5d32..c9b21d9bf2f3f 100644
> --- a/drivers/clk/clk-en7523.c
> +++ b/drivers/clk/clk-en7523.c
[ ... ]
> @@ -635,9 +641,7 @@ static int en7581_pci_enable(struct clk_hw *hw)
>  	void __iomem *np_base =3D cg->base;
>  	u32 val, mask;
> =20
> -	mask =3D REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1 |
> -	       REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT2 |
> -	       REG_PCI_CONTROL_PERSTOUT;
> +	mask =3D REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1;

[Severity: Medium]
Does removing the PERSTOUT reset deassertion from the clock enable path
break PCIe initialization for existing Device Trees?

When booting with an older DTB built before the resets property was updated
to explicitly list the PERSTOUT lines, the clock driver will no longer
automatically clear these resets in en7581_pci_enable(). Since the PCIe
driver also lacks references to them in the older DTB, it seems the PCIe
controller will remain in reset.

>  	val =3D readl(np_base + REG_PCI_CONTROL);
>  	writel(val | mask, np_base + REG_PCI_CONTROL);

[Severity: High]
Can concurrent read-modify-write accesses to this shared register between
the clock and reset subsystems cause lost updates?

The clock API protects operations with its global enable_lock, while the
reset framework operates lockless at the driver level. If PCIe host 0 enabl=
es
its clock in en7581_pci_enable() concurrently with PCIe host 1 toggling its
reset in en7523_reset_update(), their read-modify-write operations on the
exact same physical register (REG_PCI_CONTROL / REG_NP_SCU_PCIC at offset
0x88) will race and silently overwrite each other.

[ ... ]
> @@ -650,9 +654,7 @@ static void en7581_pci_disable(struct clk_hw *hw)
>  	void __iomem *np_base =3D cg->base;
>  	u32 val, mask;
> =20
> -	mask =3D REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1 |
> -	       REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT2 |
> -	       REG_PCI_CONTROL_PERSTOUT;
> +	mask =3D REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1;
>  	val =3D readl(np_base + REG_PCI_CONTROL);
>  	writel(val & ~mask, np_base + REG_PCI_CONTROL);
>  	usleep_range(1000, 2000);

[Severity: High]
This is a pre-existing issue, but is it safe to call the sleeping function
usleep_range() inside the atomic clock disable callback?

The clk_ops->disable callback executes in atomic context with the clock
framework's enable_lock spinlock held and local interrupts disabled. Calling
usleep_range() here attempts a context switch, which will result in a
scheduling while atomic bug.

[ ... ]
> @@ -754,14 +756,21 @@ static int en7523_reset_update(struct reset_control=
ler_dev *rcdev,
>  			       unsigned long id, bool assert)
>  {
>  	struct en_rst_data *rst_data =3D container_of(rcdev, struct en_rst_data=
, rcdev);
> -	void __iomem *addr =3D rst_data->base + rst_data->bank_ofs[id / RST_NR_=
PER_BANK];
> +	u32 offset =3D rst_data->bank_ofs[id / RST_NR_PER_BANK];
> +	void __iomem *addr =3D rst_data->base + offset;
> +	bool inverted =3D false;
>  	u32 val;
> =20
> +	/* For PCIC reset logic is inverted, 0:assert 1:deassert*/
> +	if (offset =3D=3D REG_NP_SCU_PCIC)
> +		inverted =3D true;
> +
>  	val =3D readl(addr);
> +	val &=3D ~BIT(id % RST_NR_PER_BANK);
>  	if (assert)
> -		val |=3D BIT(id % RST_NR_PER_BANK);
> +		val |=3D inverted ? 0 : BIT(id % RST_NR_PER_BANK);
>  	else
> -		val &=3D ~BIT(id % RST_NR_PER_BANK);
> +		val |=3D inverted ? BIT(id % RST_NR_PER_BANK) : 0;
>  	writel(val, addr);

[Severity: High]
This isn't a bug introduced by this patch, but does this function need a
spinlock to serialize the read-modify-write operations?

The en7523_reset_update() callback performs unguarded read-modify-writes on
shared reset banks. If two distinct device drivers (such as I2C and PCIe)
probe concurrently and assert or deassert their respective resets, the
lockless read-modify-write cycles will race, overwriting one of the
operations and leading to silent hardware state corruption.

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but could the caching of register
state in en7523_pci_prepare() clobber concurrent hardware updates?

val =3D readl(np_base + REG_RESET_CONTROL1);
mask =3D REG_RESET_CONTROL_PCIE1 | REG_RESET_CONTROL_PCIE2 | REG_RESET_CONT=
ROL_PCIEHB;
writel(val & ~mask, np_base + REG_RESET_CONTROL1);
usleep_range(1000, 2000);
writel(val | mask, np_base + REG_RESET_CONTROL1);

The cached register state val is re-used to write after a sleep. If any
other driver toggles a reset bit in the same register (which controls up to
32 different resets) during the sleep duration, their reset state will be
unconditionally reverted and corrupted by this stale writeback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626092029.3525=
264-1-ansuelsmth@gmail.com?part=3D2
