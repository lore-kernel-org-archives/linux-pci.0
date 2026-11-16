Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822725;
	b=g54bIbawmk5TLVYT5yja7WhsSlxzf35bFldfkVzm+gnlim9Mafegb0wEfuurVQEfr83L
	 EXmqGRcrN6HfDcYe6UaSjiqLSoEu3uzOhAtNtM39CRTIiDh9EILE1wNfhsl5fNHk+w0tK
	 5ou0xIDG7nHBanIrsFM5Sxoo/5Q4hX/lGu4xoS6UhIgkDVL4xutiDsD/pIpxOnEn8mWUj
	 Ts/j5zOtYGAJvAdJ9Lp5x56N2NEjpQY5RIluXuNFgYDFYqPUKhxUDx5NabHEZHSGoS4KK
	 599RgBZaCCdujhWLr4BeZ0++W0ZrldxD3og0xYKONthv54tfc89hqP40QCebS2V4uKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822725;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CJALN4cA6kUTsbv8DanRmvpcLs4rgXRb3bG8ynsdVok=;
	b=vcCFs9L9dqEi5xgyZXQt8pu8jxgrH38E6ix/RAQepcgZqk2+TDc01LZoFYjY20LHJSrs
	 sTkql1wKAUhbUoB3wIUTygm709ZpJFobaoEnqQ8NvUIlyORJg2OLn8JAKvCgBp09GkB+w
	 gZpDOjRVj802BKFMHoSesYJB3wqNf0qf8ZOehGEyE/WEydHapRFsaeMnqo58vTuTKwk+5
	 5LGGI/A4IZuokuG3+UKXxJJZun/2XL8NdLAAmEr6MCgx4QVNMfV2yVr1Ge9Z54CQOYgfF
	 kuNhduebu7v5pGhizDogIX1sA21DI+3Fr6h1ZyJphBOrT83UD6Qr/CHLU949CcMtaPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJhzjv5o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7255606A333
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJhzjv5o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B0E1F000C4;
	Mon, 16 Nov 2026 09:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822724;
	bh=CJALN4cA6kUTsbv8DanRmvpcLs4rgXRb3bG8ynsdVok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJhzjv5oi9HGwVa6a2VjfJTqw5sF3lHHBbgwjvbyE6GLME/DTbbRdqqymZ68ppuFH
	 OI5dvUCjDPOkKQamzF/5CxjRNmFFuTSZKcdnYRu9kMq1abROCocougTJE+xeNhaA9u
	 +v0eKVc95jrgh7Kr7qzoFTRojo/smGXe+l6hx88nv91dhTfzAXkRW5jFDK7o86QzKD
	 PZYPqlkGi4StSu8y+F5W+03n6f8GrYOf0BrnqbF69gKeEKQNAsU1TerY1BdVE7LV9W
	 IQJktNAOQMlsfvSTMNmHQRasD9MNj3N/VSY8A3eMcmrJAs5Q81VZ1pzPn9jd8zFSoz
	 nnE/j9i1NQQsA==
Message-ID: <sashiko-outbox-216655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 3/6] PCI: rockchip-host: Recover downstream
 configuration access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Thompson" <matt@boondocker.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116-rfc-b4-v3-3-0bf052b68f2a@boondocker.io>
References: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
 <20261116-rfc-b4-v3-3-0bf052b68f2a@boondocker.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:52:04 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] PCI: rockchip-host: rockchip_pcie_cfg_load() misses SError on
  Cortex-A72
--

commit f728b48c5b51b4d3ce6fd3c2e945b72fecef9c1b
Author: Matt Thompson <matt@boondocker.io>

PCI: rockchip-host: Recover downstream configuration access

This commit adds arm64 exception-table recovery for downstream PCI
configuration loads and clears the controller's AXI link-down latch before
downstream configuration reads and writes.

Link: https://lore.kernel.org/linux-pci/20261024-rockchip-pcie-resume-v1-2-=
58e54a5cf5f1@iav.lv/

> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/co=
ntroller/pcie-rockchip-host.c
> index 35105c129de1c..64ac6f42532d9 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c

[ ... ]

> @@ -149,16 +153,36 @@ static bool rockchip_pcie_downstream_ready(struct r=
ockchip_pcie *rockchip)
>  	       PCIE_LINK_TRAINING_DONE(rockchip_pcie_read(rockchip, PCIE_CORE_C=
TRL));
>  }
> =20
> +#ifdef CONFIG_ARM64
> +/*
> + * An absent completion can raise a synchronous external abort even when
> + * the link status indicated up immediately before the config transactio=
n.
> + */
> +#define rockchip_pcie_cfg_load(insn, addr, val)			\
> +	({								\
> +		int err =3D 0;					\
> +		asm volatile("1: " #insn " %w0, [%2]\n"			\
> +			     "2:\n"					\
> +			     _ASM_EXTABLE_MMIO_READ_ERR_ZERO(1b, 2b,	\
> +							    %w1, %w0)	\
> +			     : "=3D&r" (val), "+r" (err)			\
> +			     : "r" (addr) : "memory");			\
> +		err;							\
> +	})
> +#endif
> +
>  static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
>  				       struct pci_bus *bus, u32 devfn,
>  				       int where, int size, u32 *val)
>  {
>  	void __iomem *addr;
> +#ifdef CONFIG_ARM64
> +	u32 data;
> +	int err;
> +#endif
> =20
> -	if (!rockchip_pcie_downstream_ready(rockchip)) {
> -		*val =3D ~0U;
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> -	}
> +	if (!rockchip_pcie_downstream_ready(rockchip))
> +		goto absent;
> =20
>  	addr =3D rockchip->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, wher=
e);
> =20
> @@ -174,6 +198,28 @@ static int rockchip_pcie_rd_other_conf(struct rockch=
ip_pcie *rockchip,
>  		rockchip_pcie_cfg_configuration_accesses(rockchip,
>  						AXI_WRAPPER_TYPE1_CFG);
> =20
> +	/* Clear the AXI link-down latch before downstream config traffic. */
> +	rockchip_pcie_write(rockchip, 0, PCIE_CORE_AXI_LINK_DOWN);
> +
> +#ifdef CONFIG_ARM64
> +	if (size =3D=3D 4) {
> +		err =3D rockchip_pcie_cfg_load(ldr, addr, data);
> +		*val =3D le32_to_cpu((__force __le32)data);
> +	} else if (size =3D=3D 2) {
> +		err =3D rockchip_pcie_cfg_load(ldrh, addr, data);
> +		*val =3D le16_to_cpu((__force __le16)data);
> +	} else if (size =3D=3D 1) {
> +		err =3D rockchip_pcie_cfg_load(ldrb, addr, data);
> +		*val =3D data;
> +	} else {
> +		*val =3D 0;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +	if (err)
> +		goto absent;
> +	/* Preserve the I/O read ordering of readl/readw/readb. */
> +	__io_ar(*val);

[Severity: High]
As reported by Igor Velkov on RFC v2 [1], does rockchip_pcie_cfg_load()
still leave Cortex-A72 cores exposed to an unrecoverable SError panic when
a downstream configuration read fails to complete?

This driver targets RK3399, which pairs Cortex-A53 cores with Cortex-A72
cores.  While Cortex-A53 reports AXI slave errors on configuration loads
as synchronous external aborts that _ASM_EXTABLE_MMIO_READ_ERR_ZERO()
catches via fixup_sea_exception(), Cortex-A72 reports them asynchronously
as SError interrupts.  When rockchip_pcie_rd_other_conf() runs on a
Cortex-A72 core and the link drops after rockchip_pcie_downstream_ready()
or fails to return a usable completion, the load instruction retires with
err =3D=3D 0 and the asynchronous SError fires at the barrier in __io_ar(*v=
al),
panicking the system in do_serror().

[1] https://lore.kernel.org/r/20261116-rockchip-host-rfc-v2-test-1@iav.lv

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-rfc-b4-v3-=
0-0bf052b68f2a@boondocker.io?part=3D3
