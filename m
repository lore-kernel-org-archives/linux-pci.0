Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3B3546EB
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549910; cv=none; b=RNEcBloFvgngI1sEDTy+/IO1OHSA8J9B5duQYPKXo/WPgdW7PDWhCeQyDZAqdtlWqdPAs3Hj2MMmqZXTEoc2mABm2B6MsafEbPvEzYEuJftYed2uetuHvP6PhmgN3FJCRQnmZ9ptDwQsWdFI+VZGLbw7rQTPp2gkwRp+Wa8qey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549910; c=relaxed/simple;
	bh=UJeFAtYe10STMVEUUnTDYX1nceflfnaVoDzyQAljQD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZq/cf+OrErM3JVsxGszc/Z9jR3qggVi87MeVUSbIeX6wAg+78/5Zl3LvZswwMrWVpycUYnb4yxwK0O0hyWy9HJ2OrvI/ChbKclAbN4s1t66ZxiIcq/GpGwejGnKzctCjxrqPToebLwUGcPNUyf8BtHmghwHArjTsbyncYf1RYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SbxGv7QK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jceEjYtR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SbxGv7QK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jceEjYtR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684HHjZ6014271
	for <linux-pci@vger.kernel.org>; Fri, 4 Sep 2026 19:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7hAo/EqYLroAjSO5+aPYsTnM
	tvlfMRyQlddXLyFu1Ko=; b=SbxGv7QKbjsKPgYtb9tGitlfMJqSCyPgz6XnE50k
	Jx1SlXROacjX1aaM/uQjqWKUMFQIFMtstBf+G39ctUbofU4RgPvEXj2GUKpIj8pP
	oGUbs/NNZbPTvWTSy0PE2Vdwr0gAKpI0ly/SJiLfq3N33FH5xkhrPib25i6OPteo
	J4G8vH7b839Q4wkJ4ksakCCQKTtt5W7LWj1sA+x+pswlV2V2Zd5d6z3wBmZgs3zI
	b9XaUQG3DOnU05mqPDfl4xh5O923EUxVx7c+9+JzrpmTgJ+bG3qgsGpsRJU0mb3p
	jUGX7xWy713iZt1+Xun2JOfF1VnqruLlc2Jpm7fK4eP1Dw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg00yhbjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 19:25:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9396e0515dcso83210085a.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 12:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788549907; x=1789154707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7hAo/EqYLroAjSO5+aPYsTnMtvlfMRyQlddXLyFu1Ko=;
        b=jceEjYtRyWp/eTMexcFN7T5czLGarRyZiT4QoOuFCNxjseaH7u/n2HZk2GlCQOcmXy
         W0EG+CzPRBzHumrgmwhiuhH1Umm/fuA4iSMYuQqbYiB4LDDW5XmfpPs+2yAD2dvHouam
         kz66VPWbN2DBYDwaaooFx8C6pCVHJdtRExSdK1eXpZa/LQ8B7OHsqplXlH6hatahBVn5
         aKX++MYYoz23gjd5IEULIwqvdd/1X2H5vethuXsXTlLqI6bOyJ24sCjfa2F6l16fnG6D
         0EzhXEj9rbtbtEiler4Pd7nUZBIpKpmJylE/0oF+xzS8M1I8SbJ00OtIJjVqBQnf2NfK
         wPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788549907; x=1789154707;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7hAo/EqYLroAjSO5+aPYsTnMtvlfMRyQlddXLyFu1Ko=;
        b=WQD1IH9l+iXvLWq9LAJu+SpyBJIA+HBu+VajG917TQHEANEWboKy9tqC7OjxpCl8fb
         WomG0p8opKxqTcvc8uXMFEXBJOkMDbpkFIYjrtEFJoDTleXOUxkaiSjDACGaGShYCy3w
         pCYVX+8Bjph+yE6GEng5Yn6+/HfHPC8+FCQcfuaT27o045I2NiBraIbp2ghqIzvHI1Iu
         O6/aeAjgLNremYRHaNd1phkXjWy+ahGJCwvFVDO2vxweByloF0hIiG9AYnhlsbaAgkrm
         4lszlOSm3dcmZmZmehP7Y1Js9Sn6t6XTyuQB8xz3whVKu71spKGuO0lpFKyNGoUxSdk9
         3vQw==
X-Forwarded-Encrypted: i=1; AKwUvBxbAZHa8FUMs6KXhQOMClxPfwkz5C7tDnlFivWanQQsuYrOl8JfWAUDMdkYqCHEjZwgMhdJdK/w3XY=@vger.kernel.org
X-Gm-Message-State: AFuF++m0u1+8Hjolii9wGGP4kKhyRLzvN+xsGPqMnbWM4SNlV4F4T8DU
	B+TNXmdKq0qf9LURFKHy8fCfIWfg8bw9nHfQ30UdsssRl2mZa1odnikDLlsnZCUwlBL79Z1fQUt
	HPHcDyXuUgio82hr7gFAS6jhjBGe8lOwA+kffwrBvrf55gAF/0bQlSnMV1d9c8cQ=
X-Gm-Gg: AYBFou0mxFdIQ43OqnHtGcZiRmO2yNXA9HC0ASdtk/DWMl3OpQlHNcs9w4aLlOq/3is
	i0Q7jWbNLrkOJ0VNwbYNnQZ/wETxsPcuSd67bfNi9pa7+qSv84kUNVqvycBvaXzPHEWiqrh6/yK
	9yb4sd6xpZzjK0HRrT3pftfVpJZF6ughPaq9ps6nXpP/4ckEvIxbLC+FqMrT0Lg1+/1fnyiBN0c
	rQPbxSHpOURm2Rm9W9pb+QNcY9qR569nEK29cVMaCzti1qYrWLxsAo9F0F0ayP1TJkT2tcwIU7g
	CAEZRmJQzZg0C8cZgyhjyJ35VM3VgmY9kYREq3kwQfZPwktw2N2L1+zfhNeHTvK6AQa/j4IGvEE
	XLmdTX/Gh2X5LHw==
X-Received: by 2002:a05:620a:6e46:10b0:939:b99:eec5 with SMTP id af79cd13be357-939803aeed7mr605155085a.1.1788549907466;
        Fri, 04 Sep 2026 12:25:07 -0700 (PDT)
X-Received: by 2002:a05:620a:6e46:10b0:939:b99:eec5 with SMTP id af79cd13be357-939803aeed7mr605112185a.1.1788549902091;
        Fri, 04 Sep 2026 12:25:02 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588392b3esm9823371f8f.12.2026.09.04.12.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:25:00 -0700 (PDT)
Date: Fri, 4 Sep 2026 21:25:00 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/5] PCI/pwrctrl: tc9563: Add GPIO auxiliary device
 support
Message-ID: <apsbDPrVkdoBY7Y1@lore-desk>
References: <20260904-pci-tc9563-aux-v3-0-5b1449d62ba2@oss.qualcomm.com>
 <20260904-pci-tc9563-aux-v3-3-5b1449d62ba2@oss.qualcomm.com>
 <20260904173403.B6A511F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o9YkjD5QX8i91XiB"
Content-Disposition: inline
In-Reply-To: <20260904173403.B6A511F00A3D@smtp.kernel.org>
X-Proofpoint-GUID: S0-4zhxKDhseQd3L6oSpSmTijGVHz67a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE3OCBTYWx0ZWRfX+LYfVmwo36ka
 rf/Dn347O2wren42w/3+MgSxdC7JnqOEpZ94aAVSkZt78RMbPKMDhIYd//9kfEkds9kukKmutY0
 S7CEwt0XIIWi0vg3QJGasNtMlX/3mLwhCOys7m+Wo1hs2koka3Q7d1HrggeqELWYoH1b7x3MT/E
 nO1ITfHQel0p3aGdipvb1bNUP4Q4hLPAcjPVOwjs38YHWLYOXk/CwNgUXXu86q+bHtPgptGqeE5
 3eoqrv57X5DViDk7+7y3lNCTaQ3RahH8M/wtEdmKlhiaDnQmRfFAM8SNZO7KUbjKB/Xr0F9zET4
 7T5xysZVGS4t+3enZIeASZQAvabndCPbLqo7Bco6HQ6Ql8VOu/pCirrLvyvZ10QGydFSN0UFQyl
 kZ3AbCjzSkgGzwsZecvvpiiM83jLEg7624tcGBBwCndIB14rkjIzw/U2lJhXt1Ymug09qrXtPk3
 /L4CWzCpiovDeouJmnw==
X-Proofpoint-ORIG-GUID: S0-4zhxKDhseQd3L6oSpSmTijGVHz67a
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE3OCBTYWx0ZWRfX6vZKrxdBExXc
 EcnQ40R/q/j+AkaEhJXqqCUlSIu1T1NGcaDMU1F0cYpS7GZdBZ2BIfVFPZ+KEC6vtxlUKH/A4dq
 Df7qvjolS4EtjSiD1Tpp4LBtKxdzkdE=
X-Authority-Analysis: v=2.4 cv=eZcNubEH c=1 sm=1 tr=0 ts=6a9b1b14 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=4GtrQM0c771cZ9mzj4cA:9 a=wPNLvfGTeEIA:10
 a=Kg1eTzekZdi3fw47I_EA:9 a=IoWCM6iH3mJn3m4BftBB:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040178

--o9YkjD5QX8i91XiB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>=20
> New issues:
> - [High] The GPIO auxiliary device is unconditionally registered without =
runtime PM synchronization with the parent device, exposing unpowered hardw=
are to I2C accesses.
> - [High] Hardcoded auxiliary device ID causes a sysfs naming collision, b=
reaking support for multiple TC9563 controllers.
>=20
> Pre-existing issues:
> - [High] Inversion of teardown order between the I2C adapter reference an=
d devm-managed resources.
> --
>=20
> commit 4ceb9152c94ce43b58577ae6c0490e74f1fcf9de
> Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> PCI/pwrctrl: tc9563: Add GPIO auxiliary device support
>=20
> The TC9563 embeds a GPIO controller used for per-port reset signals.
> Create an auxiliary device for it so the gpio-tc9563 driver can
> register the GPIO chip and enable DT-based GPIO lookups.
>=20
> > diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwr=
ctrl/pci-pwrctrl-tc9563.c
> > index 59ad219c26c02..2230765950b88 100644
> > --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> > +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> [ ... ]
> > @@ -393,6 +395,69 @@ static int tc9563_pwrctrl_parse_device_dt(struct d=
evice_node *node,
> [ ... ]
> > +static int tc9563_pwrctrl_add_gpio_adev(struct tc9563_pwrctrl *tc9563)
> > +{
> > +	struct device *dev =3D tc9563->pwrctrl.dev;
> > +
> > +	if (!of_property_read_bool(dev->of_node, "gpio-controller") ||
> > +	    !of_property_present(dev->of_node, "#gpio-cells"))
> > +		return 0;
> > +
> > +	return tc9563_pwrctrl_adev_add(dev, TC9563_GPIO_DEV_NAME, 0,
> > +				       dev->of_node, tc9563->regmap);
>                                                                   ^
> [Severity: High]
> Does this hardcoded auxiliary device ID of 0 in
> tc9563_pwrctrl_add_gpio_adev() (in drivers/pci/pwrctrl/pci-pwrctrl-tc9563=
=2Ec)
> cause a sysfs naming collision?
>=20
> If there is more than one TC9563 controller in the system, the first
> will probe and register successfully. When the second probes, won't it
> attempt to register the same name and fail with -EEXIST?

ack, I will fix it in v4.

>=20
> [Severity: High]
> Will unconditionally registering the GPIO auxiliary device here expose
> it to accesses while the parent device is suspended?
>=20
> The PCI subsystem manages the hardware's power state via the pwrctrl
> callbacks, powering it off when the PCI endpoint suspends. However, the
> GPIO auxiliary device remains registered and active without runtime PM
> synchronization.
>=20
> When userspace or another subsystem accesses a GPIO via sysfs or libgpiod
> while the PCI link is suspended, wouldn't the resulting I2C operations
> target an unpowered chip?

I guess this is not a real issue since if pwrctrl driver runs the power_off=
()
callback, it will disable device regulators and so the i2c communications
triggered by gpio read/write will fail returning an error.

>=20
> > +}
> > +
> [ ... ]
> > @@ -596,6 +661,10 @@ static int tc9563_pwrctrl_probe(struct platform_de=
vice *pdev)
> >  	tc9563->pwrctrl.power_on =3D tc9563_pwrctrl_power_on;
> >  	tc9563->pwrctrl.power_off =3D tc9563_pwrctrl_power_off;
> > =20
> > +	ret =3D tc9563_pwrctrl_add_gpio_adev(tc9563);
> > +	if (ret)
> > +		goto remove_i2c;
> > +
>=20
> [Severity: High]
> This is a pre-existing issue, but could dropping the I2C adapter
> reference manually here and in tc9563_pwrctrl_remove() create a
> use-after-free risk during devm teardown?

I guess this can't really occur since i2c_adapter refcount is 2 after probe
(of_get_i2c_adapter_by_node() and devm_i2c_new_dummy_device()). During
teardown phase, the first reference is released (i2c_put_adapter()) but the
second one is released just after aux device is destroyed.

Regards,
Lorenzo

>=20
> The driver acquires the I2C adapter via of_get_i2c_adapter_by_node() in
> tc9563_pwrctrl_probe() (in drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c).
> In the probe error path (and similarly in tc9563_pwrctrl_remove() during
> unbind), i2c_put_adapter() is called manually before the devm teardown
> runs.
>=20
> With this patch adding the auxiliary device via devm, devm will
> unregister the GPIO auxiliary device after the adapter reference is
> dropped. If the GPIO driver performs any I2C transfers during its
> teardown, it will access the I2C adapter after its reference has been
> released.



>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260904-pci-tc9563-=
aux-v3-0-5b1449d62ba2@oss.qualcomm.com?part=3D3

--o9YkjD5QX8i91XiB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapsbDAAKCRA6cBh0uS2t
rBgRAQDrdYdwWgkU4qJVaRd72oCcXjNw9sxHf4gGqOsnSo2ePAEA3jq0eNi/NB2A
9kC7ihHTbyYQzjTu5NvUVm4If9KiHQ4=
=l1yM
-----END PGP SIGNATURE-----

--o9YkjD5QX8i91XiB--
