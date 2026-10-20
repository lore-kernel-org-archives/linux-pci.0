Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484933;
	b=2vDt1sU6n6b6AuvaxrPVo4/n+hI0fnPxMGaS/wogsUmRcjOOoVfuY15PahEJO+dIEJ05
	 90MeSAacc7lOZJfOJcp4MGl1SLBztCP+KHhkFxuC32b6XJ5srUy+k7OaOBUzDOvfhpvHv
	 twuIu9qQ/gZ2XqT/6X6pwpDAvpkqGX9pd7vZ77Z8m3mTqDqmTLWvh7HD1vrFT5VREF6jn
	 q9bP818qdElUES4AE+AbE9x6Eao1VSB61y7CU5Spp2KJcsmE29AoJicla+mp67VgSH8jh
	 c5/QqmYTPPHedpi21nv23Vx822uFqFMkiVySZjAQykadE5nPQica9508WqIK6rk37jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484933;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KGfAPHpsq6W/DX/k0Byx8PTAqkC3r1OP0csMJzXqDnw=;
	b=3ALb116vi48UH8SKecMbqflKKsDMr0bi/x2Tkl6AFl7CzW485foBnbyxl9q8qAGPH06R
	 zoeKooiWV87IQpKdP0aoMQgYeuCpknqcYKWxZWuE49jiMY8SU5XBAyWrJkjWtTg9W+9Eb
	 zDZkodpHd/aPNYDveXHv+i5SK5BWwVtTqGETHlupSwnaAHQ3KfXZ++w6rgebWBt9x8O1r
	 A7cqxRE5L5MULuHlZ7yWCU3rUrgwye28NmN6+JysXegG9MoR2r0Qxu7gapGBrW2fqaPt9
	 Li/sRZE1jlU1zU9uRnTXAjsKshRGiKYyCJuzQbnHpPh57O9kOHXDeYTUc28sXEU1xLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lkG+4lf9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fPPcrtSB;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152E606A332
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9152E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lkG+4lf9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fPPcrtSB
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K8PR6b3305949
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KGfAPHpsq6W/DX/k0Byx8PTAqkC3r1OP0csMJzXqDnw=; b=lkG+4lf97J9M1Jcm
	9rFwU/pY9ta+CZlYP8cdyba734bZluqzXOKHaZVvMjFY9cNTZ3g4N4J27pHDTpDJ
	KGp+pK7du9X4blUs5u0KiwWxGdv7n9oiFYG2JUWfieciXhVlJ4wEcOEYQqdMouSp
	0o53zwQVoZlr7Row84twP9dKTQyPZB5+g8fo3XkXfT0nNo8p5JYcOE0QVSXNDOjQ
	Ez7AKlSmZqHxcwIYaw6PFHkN+N4Cnpkb2xpGwuQaBrJ+aZXToBjFPGTMPQF4vRvg
	fb31HTx8bv9LEbhZTWI54XpwEas+L3AEVhEVazZ3XAjf2qpvt2+KJOXToRmyos3q
	rGgzvw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5ssk91-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:28:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ea6b66e53so61569685a.2
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 01:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792484931; x=1793089731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KGfAPHpsq6W/DX/k0Byx8PTAqkC3r1OP0csMJzXqDnw=;
        b=fPPcrtSB17V9olGUvvqwdz7mqYYl/1jUJZdqPUQVSN5IXo8QmecFstCzxB02aj5NNF
         T6oHPDLhHvlrXG3hcAZRNX2RBvVPiggS4iorD+HwH+j/mif1P9oxRPJN8XUeeu82pmEY
         1isest0EXYGauS7MnGnrazG1P4rUT6Trhr9mBwKKksiPOiQEcSx2g7Db4uKIX0IcHrdV
         ySR4sEE+dX5WAKullsUtuzJy+yEUkYA2nH32Ou88N3kbhMY5O4Wtnx5Aab2tWp5G+1Yy
         NXtdqh/tGehq5Q+xKXqxS130pnm/83V7TvYDsu/EgRR2GousuXZ8DcnxxXnpVRUQwoyB
         k9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484931; x=1793089731;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KGfAPHpsq6W/DX/k0Byx8PTAqkC3r1OP0csMJzXqDnw=;
        b=e++wjOwzg1iJR1t02zOxoyJTzZmmH9+jP9SZSbDXaq0vFBf381DVIb48ydq9Y28oUh
         p+pN3qzB773Yr7R511P0EdcnQc6daa2EioQa/PdUqG3pgXJHZD/tNooe4F5Fv8Q6/X3a
         9IIDgolkFt26L3TtnrV3Jzw8+SOrxM3wn0cBBA5tFBMqsYKmy3+8Fw8V+vxZ/yQWywW2
         msFnPTqAIB3ZVglWIr+HqP8XSrNDagG8vLiQB026z1lHGpUrSmIPU077eCOSDQPbOtGM
         FTMO9WB64H1QRsifao92WayhJiLVgr06XLMZTVBIxqEQC+78dNtBE/vhSRLnpjg4v7Y7
         uoqA==
X-Gm-Message-State: AFq9FYKipFl/ukFG6AN75Nmxc266JPj76ld9VRfN0hm7Jx2aRm2cOAZI
	u77I7YZcdWX0o3MT3hq9aKZBfiNmeCtQCNlDzFdW8WDD/v9aat7Yax5qnkZLNA4nLoqqw0cdNlY
	GibGzVNeitUJFYUsbReaXIlgzBlZCcx9GnY3xF2XJoAxzVb4xxIgrxm86jlx/LEQ=
X-Gm-Gg: AYBFou0Os8d73tfq6pXgXDiMjdKjAkeMYpl/6feQXm/ONVXIahTbIjE2uScKMLCkWy1
	drTBYiRHJX+y6GtJZs9X8pybcR0hr3IL+h8FXPVpO9DjYe5lxtrQQFKGzeHz5/qDWUiaxHF+h7L
	EA9QsStwnRT02Mz/E+bWT9drSb/yR9XrU1GyRabLWXvHPBHr/xvGSzqqBhR80fzS57Dy6uGutrc
	mpPsjS+RgSJlJdTyA31kBnAIrS/o0Ry63C7K6VpY3wDgb8dQ63+E/ryCM/mG065qz2aFJzAnXlG
	ckifiyJk1irn0xH9SSUHRNc5MlT1UPnyXnZQZIt3YPot/09++L1M96oVsXbCEIlcI7j1LXJJuAA
	kzA4v0DbmW3hGvElNGilRMA==
X-Received: by 2002:a05:620a:3190:b0:92e:6485:f640 with SMTP id af79cd13be357-93f29d216eemr1869316085a.4.1792484930852;
        Tue, 20 Oct 2026 01:28:50 -0700 (PDT)
X-Received: by 2002:a05:620a:3190:b0:92e:6485:f640 with SMTP id af79cd13be357-93f29d216eemr1869313585a.4.1792484930511;
        Tue, 20 Oct 2026 01:28:50 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b0f75sm5026181a12.13.2026.10.20.01.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 01:28:49 -0700 (PDT)
Message-ID: <ec5ae206-beda-42d5-b152-91c457218374@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 10:28:44 +0200
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
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
        Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
        dragon@radxa.com, Daniele Briguglio <hello@superkali.me>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-4-eda11e5dea8b@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261009-q8b-dts-v2-4-eda11e5dea8b@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMyBTYWx0ZWRfX+7u/cdB41fP0
 IipFV/TnP+KhNh7D2OoQ6Ghb1Ex6ZqfqtTi8uLGWHN74UU8w+ryfALBJeNW17Q9V3fZI6AzXJF4
 lzzMq54U4rDSoNWtod/MINXI1Sh2oCSKG+L8xrAks2/NY0OrnRp4pVXuHiM+e37KhTiQJEp4ODn
 5x8jwJckZzQ89oYtwrQRtNuvhyOeEnJ5LIdLure11zY0Te3oexzkMfiQMc8u1NrVxftqiH+v3Vi
 VchWBd2ak37JwJRzeM9CKsRSzW6aVxCa5QO/gOVEThEMVYKWX99Rp4HQhIzS/bfsF4JTaT9MhJI
 7vL4Y8AnF68m5ejN3LXXAwsufKsKjD4TRpIgLWq6ei1su7tPXCkeQ99ju9bNSQAW2YRfM/WKi9h
 0rO2DFgXzSjU0PyxVWNL7TJx3C+lQ1QrnhKnUnRKOFOPlOo8Wc8vTL1aKLyt9aY9p7I7jhgIdra
 3CelaATaig6YTnvneRA==
X-Authority-Analysis: v=2.4 cv=fIusTpae c=1 sm=1 tr=0 ts=6ad72643 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=6_vhy4Ov9suG7DV3KvwA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: O8ThTrw3cKob8gCQdM_3ILD0KNlA15RI
X-Proofpoint-ORIG-GUID: O8ThTrw3cKob8gCQdM_3ILD0KNlA15RI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMyBTYWx0ZWRfX7I09Wy7I6FF4
 m7+fCsn3jNEBfNHORjLbZvgaSyNQV2XMylDtg+g6bNPOLd4tjkALOmAXAmjEevTCoVySDhqFYpW
 5Vk/om+LwJz0F1+HWkVKCMBwy7h5UPc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200033

On 10/9/26 9:55 AM, Xilin Wu wrote:
> Add initial device tree support for the Radxa Dragon Q8B,
> a single-board computer based on the Qualcomm Snapdragon 8cx Gen 3
> SC8280XP platform.

[...]

> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";

No i2c bus and hpd?

Konrad
