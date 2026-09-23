Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001457C71C
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195366; cv=none; b=dCB3sRydNiSSqTrXGVYUbaWSacOcJUl8AtIg3XeEtMBD+yjlRvM8BncdCxdRJb9DcwarZH4YpjMZBE3lzvj5PmJV6ps0deMhjR9eNbDuTlLeeRxMnQWqqSEwMiwSz9+2rj8Ijw0OSCP2RnT7VmhOxBPp0J9+9JVEEoIKeHg9Mes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195366; c=relaxed/simple;
	bh=DVmzVfeaZlZ2h7sO+MtrgVWEGeTM3AcsBlWGq/2QyLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nB73l0dPg9JWKVsmDV5gWPL9MnN5TXIb/BmdD+X244hJSQUJCVXWhJPMG9rkAIsBr3yI3MH4EiUtlWzqiipKmjhPOf4ZuqCk/k5xvEB0zgfNG0zZwjn6bMOGm1z6l1pmVkNjlZS1otnjgM2tsFCyoAuGIAd/DxmiwIYLprv7S8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C5UP1ywy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZA+DWE+F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C5UP1ywy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZA+DWE+F"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NJkkJn4092146
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 20:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ktq8FOEiqAS2HqdwxrfUyjEp
	XI5UTr/iZCY9k3s5bK8=; b=C5UP1ywyVrr67lED7xiUGlA7iWZBSWr5X45i6FXl
	ggzSSIx4KP7fDELiL7xS9mDpdREPRSIC9InDhpFdkeY9y2u8lyMmMN/7ep54lL0u
	LPhXlio2ZY7XSuTTDapMiCiOLCVSZbGSnGoDvL91o5ogKB5fhPXbqpDe0ml7xwzx
	Xac0XozqU8aEW6ucVZpw9rgSzZ25YMnaQ4ndrboWnM6G0rQTKBUvMmnyuiqDBtHb
	020BlNMEBldvdLDeU5vYI/Io0BvulxhDSGpJRTfIY9MYA9hauS1YHbB3+Q3jgdnU
	7YSZRKa1SF1wWB8sByWrTkLG6Ty6vHai/M6UWI8fwiE87w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvmrr8b7t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 20:29:15 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90e8dd8be81so14681166d6.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790195355; x=1790800155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ktq8FOEiqAS2HqdwxrfUyjEpXI5UTr/iZCY9k3s5bK8=;
        b=ZA+DWE+FvZfnVDSSzUvaTnYRlIMTPIDD3xWIjtLbbrEY1xsawN8T6fLmdUh0kgFyua
         ngD/N1pB0SQGX9KmarPXhaiKYIyomI+8imVKDIOxtKX2J3VA3HYq6VHJIlx+ysOvid9X
         fPpUJMRo2YCc3iy6OyfpLTL0+C6IqcnbZyx3hnlEWNfIrk1Frxj/LHftDaQpjx9N1Onr
         iULUpGTblKMhLSMc3wOUvI1G1N2vRJTHXPhDbx4zcx2WN9BDCVgj6zEi6xcSj2xKrdzE
         89R7wv7XHgvTDp9SPV2mzCs4Z5HTbilnPjAe6S9eDSG6zD4+Vb/harBmI2+hEChpUAYu
         ff3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790195355; x=1790800155;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ktq8FOEiqAS2HqdwxrfUyjEpXI5UTr/iZCY9k3s5bK8=;
        b=mtAHP/ShhslbwpDYvP/67mwbqvbAIKktVjbmwGfJRyTqvolUw1t7CpUJnNr9DaA4UX
         3EKNANiOUsaaYcgsZiI497twkK5qWtZ9HzXwTKIHnA9uHUgKtIf049iIj++HH1qIJxLV
         vnnsiykS6C0PF6tToU1In8cvUVQGepfcAxTWorAv5MzpxqWyy1S3bDKhYj74XByNIMbx
         IVZMAUdKhoTkrglWHf1G2PFGSkcs2iuOV+Tuiib89QGM0G+tkHrejENsXa0Rxrfi1mw+
         /caCUyNIHNcZ1VDUH+LkmWiOdU0FmdT+etR5N71DH/rdWHaOV8EpShyGMGVetnxZdROL
         cyEg==
X-Forwarded-Encrypted: i=1; AKwUvBzg4VDcO8D3C/t4JcM6zU7GdxuyX9mICheZj5uTYGAw8xg3s8h3GB9RibDAPGSCQ8OEJ0LueRCWBL0=@vger.kernel.org
X-Gm-Message-State: AFuF++nBp7vlw9tMWoxhF4elyWgDAZSoBqjuo2bbMai34AK5Z6/IpyS6
	cwP00tNp2o6ZenMmeE44rwAyVWJGDob48wS8ReZ3C2IjnrzisBcJzcxHKLF4UaDxjpFYD5GG+uX
	xPWHRM4ajS302m/Zuyh0e3OdQQm7Dha7bgKPTiKGYV9j3y8w2tgXUtR9u1ebPZV8=
X-Gm-Gg: AYBFou1/04uSEzHInRVQfQEvYDl6YXDG3I+OdJqWQSn95nRaBe59X8buZAkSwJHVxsb
	6mw7EXgvO6/TcV0nW4z6MlN9qFZYTWzhuR9ESxTV3Z7/Y8v6k6jkmIZoGi6YHGloQJ1c6he6iOu
	OzPrQoGYEW2HMBWTlmFcHxGKcgro/BhkVeutvtjE9n+wdR7pjJAPbsm+qzKMRJ0EkZeq8O8lqIP
	rTGpxMYqdKwrtduqsorG2n7fIF9LeymetxBGxBQ3OEWPt+QhdprBPWT95+MRfRNRNqkr82JfgxG
	n7n8MdS4yWIEWitbSemv+wjq28tYOcbQwqAYBvwjZOovfQHmzQ6UET6XLC6ISR6jYCOFC6Sv4CX
	2/m3curatbVCpmr4VZqadfYlW
X-Received: by 2002:a05:620a:4551:b0:93b:fe5c:e6f with SMTP id af79cd13be357-93c346fdebfmr51182385a.23.1790195354580;
        Wed, 23 Sep 2026 13:29:14 -0700 (PDT)
X-Received: by 2002:a05:620a:4551:b0:93b:fe5c:e6f with SMTP id af79cd13be357-93c346fdebfmr51175685a.23.1790195353977;
        Wed, 23 Sep 2026 13:29:13 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c64dsm9373457f8f.21.2026.09.23.13.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:29:12 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:29:12 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, Bjorn Helgaas <bhelgaas@google.com>,
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
        Michael Walle <mwalle@kernel.org>,
        Daniel Thompson <daniel@riscstar.com>,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/5] gpio: tc9563: Add support for the embedded GPIO
 controller
Message-ID: <arQ2mDjqHv4gmoOK@lore-desk>
References: <ea49aa8c-af1d-445d-b15b-25079cdcc72f@riscstar.com>
 <20260923200255.GA1934030@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oI9GUafU7NsbJqGc"
Content-Disposition: inline
In-Reply-To: <20260923200255.GA1934030@bhelgaas>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA4MSBTYWx0ZWRfXxtRkYESGKlCc
 rLdz7QM5YY0Z6leDZKoYeRgw91+fhasnRWey4rj+DCIZ7GB58IRQuwKzUUbovtcRHAKK2bgmedy
 EX7P2dGLtrzGWlJGdULILpFm8j3WFMrAaeHpMN7/Kqv2PAwbJcAbdNEk1kfbAPkoeJdGNEBUL1D
 EB0yS6NUDM2xcCiaQZCHAYWJ/I8mn9nknEz/VpbVsuS7i3gYQ1dew4br04jCkC4IBO8XyGcUUHf
 Vb0WSlyuuD3N2IJrPPE6DvKwmfCxQMcV2luq3WFzSg+6fkIvq4HTyh7dW9U1Z1dbKiQzfCAxO9Z
 vAYUTluahbCNvfp6SR/4HAAibOIRIeas7Doatanzr/QoLX1F8jK5ZF487ON+vx/c72WjtrEXF7A
 sYLVBCmnDPu7ZuTv9roKLRWMrZmZlMMMLDtfouBRIoxgWsNHOhheCLmN/a2PQtI+FhDDaQjZ9rh
 +I/qY+pOmfeOv5XgxRw==
X-Authority-Analysis: v=2.4 cv=TYwDJhQh c=1 sm=1 tr=0 ts=6ab4369b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=DfaiL6BybcdO9YxK1uMA:9
 a=CjuIK1q_8ugA:10 a=Vvw_FJU3uCUNmsTNrNgA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA4MSBTYWx0ZWRfX0/XljH0RdxZ4
 BEzDnqIFu4HLtWbSN1b3I3lmaU2DxFa9aEQITS2RTC+isY/Jw98V+IEILts0l+/uL0mzWw+5pPo
 /cnDBpi5I0Muuatq11GSBVWuM0nioxE=
X-Proofpoint-GUID: G4Cg6I8txQi9ycbfVqUYq0WBDrFPlPwh
X-Proofpoint-ORIG-GUID: G4Cg6I8txQi9ycbfVqUYq0WBDrFPlPwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230081

--oI9GUafU7NsbJqGc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Sep 23, 2026 at 01:59:49PM -0500, Alex Elder wrote:
> > On 9/23/26 1:52 PM, Bjorn Helgaas wrote:
> > > Patch [1/5] and a comment below mention 37 GPIOs, this mentions 35.
> > > Are they supposed to match?  Maybe 35 doesn't include the two reserved
> > > ones?
> >=20
> > They are numbered 0..36, and two of them (20 and 21) are reserved.
>=20
> That's what I suspected.  Any suggestions for rewording this to remove
> the ambiguity?  The current "providing 37 GPIO lines" and "implements
> 35 GPIOs" just raises the question.

what about something like:

"
Add a driver for the GPIO controller embedded in the Toshiba TC9563
PCIe switch (and the Qualcomm QPS615). The device implements 37 GPIOs
using two register banks: three registers control the first 32 GPIOs
and three more control GPIOs 32-36. GPIOs 20 and 21 are reserved while
GPIOs 22-24, 27-28, 31, and 34 are input-only.
"

Regards,
Lorenzo

>=20
> > Of those, 10 (numbers 0-6, 12, 35, and 36) exposed outside the
> > TC9564 chip itself.

--oI9GUafU7NsbJqGc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarQ2mAAKCRA6cBh0uS2t
rD7LAPwKamp8rsgOUtzQVG4FHBs2cTDSeRJAVFRrINYQ0DBrqAD/TBi0DepNYAyJ
IFRIKZYHbaS4VFQf1hshwPrtok5YggY=
=Sv9q
-----END PGP SIGNATURE-----

--oI9GUafU7NsbJqGc--
