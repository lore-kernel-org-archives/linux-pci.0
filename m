Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33353E3C7B
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698570; cv=none; b=bQEIFvzvokE/8kRvo6orAUxJ4FrOy53IgUjS1dJVfHkH6V6wGSAuaJpxVgt8qY8BQwkYS9wb9rb+wAZCdvzDlMaUNTKWolxpOY71wYJf4FS1EWqUVyK5zYV9gTzwh0HR83YIbekk0AYMnKKfSABb9A2VQDLSNvoMhdNwyC1Rq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698570; c=relaxed/simple;
	bh=ZuDTkgX6mAwZ+rmvbZMsjFEI+Z4ozYk6bjM5ThhxEyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUKWI8FRz2SPt6P3QO25SuFDC3n3kuNFuff/cA8kTs+LBiQwoSn/oOqWe9UCQu+uBxHK52eHIcnMVOnMqsM+Bp4YtVBhcLjME2A0hFFB9VWOkhTpU2EAcz0YN5rKwelVjfe6bRfRzFtDM+xAnvJac8pmAmmx+BK3hUvDiXi6Rj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fmWOalkl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BMgHoTx1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fmWOalkl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BMgHoTx1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P6njf91330183
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 08:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RfjedfVNMYLqzmmguha+gRd0
	377+9GlhAPQfeTg3V4g=; b=fmWOalklTdggJ1XndlWLwN3g1HZHS7a5qJbDuUNQ
	1M8dr4Ds/RjjPiZhIU2s9tmYspPmLd85fiGwRZ1dqU0nXaKljl+7t0p4gtIwIYD7
	vEAc+0cubSzsb4McLSS8HtqRSYzHrLZDif0EfVfIgrj/Sk6K7P5mhSjXnUcYsJPd
	xM1z1MZyKI00eiyAqah1x27GCkdr/fs7dODd5tSPeqqBzLZSblzOtffpuQr1MRl9
	gzmwaPf2Tiq0jR+GOcdTcHOxXkzhAI+ag9gfKhbMH+GT5K+fQZ9A/La1jtNNQzuP
	SfTVMAV0sBa6+093isy3l1+CLdgbsFZnNfg8mxmO26W8Uw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb88w5ad5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 08:42:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516d53eeb8aso69018001cf.2
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779698565; x=1780303365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RfjedfVNMYLqzmmguha+gRd0377+9GlhAPQfeTg3V4g=;
        b=BMgHoTx1uQNXD9dQCH7awxf3fnXs8XE3i6LmO0f/iKSD9ze3eQXEEFjcLavQwKqtfd
         idBLuV1it+f0TgeG9mvpyHK83VI1b9o+31w7QZCYngdyRq1zyY1HC+XLi77WFbcMSnK2
         SHcMln0ctUyuQi5MtZyVdmVWj/jytfmPJj9unG6CF1Z9z8XHmA9GirGtiuGv8h/1aSBR
         dzMYbVBoVzZKwOXlqFpp+PvtJOJfC/leDtkEF0IVCEuRyqFIGW22SqzXDgXdhplx09RC
         zp/hMllWHBDPuZuNjj2nhkdM9daI+V4eau95qG2Q+1zMLRDeLw+LHxayTxEmaDWBc2UF
         mHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779698565; x=1780303365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfjedfVNMYLqzmmguha+gRd0377+9GlhAPQfeTg3V4g=;
        b=KCljbzSkt6yBZG+wLkm/NW88r+oL65scboEi1YP1YfCHkThUTtRgJL7SZIqOMeeq6a
         rrblcJQeCtpnnLchZd3+z+BG/HkokP6UXd49chasgdWFVSyZhpR+xAvAw3v3fXuutb9/
         /zxFHBhVafayNhU9gOfI7u5XevTw2M2TY5ovbU6eh7omCQcQ9gofPcOcqvQV6Qje2cBd
         yLYrwaUvb7nCyggh/zdTmzmTlapqfKNPhu92O4b9wFvOPhwWDCK6RoyhiKiyrAAjVbOp
         RtmD4Y+Fr4boin6vi5DJCLI1rz5eu0p6R8Dn1NHpdgAZjr+cevsacB+96tt0KqQ2nu8Z
         Q1zg==
X-Forwarded-Encrypted: i=1; AFNElJ8AwEcID2ObP8cK624LL3hVmuDgFPJ2JGEMiiZyL7mDcembiGaiDZcBEXHtDHxm4LZvZux7teVk6Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWSKFuGQpknVX3L/fP1FbIwFVymemIr45Uxch7lmW/f/99wfK0
	9aWUCltWuG3/16MXzmKEoMk7RdbAVd+jcLNIkLkP3LUcf95LDmMuFV30/l3/0IjR1eXSdDuXc8x
	5qsCs+zPAmdiHXfT3k1ErgJ+2j6R+9jpAjO3505xkfLvC1G6qTnh18hrI3iXPTJ4=
X-Gm-Gg: Acq92OF5NGwKXMTJDWve/JwSTkedMII1PGeirnkGyJMZfm5iOdtMF/Eve8yg7Q4Gb/8
	TcZqXKD1mLch1juyo7IsX7or/wUM+9qYd75wODbhz9QmU3g9O2uBuqtsXa3agLRAxOyhOsIWIRd
	RI3O+8JQlhYPY6KyK6iXxPpnQt1vqqFZeM8byujGgIGM9AUaLH1BSgR2Z/I4HP5lHf8w15nvGz/
	1KtX/EFMabKD3cyxMa81v+tsw7WS/VTkJXFGxW2vDELgYTNhw+pZAKIKgOdFqq1631mEjQRLxjh
	D3DpI8SidqA/2B8T9T3hp/7w/v8TCv9paigtuiLxa8LdRn70XyqnUXK1/ndzVl0mNXZ7RMdcu7r
	Hs74Vfd7ZghnsLL7JXA+Ixeu9dWxQLN3qg6eoUzCjXUwDGBsizyuhXAKyds+fCSfu3Ig/KhM31W
	3jl005959IeS696a6JwSQRYHaN3n11gXzrr9w=
X-Received: by 2002:a05:622a:4a09:b0:50f:6415:1eb4 with SMTP id d75a77b69052e-516d463dee9mr196532121cf.49.1779698565117;
        Mon, 25 May 2026 01:42:45 -0700 (PDT)
X-Received: by 2002:a05:622a:4a09:b0:50f:6415:1eb4 with SMTP id d75a77b69052e-516d463dee9mr196531821cf.49.1779698564659;
        Mon, 25 May 2026 01:42:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc0a196sm21334161fa.21.2026.05.25.01.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 01:42:42 -0700 (PDT)
Date: Mon, 25 May 2026 11:42:40 +0300
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
Subject: Re: [PATCH 4/4] phy: qcom: qmp-pcie: Add QMP PCIe PHY support for
 Eliza
Message-ID: <l7bcvuq3eggjt6oir2yq37vvyy2p2ylegf5m2m5yjhd6nl26hp@e2zonyjx7olw>
References: <20260521-eliza-v1-0-97cdbe88389d@oss.qualcomm.com>
 <20260521-eliza-v1-4-97cdbe88389d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-eliza-v1-4-97cdbe88389d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=S/jpBosP c=1 sm=1 tr=0 ts=6a140b86 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=hYsTZ0akgaehJFdaFsgA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4OCBTYWx0ZWRfX3AJVRh7AjFbi
 qeRvIWl5Xox+C6Xl+qy17U4rDKf8q1LqM7AG7RkgOBk+u2rONzjnIRYCGlMQfI2nIQfMrIjkL+J
 dBFPNXtHiX90ZS1Chhlq0iyZPqyNPNqtubL4/Co7vcrEVtecBXRZZldTtnBlAX5QJ4MyGCm2A8o
 +/FPRJUDBQPfifIsZh4rInVdt0gAsa9XIZ/MSo8qFSbucrIfMEFH6B/vSXPP+ZaD4Nh+tmhaDPl
 77/zJrbM0HNAXtYw6xpKYPN1CpDRGDwkTOT3z26ffBqpnyCUB8cqxRX3IKaXRV9cPS1/4n81+vP
 8VSKm4fBztvhVslGNQ5XIQaw4M+wCOqc4wRMKSJKBdefOgfImQGxDjL3ea7vae10HOCA4rxZKOR
 FpaBH27eRVsKqIwqx9sD8l2rzKVVuVpVay+qAjDDV7eQlmz2Xx8XNA2g3Yjy9SXi9co/72Wsyzi
 PAI3IA85cIZGVI7z+yg==
X-Proofpoint-ORIG-GUID: bxJxjks3cbOtG_-MQbPYiGG1ylQBJ7T0
X-Proofpoint-GUID: bxJxjks3cbOtG_-MQbPYiGG1ylQBJ7T0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250088

On Thu, May 21, 2026 at 07:35:32PM +0530, Krishna Chaitanya Chundru wrote:
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
> index fed2fc9bb311..113c5f8f1dbc 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -198,6 +198,112 @@ static const struct qmp_phy_init_tbl msm8998_pcie_pcs_tbl[] = {
>  	QMP_PHY_INIT_CFG(QPHY_V3_PCS_SIGDET_CNTRL, 0x03),
>  };
>  
> +static const struct qmp_phy_init_tbl eliza_qmp_gen3x1_pcie_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1, 0x93),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORECLK_DIV_MODE1, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x1a),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE1, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE1, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE1, 0xB4),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE2_MODE1, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0, 0xf8),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x0d),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE0, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x01),

[...]

> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORE_CLK_EN, 0xA0),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_ADDITIONAL_MISC_3, 0x0F),

lowercase all the hex. Be uniform, please.

> +};
> +

-- 
With best wishes
Dmitry
