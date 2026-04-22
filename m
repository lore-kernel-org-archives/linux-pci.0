Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396FD3C8728
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881686; cv=none; b=SNuLBW6snUf2n0z2h3kjEb3anwM09Q88ubv+Ok5b9syq6xrlR0FAU37yvLZzVZa6rDM0WtAzJtXlTHxcdcLWyqUJAD4GA0AegmVE5TLVSjnaeMFPAypOvBFTN58gubC0TJlfjDRSbj6FJr0h6nNGDEuEh9FbpQALmqFQJgS36TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881686; c=relaxed/simple;
	bh=CPa238Lhw3/i1jFwoxM2dK/g6KW16pMfFU0UbW1SSHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNxQvmU3dL3SFHsdnNMmeSBjFstHNM8CGPbI5wkflI8q/Wp83pORb+jruOrkVfDFu1NDELc5Ezb1egsmpmB9z4BJp1dHstGI9sOkV1J1fQmxEQpuxogc421b5hSoeNZmIy9TbVe4RHBBC8mx3LZmMlVNpNyICj8ygrmh6PsK/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SZcT7tZv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BCE5m+Na; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZcT7tZv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BCE5m+Na"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MG43in122915
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 18:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hPhGIxQkpXBRdqEVws8/Zb/E
	OCuJXIDXaw83aUIc/Oo=; b=SZcT7tZvXJjR7rM7QEPakNpS2k/kQ6kkFlrHC6dn
	9FkNeOGhbf6k8zd4T2Mw8GbN9A7eRG6/dPrfTF1wEtdBjA55ElICDq/crQmzx1mH
	FQBDByC82ZJtJybTi2hmxDMiGB88OKWo8e6+onssvtzVEraCrs6ri8KpFhzGb2sh
	3R8YKYEdzjvpGp6xkXksIxSnJ6iZR0fNw20nvTusBhhq5lQl3w5N9PKknVObV0ky
	4MOdBXwiP0QniaVKyFP+/OiKt9AbJ+HS8fd3H+YKMvKCqS7HToFwuuXFbMFUKT3B
	3BtmKhUIL649qslNHQzNypD82Fc2k1qKCPb8ywvIq6XQ1w==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1h80eep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 18:14:40 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6056898a01dso7735870137.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776881679; x=1777486479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hPhGIxQkpXBRdqEVws8/Zb/EOCuJXIDXaw83aUIc/Oo=;
        b=BCE5m+NaGh1orlsNyStsSA2IhjUJP66dEYwHdqCYC4Oh7lM0KM2And62EvGl9fcfBK
         DXnJl5e0hqVW9D4tukF2YHuKa6F7AzVgsbQ4kpPR2LT2z+nT4a/beJLcKnhs09aHxdjF
         7ztcy74fxnnTwEyk8sEmRzjfwz4mVBW0jeT6+b6V9djK9xSBZXJhrngHcAoIFDy4gb/4
         pS1gJm+3p9YhIcPzMiJB6LPiYi95zpxOJ6FCDOlW694qELrWnfRcmH31QcsdDUE9dogP
         tcKQuJFo14KyEDQ4eFFijADzm59ZDDyuP8WjXZwO95lpywY4NTIOrfP2H3HXYojMn/GS
         EPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776881679; x=1777486479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPhGIxQkpXBRdqEVws8/Zb/EOCuJXIDXaw83aUIc/Oo=;
        b=jNVX3ZklDCtVo1MQ7+3hnT3T1yd4XbG37bY/a9DVJgd4OsLEv+uJttDiMdMgxIWgWA
         uq5JsWktpcmOJDOYVnMq1eRDtebDPcD2GW0MXn2qygwgJJleummKjzDUVXj+CGMwoof5
         iK6ond8za9jCrpwQUySzfWJ29ZqdhKgVHYG+Lf+hRyILrP1it7SO+Cfvy5LuV7upHcWN
         DXJ2y0C3mtkgNZxaFRmkBgCPkt5cpOqE1kGj//0pSHDfNWqWpUFZgpw8v3ZYBJFB2Vyj
         4B0TNKqiIi4IIhclJMYbJvtUHrd3eeYRdf9l5qqsvxlSnHcaYDMujy+51LFmkqqdx6pm
         KG3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8FiAbsHsvDIzZsYjTLsT5tJ3lPF5AFe9tNdJvP+5oVL1PGLxwGG6d9ndRunGXkPWtG5VgWHrIZeEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS1L6I6sgDaP8dxCNLBTzklzCNZZH3GmWkjREm2l0o7HMSI5YF
	27cstc6Uybj/zkI2qSZi11tY2nfMaS+btLIxnoPIX7zgHqO1Al/Rfc9kzTc68HoEXVNm08pa4+C
	8JnWlSm4nCbWp2iPMsl76HkkhZywnHKpIVeNCZDCweGk5nkS2Yn1Tw4ODFl++tIE=
X-Gm-Gg: AeBDievPLY1eyLNg6V97lxXjHYkbFrLkGHhE+ZUVAoFDovDgHN83sKWzJZApfZS263U
	Xxp8Z4m0Wyr/eTPzzTyB9GobgTlaf00yhVP6sQt8X1609CbcAWrdVxPZ9Ux8u1gzaze3FZONPXO
	GnGBQkth/QmMtVY4Govdk9fBQb0b6SkCEy+rLt7HtZix2/uZRWUwDuORKFqVwWQqtlHTw1tk1+9
	ptk+0qh8blHaBfuOzNT+7u4HxctflZ3vJirdWoMecSCNpWiGrgR7N/xaFylASVsIOuHQ/hR2+Hh
	+tzNoCNQQ41ls2J2v98Ixj//xrrEbUUbgVBF8iK1hGjEOabFZ3NcDHOe08moFDWDL9kexaRUMx7
	Iq4jI3QZ3c/kTOxtq2TC/MQUZus1oN/qPxLsbU8psjUGIwQirOyjP1EVHS1gNVRNJAQug8yznTW
	xUoC6Q69d3YI4U2ejYKo4GROo971kvrxRl/D7cvz5pqHUD9w==
X-Received: by 2002:a05:6102:204f:b0:618:3503:5659 with SMTP id ada2fe7eead31-61835036f21mr7881980137.14.1776881679211;
        Wed, 22 Apr 2026 11:14:39 -0700 (PDT)
X-Received: by 2002:a05:6102:204f:b0:618:3503:5659 with SMTP id ada2fe7eead31-61835036f21mr7881956137.14.1776881678794;
        Wed, 22 Apr 2026 11:14:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad143sm4650753e87.7.2026.04.22.11.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 11:14:37 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:14:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 09/12] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Message-ID: <odwnlr3nyootxsdstjptmh5rsyms5fb3a2347y2oen4vsv7uhn@26afv3khjb5w>
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
 <20260422-pwrseq-m2-bt-v1-9-720d02545a64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-pwrseq-m2-bt-v1-9-720d02545a64@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3NiBTYWx0ZWRfX+WmAL8vmttU/
 /PgGJhZlsEnPEDiSqgr9RT+H7RUZtosT9XtWYAvhM5hub5dzZWsvTTELUrM3GUe0CcQyuPNSd1W
 4RIaJSGABwQadicM3UC6cZ/clBlH9cXJ8C1bTmETCODlQQhC7D/yNzIuoi5spuB4QFv0yJfuzbk
 k1lK3qpuLicpvMuM+O6Ep/SpbF+WOi7+VggaLBA83UV4qJtH09MMReE+7rDdI1HUt7Gk/OTUZCI
 3cQ4UfkUMJze2ZYKSWaAdhymaqT3e/FheYLsH+Q2lFBG3SknCNPw9AmK/445K1OjXALVXLyUJlh
 F6E4TLj05UdROaugiJly1x+SkjK2xrBc+eid+uXlNEpisMRoIXdquxrgebjelTg8DDQkVqHxOaB
 NAZdt00uJ/soFberMOrhM8SF8ns8cdypv/L0JVaIHA1rL7JXb4Ejljgw+BMmDz6fBY+79QVYSZu
 nZod6H16jyCR8eEvx6g==
X-Proofpoint-GUID: MivT9uFNWZ-VPkxlLxImNKKq11AtpwZ1
X-Authority-Analysis: v=2.4 cv=RaKgzVtv c=1 sm=1 tr=0 ts=69e91010 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=ZFRR4UPfCyPuBq0k6oAA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: MivT9uFNWZ-VPkxlLxImNKKq11AtpwZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220176

On Wed, Apr 22, 2026 at 04:54:50PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Power supply to the M.2 Bluetooth device attached to the host using M.2
> connector is controlled using the 'uart' pwrseq device. So add support for
> getting the pwrseq device if the OF graph link is present. Once obtained,
> the existing pwrseq APIs can be used to control the power supplies of the
> M.2 card.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
