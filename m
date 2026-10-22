Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689943;
	b=O+e4EhK++JbKcyuIO3LRu/jwOmPkku+9Km74nV17XaWsRNZTU2fbpJHm+FU6R4u0IPVo
	 wB4mlzVku5kBAy4EtmpLxgfxv/S55uz+iyLYyvSWH7N71eGzq4kC4DmOmUNRDErrjWINZ
	 nG2yxUH4tFl/eV6G6mpn7JKL+/QptCbyvyIuoL7lChizkiA97yfp2LO+p9XnHuiQMmjfI
	 WFIMb1i5lAoytpLwvEBspTl8IFJ0tpS76IAnyNL77U98EsDaWsHqlieCTL3v1IS89GmYD
	 2ZHVbJY4qWoMzLJ0NN1wXklBZ3hmJdNUubQ0/NJqZUkP5RhyOMFFPO4OIcaK3KJ2BkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689943;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=z6AktrNRc2FXQ2aAgAi4RpcR1aHmqBhSrhbs1Sqm0ko=;
	b=YErdnU3U+K6HwpKvijt0M5ogBOBSZIuhqgB76E3ts0+vEJc866gFw7lfY+XWy1GtId13
	 lHAfWoWB4VudW8SGz3aBUAAX+X9tc+EwJIOKVAdHbeP6nKssEtRycY1ll7zhxbW/45yug
	 lDlSptqGODNHb00/3Sqz+sV3NS3obapx7upejRCum/4wnpm1VzaL4HaPumxFWZOpOoI/3
	 ovlUZm5ywwADsobaId8a5DYy8ZI/HVg7L2lyQllnuPtlRz6WEPSwr5I4FOxvBsRYDpHS/
	 Z8JeYwD9TMqEQDbJpzrVr3Bq7LA5n5SRbeOqK/yxtkiIdzWIu2f7PtCZoj5V88p1oSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CWVb6AWS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FfzXVGVJ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B3606A31E
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 17:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 239B3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CWVb6AWS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FfzXVGVJ
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEFG833210643
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 17:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=z6AktrNRc2FXQ2aAgAi4RpcR
	1aHmqBhSrhbs1Sqm0ko=; b=CWVb6AWSVmzhe1s1IEiTSHJAt5TbC5Fd9U2+RPS+
	JnmomB6jHHsWXmJce9U0I3dO8SR9Z726fBDPaUo0K6/inE0LsBOvrbEvFJ0IzbFa
	/EASM4VnVPXEoz8jb4SAQcU+Wm0nASBcW8AGtILybFMcHNEUj7Qd1upYAm1+XXc5
	2WUi76Ln4SCO5SgLlaZrK4T/LeaUwihuKYhbaJaCEn8G9UAoZenNIaxdKc7MIdQh
	0+JMTe9QnNbWHYLST+1TfBsZfpbuORYt/uLp00/0JY5A0nIK0fDNaMF2zVKDdHRN
	AZUPMG4x59TUf4Ldrf/nukMKEzn9NePnIalbRpk2YVbPmQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93amrms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 17:25:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e49a1d3b1so490708485a.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792689941; x=1793294741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z6AktrNRc2FXQ2aAgAi4RpcR1aHmqBhSrhbs1Sqm0ko=;
        b=FfzXVGVJHBoXo7g611hnctNhOLrSjfw3dV6SOTnuepYkI8fYIpLC9jfFRLPDsUyu4W
         MPxIGTkxMOR/EhYFrwtRyp/fqsSgLYf3Z3wkkdeAkP12ujqflOdgbOjx7DI6z+6S0+H9
         ZDrN+ajJaxZ/o7J2Z2XlNQQfFP2wikUexoEbOykqlWOA+3ZyczsMbkisEwTkIDB8AbwV
         /pJlUWjCjxX5zVMbFv/FMSB4MrZmqHntoLMXgfpGUrnhDn5/8raBgfNpCj+hurqtgF2d
         i+qHMwMahuXpnBORydOUoXMOhUUzMMaQKgvmnmiLHHnw7NkrHaufIOq1B0d/IJphs+3Z
         taAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792689941; x=1793294741;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z6AktrNRc2FXQ2aAgAi4RpcR1aHmqBhSrhbs1Sqm0ko=;
        b=fqkQzkAABSq7DUYmyFlgH0nZKeeIau+7T+XVfALVMouePh9jS+TD/b8ccDJBevV/pG
         9uha4wybyFczHd4wyshuSXU/SD/s2X7pC6Uw478xiqIm/oUVIPFd+0V5VpHRDE1s3Y5b
         eD3jaZzk84A8mcRurZ3CyFOUosnHZKmXVCVtl1nWzc2cKCXoB5Qp73CDt79o3gjRXlY1
         K4f3BQomDTQNBLacQMmrj5C8NTJN4ER+ouoJBZ+UN3jzflDBSKRXqX6+y8lwVjSuQgfh
         ZiWS/vHe7hnxseaupZpfNKmA163cEEd9vUtJRmUgm6vet6hOQDRapIM3NoHECj87HosB
         dYjQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6zOHgmuCPb4jwDYYuvttSxOMUh1h9Q1MEBIWNH9eU33WVeOaRzgOw2m6ryqFpVggduIZbYYiAoSc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9NAXSAGFOdFIAkBxDvaUtUwQ327Hw03yu6viGwQr5FakEbzYu
	5+5iYzrQDDKvjxLuD99Cmp84Nb9edAtPPEhOdaNCPXfq/5meSNr7leqlTeoSG61gsoOJRHEXlzg
	gKpAI6xOTwGF8P05RQ0aLcVeOaa33Mmk+DZr0cMbabo+o75ikXomHUsucGb2giGQrrNDbePg=
X-Gm-Gg: AYBFou0/0xR4um39cBxQ7Vr7l0Mo7h1JiqMHaV/kt88JZV4EXyg0fv/lw07/aR1rIbY
	pC33bfDxaP8XWRGqDKLT/+tseZ9XC/V0yV2IA4aCVZ4SmYcYEsqj8CgnhFuIlR84k6L3Fav4uTl
	Q8uOM8Iq8UKtUMP2G3C1LdUM2b1FRCHOwOrBz5/S9YrX3xlWG1Uo9ECdM1Rl7TeDAdbcDqsknJf
	qqFa00NAFLBPrpIlT98wi5OZUnjF4cozu7gytUPmm+8s5io1f2EAswaAjcpjw2yBVFgBJAh8nnw
	A1Pj1AOTLaoTUl7E2/DK+dlRooAkRe7+rP+sovot6eBY6xnZuMuG18I/fKXBP1gl2O9U6F2VXUe
	BTI775X0vjIrroQ==
X-Received: by 2002:a05:620a:17a1:b0:93c:80d8:57ec with SMTP id af79cd13be357-93f6f851357mr22883485a.64.1792689941037;
        Thu, 22 Oct 2026 10:25:41 -0700 (PDT)
X-Received: by 2002:a05:620a:17a1:b0:93c:80d8:57ec with SMTP id af79cd13be357-93f6f851357mr22875785a.64.1792689940357;
        Thu, 22 Oct 2026 10:25:40 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254eeef6sm13786270f8f.8.2026.10.22.10.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 10:25:39 -0700 (PDT)
Date: Thu, 22 Oct 2026 19:25:38 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Walle <mwalle@kernel.org>, Alex Elder <elder@riscstar.com>,
        Daniel Thompson <daniel@riscstar.com>,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563
 embedded GPIO controller
Message-ID: <atpHEpzw27_8wu7t@lore-desk>
References: <20261015172620.GA1780580@bhelgaas>
 <20261019220111.GA2271378@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="THddspKwcrT7mb3a"
Content-Disposition: inline
In-Reply-To: <20261019220111.GA2271378@bhelgaas>
X-Proofpoint-GUID: uJKIfihsWs8lFNNN_JRBvJcwmYuFiv1W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2OSBTYWx0ZWRfX+6l3jujAqG3C
 wDt2m7Tyf2ToTiNoESjpWvdi8eQ0E+mUqcsB9CW01dSOtAi2cnL5xeeHHie1MMTpDn9WoAosIlF
 0sQjWaoAehF2CAM7OkWcnY+n0y3zxXE=
X-Proofpoint-ORIG-GUID: uJKIfihsWs8lFNNN_JRBvJcwmYuFiv1W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2OSBTYWx0ZWRfXyMKb+ynHofj4
 vwuFly5uk0Xn3pLnCpv3L+YVPU/ULUbt47Pcp57TS4Qh5U3pOSbUZ4ypqwExtRnMvp8oTDCkckt
 //kq3HG39jtbTJWWdrPU6AavFnBxGqrnZovnplOicIyL/0w3nCNtzGLCMRzDZbt4xoa9EdkMLXr
 l/EF3D9MFiKMM7KSKqMW1RI4oJCpVUBo3bFYPuoiunelRchJ6Agl3LQG58f/sY3Fpq/oeCBjhWB
 IXFaWIt6T5Anq5orW9HRf5fFRTClhkhbox4s9RaiB56nm3NiCup5bL76iJLEmQ2DoS3RR8CbFTg
 0WMPmi/QC2OK8eYlng0Un/NJzr9pgXZ+JozDYnB9+cbyzqDIde8n8FgZpU1iaXCgodq3Z6Ex5P4
 Fcl2weAGga2i8am+/PzA6qLRG49mpAFU4nOVgP1M4ZZ9gk+f8H0Yxd9x3GKlRMWRsxqFXbjcOlE
 x+qUZni30jxNR7G/UuQ==
X-Authority-Analysis: v=2.4 cv=dOszC+Zb c=1 sm=1 tr=0 ts=6ada4716 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=ee_2aqc6AAAA:8 a=tAtCrcrtAcaxr7tUyVkA:9 a=QEXdDO2ut3YA:10
 a=plpxFqqDF8Z-DRInVI0A:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220069

--THddspKwcrT7mb3a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Oct 15, 2026 at 12:26:21PM -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 09, 2026 at 04:55:57PM +0200, Lorenzo Bianconi wrote:
> > > The Toshiba TC9563 PCIe switch embeds a GPIO controller providing 37 =
GPIO
> > > lines. The controller is registered as an auxiliary device by the TC9=
563
> > > power controller driver and accessed through the same i2c device.
> > >=20
> > > Describe the switch node itself as the embedded GPIO controller and us
> > > it to drive the PERST# reset lines of the two external downstream port
> > > (pcie@1,0 and pcie@2,0), as expected by the TC9563 power controller a=
fter
> > > switching to the GPIO descriptor API for per-port resets.
> > >=20
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.co=
m>
> > > Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > > Reviewed-by: Alex Elder <elder@riscstar.com>
> > > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> >=20
> > Bjorn A, I first applied this arch/arm64 DTS patch to the PCI tree
> > along with the rest of this series, but that was a mistake because=20
> > those changes should go through your tree instead.
> >=20
> > I dropped it from pci/pwrctrl.  Do you want to pick it up?
>=20
> Just following up to make sure this DTS patch gets merged somewhere...

Hi Bjorn A,

is this patch supposed to be applied to your tree?

Regards,
Lorenzo

>=20
> > > ---
> > >  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm6=
4/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > index a13315bf0fb0..4da7342ca90d 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > @@ -867,7 +867,7 @@ &pcie1_phy {
> > >  &pcie1_port0 {
> > >  	reset-gpios =3D <&tlmm 2 GPIO_ACTIVE_LOW>;
> > > =20
> > > -	pcie@0,0 {
> > > +	tc9563: pcie@0,0 {
> > >  		compatible =3D "pci1179,0623";
> > >  		reg =3D <0x10000 0x0 0x0 0x0 0x0>;
> > >  		#address-cells =3D <3>;
> > > @@ -891,6 +891,9 @@ pcie@0,0 {
> > >  		pinctrl-0 =3D <&tc9563_resx_n>;
> > >  		pinctrl-names =3D "default";
> > > =20
> > > +		gpio-controller;
> > > +		#gpio-cells =3D <2>;
> > > +
> > >  		pcie1_switch0_dsp1: pcie@1,0 {
> > >  			reg =3D <0x20800 0x0 0x0 0x0 0x0>;
> > >  			#address-cells =3D <3>;
> > > @@ -899,6 +902,7 @@ pcie1_switch0_dsp1: pcie@1,0 {
> > >  			device_type =3D "pci";
> > >  			ranges;
> > >  			bus-range =3D <0x3 0xff>;
> > > +			reset-gpios =3D <&tc9563 2 GPIO_ACTIVE_LOW>;
> > >  		};
> > > =20
> > >  		pcie@2,0 {
> > > @@ -909,6 +913,7 @@ pcie@2,0 {
> > >  			device_type =3D "pci";
> > >  			ranges;
> > >  			bus-range =3D <0x4 0xff>;
> > > +			reset-gpios =3D <&tc9563 3 GPIO_ACTIVE_LOW>;
> > > =20
> > >  			/* Renesas =CE=BCPD720201 PCIe USB3.0 Host Controller */
> > >  			usb-controller@0,0 {
> > >=20
> > > --=20
> > > 2.55.0
> > >=20

--THddspKwcrT7mb3a
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatpHEgAKCRA6cBh0uS2t
rIAcAQD9XMFk9P0Wcr2AnQ1Vo7zfOmzMMBX19nW9jYUu4UxD3wD/b0ihb2VzRcme
Iwdwa1q9ZZQu+2CgZgGygpLAkLGRqQc=
=CJkx
-----END PGP SIGNATURE-----

--THddspKwcrT7mb3a--
