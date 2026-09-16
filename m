Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5C3515C8;
	Wed, 16 Sep 2026 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529599; cv=none; b=h8dFlhbztEmLgqMLXFzEl/c89ux4yKNMh588hFg6hLy7ujN+ToIqGc3MxrzmbFgTf0Vi7VVw5rO9oHVTETtoNqIU3YmFklDcjhM4ppc21ybWrauYpx1/nJPD8Qmv48vIBpoa3V6/ZcmDoYfpn4bFqxF69cUpxaetGvWFsjXdAWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529599; c=relaxed/simple;
	bh=GWfqXLYYCHe9VaUeBW4xpD6QKWRpX0SDJV1KO3ZQE2g=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 In-Reply-To:References; b=RQt85aIcS9cK3TbCyb79XImJUCcI9ldYh77uVhwDtW/JQIz5dH86vKl4XSqbBE/98u8D+le/iRAoplzwWMu7mIjOrJCIwUVANyE70xoY7qucT/bleZfZ0kCvl3CknhZd6VEt7xbUs3KKMxEKQmDxcV/UaaGzf5bZ0efAGrNYatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=nMEBbLr1; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="nMEBbLr1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1789529552;
	bh=jWMvUUzOrPmrKHCXu38aWsr263gil8jmTfO2LCzoeEQ=;
	h=Mime-Version:Date:Message-Id:To:Subject:From;
	b=nMEBbLr1lSqjjkOjN0GDEIaeo1h8ETT40AX8ohEpqZBYuv9s+ffx1G9ztkbfogXfE
	 f/robQAT/SsLDGVulkgYL2JL2l3YO9UyEJEtSD5PjavW1O07hVSbUWFBPR9b3iOCSU
	 mqiSrZ59eWLCaxzSIdLTgOV5BJskNZQjC4BPu97Q=
X-QQ-mid: esmtpgz12t1789529551tb0ab28aa
X-QQ-Originating-IP: p22YVTVAZzBPPbaX54GpBXgf19M7GP9hjLcXXtG9R94=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 16 Sep 2026 11:32:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8476099243940458162
EX-QQ-RecipientCnt: 41
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=98c1991e3a84cabccc87599576fe5533e92c3b07b62de26e2101639d3652;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 16 Sep 2026 11:32:24 +0800
Message-Id: <DLGFA3K9UNL9.AZCYNV8V9WM6@linux.spacemit.com>
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
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, "Yixun Lan" <dlan@gentoo.org>, "Longbin Li"
 <looong.bin@gmail.com>
Subject: Re: [PATCH v5 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
In-Reply-To: <aqEOHmlKdKqQWYE8@inochi.infowork>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-7-inochiama@gmail.com>
 <DL940SRP94AG.408BKFWHDVY3@linux.spacemit.com>
 <aqEOHmlKdKqQWYE8@inochi.infowork>
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: ORIMa6fDWtM3Y0v8WL6u2LNJS/BHt5m/1yY0dMtl+5CdqT0GPwbFcQnL
	lrK8cTgz9sd9WnMtlYNSRbsc2Kg/R1j7ke86BlWAlZK1Dkk4RQY0FaeTvaOewtsaUFuG/Sz
	0vFBG5f7F1Fa+9FNINBJwpw+B4pknyvzKYTlEYMiJg7/CX6nvqvNK1ca6I/SmuDkrjLrF9Q
	HNS6O6EexiqhUtceX7j8TklJKsN/icmmcGjlyKvBiL2kuowlAVBXqBwXbZDmFVoYP7KrpES
	JBu09bmoVed1CKP1vfcRCa3DV3CnEtGT2YbPL0wGEYqTd6DEzjsXaE+5rokSVY5+vACIoem
	8e5CVBQvuYxjDYTc3GWJU2Fqsk69Mcmb/uQ/zTe5f3iRLLknz9HRNJ+nRPT16ldj0fNGC6c
	oCYMf+Imk/AWD7FRIj+C8UoxAYE0bNlYQpt+DULeSCjwNvaSJs8leTiTTNRUVTH3dWFgI6+
	0kRFTi6Jzb7n5N+H2W9w0FzZ+MY9Eo4pRqqcHWt8/hgDi5dEHfUYhi6/AtvnM0uy2ACVta3
	Fg95AoPsbCpoLyqCAKgJyNi5/FxnnUK/AhHEIX1NNbf4d5fyc8hnnPmZDpILZOLcPFz8eUP
	UMnrhOXXUsr4gq5Jq1ifOy9A2IKgavwilrQnBM7JDEatf5llK5VIfuej9I6IgVTjC1KW7HF
	jsbm5AAUrC2jQc/j5ueRdlNyD4hxuzm+jKG79DkUU+o/UHn2fSgnLffwCt1p+hBOdCHJLDZ
	HT6DCBafxemipoTMLyNJ/+als78ABZoLK/vrTmYscz+Y+AnJxSEgTeHRh9IFBBjpegEnMOU
	2G2KgeLEWZI/vI8JIGY5Zr3dboviDDdGaynqQBy8CcfZ0HccBiURCKyrMVZEcyKf3I+34Kx
	3Y+7TdIyiJi6VltYCdhx3r+8EV/4EEVJbkT05hg/SOaa8sU04BA5fKuLf1S0TwaE+lXW+hm
	8OkCo5+EFFSc9V2vNHlaSEO+MJjua52zCeqOshtufatii0XNxFis0P+sxkGxkyQjH8TFaR3
	6Y7fCMkt8dPrE1Q4G9bzA4r2QWih4btM5SlTm06e9fbNKYNErA0dCl0sb4OFU3nWX18kCjD
	w==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

--98c1991e3a84cabccc87599576fe5533e92c3b07b62de26e2101639d3652
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed, Sep 09, 2026 at 03:51:02PM +0800, Inochi Amaoto wrote:
> [...]
>
> > > +static int k3_pcie_parse_port(struct k1_pcie *k1)
> > > +{
> > > +	u32 status0, status1, status2;
> > > +
> > > +	/* This register require a RAW for cleanup */
> > > +	status0 =3D readl_relaxed(k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> > > +	status1 =3D readl_relaxed(k1->link + INTR_STATUS);
> > > +	status2 =3D readl_relaxed(k1->link + K3_ADDR_INTR_STATUS1);
> > > +
> > > +	writel_relaxed(status0, k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> > > +	writel_relaxed(status1, k1->link + INTR_STATUS);
> > > +	writel_relaxed(status2, k1->link + K3_ADDR_INTR_STATUS1);
> > > +
> > > +	return k1_pcie_parse_port(k1);
> > > +}
> > > +
> >
> > Are these status registers accessible before the controller clocks are =
enabled
> > and resets released? k3_pcie_parse_port() runs before dw_pcie_host_init=
(), which
> > calls k3_pcie_init() to enable those resources.
> >
>
> Yes they can. It is something interesting.
>
> > The SDK uses the same ordering, but I am not sure whether it relies on =
firmware
> > leaving the registers accessible. If so, would it be safer to move this=
 clearing
> > into k3_pcie_init(), after enabling the resources?
> >
>
> In fact, I have no idea about which clock control this MMIO area, if it i=
s dbi
> clock (but I guest it is not), it is kind of weird for this clear and sho=
uld
> move to the init. Do you have some knowledge on this?

I checked with our hardware team. PMU AP and PCIECFG share a system clock
derived from PLL1 /8 or /6.

This clock is already available during early boot, before PCIe controller
initialization. The register accesses in k3_pcie_parse_port() therefore
do not need to wait for k3_pcie_init(). That resolves my concern about
the ordering.

                                            - Troy

--98c1991e3a84cabccc87599576fe5533e92c3b07b62de26e2101639d3652
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCaqoNyA0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQvlUkBANa2w+Z52VSTg6VPhIdnN5L53HC35mTROdqQpRPi
nqx2AP4rMeIb5iWf85lMB8tpSZ2nnHapBGg95rVgzpbj5/TeBg==
=gkSx
-----END PGP SIGNATURE-----

--98c1991e3a84cabccc87599576fe5533e92c3b07b62de26e2101639d3652--
