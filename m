Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576202;
	b=jetwjLeEZlEIANgnhLbCmKaClHa9v1VyUKx0lvyog61t8NY/cQC/DRLS/IJY+ry1nd7n
	 Ya1+FGmLu+DoDDT9FZdNuDiKk1sq6dFtVDOKfqh+Ck2wMR+Zwf5hc65wP2cBa4HH497Xf
	 eZti7dKsnEAVOkxvEmrMsGMjQmd6O94izJ8EfVV1VNq1oil1feMXKuTWSlCT0rpCU3DOy
	 Af+UKJborhw6Aj+MPHqVU4jwuKAor8wozDSpu5KxOAWigEv2ldwQrOoLpGNU5AxgvKb/P
	 IWDFBrOjh0w0PyQ/8oEyI0NNRdllbqSN2eZ57wy7E+0JC7mBgPWMKTXYiPkwZ3YK2lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576202;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ihxKxZB1ejaxXBRJKLhqkzrjcSqUhHkFQ90yxjQFTRM=;
	b=TsHsMyCEhrcnMLnoIRuMdU2NHAxnZgCQKjmr/laHY8iOYJ4c4tTuMxgCXL8sU43+5rgR
	 lBEnaj6mZ+/t76qMda6qFK+JFyvgExgnHQWcRFQNQotRguiBsK1koR9D4OFWfgoT1dj0B
	 VCQbFxgxJZOuLO2Sr7GFkMb/8ofO+/2Ubj1Vz4rYtNKNLHkjpWhBHht1MA9PCijVib/qT
	 wrvEzOMSVdU3j0AsBht+eBRarbKlLJs6sT9eFox85kCd8YrYRM9ftwL2QTH9CZI3egW72
	 qz+CAR3F6aLBiHuqw59EfFNdp9OlGUezh88V1gOkf/g8n9/l7e2BQPKOcyrI7NsW3lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RXWNXa0O;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TaGF+pF+;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01371606A31A
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 09:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01371606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RXWNXa0O;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TaGF+pF+
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5jIEc2848156
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 09:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ihxKxZB1ejaxXBRJKLhqkzrj
	cSqUhHkFQ90yxjQFTRM=; b=RXWNXa0OlRHW8GfojSSbj0G3meelmRycN2rGORBG
	6DfnwTUFz5Nf49A5EUcMlRM78kWmj5Zbw6EKrtYoKLv+hhW5wn5lxYMwIYrW/jbc
	R0pWSfnG8FqyKBSgfdMvPpOwNPi1azCxkceL+w3b6n2VN87KpjexU4g/FB2P9ScR
	1TKRxlwxfiF+JkrCvZrN6jb+Dc+rmOJevR0G4fmWIKwAwp4e4wIOdurLxedyvbmr
	IUcQTfpXq7nR+WlclSY00KO9STcuv0N5WqHUrDLaaZG0tRESXjXP3lf9e6Y0m288
	uS/AlKsp2d6pK9vQ45EXhQ2ELd62zRhO3cyDIhrBL3RT3w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb9b508-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 09:49:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f26dd2165so175614585a.3
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 02:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792576199; x=1793180999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ihxKxZB1ejaxXBRJKLhqkzrjcSqUhHkFQ90yxjQFTRM=;
        b=TaGF+pF+mQvHPTr07KDd5GUm1MNZXWsalORndEL3+tPgg9A+Ap2zOdhSTcpo5PnsDJ
         noh21Ny+vnHP2SM5EGDDLXRB1NLseAAqSbBnyMnQxe2GkGv0rFfUd273MIyKgucgBF0b
         cY29mMrG0sC7GB2F5xsE92pyCXOX351l/x1wGtqDuuO/Lt8uSBN2a5dNYY3CCSsvv6Yy
         WzisdlC9rB/JCuKblwYgxo8boD58U0ucauXBN2jeX3K36s3VpkCF5PEFAFqYxlTlnE+f
         nj6T/LwcKdevyPZd0qfQVd3tmr/lEZIx0mz0i/ldOpK8F/rY3+BmaRn46zBINPjLtF5G
         cpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792576199; x=1793180999;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihxKxZB1ejaxXBRJKLhqkzrjcSqUhHkFQ90yxjQFTRM=;
        b=Pf018anuLj/V5XS0RrLmDTKHrGDpmQD7lHdJDw0Lwm0aLOo7Gk2TuO32bsIcDpJiPy
         EeJEwt0OmMcewykBthBWy5VSy9RHZ0o6bUIPWWDWlxZTtyX00Uv15i8F0KehtA3xHnMQ
         X7gsZG6e0rTrlrn0zb7nD0ddz8Qf5JWfcjMfqsONW655hp0nBkXAA7lpGQwqqdfwbisU
         kDuchLis5xFU7VYGi/zqpwRa4hSWtQXCFnCsXWOXZx4SeQuA4FI1+X+eCl6MlEl2kBcE
         BtCzb60YRzGNHGvI2VAl9jnes5LhaSzLZy5nXzDJo9dlJSJGmwnJRPJNOCgCnFDSa4kT
         uuNg==
X-Forwarded-Encrypted: i=1; AKwUvByzlhnw4IdPltPtroOc7KpNRcEExcqZuziQjh1rqwvOc9hke9mwa+Mg1IiqIdNl0LrIPQBhFhkYKRc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuQFymSlXcHe/6gnZKwvU7sG92q8SV1c+We9iYWXXA1kp307Uj
	wZYrYRcBaxjl6B0/qcOW6Vb+TVJEXC2MqqhGAX9LREm8vWkf+7faNE+FJp/Lg92ud0FJ25SRXE/
	OMqC2BskK6f+Py894uk2TAKTt1xBbB3bRIsjXGYcS2oNELTfiwdfQ1/GZ6K6I9XU=
X-Gm-Gg: AYBFou3tVRdRKFxXqdIe5cBDggWznnJehQW2KjUGHJkztlqqL5hbmXYHEwAPGQCLqwI
	iwcq7YVRUqP4Cab/w0j6uTfIFArPnfSHEEdg2qJuPcUvU8KEhUKXvkK/SSuGDFqKcAIMCMjaH50
	1AXAm7z+QOmQA7ulLxk+b0CvseQdHajU0q0naku7xryrjr/H4KMbUpmIR43mEipVN0ij4TjdSlS
	HileAe+cwV24e0fJLEB/0WzCP/nejARGe50NyL3q6YwIqE3WRthPjrg8q1Z8Ic92t+s5ZyKLa4D
	JX+LRpeF3tSBCYHuzaXhmX3b9lce+cjIP80SxKG1qd0N5uYInQqNbuxdMnqz40RjfUPjxAWhvN2
	bLMW8je+t+f3nfg==
X-Received: by 2002:a05:620a:4505:b0:93e:c12c:fbc4 with SMTP id af79cd13be357-93f57f9f3c7mr297090185a.81.1792576198907;
        Wed, 21 Oct 2026 02:49:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4505:b0:93e:c12c:fbc4 with SMTP id af79cd13be357-93f57f9f3c7mr297087385a.81.1792576198327;
        Wed, 21 Oct 2026 02:49:58 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb83ff0dsm81479655e9.7.2026.10.21.02.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:49:57 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:49:56 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Alex Elder <elder@riscstar.com>,
        Daniel Thompson <daniel@riscstar.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] PCI/pwrctrl/gpio: Correct GPIO_TC9563 /
 PCI_PWRCTRL_TC9563 dependency
Message-ID: <atiKxGuCC8961jL8@lore-desk>
References: <45484c37512a3102495d8b75b6e9f72a141ba42e.1792574560.git.geert+renesas@glider.be>
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
	protocol="application/pgp-signature"; boundary="i81LDSJ13peNYO7r"
Content-Disposition: inline
In-Reply-To: <45484c37512a3102495d8b75b6e9f72a141ba42e.1792574560.git.geert+renesas@glider.be>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzOSBTYWx0ZWRfXwmim7m0JVN15
 Nptqbxe0gX+XMbpfnLZSrzA3CRB1qqfCnG+o8crbZ5zrFIe2e1iBtnmCm8DNnHTEx4Qc0uVV0JW
 eolhcf3HVVsTOild7ExVvzkzZA/1nNA=
X-Proofpoint-GUID: jbiql1hckP8Oy4PATCw_TP5HAVtWtMQD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzOSBTYWx0ZWRfX+Q6lhA0hYlVc
 op1Q+L0gZW7v/0T8XqDw8RDW+z1fxxqGBkemkczrpWF/QTYY0WanY7WAY41d5DWTgKZK8hfA3Ki
 z2G830xUnCMfMvuqKKbbw2MBMK57fuM/lmbU9VIvlnTCBgRMCYmiJS5S4WUH57CdhTgtLMesfj0
 9Kl/lM1dmEN53V8ElrskKHFax+n7HPNsIAcRiorURpnGSzW8U6Pa0uVRsxEnxRi+W+HwdlAfnmQ
 VDPTBnQoWPPai4N4GEn/Yw1Jv+1tJ1Q+mQ8eSpZQz2NJXFgJMlvAeLIFV3sPpw2ERkaO3jqCCBU
 oZBivTWGrVtfwB/n36XIPvGnwxEvH2sQY9bC2dVGyuDjXqH32D2DoIaCxqp7OQ8l/Ev+sfiXZeC
 3I1GkVMBJDHDc33CsX6aRF/OQ31pYNxfSitgkjjyGU6bQcyae7wTk1RRy/1FBdamk1NYPFG38en
 3uLYZwVCtvCKqK0GLBg==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad88ac7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=DrrgTA9W1NqqBr-8W0gA:9 a=CjuIK1q_8ugA:10 a=HWeOJtvGEj_8LY2qVjsA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: jbiql1hckP8Oy4PATCw_TP5HAVtWtMQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210039

--i81LDSJ13peNYO7r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The Toshiba TC9563 GPIO controller is embedded in the Toshiba TC9563
> PCIe switch, and its auxiliary device is instantiated by the TC9563 PCI
> Power Control driver.  Hence make GPIO_TC9563 depend on
> PCI_PWRCTRL_TC9563, to prevent asking the user about the GPIO driver
> when configuring a kernel without TC9563 PCI Power Control support.
>=20
> Drop the dependency of PCI_PWRCTRL_TC9563 on GPIO_TC9563, which
> represents the inverse and wrong relationship.
> Let PCI_PWRCTRL_TC9563 select AUXILIARY_BUS, as this is no longer
> guaranteed through GPIO_TC9563.
>=20
> Fixes: eea9a072221d97ab ("PCI/pwrctrl: tc9563: Add GPIO auxiliary device =
support")
> Fixes: 81ec9c22d06aea92 ("gpio: tc9563: Add support for the embedded GPIO=
 controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Let PCI_PWRCTRL_TC9563 select AUXILIARY_BUS.
> ---
>  drivers/gpio/Kconfig        | 1 +
>  drivers/pci/pwrctrl/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 5d3f076c539b3a64..c5556b1638b8c113 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1893,6 +1893,7 @@ endmenu
> =20
>  config GPIO_TC9563
>  	tristate "Toshiba TC9563 GPIO support"
> +	depends on PCI_PWRCTRL_TC9563 || COMPILE_TEST
>  	default m if ARCH_QCOM
>  	select AUXILIARY_BUS
>  	select GPIO_REGMAP
> diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
> index 38aab596aa04b8b1..a2fc2a359702e861 100644
> --- a/drivers/pci/pwrctrl/Kconfig
> +++ b/drivers/pci/pwrctrl/Kconfig
> @@ -29,7 +29,7 @@ config PCI_PWRCTRL_TC9563
>  	select PCI_PWRCTRL
>  	default m if ARCH_QCOM
>  	depends on I2C
> -	depends on GPIO_TC9563
> +	select AUXILIARY_BUS
>  	select REGMAP_I2C
>  	help
>  	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
> --=20
> 2.43.0
>=20

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

--i81LDSJ13peNYO7r
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatiKxAAKCRA6cBh0uS2t
rM8lAQDlwQYXTcfSyFQjMNNia/OzD6xyyy5hxoHYmoDszs3ydgD/cwDKu6iN/C+0
3FNo6XEKgZP3DSGm1nyZYNVjR/Bnfws=
=B1zP
-----END PGP SIGNATURE-----

--i81LDSJ13peNYO7r--
