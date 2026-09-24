Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFABA3D525F;
	Thu, 24 Sep 2026 03:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790220416; cv=none; b=JqHbSCTCQUSoc2GVU5Z8k2RvZG34S10KkVxBz8bjog//vQaU2/24/w+jhKQ4smT+rhpw6L9r7VeAg1Mg6K/apmX2LCYpdK3WPfPNeSzqmo+E1Qru0GrJ2rDMQj70XX3WwRqpNjhEYkFn2JzkXlhV9ILr1GxkQXexsVGD3k5Hb8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790220416; c=relaxed/simple;
	bh=CXlH3SBMSFvkfQPfiQxGklN1CS3iPjfzCSqlZqogoG0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To:References; b=tYL35Fe6UyCRxg+QQGKy/TBx2m5R/5ekep8nx/UGOqMqmCZSjJ6Z9rY0gjuRSn4yly2G1YqTWUN5w81HBNvAVc6D5ydlSWV/yXHq474IS7V+YuhRAfJIp/N2+1rS8n1yrAA87laCIB7En49aToZ5e0/RYLfVE8YsIcRvouA88PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=k5tYNDMa; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="k5tYNDMa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1790220322;
	bh=1OuECCNgnc6CLvCQwxn/XTZt38EU5TJNmlwiHDDUrSc=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=k5tYNDMa42TGq0tgygg8GGiMdTdxYU8sA466MFGd705xPcEFrp2+oMBHWsfORPhxq
	 2blPdjTkyllTDw98VJLpwhR1uZ19JJzzz+oSPypsCIAxEb6+EPPMe7RyWWGHqmq9Hu
	 f4i4RCRM0aRJ8+r+tIg2K5QVlJD6ly6pN7dKZpYs=
X-QQ-mid: zesmtpgz1t1790220314te0b2c6a7
X-QQ-Originating-IP: 4x/4dzp1jA75d0q38ahlTcs6JiNxTb0iijMQfx4Sicc=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Sep 2026 11:25:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11185655890934613812
EX-QQ-RecipientCnt: 41
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=c1efa6dd65a7157a3cf15d727fdb83c765b9167dfac6b27657fb2a2cc304;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 24 Sep 2026 11:25:07 +0800
Message-Id: <DLN84VV7GX6M.9VWJBT3INEFO@linux.spacemit.com>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, "Yixun Lan" <dlan@gentoo.org>, "Longbin Li"
 <looong.bin@gmail.com>, "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v6 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Jingoo Han" <jingoohan1@gmail.com>, "Manivannan Sadhasivam"
 <mani@kernel.org>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Yixun Lan" <dlan@kernel.org>, "Paul Walmsley"
 <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou"
 <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Frank Li"
 <Frank.Li@nxp.com>, "Niklas Cassel" <cassel@kernel.org>, "Sherry Sun"
 <sherry.sun@nxp.com>, "Arnd Bergmann" <arnd@arndb.de>, "Christian Bruel"
 <christian.bruel@foss.st.com>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Vidya Sagar" <vidyas@nvidia.com>, "Xincheng Zhang"
 <zhangxincheng@ultrarisc.com>, "Alex Elder" <elder@riscstar.com>,
 "Siddharth Vadapalli" <s-vadapalli@ti.com>, "Randolph Lin"
 <randolph@andestech.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Inochi Amaoto" <inochiama@gmail.com>,
 "Pengpeng Hou" <pengpeng@iscas.ac.cn>, "Ping-Ke Shih" <pkshih@realtek.com>,
 "Anirudh Srinivasan" <asrinivasan@oss.tenstorrent.com>,
 =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>, "Gustavo Pimentel"
 <gustavo.pimentel@synopsys.com>
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260923015016.64069-7-inochiama@gmail.com>
References: <20260923015016.64069-1-inochiama@gmail.com>
 <20260923015016.64069-7-inochiama@gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mfy7wfw2LMQ46+6RGrspbCzA8lFQzcL2XGXmMkaoq/PagtaPhYQOXPrd
	mMNBAzHqDYKfnBfIQ6mqaX1NIfH8Bg/WRTTZ02neqlGB2dJKfd2PihwjbWb3Q1E/GgGVHD9
	FRL/v7h2+XYrmrn6lH8FR1v5VTMhG/C8hG/plLf1DX3rKapMGmNILTo4Oy1P1B5mP+GACcb
	fO4h/L69z1FdzzfZ+eBopwNanrgAS/Bnblmi+g3/B9uaNE5wxLDWxr4iPtE1xtR8JFRbHu2
	8kg64acCzBStzQTQskdzzgusyTRtnkhP+4w91lw9/9oCjOoiroiTJwIe5Q9s9OCHS2ctqXV
	elwzRd66GVFEKcmptgcqKFBEM7lvTQYN/0t34WJ6AV/LVBES7pHmqykB7fdEyyIc2wgAdel
	EMbSniX0ydkQaR58c1p3DtnPOzFGM5q3AAvY2Unt5K+pxITA3eKTt3mXV1EgmiK86byKSOR
	/bqGPk4jUybPYNbGInAXjRQ7mUciVc4djXHh2FvcC/DM77TY8dOHwn+KO9atp2kcTUrpBZs
	7cpYjoumfPuJnA8c/WoUxkhDwO5hz9RdX97CzlRXvM61SJtCxbOgpQSuNbyE9F/2t48jom6
	3A52kLe10ceNFkTUgWkNtMHLVpZCsuKAk0/ks7xsQkVVitTI3jUzU5kVUy7gpJwR6cvBlPC
	h4i5vhFxNP588Z/eBUNJuOhlVmJ02uTux6/689kESak1pMccSKeqebn2Kz2PbAjiSIy956d
	ktbBAeqPFN/yinQBlSkZXn856e8NvUKMjq+zKjOn6ciItxLGwBd3tnoSkF0N2OKM1/Knm5N
	uWiPe8AZgMVXZhi4dtSODbFXXtyzNrVFH0BwysFiFIxQrjtuBeeY/8MII5qlGYVlrNv2a5M
	et5gPdd766rNYOhICfNGemLdAQlq0/QpuON6PY86EWH15ZD3O5RVsRGB7ICr5t67iNTBCYm
	ZV9lmdO5oze7jwjxEppWImsOAjUES6hN+HdIJHDMpAvawORx4GznuPiBUWEnw0qppHXGyUN
	zxoeoe2SnzOZgl+Nj9+ey6ghkI/1Su7U4t7IUYAPPSRZTE7z4jUGa8a1OOAcHEbajdOe4D2
	FBUs9+kdh0ff0cNWGuU8jo=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

--c1efa6dd65a7157a3cf15d727fdb83c765b9167dfac6b27657fb2a2cc304
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed, Sep 23, 2026 at 09:50:15AM +0800, Inochi Amaoto wrote:
> @@ -315,6 +328,123 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
> +static int k3_pcie_init(struct dw_pcie_rp *pp)
> +{
> [...]
> +failed_phy_power_on:
> +	phy_bulk_exit(k1->phy_count, k1->phys);
> +failed_phy_init:
> +	k1_pcie_disable_resources(k1);
> +failed_resources:
> +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			   PCIE_PERSTN_OUT | PCIE_PERSTN_OE | PCIE_IGNORE_PERSTN,
> +			   PCIE_PERSTN_OUT | PCIE_PERSTN_OE);

Could we keep PERST# asserted on the error path, as k3_pcie_deinit()
does? Setting PCIE_PERSTN_OUT here releases the endpoint from reset
even though initialization has failed and the controller resources
are unavailable.


--=20
Troy Mitchell

--c1efa6dd65a7157a3cf15d727fdb83c765b9167dfac6b27657fb2a2cc304
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCarSYEw0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQvnBMBAOqoYG0RTGya7s/xnZ8oNm2v68GflTIw5APMoNFC
yKH0AQDdN3A8M5rPjea5jEI3eGpn06cdTl/AmbYmgItVl4/mAg==
=B9Ym
-----END PGP SIGNATURE-----

--c1efa6dd65a7157a3cf15d727fdb83c765b9167dfac6b27657fb2a2cc304--
