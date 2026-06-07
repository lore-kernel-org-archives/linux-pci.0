Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534C92F8E97
	for <linux-pci@vger.kernel.org>; Sun,  7 Jun 2026 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828156; cv=none; b=BvLRlyVY7ud67JHhBu7g9MaPkhoupQIxkRJBAlcfvWEsZHVg56Y1OBkRpvu6hEM+VnEzx66S0bFk90qCCUjcUzJPrMk77MqPnbJI0qe4gaOfYjRTm6SeM+NnfyUnXcmTT1fPtnY2MvyDPBL1P/lwDvvEw9gxC0f3kSr4+95oAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828156; c=relaxed/simple;
	bh=zpGAW9tYCes4jygC5Ch4v/XC2hqs2InqXCOcVgv91pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZB9EVhS+2i5M46uPAtjkCmEMmHArrDCJOvNXfSuoG3pIw+GGG0AnlIkybrvl9eTPNYJ2/56qOfZh/B5M/Ux+g8xEVvRhRCwsoutry3w0N6DtWBEH8ceSZS1FI5yX+S83+/BxJ19ItKm6GyEODFjc6BVt8swz5lJexqON525Zoo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZAdl/Bdg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jBCKwpkW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZAdl/Bdg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jBCKwpkW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6577AO3X4166571
	for <linux-pci@vger.kernel.org>; Sun, 7 Jun 2026 10:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=maV6ymIW+tN4bTb51Mh37tnM
	ZGwL9fhMtkQZiKNq0Jo=; b=ZAdl/BdgOqdteeXLfmxajMSt2D/VX4kOEy74z8B0
	6D0WNqWQkwPm29FGw1ajGny9GPfwk2CaPdfxWiMy305DMRPP3O8VL4sHVm21GdY1
	j3ztiO5/h/dy7JdxePkj/6GDm2h68tBggF0tgmMoiVLOr3i/iDy27LqG6wnMsgIy
	Vz6o25g7QfSbt8tTp+M/jtWfiYUiMujM+AG3Ut+dZws1utS53H4BXhk+46mXUD74
	Cf9DXCteW9/7WMOvk+Wp2ehIQSFrW3yTQk9WC9JT7XAn6cEGFORvyspS7sDv4rFr
	ZuulobkEzzV98XTTRI5MvzDwi3GLEBgshjkcHjQ8JdOnFw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmrbm9t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2026 10:29:14 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-963d9b6b92dso1475939241.2
        for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2026 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780828154; x=1781432954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=maV6ymIW+tN4bTb51Mh37tnMZGwL9fhMtkQZiKNq0Jo=;
        b=jBCKwpkWSsKBsSWVaho8f2rPyW6iOZcC+FNGFR/Zqpydwk6KFKsxUc1dvZqh36ipV/
         v2MIZhNzDiK8ZNuKM0vDFUjIcEj2CY3EleEBeq/yKLo9jU3nt495oY6idp12ALPc+s6q
         AOYgFiB0CxjRXARZLdqCf70044jd1McZNZCRHdTqkYnEJQts2/SUwRvPfb2TwMfQYByL
         kCL9uJWev3B2JHV9K+40ZgY/BPniPGumBUdF6yfclCpnfrx+T+rq66HFy3K9gi8C3NL3
         WtWWs6Ge3sRZ00woiKpnbEXtyNlAZFOSej+EOGfjC1V3kI+2BJZU192TzBUERnhmeHew
         kwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780828154; x=1781432954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maV6ymIW+tN4bTb51Mh37tnMZGwL9fhMtkQZiKNq0Jo=;
        b=qx9ZXPU2X+g8+8z1lO5/cejUBovvH+DgNRz3DkYpbL8p8pVYg9+ZwXwz32zaBg2tK9
         rWWpyWo2PPIda3YRaZftt7ST+5GyWPHKVERsTiwNDyyX1Px1zSLeXJEaLRlNRdtS3txl
         EXfhh4Nf81W215ejJiD7SDuV8tvHkxwUVyQsTFBbMMWuZ9nbN4/aDMfg516Tm5MfbUpQ
         xUB5j9u6ApNFjt5w4xPtnuDrWtDOGMKZqKWyvL6Ob0xKXRCnaYW3XYumGkimM1HFmY9D
         wTzSuCaJAxJaDEeYsnODUGfJdDZnvlGSriY+gZge6VIo5MeWwODFcUR3Y6f5nT2Dv12v
         ek3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+krWbwzJg8vEuD7VzZ4AfO0FiQgycVTSjsmyOXrapGh2FWgVIwSy1c3XZMLDqQB66qGrpNnJQhxrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEbDRTaFU8EE7Odo1w6QTH/d28kd/WWFLxxWJZLr5inaWQbxx
	17WHBzIm6GfnDtQH885A/HxZlcqrZPbXlsDfXR2WTrZhptWEHK8CBICSin2WUfYZrsvnWiUIF5i
	hJk2FflcDdB7uwpGKkiYYI3mj0wnrVyb3xbuRea0EmaHaVSR+XnhQxQoMdKQKnX59KlNaDAc=
X-Gm-Gg: Acq92OE1tAnMZX3WGaVc0rHT65Lj03s1sk36YrstJDHUdvN2pwcDtOpFYoYNuAl52vB
	pD7HReKiD4i7KFaz3XVrzb0JAMzTXzXIlMhG6ynupfoETb+o0eTAsGdmlO4Q9KVilUyBUdDBedQ
	N9rSaa1isqJf7O1aiabUomagZ/mpQ7YOlMoR0tjgwZOh9ShrA90pK19I6aQikSmMAhvPE0dvGgY
	ixx3icsxAkOFu6xzDzEpyG1O430KFXRsIVBCm6ZLdnBQkFOAToiTXd3RLMrqJuCsKMf+aYK3uT0
	3Qce51TtN2Ws9lYXJTksfdKIodE2GKq8mYK4oMpdP/0UqC/qRfPXZDOhjV4PAHNlq91BIKJD1gY
	THkZveEcCtE2cOzoY9hLtd3a3+UiOR31I+fRL95zg4oVRi7AT0JDfnkU0++zXqw8k7truDnHqTL
	2JGoIQZHrN8I0Zgu4FD1dd3Jvp9WLmdxTiS6ZB+VBfi4iAvw==
X-Received: by 2002:a05:6102:5094:b0:631:26f6:701a with SMTP id ada2fe7eead31-6ff156acf6fmr5264032137.29.1780828153516;
        Sun, 07 Jun 2026 03:29:13 -0700 (PDT)
X-Received: by 2002:a05:6102:5094:b0:631:26f6:701a with SMTP id ada2fe7eead31-6ff156acf6fmr5264023137.29.1780828153136;
        Sun, 07 Jun 2026 03:29:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed8e0sm2995208e87.2.2026.06.07.03.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 03:29:12 -0700 (PDT)
Date: Sun, 7 Jun 2026 13:29:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/3] phy: qcom: qmp-pcie: Add QMP PCIe PHY support for
 Eliza
Message-ID: <k37nby6lnczb5qajku2shpff4rsisyynlfmzu46lhojl5eiwqo@wkpy2tbeoa3b>
References: <20260601-eliza-v2-0-6b44c9c23d5e@oss.qualcomm.com>
 <20260601-eliza-v2-3-6b44c9c23d5e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601-eliza-v2-3-6b44c9c23d5e@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDEwMiBTYWx0ZWRfX/jOZ/y6ALLiA
 xjhc7KiOCheKo2RQjK5bule5bzQeFTwsrnZ3rmgkg5M7VKA3g6jxFep5nxWHmibLF+lloVkpeVa
 mL+Jgg/vx2AHL3v9gAUWSxSTywbMMsRH7YdDnYoEvReDZjvRtjOdRSvmqt/8eMxTjPBp1eGXGeE
 QG7gTpUkYb548e97x/g+yaYIoTml+n+dDswwJwQEl4fKTe5yKNEhdBlr80+OPTtodmPhWH3Jv9z
 sgc/T9MXGnAGsu4y8Qh7QGfwlv52T8P+M7Ln9Zvs/PDDnaB7EEchKinm/S1ifGdhw7mFM3nkWbo
 w+9BkDhSaobb41dQlWsxlbn0yjEqKS57I006XGfctRvvx9w8twQmtDumLlHSNGq0xcZzhngwdUL
 GNdKdOFpG7OWaZxan+Mty03zELi/7ba4dXJbd9b0KZ1efZkU7jaZP8x6t9TquEQFhttBs5a39dT
 +cF4brM1IWV1ZSXUtCA==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a2547fa cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=M-jGJTmE-ygQmRKCDXMA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: kCrId7_cC2-DuzXPYMpbQhP2q-2D-oCh
X-Proofpoint-ORIG-GUID: kCrId7_cC2-DuzXPYMpbQhP2q-2D-oCh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070102

On Mon, Jun 01, 2026 at 10:59:46PM +0530, Krishna Chaitanya Chundru wrote:
> Add QMP PCIe PHY support for the Eliza SoC. Introduce a new Gen3x1 PHY
> configuration with Eliza-specific initialization tables, and reuse the
> existing sm8550 Gen3x2 configuration for the Gen3x2 PHY instance.
> 
> Also add the missing QPHY_PCIE_V6_PCS_PCIE_INT_AUX_CLK_CONFIG1 register
> definition to the PCIe V6 PCS header.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c        | 139 ++++++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h |   1 +
>  2 files changed, 140 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index fed2fc9bb311..257b4df965c3 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -198,6 +198,112 @@ static const struct qmp_phy_init_tbl msm8998_pcie_pcs_tbl[] = {
>  	QMP_PHY_INIT_CFG(QPHY_V3_PCS_SIGDET_CNTRL, 0x03),
>  };
>  
> +static const struct qmp_phy_init_tbl eliza_qmp_gen3x1_pcie_serdes_tbl[] = {

Thisis exactly the same as SM8550 table, except for three extra writes:
QSERDES_V6_COM_VCO_TUNE1_MODE0, QSERDES_V6_COM_VCO_TUNE1_MODE1 and
QSERDES_V6_COM_VCO_TUNE2_MODE1. What are the default values for SM8550?

> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE1, 0xb4),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE2_MODE1, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE0, 0x24),

Other than that, looks good to me.

-- 
With best wishes
Dmitry
