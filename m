Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD85350A18
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272254; cv=none; b=qqIN7/c86B3I9MWnOnDLPfr5GkeMPLv3PNdog/CfXg8Hbjr42MFE+t3v2b/TY3J7ydqJPZTGhltc/+ZA2rfvBojH3ww1B1M4WKyaUW5vj/+iG2S9xsFZBOS1Q4XywtQ0K7DCSpb51IwX8l0njwynkxAwpe6VX3lCQ0+L7LRPeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272254; c=relaxed/simple;
	bh=Ag+3Gxwth8scj4spb7kinR45PS61DL85tZPM3vUaGBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sicozFVV53ytmhDw2xS2lg57QbQzHcKAZw6IKn6/eAK3dAfZei6uWKLaFJyFyIJKW0Uk8cJkVSIhfBgz3GaIQpULlZe/DMT6//k/MWNQVRANENOuNOPaZWbsPnYJCYPbH931FGzGVfNLTd223i6WBxzJacmSZU5YMUZCxU8G7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DfREpZUE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gARul/1y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DfREpZUE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gARul/1y"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E9N1V3004249
	for <linux-pci@vger.kernel.org>; Tue, 1 Sep 2026 14:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L2p4PVMRQyap4QtREvmTG+zHDqqjqe019cA/N4E/d+w=; b=DfREpZUE17EnVXWt
	FsfvZnSl8y0oz3seSNn36W8vVQlcx9BmPZ1tbeB4g8+miJh8a5XEIDe8nAk/reWc
	eqPzvUE/CBhpFp1fBaeOR/mpbFjTDAVXfV3HTz2k5qUU6bhsG7dODoAkntR+7MuI
	myXv/LFolnqeGAWOUyidi7usccMXvaCVDj5laKJolcA4g9mK0dV1d/51akXLuPsS
	iM0GwsNfLfEG8TMMKnsAmvAime+DqCvyn3RMte8Q982wI3w7sssHbgwf0Fu/HZsg
	u15usGLKjh7u4OD7X/Zh+dPaPXaW9yyjU5e+I/H1WT4wO7PvFDdz9Sh04NrSqI2O
	gqW3pw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdqbh2fah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 14:17:31 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7570225606dso121980137.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788272251; x=1788877051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2p4PVMRQyap4QtREvmTG+zHDqqjqe019cA/N4E/d+w=;
        b=gARul/1yDzZJa1BeKFug9rwx4JLcOfsRwAIVCUtk3W4OJP7X+a4p1ECJ39YvtTO8bK
         V3vuK2bFKAh7KblI6impfuZCXcEGEJcc5HiOxOLt1qnufNdvC7y2VAuYM6f7Wk+AqYeU
         IkOKwFYvQZt9jIaFUG73JYZk2vBy+p+OU4IzhgeoS61dNpGMJTU3uobqac1AY0t4fZjz
         1Zzm7HZrHf3TpFXnIPgtoMQONhkygy1krDfXaduMBEshqoPaT9AUc8GGuXlNOeZ8sNIt
         p4HB9InLwjHFjwMCVdVZLDNEevk6XisxxInNWaozT+mwo97BKMbIWocEgvMvSWHgTy1F
         /hiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788272251; x=1788877051;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2p4PVMRQyap4QtREvmTG+zHDqqjqe019cA/N4E/d+w=;
        b=QUL1i/jIwsHz2XYn+Uu+YVUcnWfDPqFWlqBir9tzgbbTY3u44YfQS+zetVSnwhODya
         8CjE20hodrmwUHISOSL/Kg6kqsEAqbJoYWCvFJbXxDNKS50ButGAZ60qyjyQV6ub51+I
         5x7IEtxPL0TGTv9cn3kRdQOqSrXV6M3dshft954PbmhDE5hUlCWZleKvlsm0f2S+e28p
         hKjrfP29B0MPhJJl/TiWvjJIbRvyddn3by/mL3XccbZXtm/O2tvMy/EEC+gXF/lhf1Tj
         0RAsjHhhOtejEZIoi9fmwHC+m1uIJdQU6xoJHw342scVTFIO2atZrdfohnWQVx3w0O0L
         iDJg==
X-Gm-Message-State: AFuF++ntgXOxKiA9wTQomvJpX4GnMwxvXDJm1AAJJPjPmxvUV8WhesVH
	5Md4NaDiT7TLgWXXTa58fZOBMDMBh7lYpfODPDxCDeSq5cZ92XPCnYLktkXs7NPZAX6wTgSJgJa
	47ig4cqTFSntB/gwmIP+ubB+JAaSGkegHgq3TyjpdLZGyYJTs7NtDqRkKFxKG2iA=
X-Gm-Gg: AR+sD112NLNCyz1c3egC3TnzX+dMlwDfkFW+mmKHRDO6/qUf1QHksA7XEH6YZNW6Yqs
	4NRAXpNhu7Rz4OtwPuKd48o7v+vxzj3aENDVYFA+jmL86ximQE5sVCZ2yBLYTJ7gL5FsRpvICa6
	yqYOv94HvwRRSX/PKuGDuDPOkREUr1cBtMpEx4oLiDOOAHOfyNlznxm0+izCactKPqZb/jWSFTr
	RnLAHhpZobFFmah3/7yMcA8sHpjaNFk4ErGl7O7LdJGd68dvzjDQKZVkbCsfwwXFFiiGXzO3G36
	GeJcWuNCr8+bahD8zbiAbdjCx4fPdCfOmMLGRQdl489SR7asbZfSAfYj2Ju4THvQ0fEWC9MlhHq
	ZvmI5M4SElboCsufIL1vZXg==
X-Received: by 2002:a05:6122:c2d1:10b0:5bf:b91f:3bb5 with SMTP id 71dfb90a1353d-5c6814304b4mr4067444e0c.2.1788272251240;
        Tue, 01 Sep 2026 07:17:31 -0700 (PDT)
X-Received: by 2002:a05:6122:c2d1:10b0:5bf:b91f:3bb5 with SMTP id 71dfb90a1353d-5c6814304b4mr4067408e0c.2.1788272250419;
        Tue, 01 Sep 2026 07:17:30 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25618430fasm597611966b.22.2026.09.01.07.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 07:17:29 -0700 (PDT)
Message-ID: <a5702e89-d083-4dd6-859a-9a52faeebfd2@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 16:17:25 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow
 gpio-line-names
To: Xilin Wu <sophon@radxa.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski
 <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyNyBTYWx0ZWRfX1QvOC/pGEipF
 +oliDoiAeh9EjG4rLsyGVYE4VeBxDzeJt4IeF72chMDt1LEHdieBV1DwTxekGcd4n5sTiOXNMAQ
 7rEZad0mHAZXo6JDtKoiL+zEkhdqzv0=
X-Authority-Analysis: v=2.4 cv=R9wz39RX c=1 sm=1 tr=0 ts=6a96de7b cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ksxQWNrZAAAA:8 a=EUspDBNiAAAA:8 a=hDogp9jCFjaJvwT77eQA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-GUID: ChSMJn9nj_QH9m1OyfN1ygXxMNSeLShv
X-Proofpoint-ORIG-GUID: ChSMJn9nj_QH9m1OyfN1ygXxMNSeLShv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyNyBTYWx0ZWRfX68ISp4ZzK/zH
 kTpWFfDLeRsNa8CgWHuJBhsn3qIIImmurXUlct/hbexPnTxVzjMqLjcblmOSQ5AIzgJguGVaa4r
 a8iAKTjEa2d4oGunLN3aKr7SF7LC8t7fxdgDvso4K0mjnrn0CzzyVi7vbE+XIeruQTvbB/KHleJ
 7nED743Uf35lCw1LbxA7bccKnDYoeTdPMLs2FhpLImpzoItj74G8OUmhl26apk6NE37EEN2ExrF
 6C5jJ1BFKbd/o712VpWxc9nJN5U8HT3Ey9qSQizcWibNfDqcHmtGs3Rp4stpDTvtyAJsKEr+zCy
 1K6uMPOgFDqFRO2yemmZqF3rNS05KfAknZmn7ZADn9tr2z/qtI1DRuUsxdCNHQQfS86j2tYcXSF
 NRuuEgqtcfTqvhtbxVfFkwqtFvGesddBwZY5tCxRFrc53EUao4Ce3cCHUV8oS5ImOk27Iho2qGc
 +hd94XKHt2HroAoXstA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010127

On 9/1/26 10:47 AM, Xilin Wu wrote:
> The SC8280XP TLMM GPIO controller exposes 230 GPIO lines. Allow boards to
> provide descriptive names for these lines and constrain the list to the
> number of GPIOs exposed by the controller.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
