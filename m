Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848882;
	b=eUxhvTpPnXkeOrjwSevEY1HeRGSqesvD2PGEQZmEZl7X0IWx9+V9uJml/5J1ubPwlnlN
	 z27p0OCzo7a1UdYJgnlYPh+crQiHp7qtiyneCvRVvcJskkyCN4BY21mZcUH5V3LaNwx5j
	 nYli57N24gGwGgztWkYdbBNWyv9If1GHnF4WL064gi1n9GaU4ASjxYBXKnvXLLYy0iFN5
	 C/JEWHetsGr9FDnv9zXtf+Rq4nYxj6qGomlPXOzG+24HEspQ1L9m6y0pnX56gTLyemjZR
	 iZoSLjM+FT6R0sBheW60QmLwebCuS0TmiMZ+mqILaizUj9qmNFO3IsDS1H38e2WMY1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848882;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=eiCR7OQYpPnAB0LIBHCUmY4hczAoSVAJP7e9oOsC1mk=;
	b=QdtWsAMo92daqdNkEK78jvAl/1fgInm+le0S08FBPIFDpDuUFcJ+Wrkny6uvNDC5VpX7
	 vhXx/dmA5fSLhAcN7fSN+NZzfwTw3IaOkstkwkicVDyKmRnWEabDQBlxMZHFbwdPphckN
	 PPzUqUenfoE+0a3JSERCifq7d2a4rXAFc7GHyirSwkTv/lqCWKexiEOL+LVid2dP3H6ro
	 WFFGWoqzbH55yiNqXTZYPH6i2tTInCyM9KPaXs+lkKIU/hjgMOpDsbYdqkQvXKPqBi8M+
	 dyGuuO7awYM8/dPXtzRzyT/5E+Ly1YyB6fVVt+zErtq2kDM3G12KHjp4NnuKpkCzWog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=pV8kv3ht;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA903606A329;
	Thu,  5 Nov 2026 03:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA903606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=pV8kv3ht
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1793848779;
	bh=eiCR7OQYpPnAB0LIBHCUmY4hczAoSVAJP7e9oOsC1mk=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=pV8kv3htuM3fk2xOqy8akoSfpO0rVJaNWJwk/eNAD/rSuP8bstO8xlJGT/G20cKM1
	 +5Xtsa54BgyV5lKkJ1MZ5E15A2fPmIhjgX/3yrA8PuMSTrnPKYv4w1mKxG457e8Q6p
	 6zSXFOVZsPQSWlC6CaF1mSTH//UatZ8dlaRWeckM=
X-QQ-mid: esmtpgz11t1793848777t99789d7c
X-QQ-Originating-IP: 7g3Wfm+iHmokJvzPZ9+1FSgY6SMSZ1RqJkpo1rJsV+c=
Received: from localhost ( [8.218.183.135])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Nov 2026 11:19:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3139450742990375673
EX-QQ-RecipientCnt: 18
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 11:19:32 +0800
Message-Id: <DMMYBHEKT16W.33GZJ04KWEPY1@linux.spacemit.com>
Cc: "Rob Herring" <robh@kernel.org>, "Yixun Lan" <dlan@kernel.org>, "Troy
 Mitchell" <troy.mitchell@linux.spacemit.com>, "Ping-Ke Shih"
 <pkshih@realtek.com>, "Anirudh Srinivasan"
 <asrinivasan@oss.tenstorrent.com>, "Alex Elder" <elder@riscstar.com>,
 "Vladimir Oltean" <vladimir.oltean@nxp.com>,
 =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>, "Pengpeng Hou" <pengpeng@iscas.ac.cn>,
 "open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
 "open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: spacemit: Ignore PERST# bit for controllers
From: "Encrow Thorne" <encrow.thorne@linux.spacemit.com>
To: "Ali Tariq" <alitariq45892@gmail.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261104140750.761330-1-alitariq45892@gmail.com>
In-Reply-To: <20261104140750.761330-1-alitariq45892@gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Oe3CFHOZR6DzuKIN8uHjvMBUlgk1xGkGdFZqmpgKu3g0u37UFzc0TIbT
	Y8xq9vGlcQq711GJSoeEdDuALZKuJBFadfBD0r36QoOEiyzhUp3fRmEMHaHEXmyReqqo0/A
	M9uiJK/MdUGO6tM5iJWFTVkyByeTLUwEX83UEiLuK3sce14WXZswrOKVZLcUH5a3ufY/cEm
	upYkUv7hUH2cxyQ0DEF7cnAK/U3+viZqxO6HqHqUB+XMmLklGrCEqWMu1SPGx1QG4uRj7HY
	afr64LaJXbTXcV7VYcoKgQdfrBiYtJaVOiCfx1BjI6t90PHJVPP4vIq72kNgja976fCi3ge
	9IF4RA8sNJphO9MNUKbs18TmEHshcArAgJwEIuTny7qFFSyVV6a8MvxcBjU7IcNVaKv5mtl
	GfDBKRNDTeWFf5mLOL7PU5QmTrLZAyW+CA2qo0hRDvBw1mSXKzNlwWPWLBfP881MBSqOEkZ
	3b0Wk5L2vqlSXMMQ7161Cuvf/mXX7Hbw8gVB+gkof0BjqJfSe19Y1js9RoS5lntIfTdmPfP
	5ix2QPczldSjrrwB1LSICnHq7aPmUwyB6uKEFSqvX+upMff+DZoaQoEqmUkXUq2ZMGTw1T4
	lAC/GHr7+2myJV1xWMyoNZCOPfXEtH+1e4Y1ML6Hdn0JoV12K3lKE8AgDxx0RBgECcdLEe4
	4tzORUrW//kfDfjoFkb9DPLV3ftwgZlfMl9PQxB1GaPGq2ByrUMyTBELaq0qIvTRgpppMbG
	zVz4+h/40TZV9EJwC2mgaPMzAFoeTX8wURiDJPSgQTPfJJJ1Wgf+ebxgkZfwhD9/Ff0cNGU
	ZLxjKBeF3uaIUuppDvHS0sx8w1HZLPM/mwfH8bbWMOl2/hsd/RrJSXG6gfFjMwFBL0fgn8E
	Dug7QPyGFMW/yaN93ILzICTaBbmK+ttblsceFHQ80KDOuS5j3W6mE0dviuYrQ0Ntsb7mWy3
	vbVqnNDV+VOy67STvnpO4FK1teoeSOO7YqPE6TW8cc81rQEZr/dSgPi7hq0WsHGoSIkpdIa
	+vxBnsEkCCHdORoaezMaBJM2ZU2tE0vV3JGxEmrAcgvLKXQb1QLzLGvUt9vvU4UXy0ce+rM
	0NO+KlaL9UDj33hVKhpGE2I0StSNBGF9b6wb8y0iIQT94smKZD+8/M=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On Wed Nov 4, 2026 at 10:07 PM CST, Ali Tariq wrote:

Hi Ali,
> The k1_pcie_init() does not set PCIE_IGNORE_PERSTN bit of the
> control logic register, which causes controller to reset itself once
> PERST# signal is asserted even when acting as host.
> On Orange Pi RV2 (SpacemiT K1), this resets the controller and wipes
> the IDs. k1_pcie_deinit() leaves PERST# asserted, so when k1_pcie_init()
> runs again, its first DBI access hangs the CPU.
>
> Set PCIE_IGNORE_PERSTN bit of the control logic register of APMU
> in k1_pcie_init() before enabling resources so controllers
> dont end up resetting themselves when PERST# signal is asserted.
>
> Fixes: ff64e078e45f ("PCI: spacemit: Add SpacemiT PCIe host driver")
> Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
> ---
> Hang log: https://kernelci.cloud-v.co/scheduler/job/420
> Fixed Log: https://kernelci.cloud-v.co/scheduler/job/430
> ---
>  drivers/pci/controller/dwc/pcie-spacemit-k1.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index 92a71ea90ac3..af6028e8825a 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -47,6 +47,7 @@
> =20
>  #define PCIE_CONTROL_LOGIC			0x0004
>  #define PCIE_SOFT_RESET			BIT(0)
> +#define PCIE_IGNORE_PERSTN		BIT(2)	/* 1: ignore PERST# */
> =20
>  struct k1_pcie {
>  	struct dw_pcie pci;
> @@ -131,11 +132,19 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>  	struct k1_pcie *k1 =3D to_k1_pcie(pci);
>  	u32 reset_ctrl;
> +	u32 ctrl_logic;
>  	u32 val;
>  	int ret;
> =20
>  	k1_pcie_toggle_soft_reset(k1);
> =20
> +	/*
> +	 * Ignore the PERST# signal so the controller does not reset
> +	 * itself when it pulls PERST# low.
> +	 */
> +	ctrl_logic =3D k1->pmu_off + PCIE_CONTROL_LOGIC;
> +	regmap_set_bits(k1->pmu, ctrl_logic, PCIE_IGNORE_PERSTN);
> +
>  	ret =3D k1_pcie_enable_resources(k1);
>  	if (ret)
>  		return ret;

Thanks for investigating this and submitting a fix.

Our testing also confirms that setting PCIE_IGNORE_PERSTN prevents
PERST# from resetting the local RC and resolves the DBI hang.

I will send a v2 of my earlier patch with an updated explanation
and the test results.

Regards,
Encrow Thorne
