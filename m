Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1C33B6C2
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599264; cv=none; b=qhotP23/Q5Yq38og/9FE+vS2e7ucbhMK8145P2bzGD8dBfvmBapESD16ykltjcgZC6A2RoYYq8EIfwi9/O9BZRYhgN/siz4/f1RT1cFP2dmDQM5Rct6ALlRm1/+5HTp4uRSseeA+K3gEFS69/Gh1YCtZn2LqgG5u8vmZTtXqoqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599264; c=relaxed/simple;
	bh=0qnHLqAs5qKXRZ3SwSRRXmZ/pwA2WYkJLsmOPNdmiTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFBOqCU/NFGJEiafosENSV3315qbXZBn/JXvCaMm4yuhv69+K10NZ8ubNtq7n8t3Uepffdaqw461KZ2mp0L+yKqjxy8JPQZMa4XRIyyvN8sH0vdbx1JDqQMxflOVZ0XHUT3wP2JScIpJXtXfyCCRnBJZSlQ6FW9/SiURlddEWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OVGNQAqE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g/jx4RyX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OVGNQAqE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g/jx4RyX"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S927gI811586
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1g2tc08NYFOW9PyN0Q/fD1WgNK60ygQO4ur4eDmhFgk=; b=OVGNQAqEyJXdmDbO
	aX2gznPXCvBCwLJ4xK/OpqjbaCvvSwc1KeNGm/O01eQWMAlYDlKB9OJALSBfeL4r
	9xtn/GECQXB+R9N2zUluP7CwdvXl62t0TYrydk8Hucqk6htd6HktYD+XRIITjTmf
	xccgtRCt1vWAPxHQkm/RVAaCaOGUwwEkvgnSIZbMorPoTOgOqO/j2RaWBHGw62jG
	ri/Oo1v52yjuh8kj/HMK+NQZHy4gT5GrifNZGVKnknxs0OLYqWrawc5RDHl+cGPM
	nl6sOXory+jz3KDsHJ3c03uUOeRdbMJJRHuBarobuF6wiaYcpcbjbtNPwVEfOL+Y
	BlD9Zw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by6qbj7kq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:21:01 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a262380deso18756066d6.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 03:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769599261; x=1770204061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1g2tc08NYFOW9PyN0Q/fD1WgNK60ygQO4ur4eDmhFgk=;
        b=g/jx4RyXoh3QRzM4Uipsx7+oDExNOELAv9PrLSSXG/soQdhPFB1XBHMDosPk0ThBqb
         uT8MWt1Qz/R/sddO89dmHwtrwYPwnsgg9Imd1C5jXBT6TVd9Ix/zVYU0boxDCv4Dm3ZZ
         CqJfxpAAKe6A9yr3k9GtatX+tK0Lxyy+iVkzyh1xwflHrb+CpbgzojDm9tH7h7BGqduL
         zw0ENELZ3qgf1H2XJpdETphAKPwfrpSaHsYOqvQjzC+Yeqa81uZ15rgnuO5lhA4DmxAN
         ESbP5rXohrNLc5uYMnE0bio0qyUh893LahXogR8kthDkE521YSR2NuOq/TQHrTbn2V9C
         xBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599261; x=1770204061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1g2tc08NYFOW9PyN0Q/fD1WgNK60ygQO4ur4eDmhFgk=;
        b=SQLONcmtGBu0ewT6QLMNRZxHaGZ2UgGIoLNujX/NDY653Va0DOSYeOZnqOSJnXs9n/
         NzTzAsE931YYKhb/X7XfUe0RO/rf2vg8wq6gq5dKE9+dbQ3Nt/q5kDSRb3WUg3LAsf1W
         qouJ2jBGlpCWWZyOi+m5r5WXy7BfNKpMyIqv8XEcFwgk4novIpHRPePbYqheN58Srd8x
         ovcjUOR4D5+slst5DTx5LvQ7i9IznDZ5GtnYrRYOLJg8LIyufVKOqiczaySeG+a/XWVh
         30iikUJglOb1ocLSyj2ODQ5PvKxA8V7RqijWoQooHWxRS2/MI+O0CIMJOdNMQ60bxpPa
         ZgCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeHtn45svq8Jn6P4klBWZ9++NG/zkU3jvHC+SnpCSSrJC5wG6alFP2Po7+AuD3OarZUaokIbRltX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5BmQBOGxHKP05Bf272ttAwnPriHP7FA2lyf7hQBs73/Tmyu6
	SRax3xFmo/EW8uQpKbLIWN4TOiBAPWEuD6hfxvwmoV/hzeAfiVs1bTc4nlDjK8UnDFqNUvP9NH6
	0TaR8nV1QLHKkYGFfRRWhqNa4rZ5chEz4VKkPQDAveO6LD58hJ1KTTcLdmc3xxzg=
X-Gm-Gg: AZuq6aLLMi+p1JySo9u4x1y7HbcCSh6XSpqrTZPSm4C145K9HYxtn/QfWQcVkdpf161
	D116vQB1bgk4qUtZFs4wPh6ukNnFv22eH3q3CJxVsDF0Xlpj6xTN7ZNNzqouR1wTuj//GtTtiMJ
	ksaSE+e7Plo9o00TtCi1KQ8uG6iE2wxQfGw1NkewrXxGDfdxg1uBlttXAi6cHQ2v8cfCI9IvJpm
	ah+ubVXK8rMt24NW/biu0pMvpVsh/eCJcdTWLz7PZ2eVkYetWkUAnYDKxHHSB0XcNKzLPGgqdf3
	NjP/C4g+rYEeMgJZMPQFmV4Uh93X4tsLvQ20SY3stuH/O49/qAM51WtZ6gjOfmcNZ0P1PaNMbRO
	khcOIcCwoX4EZC6zUCOW05j61UEZhWA4kjEThsJJNtKICOMz5loWZOlirMwVJnnPJALs=
X-Received: by 2002:a05:6214:5c92:b0:795:c55c:87de with SMTP id 6a1803df08f44-894d786e265mr9868186d6.5.1769599260710;
        Wed, 28 Jan 2026 03:21:00 -0800 (PST)
X-Received: by 2002:a05:6214:5c92:b0:795:c55c:87de with SMTP id 6a1803df08f44-894d786e265mr9867946d6.5.1769599260101;
        Wed, 28 Jan 2026 03:21:00 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b44527eesm1422612a12.9.2026.01.28.03.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 03:20:59 -0800 (PST)
Message-ID: <56b686d8-d526-4e11-9b5b-b98e4f1f72d0@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 12:20:55 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: sm8650: Add sound DAI prefix for
 DP
To: Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-0-c55ec1b5d8bf@linaro.org>
 <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-6-c55ec1b5d8bf@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-6-c55ec1b5d8bf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JKZJR8w6xbcB47L-6I6Wk4T52j0s5shF
X-Authority-Analysis: v=2.4 cv=Z4Dh3XRA c=1 sm=1 tr=0 ts=6979f11d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=UpTyAFhicMDBmGaZp7IA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: JKZJR8w6xbcB47L-6I6Wk4T52j0s5shF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA5MiBTYWx0ZWRfX9Bo3I3RJqCYp
 tI+lKfp4U2scrAV1RBBzV2pn5BwCIT1wUiLD2yBb94Jgv3WxnCf0qC9ldV4Po3t51ZV81DkDksW
 Xr/HFP1vwhPy6fxuVFWwKYhDoH88SfSHDbHHg0UJ9vPoEXOdMOswWgb47+gyEtney80ZyLbT4Rw
 SNm4Vo+tOAGknZouc0cYN0E6jnDHsSLccWy87PrNf9ejF7g4fkhrWYaXn5VljvjF+F+VCCpZK5l
 Mj8ty2XMtq9b5CXMvWBjFOIVDpQherY7sDjUAPxh5oJ4pRQe43FT22vIsle11VCbm27r6JmX3Qb
 DRLA0gSkffwvRaAuGBafn6rZ9YmzZJT4t+OuO+F7g8dnLzPj3uAr8KnEklrgALTopaZbIDGIR7V
 FbAXqpylg7PFM3mzmmHrnUTxD8yYEbdnJ4rtYtvALLSOovrF1GsrN2H/wtxiKoMSJq0jIZB4vjV
 kL1cMzwzHGpDSNa+a2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280092

On 1/27/26 10:57 AM, Neil Armstrong wrote:
> Sound DAI devices exposing same set of mixers, e.g. each DisplayPort
> controller, need to add dedicated prefix for these mixers to avoid
> conflicts and to allow ALSA to properly configure given instance.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
