Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069DE5540AE
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968308; cv=none; b=cKkpe9Z31bu27zqSzWIP6xXKDgLQ4EWbC1dj5lkgO4zZiTyvCntsIWiwY32QyllzKDX7u6aCkL10vYOvQ1uogW+d14Ts9nwZ94U7tNXIZL4bTOHDaeX2ershPZF2sId4v2rzLfFzghxAfYb2kuooVS5+XPndQppSjun8Fxp9O8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968308; c=relaxed/simple;
	bh=rTjQD0AWXvJKBlAO6G8aQGljW+/ivZFhpjJrPWqIlqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SO3FMBD8aUlUippOpqUQjoumRTw1f83AB+4wBGYAKeCMmHzl/4p5iWKQ5ithpPkis5E6GlNEDwDLrXW0yScDYw1t+HZbY/4Khx8vESj9opLirv7sjFKRU7JoUud9NtkXNKRuTtQu8YsxSlmwcl1XcJbWuOBLnFWU+VYA9nILDPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jQRvUREd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U6BawXdD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jQRvUREd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U6BawXdD"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BoXtW2698601
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 15:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AIrVvX335LUhs5A+Yn7aX2BB
	Y+6j0On/IVOblwEFVk4=; b=jQRvUREdk1xS2Lx4iYJfUiiZn/b0gjtXmFZErRNs
	4TwmeHc58s67Q7do9hwxyDMvcuSNiprHsf556ELDPnKSqHPQzheHWV2UXrlMCMkd
	7CGva87UV5fPGO+64vSFrBeeVwK9aN6sVD1IKOo4xyA1ZyFpo7G/j06S2X+nL9Cu
	EFcJfuiRVBtmxjwdZm/eJha4k7RIZwY8e5eT7j96oiSt4R601+iUaXjkrQeQrQ02
	UI8MvvE5joFfMyIvmakT7LHoHWu09Lnu7xIQonf5V7Il8n5j+dBnnSu6TkX0oX2I
	Au1GoU25EYBTxOWtoBYYMHx4SIcR0+5XGinX4Yyy3Nwspg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk6xh10x2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 15:38:25 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c66c4fd901so6673010e0c.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 08:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788968305; x=1789573105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AIrVvX335LUhs5A+Yn7aX2BBY+6j0On/IVOblwEFVk4=;
        b=U6BawXdDJKkuZiVxWh6Gv8Am2AaphnAxiluJcblGDZOXqCTDyoD1WglGOMQcxJ3je6
         0Vwmez6BAWWlvDTwDqi7rjSbuaEF0A+Qm13yaKwdXdW/s+Yo1k4oyMCIkgMYVv8OEdTZ
         ZC2FsuDjaH+AUQ8561ZOXLb9v4OLaYsggFq5JpfV3puGzymjA2tYWh/XbiAm1rkBU7Cq
         qjIogOm+xG6flLRIEOKVtAgLepCOFbnmCtPn+kA90fg81b7ddjj76/UZcGG3cOmjed89
         cgUkYFfCQMHnNjDkknkQtrVW2481QkLuSsZlzKsBWm5ncD8ucT0Q+S/zk7XrRHfBWMZC
         ZJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788968305; x=1789573105;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AIrVvX335LUhs5A+Yn7aX2BBY+6j0On/IVOblwEFVk4=;
        b=RaVdRQm0devTZnyI5W+z53PrnxtSHRMIMVczc8fvP/qErjV9QB0OVvHtqDUrp9yDfb
         lA42UpX2UZKgIg5/6JL9NJ/Uy+OggmCzSeBCIbGeH08XSqORleT/DdcBRoI4NafAUkyk
         miGP3D3qJd0CUnko/LEIy1MH6PFbZTfH2USZfbTWsTFvXDhACZf1QeNRmARb8XKnc+Xh
         25CEzCofcRjZp/EkGLFzzA8AHZltpy8qqax3EJ3HldjwQxb7sMDDBE/KJo+MEi99DQwf
         5Z8ucRd3LPlFc5f3Uza9Bkw9nixgIuPa5RPFUlmgnIKgHO+AskpTnC/LQWaQhj5xdx5D
         cfyA==
X-Gm-Message-State: AFuF++lrNHItnHnAAJygWcijYCxCwx9APJDv29PbFysqJYXPYe+5DIIA
	RaKnS1PIOSy/EfVN98e/glQOkfT913cRDcFJ/UBfvpiAtBiJoDm6dvISzzh8nODr/I+R6yVEzDq
	rS6MskeElGMpexgYcQ1z6sK6AI8EqIEqWhfgN5ISfEB6wu5MUelO6fHAtUsbn3Uo=
X-Gm-Gg: AYBFou070wvBfddiywZTW0U0hHVIJsa5+iOPM4+meBjNDAxUGYf2GBAZ+qboX2U4ZwD
	9VaPiNIYsJ0Dub281qpxqR6g4+km2+mVcS/rUTVrSv0Ud6HOjV8MM4DfUvsYwxVgK+rrO157mn0
	WRMNRNXMUMfN2ga8e3bUQk/ZhShXH3nOkzA3WmmEVHB6GWtqqbQ8Ni03bVojlHTepC/7sbUkCWp
	adeGILxe3wu24ul1N9VfWWdDsvdJzQOH2v7JuqOodS8E2pjAT+3iFZ6tz4As4f+mHXxyiR2P/ZW
	L2PqlCSEBCfGczV7CS7XmMoC5pSBLdEezgB7JSQBdKHbNH4pu24Xbn3pev9l/1Zetk5jullHlRU
	qWHCNMlrvNUnxHQ==
X-Received: by 2002:a05:6102:80a3:b0:77d:9fe9:1716 with SMTP id ada2fe7eead31-78a4a6e83e9mr21279495137.2.1788968304772;
        Wed, 09 Sep 2026 08:38:24 -0700 (PDT)
X-Received: by 2002:a05:6102:80a3:b0:77d:9fe9:1716 with SMTP id ada2fe7eead31-78a4a6e83e9mr21279354137.2.1788968301950;
        Wed, 09 Sep 2026 08:38:21 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d1fd532dcsm61690985e9.1.2026.09.09.08.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:38:21 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:38:20 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: PCI: toshiba,tc9563: Document
 embedded GPIO controller
Message-ID: <aqF9bHTBBMmRhmn9@lore-desk>
References: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
 <20260909-pci-tc9563-aux-v5-1-c9b33f56c8d3@oss.qualcomm.com>
 <20260909150403.A5C511F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ekoMoU4jMT3u/jKP"
Content-Disposition: inline
In-Reply-To: <20260909150403.A5C511F00A3A@smtp.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3NCBTYWx0ZWRfX2byb/yKuKO0V
 1M0s4BdQXcWyS4UvNmyUZl2yaIXH9rQSmJI21q7Egh9S3D4XJ6q9nACHHFl7ct4JjGvkm7dXSV4
 EJc1HYRwVXDWQOM2bf7g9U6cZpruU8ECDg+FTZ/AHj52zFHMlwluXSZfw/YX83D1RF6zJrCOcxR
 Nxqq76kXfCDi8vTiyz7h4YhtBCb+UlgOS6VUdeUSvLWw3g2gvgso7c5KXVOTBvQxHioh4Sy41KX
 tSp8oGAcSyudD2ja+v4hxjJeK0a5kAz/fjvqzW3wytU6IA1/kwIrc2S+TBhs2gt4Nrm/KU6h/N3
 epwtbN3ulvYq6dmYKfQ8cbG+QNIetflTbGBdXhT0/6gxEUEbPUh/mkKVUv+HrDgla1ThRCxO4ig
 SpOvPM0Q7SGcHTND27cetWgnO3of4aPcNc5fCWK+jCmbpILgJrSAj8hxX5vyyOTpC6SV0Fud32w
 B7HUAhxv7a9TItcKN/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3NCBTYWx0ZWRfX951wk9TEcDH+
 gJNrBiQHwBJIQjQuz01nIzlIu2IT/RmVO9XzX/lxbgyetb3T8gL2BzcZGgzDHnQ/y4WWRWeMfUw
 cUb7scXXwkSkIb6Xji0reZ8DS9JhCUs=
X-Proofpoint-GUID: znghIEIZ_4BYRBe8ry0-8lFPWmibv3yh
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6aa17d71 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=UfEYJwnE5WuK08dpBrEA:9 a=wPNLvfGTeEIA:10
 a=6NAFynQPVF88eBM1lewA:9 a=vmgOmaN-Xu0dpDh8OwbV:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: znghIEIZ_4BYRBe8ry0-8lFPWmibv3yh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090174

--ekoMoU4jMT3u/jKP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Missing Required Properties for new GPIO provider capabilities
> --
>=20
> commit 384b355928f0212bcff0ab6c4447b15d28dc4109
> Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> dt-bindings: PCI: toshiba,tc9563: Document embedded GPIO controller
>=20
> This commit documents the embedded GPIO controller within the TC9563 PCIe
> switch. It exposes the controller by adding the gpio-controller and
> #gpio-cells properties to the switch node, and updates the example to
> demonstrate downstream ports utilizing these lines.
>=20
> > diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml =
b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> > index f084830c6d0cb..c4ebb99f50c37 100644
> > --- a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> > +++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> > @@ -31,6 +31,11 @@ properties:
> >      description:
> >        GPIO controlling the RESX# pin.
> > =20
> > +  gpio-controller: true
> > +
> > +  '#gpio-cells':
> > +    const: 2
> > +
> >    vdd18-supply: true
> > =20
> >    vdd09-supply: true
>=20
> [Severity: Medium]
> Does this binding need to include the newly added GPIO provider capabilit=
ies
> in the required properties list?

In order to introduce any ABI change, we decided to not define 'gpio-contro=
ller'
and '#gpio-cells' properties as required.

Regards,
Lorenzo

>=20
> When hardware gains new provider capabilities, the subsystem guidelines
> stipulate that the corresponding standard properties (gpio-controller and
> #gpio-cells) must be added to the required properties list.
>=20
> Looking at the required properties block further down in this file:
>=20
> Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml:
> required:
>   - resx-gpios
>   - vdd18-supply
>   - vdd09-supply
>   - vddc-supply
>   - vddio1-supply
>   - vddio2-supply
>   - vddio18-supply
>   - i2c-parent
>=20
> If gpio-controller and #gpio-cells are omitted from this list, device tre=
es
> created with the pci1179,0623 compatible string but lacking these propert=
ies
> could silently pass dt_binding_check validation but fail at runtime when
> dependent subsystems attempt to use the GPIO functionality.
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260909-pci-tc9563-=
aux-v5-0-c9b33f56c8d3@oss.qualcomm.com?part=3D1

--ekoMoU4jMT3u/jKP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqF9bAAKCRA6cBh0uS2t
rAobAQCReUFtc/l5ysciS8O9zot3R4eXhbP7ioeZnrBFv/9JbAEApyvA9fzzEwQ4
qK2BvU7gi3eJOwKs6zm0MmTSKXF2eAg=
=OpeS
-----END PGP SIGNATURE-----

--ekoMoU4jMT3u/jKP--
