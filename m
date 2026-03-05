Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13AE374163
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699983; cv=none; b=e7B8PhbFJL4xR9Uw1wJCfBUf6vgbN/AxVP7CULOZpI/XfGDaKNzrVgtpufydnCq26C8zMMIA/NX2MmhZvtgq03je7jMupr7YE47sfxTJv+0VEMLl475Yipr2EEUk7fPOW+f65YEvZy4j6KZKT8R2BWTuko/MkVZnx8ltbhQyHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699983; c=relaxed/simple;
	bh=6xaS693NEPvMsmPDTvB8J6q5UsLGM4wm4qipY7xfOGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgTe0q7m7j1NKTtYNv139E66TgtaQLNyzLwI9EWXMHh2i5HZdkNqFBlpffJraGOur7YSh4NPQRfTikfPvWH32TQv/zeoihfDPPODDJrfiZG6/btGPrNkNkrqkz8gGd/0k5FZcdnAjuyWiuWvd1v9QAz4bQiJZnNdF7OXpFi3NnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zhs1szgR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jftXYqSq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zhs1szgR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jftXYqSq"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6254KIL61853037
	for <linux-pci@vger.kernel.org>; Thu, 5 Mar 2026 08:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kdWMwgc8nLSwvc7+zSIUZsTz2pEGRMvswxdPfflnvOo=; b=Zhs1szgRs6PvG6yC
	/K6l0Og7co3C6ED8icQT7ngtsI9G5Zp17IaIYa/MOFJSyTxAUHo39qtMLOBGQhpj
	JO9fE/F/E4F4LvhAKnAlFKn+fH9sEpkGqfNT9M43WTCJkjqaFeUzfOGpTrDAGNtC
	tA5poP4iW9oFEFa2er9A5XyBDJ8CedmbmCYM1jjJmOXgrD4UqsM96/EbUTiVA/x+
	+Hq4ib0d4uJFejDRNFTAYPM9OxAzG41cfjw0IJBJVDWkmbFbGS1eLwFkvUDxUI+x
	i9yGzbk3U3z2KxBfUGbK5GoyOmpZPSUHhrYGJ9ek999ywA1Q/YTR3XTo5MWWFrPw
	1lqwYw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq2q80stk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 08:39:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb50dfd542so577162985a.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 00:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772699980; x=1773304780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kdWMwgc8nLSwvc7+zSIUZsTz2pEGRMvswxdPfflnvOo=;
        b=jftXYqSqtrokdujho1rSZ8RV2+df0VSJJ/M8ZUZxSfL+guycXk5e5Oa+/kyiYv6qq7
         wDt7pgwE82GoCanbnE56n+QEoFdpyD0IDJAXa2uedcbQvZQWJRRzpQWeE+FA2evLbImb
         HHx25k81XwtVs8AYIfGmGN1Heris1W4EH+3TjG9IsAQO2tfFNcYJFHacx8H5ixGQjhjp
         YhLkHjONVRBKpyl+EoAHQo2i8UAnKVr+iozz53JeeF4uhO8r6lRrGpcB/0Hhik80AyD3
         +bPbUwPZDvHgZwinc1JyJ5+XebVWXjYBrsXBjFQwXL48HKIXO1qH/SWx+i+izxWR3tKA
         fXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772699980; x=1773304780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdWMwgc8nLSwvc7+zSIUZsTz2pEGRMvswxdPfflnvOo=;
        b=U89WsX+HuQIHhQwJlt59Xic4U4IekK2UbdQSh3awJx/rC5O9lAiPbpqTupWbvoX8AY
         9WKmsUK7aqkzfi4jQjt3G+8KuyBy+q83/jpgjx3/Q+44O7f++u0zAhnaUAnqu+zzBekh
         TVUs8fe6T//ILF+dPoXM8lGqEA2S4ujXKIdKIh/cRzkGCgQa6KsuTWu7mkFyKa4PXt43
         eHptNi84mjqr4JH/w602Pjbjytw1lVnaCzEf1Y4mYFxB8okTcYaniO2mQTHTqEm8UxWO
         Kvx8k7WKmtP681sfDbMp6Hb+H/oQSc8vgXTdpg/eQ2xYJAnbaUZg9DD2roPOoInBnH5l
         ZC0w==
X-Forwarded-Encrypted: i=1; AJvYcCUr+CAoQovE+f+Eo2Mao/DMsHz+EMT0jBimpy1c24rBscN7bVbcVT/Ysai6zpq0LbmLJ4O8dZTo294=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx93jH396KMDNZpHXxL1TIe7Ufkw5LjGXqI7qyOgJeAUIUyBfB0
	3B1rtHs5dHdA2hTECEnHIqxsxeM0kBl12h4U49jUUbQdQPL4tRjSgXnXEyR/xhb5I5g5AaoKqSK
	OOpU9Bk39J5fYizCxrGqToT/AULvkEDXH/gUKu52kab0P4AgqKIRUIIVjjgorvGA=
X-Gm-Gg: ATEYQzyO1FL/TK5kp/km8xkJt1BZTehBWuWwW9i1Iya+Zvy/kX2JSyQaEq1lc2FTS53
	IPr4UdC2rLBPMnMM4xcqUem8lIKLMTEuA5UQ61DF8XvNfTssWymHQ9AETEjNRP/DDz1u0Gvm2ZC
	qCZdYRrJw1dHUBxz24AyZJ/p/cOuwImcRlFv+PSu3XN1ScB3x9Hl8AAevNB/90wuKUODUkz8fhF
	Y11Y2IdBbOyZbUgN2ianXZLYKwa7hUtt4zyn2zoH2Y8pN7yXE5gZJ50fksCl0NBzTvGeYQa/+5B
	QL32ldBKMqE0oyB7ShECqotID19Bk/yA/r8wCPdkkQPkWfHqKgqXtpe7ivEZqlfp93TWSaaGXSU
	2A59buxOrLbAtMi+gogUPjDIgIOI8UpV/st970QtptGwXmw2fuNcBN4Q36IjM3Zl7eeceObyOVl
	CsxsI=
X-Received: by 2002:a05:620a:404c:b0:8c7:1b40:d096 with SMTP id af79cd13be357-8cd5afcdcfbmr452358385a.9.1772699980142;
        Thu, 05 Mar 2026 00:39:40 -0800 (PST)
X-Received: by 2002:a05:620a:404c:b0:8c7:1b40:d096 with SMTP id af79cd13be357-8cd5afcdcfbmr452356985a.9.1772699979710;
        Thu, 05 Mar 2026 00:39:39 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fac06e3fasm6657504a12.25.2026.03.05.00.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 00:39:38 -0800 (PST)
Message-ID: <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 09:39:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
To: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260304175735.2660419-23-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MepPWtt65CBiX36exrtlfH4XnhTcBOnt
X-Proofpoint-ORIG-GUID: MepPWtt65CBiX36exrtlfH4XnhTcBOnt
X-Authority-Analysis: v=2.4 cv=GecaXAXL c=1 sm=1 tr=0 ts=69a9414d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=8AirrxEcAAAA:8 a=GJStlgXwfe-SXQdWLvAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA2OCBTYWx0ZWRfX1AO9BFhvleUB
 cBTaQu5VUFJTVhl3EVg1ybekfOcq5Emupytzp4z5oR/3vuwdcyep0Nadg9yEeUkohTR10aUlQ94
 xVzjMXxYO0nX8olEb4OwpPGsmtuByT1GMu+3K7cFZnvNRBwDGfib05qR7H31FVZ8MD9WQis+bMY
 Wytzyex7wiYOAOlxUgpzZ/AyQ9nvflSF3Ww/POwVhqVJnz2W+ZHOSIuACMngkadUzUFBAfN4imE
 XmvJfJawUZ6Q6NhiU9DFcUfqLdX8U2nB3ICPx9YRU87whxsfxroOPeDW2k8/qHzuFB4zLqbeKdz
 rY2JAcAvjfVJqEFjU88v544ke2pcb32ZVzh6zV3KZ59y4huBGmvNSJyhxr/JLKJj0clyegyo70v
 VZAw+KvfS3qo4sXI+kiJUTm+WskifveBq3xAUhirz1AgJKTb9KKo5vD6TZGS3B/IROSxWyTfTo+
 5p8v7zoWyA0pdNGdIGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050068

On 3/4/26 6:57 PM, Vladimir Oltean wrote:
> Some pragmatic shortcuts are being taken by PHY consumer driver authors,
> which put a burden on the framework. A lot of these can be caught during
> review.
> 
> Make sure the linux-phy list is copied on as many keywords that a regex
> can reasonably catch.
> 
> For simplicity sake this is not perfect (devm_ and of_ are not valid
> prefixes for all function names), but I tried to pay attention on
> avoiding false matches on things like:
> - drivers/net/vendor/device/phy.h
> - include/linux/phy.h - network PHY, not generic PHY
> 
> So I used \b to try to match on actual word boundaries and be explicit
> about what is matched on.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55af015174a5..bdfa47d9c774 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10713,6 +10713,7 @@ F:	Documentation/devicetree/bindings/phy/
>  F:	drivers/phy/
>  F:	include/dt-bindings/phy/
>  F:	include/linux/phy/
> +K:	\b(devm_)?(of_)?phy_(create|destroy|init|exit|reset|power_(on|off)|configure|validate|calibrate|(get|set)_(mode|media|speed|bus_width|drvdata)|get_max_link_rate|pm_runtime_(get|put)|notify_(connect|disconnect|state)|get|put|optional_get|provider_(un)?register|simple_xlate|(create|remove)_lookup)\b|(struct\s+)?phy(_ops|_attrs|_lookup|_provider)?\b|linux/phy/phy\.h|phy-props\.h|phy-provider\.h

Would looking for the devm/of_phy_ prefix followed by an open parentheses
not suffice for the 'has function call' case, instead of listing all
currently present exported functions?

My worry is that this approach is overbuilt and absolutely no one will
remember to update it

Konrad
