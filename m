Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A051C343
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546776; cv=none; b=eIpXtcQeP7SMNndT6VfJ+kLrKXB+EbE0kXi41BC0sG+s9/sXeQt60D0FsaE5nvaJ4u/AYjOebXvGTWO9k1dm1paGI3HlTqZcK7l+9435RCRYDrtbd4kdPYCPHCMLmq02oN4/+h6V/9bHHjt6RA9ZgqEAksoXm+fk2CZ64plNx0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546776; c=relaxed/simple;
	bh=j+1ZOes4kWP7FAkpcojmQmiuJSCqnncwy86K3mTRxl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7/9sBUVEcMh8hLPLTFfWsiuq7B1w0rsIEqJ/3gdoJV0OBoBYcCKAkNfWi4VsB5jbhB129v+6G3yHQ4CK4Zt0IngUb7M2ftv/nEIN/+b+9drk4sZ8wzlmgyDYWCDmibFT+6f7PyQnXsE1jTw84x6x8J2wZzJxfsbF1ZhUGakYbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ULmMrf4r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jtb96aRE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULmMrf4r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jtb96aRE"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684HI0sM548618
	for <linux-pci@vger.kernel.org>; Fri, 4 Sep 2026 18:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Bvne7HECiZvG5t61nBxUCDlI
	c5mqbwFgVydcIZZ6aPE=; b=ULmMrf4rdQk4fHXC5NzSRck1gg0RthPnycO4EyKl
	6cQm7QUB5bvsd5eNmLl8cI9W38NnaDu0UB+qwVUEQsuDhE99yzOTl+WJfXLAPqao
	eWlZAxj6sLg1EghOi/+SJQYSYCt66uRnYrorFcW7qBl+in5m4DkMuLXAdvoEDCeZ
	FG/qLHDW1NM0zSqXpdjyx3EotyD7vqsH2H4mTdzyf1Z4wPnYFroiIHLe+LkAVLXC
	8xFCL/JSdtz1W+TL2z8pEcw31DNHdpZz+WB+p+cFgFSfvo7d1apP/69ZvvIX6q7a
	Kfd5NVDbOtR+mRqubut8q0m7LiOq5b5guRFl6Xg4DAAw5w==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg0121ey5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 18:32:53 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9808f4a12d5so137475241.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788546773; x=1789151573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bvne7HECiZvG5t61nBxUCDlIc5mqbwFgVydcIZZ6aPE=;
        b=Jtb96aREDnvVuNNiYlLd8vDhuwj+YbfxpZ8vR7ca3rkCTMLlDmKVAskPgSh95Ul0dX
         0LYS0FkagYG5w+47yMPOZUsjXjS2xq6xNGixWyik2MRtOlzj+ZNQ+m5FI/Yu0Bxc5bSG
         l/IWMxGmPgQTLIbNPrSUtPrJVwxGd+s6TuMaST6INzBoMECNLhPA6Vxxo2jjpYPi7tte
         3lCiOvAkjhvoZQ2g7e5E6HdR6cQm23C9vJMtJTAI93p0T/im6+6dei4bPEfRM/uvtsw+
         TyTkEH0+hSH5Hv9qmp3ksnl8guImNM1580PZ/lNVolCs4xqSR3PkgsfP1lB3W6Q6ZPEx
         g7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788546773; x=1789151573;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bvne7HECiZvG5t61nBxUCDlIc5mqbwFgVydcIZZ6aPE=;
        b=nWh2o4kVtJ6z7ygmZ1AClG37CLcrra/WmFg+0s57igVZ5UxRku1cqzr6WZ8BRS9nz/
         8Jh/15mHaRr7soK9FZT5jDXAKa1wJxkG2DDYwwVWcBuSgdbV8aHaf0SQZ6U2+PPc4Vtp
         rVSPU+DHiZ1SHxsA5c7q7h/wb91PYnimi3mTY8/G2vpZCCPDzUpNGfdUTONvUpr7R947
         S49eCmOM/x7QLJ+cIvgSxeSZtDwmZ6VPotVbr9gfSuauykOCG1+9H5jqFkEgo6/TDQqb
         rO4+QQsSEs4SeOFu7kNAux1GwFv80mP1RrrNIguf4qPg1WhUqQoX9/g4dV1Xec2opUZ9
         WbCw==
X-Forwarded-Encrypted: i=1; AKwUvBwj0R4ygiK+/Cd6oyrkQ5TRX4kc4GtAX76tgqRPEOGMhygzxp+1tB4UzJwJStyQIvUBMXv8h2x1hRE=@vger.kernel.org
X-Gm-Message-State: AFuF++k8FQhtpyYChKig+jZnrYYp7gPZmKeUjv/wyEjj0qlDjaJpzf1O
	dZQgIQx04zVDQys3m6mivUl4Ymay6ukbzxXbwWL0YplSBhF+U4Lb0ugJgdEHSlBpu8y/OEyGfuu
	bfiK21P+lUZYmKi8OQafXaSyrwsnu/GKoVr7/3ruQ3wN0/Hy0GPizzXmDuCCNaN0=
X-Gm-Gg: AYBFou2iQCk87z14ghhvrj9CpvUBhy03lbPGRrWU894yfKS5yWe67SvwRl4BUsolgvu
	BN4EQgah9hDCnaA6/X00AHqKu1+VmJcNd/g+igmyAgxGBNYVLDFUkrhPe1IKb61CvPNNhiHHbwn
	7f1VHjj3Oa0y9LwI9B4l8fafetqe9hyiOa2953JY2yH07OTV8xOc5/wtNDawo/06w7rN9HXxiy3
	9+dF7FSDE/Hc5ZhqIuks7iLm9zcc25bBB697GN0KpjeC5FDGbX9bZftuSj935oRGH1m/18UAH6f
	fRnMLR9VQMudFqfNwMISI3ByvhzWuntw2fArCs16Eb5HWIiBJRbLTFiGPIxwve3p2FEe/nAgT5y
	be5Z/k7CcZ3Eh4Q==
X-Received: by 2002:a05:6102:2907:b0:778:9033:e337 with SMTP id ada2fe7eead31-78a4a7186d7mr2482588137.7.1788546772887;
        Fri, 04 Sep 2026 11:32:52 -0700 (PDT)
X-Received: by 2002:a05:6102:2907:b0:778:9033:e337 with SMTP id ada2fe7eead31-78a4a7186d7mr2482567137.7.1788546772398;
        Fri, 04 Sep 2026 11:32:52 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm168209295e9.3.2026.09.04.11.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 11:32:50 -0700 (PDT)
Date: Fri, 4 Sep 2026 20:32:49 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: PCI: toshiba,tc9563: Document
 embedded GPIO controller
Message-ID: <apsO0dPYIiCujiM5@lore-desk>
References: <20260904-pci-tc9563-aux-v3-0-5b1449d62ba2@oss.qualcomm.com>
 <20260904-pci-tc9563-aux-v3-1-5b1449d62ba2@oss.qualcomm.com>
 <20260904172114.2CF8F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ewcNLQpfoQlfLSzs"
Content-Disposition: inline
In-Reply-To: <20260904172114.2CF8F1F00A3D@smtp.kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE2OSBTYWx0ZWRfXwNQHhana4Ztf
 tcU6UPz3c80z9AMzSnI/Q+aLaRJTdpmvgPpkqeqgRok1mN1/AoRpEGnT2E6R3RH5UuhSf+hqDGi
 palxM3OvaFbg9st1kYWeA7nnUrKKoas=
X-Proofpoint-GUID: DUrw192neDJunl25kpazuIhdPIf7940F
X-Authority-Analysis: v=2.4 cv=LreiDHdc c=1 sm=1 tr=0 ts=6a9b0ed5 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=86Be0pIABdjnZPeXsFYA:9 a=wPNLvfGTeEIA:10
 a=kRZTEHTrMTxrHKFV5dYA:9 a=TD8TdBvy0hsOASGTdmB-:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: DUrw192neDJunl25kpazuIhdPIf7940F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE2OSBTYWx0ZWRfX7aEljz2bIjv2
 hXAvF+01j/Xxwu6mxZtrvJ1tLIz5m/PD13Er08lMMfxILS/0kORjpBuVysdcylhsj+BphuQiRkw
 3LVw+ew6IjTc3UWDoMQvpxHQUjL/83fwZPqjrgoNiJvvrjt+j5XwpQGWHydzwJnZBqlCNvhAFsp
 8h0ux4s/92ZSqxXyqNsZxAhPteBMZblbdacozzgmhPkC3oeviWPIWnSDXlHm49bUgcEaY9YZ5ni
 LpR+ohJp0Rw3lBueFOkLDc2GbylAgo93se82vr2jj0DJ1oSaBo2VdwE+5ocERKARWHgyHKHI3/J
 7oce1XWR82t5Wu3Nbaas8mvO+/CdzRECVEeakhQs1C3Njf29WA9EoWNRhidOtHsOE1U3uB3SKkU
 jUf7iPFPO4zLHmAD0wUl+wU3dk3u2k8GAtHgW/bwS+vwjwaWRHYTRyNw2Imbb2OYw8HpULHcPmO
 ILX16mXiTG+RBMgZrTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040169

--ewcNLQpfoQlfLSzs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The 'gpio-controller' and '#gpio-cells' properties were added =
to the binding to document GPIO provider capabilities, but were not added t=
o the 'required' list.
> --
>=20
> commit 167159eda5a6932cbffa6730117f8dd7e23b2970
> Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> dt-bindings: PCI: toshiba,tc9563: Document embedded GPIO controller
>=20
> This commit documents the embedded GPIO controller within the TC9563 PCIe
> switch. It adds gpio-controller and #gpio-cells properties to the device
> tree binding, along with the reset-gpios property for the downstream port.
>=20
> > diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml =
b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> > index f084830c6d0cb..c4cd162cb084b 100644
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
>=20
> [Severity: Medium]
> Should gpio-controller and #gpio-cells be added to the required list?
>=20
> Looking at the required list in
> Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml around line 108,
> these newly added GPIO provider capabilities are missing:
>=20
> required:
>   - resx-gpios
>   - vdd18-supply
>   - vdd09-supply
>   - vddc-supply
>=20
> Without being added to the required list, device trees with incomplete
> configurations (missing the newly added GPIO controller properties) will
> silently pass schema validation when running dt_binding_check or dtbs_che=
ck.

ack, I will fix it in v4.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260904-pci-tc9563-=
aux-v3-0-5b1449d62ba2@oss.qualcomm.com?part=3D1

--ewcNLQpfoQlfLSzs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapsO0QAKCRA6cBh0uS2t
rAIPAP9ldnovE+inPbu1tazRg/kLnB87xWlHIQ/I9Tf1dz1JlgEAo4dME/cIbVWt
XSEfFwuOSDseGq//+7sOhx6dxC3CvQc=
=7vvW
-----END PGP SIGNATURE-----

--ewcNLQpfoQlfLSzs--
