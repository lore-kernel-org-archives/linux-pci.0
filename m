Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07844A3F1C
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530384; cv=none; b=CNfDXgVA67+6nIvpwfT5+QukoU5vyKILufJ4EJGO6aEInItNGPdhB03j6rvWweEWt/Usi6U7KimHYcQb6D5NBVig3zKcCZV/UJa4fCrdUEcSkUK0U5/9XPwq4JTCIqeMHcC+kE19b8bEAlMKkaDPKoNKTe1Bbm241utaAJSfMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530384; c=relaxed/simple;
	bh=7pCFeF+gU3ZAuL7WEqKYbLZ08IsQzpqKN5xp8+HwQ+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU4jTs3BtFklesjyPPVyzTz7ovadqE2AWM4T1JdTShiaqBqGuwsbvEVug4WbHAH3eBVB4Nyqv5HE8h/Ry6bIbT/piCU2WvCOvxcZvqqDEajDT47CuYVbOlGeL0xgmVhorxok4omlKRINE5feoByW+mHWsyY+bzlMTaHLfrFh64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T51kJztQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E6ZfKMqL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T51kJztQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E6ZfKMqL"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684DgUxh686841
	for <linux-pci@vger.kernel.org>; Fri, 4 Sep 2026 13:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4RMHhI2ZfjbNe1CKw5LT3jL0
	mAhEr4O/HrQd7u9Jkos=; b=T51kJztQDFgdxHc7U69v8uKcn/eLjcz87y31AZPi
	TtmMVaQfCwx8h5XjI4zLzn1l9GnOFahIoXY5XY4b/5t25L63PDshmCPZxEjr6zkp
	0efMrcLrcmIl4R/aL4Jf2ygmQyIklH7MOHL9KK7bUN9e1rU5VGQdFV5602hsLwY+
	/tZMrjTZ+/MoMVTXN/wkjjw4H68Wn2OFkBilA0QFHMdjWO2h/82Zlvw9rBw/8ypI
	3nBcPPgn/g2rqkdkkvrfkZLe5DAroUxixwM0FEjS54SVLxFoXNr5bu28ZanZysms
	gSN8H4Pl9aXR0N0DzOdiXcS6sA0+cd7N5toyiUTVwC293A==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfusx0w1u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 13:59:41 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c405d3e18eso1093850e0c.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788530381; x=1789135181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4RMHhI2ZfjbNe1CKw5LT3jL0mAhEr4O/HrQd7u9Jkos=;
        b=E6ZfKMqLeOXyXzEs2+dD2FjJXCGOk2VJUkNu3DXz2tbdZKOYar7JjOIWrMjcwQwnYK
         9w5sJvR6B8T0EJwMLyN2cHr++eTzS7HsyEaGTtW43jtDRU9iV6lLcsjQBhkUIGe2B6oU
         +v3lNonzgCOz7tY23LrzqRiF18PrsTKT5OnFhc4K4mdvdnGp/GvDxn2HjQeHA6O3piXG
         ray6a/8r1D9FLW8uiMYZenWFaq7aMnTTAJgyGMLMDc+vSl5TxiW7FymaBEoHDsC2LbsE
         a5ZyoYY8kCqCXETNXto1EDkePi1civqhkJgT5SmrDTF2GFbDLb7Ry5EU/dBjKeocOyOA
         ZPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788530381; x=1789135181;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4RMHhI2ZfjbNe1CKw5LT3jL0mAhEr4O/HrQd7u9Jkos=;
        b=lfxjRrEAuPEOb92EOpSGH5KKmEV3cg54DNRmJHJaBsmweU9W8hxoGeaCNtsviQ88Za
         RytS2sx2fyuWFP3TewlD2FwF+A79BFt2GVZ+7U1z4sJZka549UL8KPzxz1W7bmKAOjiC
         d7wr+YvpEuuCNRLWHl7ujl6ZcPp8dlA6VtAwdjuZaxwIA3iJ5rmL6/JmFhr3EHF8P155
         wv2yF0fvOrX/TMIpQmNQnRpxFPHHmHjoVxih0iipGJ7gAKQ+YIdwmkmzQX3aFTSzSpws
         rKHhVCleGIRgH1VOY5pnMoH4J2//z6Zv0t8pBEUw/G2BfXYmhtAOqX0JVr68Ge9SmvgO
         ihDw==
X-Forwarded-Encrypted: i=1; AKwUvByZsKorkHSpbbZlMCZR24xZ7i5eOmLneznmy6XmHbOPTLMJ96Zn5zxG0QEc9/ezxiGSAC1QW5URN0k=@vger.kernel.org
X-Gm-Message-State: AFuF++lGy+8NhVQ2TWkwonNrxnn6XIF+uct79Fkg/hjm9Z7C8SaFqpI3
	UM6SYvMwGTG6wFG5Y83nTn41j13eHS/Pu6B3Uj87zJ0ocUH95ML5lFYkbGZxHDceq/B1RfM1vVa
	MDGicXJMcJ9rL5V+eoxqQljZWJSnuSali0gCpYesvy3IBBIsdcc7d1S6BhIoiWP8=
X-Gm-Gg: AYBFou205zCpZYl8hGrVjQQqqueEmCLutZem62S+rPr2J3vb0knsi5GJOds6pfFSAWJ
	3QphS6sIPV5L/trOeI8lYUT4zKrPLgarFAesqS/G0yQqz5UTcNBN0bgTob6Kin4HqOGSCRp7Ly8
	4lZ3dO1ElURsN5KZ4erNyXwY1LUyuJbIG/a17vbrQ6h+Wf835fBh6oTzhw5VnL8WDkHfmQZduZr
	9QjyY2+wCF9FGyqAvuOiEBG0o96tcLtxQqvOAp4aY25yp2Mvcw7PinfYgATpMm0pg/7GS7Es33A
	0Dqy8AykROQviDMZNb8MlDGQZ6T77+XB1iWgqSPU4rFgMg2mxWq7q2nVipAVtBewOzwtPXQX+a/
	zamSJYox9Y1dtIA==
X-Received: by 2002:a05:6102:b02:b0:786:c86c:4f5e with SMTP id ada2fe7eead31-78a4a6e7023mr2348228137.3.1788530380557;
        Fri, 04 Sep 2026 06:59:40 -0700 (PDT)
X-Received: by 2002:a05:6102:b02:b0:786:c86c:4f5e with SMTP id ada2fe7eead31-78a4a6e7023mr2348208137.3.1788530380019;
        Fri, 04 Sep 2026 06:59:40 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm172877955e9.13.2026.09.04.06.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:59:38 -0700 (PDT)
Date: Fri, 4 Sep 2026 15:59:38 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Walle <mwalle@kernel.org>, Alex Elder <elder@riscstar.com>,
        Daniel Thompson <daniel@riscstar.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/5] PCI/pwrctrl: tc9563: add GPIO auxiliary device
 support
Message-ID: <aprOyou2q0Ckw82m@lore-desk>
References: <20260903-pci-tc9563-aux-v2-3-34c625b542c1@oss.qualcomm.com>
 <20260903211718.GA2247285@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VXoiADj/XRej++0X"
Content-Disposition: inline
In-Reply-To: <20260903211718.GA2247285@bhelgaas>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEyNyBTYWx0ZWRfX70Chvi6J1HGj
 oFSyxF6UZA/alli2pFQPhL82CV64xGLwfTroFJ+y50V/bOxGNDE+Gyb6JU5ZfWRxBJobUnYusMJ
 MAoU7K/e+ynLlgvFcW6UurhPGhfDZDk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEyNyBTYWx0ZWRfX88vrrblTMR2z
 2aSU2ZzTyWUuAJ3d9MufcCnTaQ1JLLV+3HhDNLA4/fcgsfnIJF0csTNCRyAT4K4RJuFv/n/vtd3
 W2LYfZPYNBVIq9EOEqjyJyymTOATNxOVLDQsygglHdvk7SBaJys7JgD5UW5ErRfM6YpcEJwECIM
 hx/ljPR/2Fs/iM5PLSOs4k9itW4VusWnMa5hSCN9iCfiRMHzyVQLfJ4th2kYIsKjHw+PcaplQ1f
 EoCLMFqIQlIcLwYXcG+mFSkGOkf37ErBc37FtLm2z6v7noqjhVTccSHgwKY5946r4iNgc/UxbmF
 V2REleCK5L20qYjJV7grVLIMvq4T7tvRpfQvjY+R8CGQj9+vlkh7QmC0TanohSndSp0iEp3RA6u
 z4RSLYSUrx0poQ7iJwnv2LsfSrKyVw7pXWJzjrKQxDi/tRQHRTvOL/zJ6IxJG3oQFlom9pxoCi3
 uaKv7o6lK2/Fqe2+xGw==
X-Authority-Analysis: v=2.4 cv=NenWEWD4 c=1 sm=1 tr=0 ts=6a9acecd cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=1XWaLZrsAAAA:8 a=h4XguDUzrQ5YFVcWg1QA:9 a=CjuIK1q_8ugA:10
 a=JwWWi_KuMMMZo6bZ-A0A:9 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: XIV1EFotaF3H5QrwzwyHCAo4hMTmM0aO
X-Proofpoint-ORIG-GUID: XIV1EFotaF3H5QrwzwyHCAo4hMTmM0aO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040127

--VXoiADj/XRej++0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Sep 03, 2026 at 09:52:59AM +0200, Lorenzo Bianconi wrote:
> > The TC9563 embeds a GPIO controller used for per-port reset signals.
> > Create an auxiliary device for it so the gpio-tc9563 driver can
> > register the GPIO chip and enable DT-based GPIO lookups. Pass the
> > tc9563 regmap to the auxiliary device as its platform data.
> >=20
> > The downstream port DT parsing loop gains an of_node_is_type() filter
> > to skip non-PCI child nodes such as the GPIO controller node.
>=20
> "Add an of_node_is_type() filter in the downstream port DT parsing
> loop ..." to match the rest.  Or even just "Skip non-PCI nodes such as
> GPIO controller nodes when parsing downstream port DT".

ack, I will fix it in v2.

>=20
> > The pwrctrl driver does not wait for the GPIO chip to be probed. The
> > per-port reset GPIO lookup, returning -EPROBE_DEFER until the chip is
> > registered, is added in the next patch.
> >=20
> > Select AUXILIARY_BUS and GPIO_TC9563 in Kconfig.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> What's the merge strategy?  I guess this depends on the previous
> drivers/gpio patches because they add linux/soc/qcom/tc9563.h, which
> this patch uses, so they all have to go together?

Yes, right. I guess all of the series can go via pci tree if gpio maintaine=
rs
are fine with that.

>=20
> Capitalize "Add GPIO ..." in the subject to match the history, then

ack, I will fix it in v2.

>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> > ---
> >  drivers/pci/pwrctrl/Kconfig              |  1 +
> >  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 80 ++++++++++++++++++++++++=
++++++--
> >  2 files changed, 78 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
> > index 1952ab4f29b6..38aab596aa04 100644
> > --- a/drivers/pci/pwrctrl/Kconfig
> > +++ b/drivers/pci/pwrctrl/Kconfig
> > @@ -29,6 +29,7 @@ config PCI_PWRCTRL_TC9563
> >  	select PCI_PWRCTRL
> >  	default m if ARCH_QCOM
> >  	depends on I2C
> > +	depends on GPIO_TC9563
> >  	select REGMAP_I2C
> >  	help
> >  	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
> > diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwr=
ctrl/pci-pwrctrl-tc9563.c
> > index b0d8912690a2..6df512d78b54 100644
> > --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> > +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> > @@ -4,11 +4,13 @@
> >   */
> > =20
> >  #include <linux/array_size.h>
> > +#include <linux/auxiliary_bus.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/bits.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/gpio/consumer.h>
> > +#include <linux/gpio/driver.h>
> >  #include <linux/i2c.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -20,12 +22,10 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/string.h>
> >  #include <linux/types.h>
> > +#include <linux/soc/qcom/tc9563.h>
>=20
> Alphabetize in with the rest of the #includes.

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> > =20
> >  #include "../pci.h"
> > =20
> > -#define TC9563_GPIO_CONFIG		0x801208
> > -#define TC9563_RESET_GPIO		0x801210
> > -
> >  #define TC9563_PORT_L0S_DELAY		0x82496c
> >  #define TC9563_PORT_L1_DELAY		0x824970
> > =20
> > @@ -393,6 +393,73 @@ static int tc9563_pwrctrl_parse_device_dt(struct d=
evice_node *node,
> >  	return 0;
> >  }
> > =20
> > +static void tc9563_pwrctrl_adev_release(struct device *dev)
> > +{
> > +	struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> > +
> > +	of_node_put(adev->dev.of_node);
> > +	kfree(adev);
> > +}
> > +
> > +static void tc9563_pwrctrl_adev_remove(void *data)
> > +{
> > +	struct auxiliary_device *adev =3D data;
> > +
> > +	auxiliary_device_delete(adev);
> > +	auxiliary_device_uninit(adev);
> > +}
> > +
> > +static int tc9563_pwrctrl_adev_add(struct device *dev, const char *nam=
e,
> > +				   u32 id, struct device_node *of_node,
> > +				   void *priv_data)
> > +{
> > +	struct auxiliary_device *adev;
> > +	int ret;
> > +
> > +	adev =3D kzalloc_obj(*adev);
> > +	if (!adev)
> > +		return -ENOMEM;
> > +
> > +	adev->id =3D id;
> > +	adev->name =3D name;
> > +	adev->dev.parent =3D dev;
> > +	adev->dev.platform_data =3D priv_data;
> > +	adev->dev.release =3D tc9563_pwrctrl_adev_release;
> > +	adev->dev.of_node =3D of_node_get(of_node);
> > +
> > +	ret =3D auxiliary_device_init(adev);
> > +	if (ret) {
> > +		of_node_put(adev->dev.of_node);
> > +		kfree(adev);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D auxiliary_device_add(adev);
> > +	if (ret) {
> > +		auxiliary_device_uninit(adev);
> > +		return ret;
> > +	}
> > +
> > +	return devm_add_action_or_reset(dev, tc9563_pwrctrl_adev_remove, adev=
);
> > +}
> > +
> > +static int tc9563_pwrctrl_add_gpio_adev(struct tc9563_pwrctrl *tc9563)
> > +{
> > +	struct device *dev =3D tc9563->pwrctrl.dev;
> > +	struct fwnode_handle *fwnode;
> > +	int ret;
> > +
> > +	fwnode =3D gpiochip_node_get_first(dev);
> > +	if (!fwnode)
> > +		return 0;
> > +
> > +	ret =3D tc9563_pwrctrl_adev_add(dev, TC9563_GPIO_DEV_NAME, 0,
> > +				      to_of_node(fwnode), tc9563->regmap);
> > +	fwnode_handle_put(fwnode);
> > +
> > +	return ret;
> > +}
> > +
> >  static int tc9563_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
> >  {
> >  	struct tc9563_pwrctrl *tc9563 =3D container_of(pwrctrl,
> > @@ -565,6 +632,9 @@ static int tc9563_pwrctrl_probe(struct platform_dev=
ice *pdev)
> >  	 */
> >  	port =3D TC9563_USP;
> >  	for_each_child_of_node_scoped(node, child) {
> > +		if (!of_node_is_type(child, "pci"))
> > +			continue;
> > +
> >  		if (++port >=3D TC9563_MAX)
> >  			break;
> > =20
> > @@ -596,6 +666,10 @@ static int tc9563_pwrctrl_probe(struct platform_de=
vice *pdev)
> >  	tc9563->pwrctrl.power_on =3D tc9563_pwrctrl_power_on;
> >  	tc9563->pwrctrl.power_off =3D tc9563_pwrctrl_power_off;
> > =20
> > +	ret =3D tc9563_pwrctrl_add_gpio_adev(tc9563);
> > +	if (ret)
> > +		goto remove_i2c;
> > +
> >  	ret =3D devm_pci_pwrctrl_device_set_ready(dev, &tc9563->pwrctrl);
> >  	if (ret)
> >  		goto power_off;
> >=20
> > --=20
> > 2.55.0
> >=20

--VXoiADj/XRej++0X
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaprOygAKCRA6cBh0uS2t
rIY/AP0fU8j6Qo/YEywAp/ZkDDvk9lcJmRDc7tUAlt8NEnh7XAD+Kyg/S1IVYqkZ
DVuwwVt67UDrac7CTDeIMgzWtPusKgQ=
=Zf0R
-----END PGP SIGNATURE-----

--VXoiADj/XRej++0X--
