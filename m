Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254837;
	b=1Aax9aq3rhbfHZulHLL2MWKAPawf4/zp0HuH3YPw+odtno2ebkLYevMO86x35eUHBl9k
	 dxpZc4vReOlFQ1cCSKhxQ7kpn0DB3/MntZLhtmtEXWyYZWEvPqi3X1GiGkaksbTPP1pL0
	 fC39uQ7MO/82NJRv0mj4X4W5KmndScp6P2l7MW/exV3j5PuTDzf0U++LJSeVfkwxHZxX2
	 AcU0aXZLQEL0C+AwMCwjKLUsI8SQ0lKC7LgK2DVb+lZidN/3LGjelA0i9BnXSSsycPp7/
	 0hk2AWINGQ7bDzI7ATEjE6TmGqDVoWVynr9isjWYyob1fCZV0n1UIfa9zI5PfaITskA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254837;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l4x5yMceZnDFpK01o9lI7Qfmpx4YOTKYUMON4WsdsCY=;
	b=WjBESAsvAv0/YcAoyj5PUwjttGw1FScjDBk/KY/bQWlCneSP+YhBp1ZLYuk5LpMb2msI
	 2Wllso7i8V7H99Bydp7doGfuLGItYB3cc+qFF4dUwWRvY4SkGox5arffc2yMHf+UT6Hyz
	 H2dUFvwKQfRFA+zdaMpc0NH2zkoV73tD8eB90T2RDzi+MAglUSdaklacWpW2SdWiQqPwt
	 qaOLVtpU52tOl6yv/aciGUTL9gcMtff/pmHM4FcQT+BjAyWQIQonEkGJhSTpJCXzAO9NY
	 SaJQDrkzl+oJmCidiHjL6h0/UxqwdyAILoyEAVH47ZAuQpTdDTFd4dvn/or1mqZgrrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRzFR+BQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D560A2607
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRzFR+BQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55821F008A4;
	Mon,  9 Nov 2026 20:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254836;
	bh=l4x5yMceZnDFpK01o9lI7Qfmpx4YOTKYUMON4WsdsCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lRzFR+BQtvosZbOf21JJKt4285SYraMuXbzYWT0F5wNoaMNjzeHz9Pizumi6x/C3r
	 Qe/nno2vqh+EaCnht0DBmVKgI7WuCi+ILMTaKGBLPMQD7X/KLOlZ2hfKrn1aI8d5gR
	 OiTLEfZzY1KJMcNfdV36nXILXw2WQAP7mB0eJOUHkuXv5gH3O0sBXHSJ2wowDGx5Ch
	 viFEDs2eyU2Oj82xiO9IfuewLcgyltwYr/h1JNp+7pS//dlGThuz6p8NnNGb/REnp5
	 ZK9JJTRJCkvGQf7DKOo9keMJBIzU+Ry09fcg4a0d3y4mgBsqvTc0kyTBUkNYs+H9tx
	 zymZGTonqQuHw==
Message-ID: <sashiko-outbox-205539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: qcom: Add register dump support for PCIe Link
 Down events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261107-regdump-v3-1-c85648af91ee@oss.qualcomm.com>
References: <20261107-regdump-v3-1-c85648af91ee@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:07:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] PCI: qcom: unlocked register dump in
  qcom_pcie_fill_dump_buf()
- [Medium] PCI: qcom: out-of-bounds PARF reads in
  qcom_pcie_fill_dump_buf()
- [Low] PCI: qcom: PARF_INT_ALL_STATUS cleared before
  qcom_pcie_dump_regs()
--

commit b30e1ed6bb64a53a1b0da2d0c7ce94bc1f80823d
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: qcom: Add register dump support for PCIe Link Down events

This commit dumps key DBI, PARF, and MHI controller registers to dmesg on a
PCIe Link Down interrupt and exposes the same register dump via a per-contr=
oller
"regdump" debugfs file.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index d903f10211c23..147aab6f4155b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
[ ... ]
> @@ -207,11 +220,48 @@
>  #define PERST_DELAY_US				1000
>  #define FLUSH_TIMEOUT_US			100
> =20
> +/* Dump buffer size for the link-down register dump */
> +#define QCOM_PCIE_DUMP_BUF_SIZE			SZ_8K
> +
>  #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
> =20
>  #define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
>  		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_get_link_speed(speed)))
> =20
> +#define QCOM_PCIE_DUMP_REGS_PER_LINE	4
> +
> +static const u32 qcom_pcie_parf_dump_regs[] =3D {
> +	PARF_LTSSM,
> +	PARF_INT_ALL_STATUS,
> +	PARF_SYS_CTRL,
> +};
> +
> +static const u32 qcom_pcie_ext_parf_dump_regs[] =3D {
> +	PARF_PM_STTS,
> +	PARF_PM_STTS_1,
> +	PARF_INT_ALL_STATUS,
> +	PARF_INT_ALL_2_STATUS,
> +	PARF_CLKREQ_OVERRIDE,
> +	PARF_L1SS_SLEEP_MODE_HANDLER_STATUS,
> +	PARF_L1SS_SLEEP_MODE_HANDLER_CFG,
> +	PARF_CORE_ERRORS,
> +	PARF_LINK_DOWN_AXI_ECAM_BLOCK_STATUS,
> +	PARF_STATUS,
> +	PARF_SYS_CTRL,
> +};
[ ... ]
> @@ -1855,6 +1912,260 @@ static int qcom_pcie_set_max_opp(struct device *d=
ev)
>  	return ret;
>  }
[ ... ]
> +	len +=3D scnprintf(buf + len, buf_size - len, "\nPARF registers:\n");
> +	if (pcie->cfg->has_ext_parf_regs)
> +		len +=3D qcom_pcie_dump_reg_table(pcie->parf, qcom_pcie_ext_parf_dump_=
regs,
> +						ARRAY_SIZE(qcom_pcie_ext_parf_dump_regs),
> +						buf + len, buf_size - len);
> +	else
> +		len +=3D qcom_pcie_dump_reg_table(pcie->parf, qcom_pcie_parf_dump_regs,
> +						ARRAY_SIZE(qcom_pcie_parf_dump_regs),
> +						buf + len, buf_size - len);

[Severity: Medium]
Can dumping qcom_pcie_parf_dump_regs[] read past the end of pcie->parf on
cfg_2_1_0 platforms?

qcom_pcie_probe() now registers the "regdump" debugfs file unconditionally =
on
all non-firmware-managed controllers.  On IP v2.1.0 platforms (apq8064 and
ipq8064), has_ext_parf_regs is false and the "parf" MMIO region is only 0x1=
00
bytes:

arch/arm/boot/dts/qcom/qcom-apq8064.dtsi:
			reg =3D <0x1b500000 0x1000>,
			      <0x1b502000 0x80>,
			      <0x1b600000 0x100>,
			      <0x0ff00000 0x100000>;
			reg-names =3D "dbi", "elbi", "parf", "config";

Reading "regdump" on these platforms reads PARF_LTSSM (0x1b0) and
PARF_INT_ALL_STATUS (0x224) beyond the 0x100-byte mapping.  Additionally,
v1.0.0 and v2.1.0 controllers report LTSSM state in ELBI_SYS_STTS rather th=
an
PARF_LTSSM, whereas newer controllers with has_ext_parf_regs set only dump
qcom_pcie_ext_parf_dump_regs[] and omit PARF_LTSSM altogether.

[ ... ]

> +	if (pcie_get_link_speed(pci->max_link_speed) =3D=3D PCIE_SPEED_32_0GT) {
> +		u16 rasdes_cap =3D dw_pcie_find_rasdes_capability(pci);
> +
> +		if (rasdes_cap) {
> +			int num_lanes =3D dw_pcie_link_get_max_link_width(pci);
> +			int lane;
> +
> +			for (lane =3D 0; lane < num_lanes; lane++) {
> +				val =3D dw_pcie_readl_dbi(pci,
> +							rasdes_cap + PCIE_RAS_DES_SD_EQ_CONTROL1);
> +				val &=3D ~PCIE_RAS_DES_SD_EQ_CONTROL1_LANE_SEL;
> +				val |=3D lane & PCIE_RAS_DES_SD_EQ_CONTROL1_LANE_SEL;
> +				dw_pcie_writel_dbi(pci,
> +						   rasdes_cap + PCIE_RAS_DES_SD_EQ_CONTROL1,
> +						   val);
> +
> +				val =3D dw_pcie_readl_dbi(pci,
> +							rasdes_cap + PCIE_RAS_DES_SD_EQ_STATUS2);
> +				len +=3D qcom_pcie_dump_lane_reg_val(buf + len, buf_size - len, &col,
> +							lane,
> +							rasdes_cap + PCIE_RAS_DES_SD_EQ_STATUS2,
> +							val);
> +
> +				val =3D dw_pcie_readl_dbi(pci,
> +							rasdes_cap + PCIE_RAS_DES_SD_EQ_STATUS3);
> +				len +=3D qcom_pcie_dump_lane_reg_val(buf + len, buf_size - len, &col,
> +							lane,
> +							rasdes_cap + PCIE_RAS_DES_SD_EQ_STATUS3,
> +							val);
> +			}
> +		}
> +	}
[ ... ]
> +static int qcom_pcie_regdump_show(struct seq_file *s, void *data)
> +{
> +	struct qcom_pcie *pcie =3D (struct qcom_pcie *)dev_get_drvdata(s->priva=
te);
> +	char *buf;
> +	size_t len;
> +
> +	buf =3D kmalloc(QCOM_PCIE_DUMP_BUF_SIZE, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	len =3D qcom_pcie_fill_dump_buf(pcie, buf, QCOM_PCIE_DUMP_BUF_SIZE);
> +	seq_write(s, buf, len);
> +
> +	kfree(buf);
> +
> +	return 0;
> +}

[Severity: Medium]
Can qcom_pcie_fill_dump_buf() access unclocked MMIO registers if it races w=
ith
qcom_pcie_reset_root_port()?

Neither qcom_pcie_regdump_show() nor qcom_pcie_dump_regs() holds
pcie->reset_lock while calling qcom_pcie_fill_dump_buf():

CPU0                                  CPU1
qcom_pcie_reset_root_port()           qcom_pcie_regdump_show()
  guard(mutex)(&pcie->reset_lock)
  qcom_pcie_host_deinit()
    pcie->cfg->ops->deinit()
      clk_bulk_disable_unprepare()
      regulator_bulk_disable()
                                        qcom_pcie_fill_dump_buf()
                                          dw_pcie_readl_dbi()
                                            <-- unclocked MMIO / SError

While qcom_pcie_reset_root_port() reinitializes the Root Port under
pcie->reset_lock, controller clocks and regulators are disabled and resets =
are
asserted, so concurrent DBI, PARF, or MHI reads and writes from
qcom_pcie_fill_dump_buf() can trigger an immediate bus abort (SError) and
kernel panic.  In addition, on 32 GT/s controllers, concurrent callers of
qcom_pcie_fill_dump_buf() can interleave writes to the banked lane selector
PCIE_RAS_DES_SD_EQ_CONTROL1 and read back PCIE_RAS_DES_SD_EQ_STATUS2/3 for =
the
wrong lane.

Acquiring pcie->reset_lock around the register accesses in both dump paths
would serialize them against Root Port resets and each other.

[ ... ]

> @@ -1983,6 +2297,8 @@ static irqreturn_t qcom_pcie_global_irq_thread(int =
irq, void *data)
>  		qcom_pcie_enable_outbound_blocker(pcie);
>  		mutex_unlock(&pcie->reset_lock);
> =20
> +		qcom_pcie_dump_regs(pcie);
> +
>  		for_each_pci_bridge(port, pp->bridge->bus) {
>  			if (pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
>  				pci_host_handle_link_down(port);

[Severity: Low]
Does qcom_pcie_dump_regs() read PARF_INT_ALL_STATUS after it has already be=
en
cleared?

At the start of qcom_pcie_global_irq_thread(), the handler reads
PARF_INT_ALL_STATUS into status and immediately writes status to
PARF_INT_ALL_CLEAR:

drivers/pci/controller/dwc/pcie-qcom.c:qcom_pcie_global_irq_thread() {
	unsigned long status =3D readl_relaxed(pcie->parf + PARF_INT_ALL_STATUS);

	writel_relaxed(status, pcie->parf + PARF_INT_ALL_CLEAR);
    ...
}

When qcom_pcie_dump_regs() later dumps PARF_INT_ALL_STATUS from
qcom_pcie_parf_dump_regs[] or qcom_pcie_ext_parf_dump_regs[], the interrupt
status bits that triggered the Link Down event have already been cleared in
hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-regdump-v3=
-1-c85648af91ee@oss.qualcomm.com?part=3D1
