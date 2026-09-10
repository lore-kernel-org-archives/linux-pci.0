Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C333B635C;
	Thu, 10 Sep 2026 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033920; cv=none; b=pQBQNYkhK5VimojIVcUDwr6DN0tkWqsYnXk9YKlRmsU60c+GHT+jluR7A0Mnqml9O2FK9vJizxdUsbjhix4dOrif2bWryoTR4Ww8heECYSOwp1r1o3KMn8CDvXLgzAIdiShgtSliPFYyUm4vNq8SYSoEkvkm5g6+eW/2VpgfNxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033920; c=relaxed/simple;
	bh=QbVfbTPjA+0nznXPLlbTkBA4zLLyJWykRgFpQ4H7JiA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tGdCAlgaEls2yC8GCA2iqVMdrs6JsarFWFrZ6of3qtm7vjbWeMiFLfifMDyas/wKQelcRwX0Rq6+tDbKBOokK5k+/z2vfa26QDKtYJg3iqPZqtM/ANKWRhmv3i046xWziVCKpd8wUOIWIp/x3wavmtZVeGCtFfsqcCZB3S11q68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=jlfHboen; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="jlfHboen"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1789033872;
	bh=/jYHDEeDj6mTSil5AM0ztwiU+xkuIqY7l4GjrURkwMI=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=jlfHboencdVUt2pJfQtKOAB+6e5Ua3ZLRzn6l7ZA6XtNAEuWjYBlSCFNydW2y3CQp
	 MztbtfMpdJ0Y5bYXe2KRkYYmqCUCzkmW2mF8Gk+HbznMuV8UAJtYD4jiTLXCtcYMsm
	 6nexYAq5iUD8UPtCIyKxNL97JzAtrEfD6kSshZp4=
X-QQ-mid: esmtpsz17t1789033870t1eda2e6e
X-QQ-Originating-IP: f5kVe9DZlbg/hxKYwteXDSAPYMlVF5XmHtXimArN3mo=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Sep 2026 17:51:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9185703477099524702
EX-QQ-RecipientCnt: 41
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=a3226df17150e624bf4bd069700ca9c5fbc60f85bc86f72fb8331621a4e0;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 10 Sep 2026 17:51:04 +0800
Message-Id: <DLBJKRFHSLZ7.3OKDAR8I7V7JE@linux.spacemit.com>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, "Yixun Lan" <dlan@gentoo.org>, "Longbin Li"
 <looong.bin@gmail.com>
Subject: Re: [PATCH v5 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Inochi Amaoto" <inochiama@gmail.com>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, "Jingoo Han" <jingoohan1@gmail.com>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Yixun Lan" <dlan@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Frank Li"
 <Frank.Li@nxp.com>, "Niklas Cassel" <cassel@kernel.org>, "Sherry Sun"
 <sherry.sun@nxp.com>, "Arnd Bergmann" <arnd@arndb.de>, "Christian Bruel"
 <christian.bruel@foss.st.com>, "Krishna Chaitanya Chundru"
 <krishna.chundru@oss.qualcomm.com>, "Senchuan Zhang"
 <zhangsenchuan@eswincomputing.com>, "Alex Elder" <elder@riscstar.com>,
 "Xincheng Zhang" <zhangxincheng@ultrarisc.com>, "Randolph Lin"
 <randolph@andestech.com>, "Siddharth Vadapalli" <s-vadapalli@ti.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, "Vidya Sagar"
 <vidyas@nvidia.com>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Danilo
 Krummrich" <dakr@kernel.org>,
 =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>, "Pengpeng Hou" <pengpeng@iscas.ac.cn>,
 "Anirudh Srinivasan" <asrinivasan@oss.tenstorrent.com>, "Gustavo Pimentel"
 <gustavo.pimentel@synopsys.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-7-inochiama@gmail.com>
 <DL940SRP94AG.408BKFWHDVY3@linux.spacemit.com>
 <aqEOHmlKdKqQWYE8@inochi.infowork>
In-Reply-To: <aqEOHmlKdKqQWYE8@inochi.infowork>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NECtOrwCNQSlNrBcyK36z3/CtNp6rfTkNd6AVsc2jFgfzBvZfHVH9NJ0
	tiYjkBxkfpKFTJzHTfJihAroeCJZ1zcjHAtMIU+ks+PyPM3CWcnASERQP4SDwDhuJPqbS0x
	84thvWVVGmdWE9T1d+FL2g+/bwEsUBZVJQM42PRei5/zEhj8KlyJqoU/mJdXTqp26uyqUQX
	k9VklKaoaxINtGYq5StIfQOQpumV0Q0eGPOSuAMR+9QjJD8lz96vOyJxr67Tvi081+mJJDh
	miOeCXvPZp/diUzE6FitcpeRq5iSxvXT2TbDJXY9fDewkgU15GD+aVEJSaN96nSvzSafv/8
	2yXhzIZalpGz3sCEEz0Hv36S0K/8xtwuZXggDonkDcLh66ryP3UCkHSdR6Q+Hm0ISVdPXaC
	obrkVMBnJMiD22xmM3fr038nqFJf6seigS9xZF4rLxZ+y7GGsQAAbw9pm2C0z4Tz733qFqR
	ApvYcnGwlhpWckFfMDFH9fwSuk3y63i4crj+bNsFISe9CgpKFeHq9bbBg8WHj1l1ckpuZK3
	R6nPSnjmC7gvvQCnXkyI1Vl1IN5/5PR0XcHBAHwFsYTPXE7c/bOAD4ncMguxkMhth3J5gwh
	AcuejJqhKwYGOfLUUibBwVQDCcUf4lYzLulk17C8CmGPL26Pgpq0RTyVsg87W1GMxOfRNOg
	cZjy8po3lITvvrDhhptCZF2WLzlytlz+n+7QYyqqYtRIcoY3owprlPw3bX784hdIrHmeAl1
	6b+r38UWALar1r2M93cpO2ANYrX4wpZX3PjwXOoXvXLllFLXzr1YIjr+y25m9XPqZcR5QVE
	WmStf+0ALueHyJg7erXTEX7iyOkUTQlDMPdOeTgZ/y0+1U8vxjV9UVEnRdGJdbudsJCAncJ
	BghkTcga83eimeRpYwXmnUiNPuSMc0IRRnA+Oy7EB51F33VoLkCwjSrBmzWHRDL2zlrAFAg
	kUpSE0VJ8xhbM9Wn5hwbtq8PJjmgQBsXuHmglWCaXuTbHIwzcRVEViqHKRRg3eSneSNULhJ
	2P6P4omiddX/29PP7nU4KxW0w09NHlMC0xYzcfagCWVweQ4FcEI9n5qENpYVhxS5NlbnUno
	1xBWH0OGS0DMvZysNHNg/V9FsrCHwVb5g==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

--a3226df17150e624bf4bd069700ca9c5fbc60f85bc86f72fb8331621a4e0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Sep 9, 2026 at 3:51 PM +08, Inochi Amaoto wrote:
> On Mon, Sep 07, 2026 at 09:14:23PM +0800, Troy Mitchell wrote:
>> On Mon, Sep 7, 2026 at 07:26:05PM +0800, Inochi Amaoto wrote:
>> > [...]
>> >
>> > @@ -303,6 +316,116 @@ static int k1_pcie_parse_port(struct k1_pcie *k1=
)
>> > [...]
>> >
>> > +static int k3_pcie_init(struct dw_pcie_rp *pp)
>> > +{
>> > +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>> > +	struct k1_pcie *k1 =3D to_k1_pcie(pci);
>> > +	u32 reset_ctrl =3D k1->pmu_off + PCIE_CLK_RESET_CONTROL;
>> > +	u32 val;
>> > +	int ret;
>> > +
>> > +	regmap_clear_bits(k1->pmu, reset_ctrl, LTSSM_EN);
>> > +
>> > +	k1_pcie_toggle_soft_reset(k1);
>> > +
>> > +	/* K3: Set IGNORE_PERSTN and drive PERSTN_OE high (assert reset) */
>> > +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
>> > +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE | PCIE_PERSTN_OUT,
>> > +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE);
>> > +
>> > +	ret =3D k1_pcie_enable_resources(k1);
>> > +	if (ret)
>> > +		goto failed_resources;
>> > +
>> > +	regmap_set_bits(k1->pmu, reset_ctrl, PCIE_AUX_PWR_DET);
>> > +	regmap_clear_bits(k1->pmu, reset_ctrl, APP_HOLD_PHY_RST);
>> > +
>> > +	ret =3D phy_bulk_init(k1->phy_count, k1->phys);
>> > +	if (ret)
>> > +		goto failed_phy;
>> > +
>> > +	msleep(PCIE_T_PVPERL_MS);
>> > +
>> > +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
>> > +			PCIE_PERSTN_OUT | PCIE_PERSTN_OE);
>> > +
>>=20
>> Should we use pci->pe_rst when reset-gpios is provided, and keep the PMU=
 path as
>> a fallback? The SDK handles both cases. The DWC core requests that GPIO =
with
>> GPIOD_OUT_HIGH, but this path only releases PERST# through the PMU, so a=
n
>> endpoint using the GPIO would remain in reset.
>>=20
>
> I do not think this should be included in this version. I found PICO-ITX
> has no reset gpio support. This means I can not test this feature.
>
> I suggest adding this function when there is a board using this function.
Agreed, we can defer GPIO reset support until a board needs it and
we can test it. I checked again, and the SDK only added this support
recently. It provides GPIO-controlled PERST# as an alternative to
the native PERST# control through the PMU.
>
>> > [...]
>> >
>> > +	/* Finally, as a workaround, disable ASPM L1 */
>> > +	k1_pcie_disable_aspm_l1(k1);
>> > +
>> > +	return 0;
>> > +
>>=20
>> Would we also need to configure IOMMU bypass during initialization? The =
SDK sets
>> the PCIe A/B/C bypass bits in PMUA_PCIE_SUBSYS_MGMT when there is no usa=
ble
>> iommu-map. The proposed K3 PCIe DTS has no iommu-map, and I could not fi=
nd the
>> corresponding bypass setup in this series.
>>=20
>> Is bypass already guaranteed by firmware or the reset state, or should t=
he
>> driver set it here? My concern is that enumeration could succeed while e=
ndpoint
>> DMA still goes through an unconfigured IOMMU.
>>=20
>
> I think the firmware should mark it bypassed as the default, at least
> I have notice this behavior, but I am not sure whether it is the builtin
> firmware or the uboot do this trick.
I checked the register specification. The PCIe A/B/C IOMMU bypass
bits reset to 1, so bypass is the hardware reset default and does
not require firmware to enable it. That resolves my concern.

>
>> > [...]
>> >
>> > +static int k3_pcie_parse_port(struct k1_pcie *k1)
>> > +{
>> > +	u32 status0, status1, status2;
>> > +
>> > +	/* This register require a RAW for cleanup */
>> > +	status0 =3D readl_relaxed(k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
>> > +	status1 =3D readl_relaxed(k1->link + INTR_STATUS);
>> > +	status2 =3D readl_relaxed(k1->link + K3_ADDR_INTR_STATUS1);
>> > +
>> > +	writel_relaxed(status0, k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
>> > +	writel_relaxed(status1, k1->link + INTR_STATUS);
>> > +	writel_relaxed(status2, k1->link + K3_ADDR_INTR_STATUS1);
>> > +
>> > +	return k1_pcie_parse_port(k1);
>> > +}
>> > +
>>=20
>> Are these status registers accessible before the controller clocks are e=
nabled
>> and resets released? k3_pcie_parse_port() runs before dw_pcie_host_init(=
), which
>> calls k3_pcie_init() to enable those resources.
>>=20
>
> Yes they can. It is something interesting.
>
>> The SDK uses the same ordering, but I am not sure whether it relies on f=
irmware
>> leaving the registers accessible. If so, would it be safer to move this =
clearing
>> into k3_pcie_init(), after enabling the resources?
>>=20
>
> In fact, I have no idea about which clock control this MMIO area, if it i=
s dbi
> clock (but I guest it is not), it is kind of weird for this clear and sho=
uld
> move to the init. Do you have some knowledge on this?
I have not confirmed which clock controls this MMIO region yet.
I have asked our clock team about its clock and reset dependencies
and whether access before resource initialization is guaranteed.
I will follow up once I have clarification.

>
> Regards,
> Inochi


--=20
Troy Mitchell


--a3226df17150e624bf4bd069700ca9c5fbc60f85bc86f72fb8331621a4e0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCaqJ9iA0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQvIEkBAI5lOSUmTC1KRnfbtQZq22dzmqYH4si4e04iOSyS
qA0iAP4h5FpgcgN1hdhSj0naM37Eexy5IDGOkDub+ZEMcldRBQ==
=7iXk
-----END PGP SIGNATURE-----

--a3226df17150e624bf4bd069700ca9c5fbc60f85bc86f72fb8331621a4e0--
