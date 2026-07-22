Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7C288AD
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726276; cv=none; b=Iub20F0oNzZMlXscIx6lSRYnjDLmbF6eTxciufFLl+9ecM+xkaARItVErePKu/u0kZCinJjU6h/5UoVi6+8ArRGpiv1C4VXjXEOLd/j/lV7rN5zWSANOuV1QZjG+1yBEhY9ka6jT67X232GbzJisostZExkRweAopsUK+tCZa28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726276; c=relaxed/simple;
	bh=sh9ZU5Ncc8RUC8V42Rp9x8UPi3xY/aC/ruJVJxi2z8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC2uGILGJFaWgdIPG3Tcf9vyt+OXH745vPPbD2m7vbyM4yrta8wxq+yHbZXVvKqcSUyU8glAXqWmBl1oS2yWKNjtVDUkvYs3cwtpAM0MYLsXEOtilc9kujaf0+Xvmpx1m6WfsmFlWzEMLJBcT6+wRB0AXcw0rQ0dVMwVYVFHIoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kqU5K5hl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EOxhOYyz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kqU5K5hl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EOxhOYyz"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MD1pLH944760
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 13:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=f/z7Vf0CFs4vDGQLLJUD618C
	7Uy9T9x3H6mGeOakJz4=; b=kqU5K5hl5hqAHl193dF9LYbBD1n6i+hH+eRENipq
	F/kc+RwlgKLOjraw99yyeEPx/Nq5GbVaQfgg8WeWn/Ug+vXer9jq11xaazD8fMh9
	KrbQGTT9vu8Vpfmjx9VnoC+6ESAjtY4YpZJIuUYUrvIYXk0Z1+zFuGhkOd0NIaTT
	WxWXV+VmVxDCfvsbEjAshb4wjZyK6K5wIGIDRH00cRJDVQHrOnCtD2qHkXcx+xZf
	UyAj/k//BodvU8oJUteC+8qGT2cQlXBv1zpZMmMnnsyL38ic7qZZ/RQe+bY+ra7W
	1iVTlDKlrnF4vZKO+LJA6E/WgpzS4ULLZ73Ya4csiZdYWw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjs929fsm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 13:17:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe3fa93bso256460161cf.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784726273; x=1785331073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f/z7Vf0CFs4vDGQLLJUD618C7Uy9T9x3H6mGeOakJz4=;
        b=EOxhOYyz1uVQFkmKD9clAzuBAN47qnTHcZIl88swaDIh+AMUu9ov8ijk1J402apIBN
         t7X5Vpk5CpQKdO7NrxOAa2f5H+bek4MYMOlsd2ouaKTgNtE/+dQQqWBl4WrT609E220e
         cY8pzWizJ/UtUjBzBlpmvFl41nt9OJp1XOGkRg5SIFcyVrCxB7AQeO4FFc+ZvZEUve9g
         +Mw+bZTZPUwa8gb8O57W//VAypph4ylbSNPtJrmfBQyeq/0/TzszKHl2Y+H+1bQzKono
         hS0EldRhtr7EK7sl2RvtFMflqQKC6ZSvao67ROvNPFyWw8wRnNP4OVC0WH6HFazSCdMm
         nL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784726273; x=1785331073;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f/z7Vf0CFs4vDGQLLJUD618C7Uy9T9x3H6mGeOakJz4=;
        b=pmU8+tiOocW+fpFovM5Ke8X9X6z4bX0jUCqYsmp/nFXexuuLtOPVe2pdk8sSw01yhZ
         C1fI+llpDZvWPHANfnR/mtVu4Q+fkCd4dNiDg+7CA1y7aauvyhsik28t7+uzwHCsBb+O
         LkjeeT4/RS6Zz1XaWZSpg8fEPIYezbCxrAa5JrZ4yqPXHRaiyX6Zu5xuLZzo2VftlxDb
         rk4n2L1Rt9lsgR04uXxjP3rnhrd9AyQJF4IpfGQIplJTEGIvicbYQE0MkZZGPRZdiyJ+
         gN/BQG46cVC+WuKc5jYAVRQtA2IlyQ82kRzCLKTqRUunDdElm6EvinY+70h8o90K29A4
         Rz8g==
X-Forwarded-Encrypted: i=1; AHgh+Rqs1cj4bkjQd67rhNUop0hW86mmHK3KC9UFCZ/rLu1BC4LM3jsV1yYGmV0m8LHTZTVb0SZqivQAtR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMqNSDJGukQtMP4mjR/VD+2gxzy0FxZ0oTWlN0pvphwXbCrg3P
	kfrzz3Zmwxs7o/QKVqLrKIOikQFuXLR2vElHbILhYXDtUnEQvE4Nb2Gxr/szmeEGHOX0LnqM5bj
	GmRmpVk8dfUuw3o3Rxylo76cknw4POceSncPaEMTFFk3WbffkeDU5/Sf+RP0ScZY=
X-Gm-Gg: AR+sD113JeW7X0XDjx8f9T74J13kTaz10Al7wOwP4wCr3ZrS0MwW0LM5NwIxyyzGf4L
	i9+yDce3TOia5NLEhXPazW/Dih1XF8yLPQljiDyGPsMtiOxcvxGEdxI9BxWbH0Mj9rgsbzjPjc5
	7Y1jGx0dh7yukQ+Wkza0Klr4qBpEgqX9jLShM/TI33RWL1g7E9R3YaOwkA9jrmQwczNCb29zUi9
	x78YTilQPDtjFOMqPDi0Squf+z+mdmFcqBNTYl3gmIf+7qJWkX33YFzeU3x0scZNN0XUEpjvarH
	/BgFm2jSDubNFtx2umIzHGmaXtrIAFBHyfw+0Y/CAmmstR/lBfWXpYHIskwyZ5jxq/t7VKUky/j
	H6nO15TvCTeLPboQxBMsLav3UiIj5izPhnZaprMin1s20I1fJZp4c59KFuPdnRjdqJpkHfjB7CR
	ck8zaXujmC78Qe2w==
X-Received: by 2002:a05:622a:351:b0:517:6b31:8058 with SMTP id d75a77b69052e-5213e0821f6mr207212741cf.40.1784726272608;
        Wed, 22 Jul 2026 06:17:52 -0700 (PDT)
X-Received: by 2002:a05:622a:351:b0:517:6b31:8058 with SMTP id d75a77b69052e-5213e0821f6mr207212221cf.40.1784726272083;
        Wed, 22 Jul 2026 06:17:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9e4313fsm463602e87.60.2026.07.22.06.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:17:50 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:17:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v5 05/11] power: sequencing: qcom-wcn: Report power
 controllability
Message-ID: <6lxktlm5suakzub7gvlhianc65yeiqjbbodimsikvcicciag3q@ugcdr2gbg4ok>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-5-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-monza-wireless-v5-5-69ec6743543c@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfXztqNTw0N4Ahb
 PntbzlOXikpYGaL2ZB7K+P0c1NrQ3ZsiM2DORmsCp6hAMR2WWUKtgBwdGE0B9P8dcG5ON2nZtSQ
 tKdaVrQ1psapKqtw5DORPxJFeVfGLH0=
X-Proofpoint-ORIG-GUID: NrpMh2S_XGB4yL3ehdo9inZtMYv34yfo
X-Proofpoint-GUID: NrpMh2S_XGB4yL3ehdo9inZtMYv34yfo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfX8BV7FRUiRQzm
 d7HrLXgnb6TfXqukYYKTO4OblYWjtAmIOsOXyB+Bxk+/rhbF8tndGtLUrFwQOH6FZM56MOpTvl1
 RPUPEW2dW2uiqwYKGb1mUoD5uJFJHlkOg8o8o8/wVNvjg2vljnKodikX24M7XH3DamHrO6TxGI5
 +Byn+IkqK2npiJIOP4CNImvtJLd+f4fU5aTRxQCXGC4SqRuTUNFiSJw8e3i5iNLKUKtVp1sxgYS
 Ex2X50d2h9687OwIN3ic2gqNuqhOTjv23W1lVbDV9jgBlU/THl/RkZjYU7YCyfkh98fMP3yW9Nd
 Jmh3Rd88dVdj1RrY4Vhw4uIndDJujbNmuYD39rua2ATXrnNO4EyqrwZ8FBInmdJcdwOfBb+Suai
 MpRpreS5SzNmDEUuKGPzwl0BW3b48KlafgtRQuaZWEcR/Ner5L+rtZW8bsj59XrPvLUMQaOKOw4
 hobVe4tMIuWc+5kuCYw==
X-Authority-Analysis: v=2.4 cv=QahWeMbv c=1 sm=1 tr=0 ts=6a60c301 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=dA91eB7zeV-DSUTtgBcA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220130

On Mon, Jul 20, 2026 at 10:04:07AM +0200, Loic Poulain wrote:
> The "bluetooth" and "wlan" targets drive the BT_EN and WLAN_EN GPIOs to
> gate the respective functions. These GPIOs are optional, on some boards
> they are hardwired to an always-on pull-up and not routed to a host GPIO.
> In that case the corresponding enable/disable callbacks are no-ops, so the
> consumer cannot gate or reset that function on its own.
> 
> Implement the .is_controllable() callback on the "bluetooth" and "wlan"
> targets so that consumers can query this via the pwrseq API.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
