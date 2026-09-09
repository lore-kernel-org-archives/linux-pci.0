Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8456C568FD9
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968546; cv=none; b=iBfvtXVu1WxmcT9MGhGtvFlOTTs2HR5YXAoQBfuGVk62Jg+TCHdFtKRK7mPUfuBJ1PMlsIS0I2H7z9TeBtE5BR2cXwMZITMy9/9M0MMeqHc0qmx+plrcSHMGBkpzC60y0O4nhSlZEQuXXWNVhbXcdJ+WXilUlJV400xyfoGL2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968546; c=relaxed/simple;
	bh=a64GDqnqJM5Gcxb2TXIlPcd98cEhnNLarprMbWo/s1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX0zWyCdmVvulH9t3NoQNcS6PCIbOCm6C+2v6NEkT/vyuL34c+UU7DVGZt75PbVwSMm38AY6deAnI5ZHZ1LwLIZjxARJNePUNl7tW+60/jRxP1xris6MHR5sD06OfLu6TMMsqA36vxwUl6XLWT9TXZN8DTJkg7elxydQG4L4gwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j+9hzrD6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V9uzP8E9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j+9hzrD6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V9uzP8E9"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689Bomk42698832
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 15:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6xzuTsxy6Ya0ZQsG74zmxLXv
	e+omDninFQp6NvwxOLM=; b=j+9hzrD6omM2dcqkJYGS/06kGJdbLNA7gIF03v65
	NJ0Ybgr2c2XeVK6+ahLFI8aKvPcTgKEd4V+uzxUeDDZhIrgcAq/lMuuzBs8Xj/14
	OYppU/shGuPV8l4mYCGdyLl3DcGScFDLbkSWOHK9SrCGnjZV5JMPmaIeMNorp/ue
	hvchFKECrB83rUiLVsHTJ7sMsMSwv46MKHPki5PrCRb8XfjrL1ck3IMgnUkKukuR
	6It1xIHlMQ5uABYr5Pr+f41+gdOkEjrzgOzYFJ6ZdHC6z9RqKDOUtkDoSdG57+Lx
	lEnszGkss+LOkGcwhTUs4tIjzsc+8Ky3BYOMpcDFDDkYig==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk6xh11fr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 15:42:24 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97e768af628so4643169241.3
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788968543; x=1789573343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6xzuTsxy6Ya0ZQsG74zmxLXve+omDninFQp6NvwxOLM=;
        b=V9uzP8E9FHKr9uO/WOUCW2mkoJlDWOLraeghhL/Iuxs7/H/X8W0nN0eZwvQgl/MgfI
         vwjvtC03ORviMZWbxVGMc40yuBkQbw6pvu12ygv411+gQymNvEPjf6tF/h5EWaGrUp/H
         ewVy5oH9MvkcEaI5yeScM+c2P1iRt+ggiREeefMtwNgn6laJQBfIxGUKdF5WVeaw/PHM
         Q0vK0h8aMjghF4TyYJKFmnHHcBlIRrA8Sp4mGeI+MC83tUcSpGUBrANCSGRvhtC1zFkT
         q/RJfsjUSmugKHIZlTg1gY4C7P7Ush7Zc4y4NuY1DRdmK3DVKH0odSfSs0T0YlUGaI3Z
         hOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788968543; x=1789573343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6xzuTsxy6Ya0ZQsG74zmxLXve+omDninFQp6NvwxOLM=;
        b=Obptz40oA8VjVUgFEMxYIefDRLPxGeyeX507B1u+oncDIaYqgTsNcSksaZmxAPtYfi
         AcQbLk3nFI51FfpAEwM83iMkS9JCDiIs7CvDnTn5a318TiaWTk2pBAqIRdy3m5UYWyRG
         fytMvBln4CyzH0XXKgJwk87gAo1gfDh2hhUOJA5MMlpjK0hh5cvIuwe7k8LCRncZeklC
         y7VeoXSO8b02KpyooIN3TWn/CSGs6BZvO5sNC0aCs1Ck+YwpsJZj08sqmbwEGMZxBBJD
         zuaeI7fCghsvieXfzmmhwQreIfAwYZkIHzMgi5ol+/cKIQy+PFbvpDLs5YWN5kb8APlh
         7aLw==
X-Gm-Message-State: AFuF++kXuhnRgnT/pBFkqA63kVuguam7QQOZPcyF8ftVnGZfu1rws7D6
	3CsG0ZvBHEMYHvMHBIxDenA10UwVDsFNEdrw4Yod+hjvMA14iPz/4QC59nF+AsEptz3FuDYFhu7
	jdWgiK/UmagX51bA1p7rbgfHswF1JUgTdB+lW4l+fFsc0I9xtOTg3hsjVfewLgsw=
X-Gm-Gg: AYBFou1Ot0v4vpNPTwfrBRZXa3KLy5JMJazhKLsmwGoqzFbdqPiVMHTJi9LgZtRaWTT
	DqyvFzS0uGPHl9per9bWL2ODYAyFj9RMLMZEGai+nNRythtTzVbibRD5WnmD2/Ig5INh3GHqqHd
	uLIY3Q2ZKGbQkj50qC8q/aoxjWK0oRUOxksDDeM152PC5nn7EVDtGFXj9UBb5kOCCs9AiPe03vq
	D/+NWPlDHLzKWQb/mMJi9+JVgcu0GGje4wB8Rs31WWm2C/39ymH31ZFUCLybVjdC9AjBm8TspA1
	vFkTkgC8OVFW3tukchaIw3PCBXjBNlnhHbAT1zD0oyJIFSZQ2twlFXSOsmFk8qjCv/+lmjXDASg
	RbaenSqyH+49/0A==
X-Received: by 2002:a05:6102:5487:b0:738:1ef6:51b9 with SMTP id ada2fe7eead31-78a4a96d8c3mr16962556137.5.1788968538594;
        Wed, 09 Sep 2026 08:42:18 -0700 (PDT)
X-Received: by 2002:a05:6102:5487:b0:738:1ef6:51b9 with SMTP id ada2fe7eead31-78a4a96d8c3mr16962525137.5.1788968538064;
        Wed, 09 Sep 2026 08:42:18 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm43767403f8f.23.2026.09.09.08.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:42:17 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:42:16 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org
Subject: Re: [PATCH v5 3/5] PCI/pwrctrl: tc9563: Add GPIO auxiliary device
 support
Message-ID: <aqF-WDtoSEbsstzW@lore-desk>
References: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
 <20260909-pci-tc9563-aux-v5-3-c9b33f56c8d3@oss.qualcomm.com>
 <20260909151551.2DA281F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JIEZH1p0DJS2V+dF"
Content-Disposition: inline
In-Reply-To: <20260909151551.2DA281F00A3A@smtp.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3NSBTYWx0ZWRfX5NnTlTS54OuY
 nrJj+sivQ2ZbBeAMjISMSqIR8R9bV7kTYTxTDj6x2FjKSzhcsbJLjBQJlauAFve43eIjRYhBd3x
 YOUhuhcuaF6+joXV6MErXww2rqcoTGlrHhCNcce4/FoIEMf+t6EqEzxosobTI32HqqjZxV4Dm3u
 /h0TInAd6fRi5QFqxbDhXp7kqUoWnw+dVBaMhJevfpUOFuFVXQ47hOBwRGPIj0s1msbmkK0qbJy
 rpLd5o2CMZuYyH82w+XWASAj6vbZya88eA5iHGSDzOZEd4CMRpntVVxkd73m+fpsMFe4FNJVH+t
 qcyiJqTyF+ZM98c6lFVwyaCMkwYaNmHtva8F8UXol+r2TSjh+QNX+0k5+b7isJVAN/AoKXzJ9/j
 ErbHcpGt0+HcyM8qdFMJng7d5dzDiHlXIBSjFsO/jxOjJrZD+EsHx3GFHbzoWMquPJi7a89EZ43
 jONlqPRIA6qW0wghjOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3NSBTYWx0ZWRfX5Xg2vti8T80E
 3vm58Vs1O5PrEK8O4P7tY7QQk5fd+EAj+hEeBMd6B4QeqIegLm0Is/6zBPc8Od60C4ECZi5aGIg
 cJiu0FedGJORhdbZGh6p132ikF5N+hU=
X-Proofpoint-GUID: -oEAX9uwJcGLYQnHtKAHWQQxe-VvugeS
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6aa17e60 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=W8DIBEWQemVwItpymzoA:9 a=wPNLvfGTeEIA:10
 a=bTiFXxHaIdIL6kvNrrEA:9 a=TOPH6uDL9cOC6tEoww4z:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: -oEAX9uwJcGLYQnHtKAHWQQxe-VvugeS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090175

--JIEZH1p0DJS2V+dF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Auxiliary device teardown via devres races with manual power off=
 in remove(), allowing I/O to powered-down hardware.
> - [Low] Missing explicit `select AUXILIARY_BUS` in Kconfig for PCI_PWRCTR=
L_TC9563.
> --
>=20
> commit 6f8a88de67f080d18050c0ce0599dc8854f71eab
> Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> PCI/pwrctrl: tc9563: Add GPIO auxiliary device support
>    =20
> This commit adds an auxiliary device to represent the GPIO controller
> embedded in the TC9563. It passes the regmap via platform data to enable
> the gpio-tc9563 driver to register the GPIO chip.
>=20
> > diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
> > --- a/drivers/pci/pwrctrl/Kconfig
> > +++ b/drivers/pci/pwrctrl/Kconfig
> > @@ -29,6 +29,7 @@ config PCI_PWRCTRL_TC9563
> >  	select PCI_PWRCTRL
> >  	default m if ARCH_QCOM
> >  	depends on I2C
> > +	depends on GPIO_TC9563
> >  	select REGMAP_I2C
>=20
> [Severity: Low]
> Since the driver now directly calls auxiliary bus symbols, should this co=
nfig
> explicitly select AUXILIARY_BUS to prevent potential build failures if
> transitive dependencies change?

AUXILIARY_BUS is selected by GPIO_TC9563

>=20
> > diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwr=
ctrl/pci-pwrctrl-tc9563.c
> > --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> > +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> [ ... ]
> > +static int tc9563_pwrctrl_adev_add(struct device *dev, const char *nam=
e,
> > +				   struct device_node *of_node,
> > +				   void *priv_data)
> > +{
> [ ... ]
> > +	ret =3D auxiliary_device_add(adev);
> > +	if (ret) {
> > +		auxiliary_device_uninit(adev);
> > +		return ret;
> > +	}
> > +
> > +	return devm_add_action_or_reset(dev, tc9563_pwrctrl_adev_remove, adev=
);
> > +}
>=20
> [Severity: High]
> Because the auxiliary device is queued for removal via devres, won't it be
> destroyed after the driver's manual remove function executes?
>=20
> If the hardware is shut down and the adapter reference is dropped in the=
=20
> driver's manual remove path before the devres callbacks run, couldn't this
> allow I/O to powered-down hardware if another process accesses the GPIO
> sysfs interface during this teardown window?

During driver teardown phase, the aux device is destroyed first and then tc=
9563
device is released.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260909-pci-tc9563-=
aux-v5-0-c9b33f56c8d3@oss.qualcomm.com?part=3D3

--JIEZH1p0DJS2V+dF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqF+WAAKCRA6cBh0uS2t
rD1LAP9wbNdf1zUKYUrlR+yjRDTb9C3QrQZjvlyjjMPSUa49NwEAmE9UamdiPov1
1gWNEXt0HAz/GYW+07qobLMLmRHQrgQ=
=nasC
-----END PGP SIGNATURE-----

--JIEZH1p0DJS2V+dF--
