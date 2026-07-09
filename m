Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4207284B29
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603212; cv=none; b=lInZnD504PzumrZuOYQk0kLmXr/RsfUwYLXVUfjpM4uCHNwoD0+Dmgulg7lQb5xS3zY7RYIbxMoeo1B95InjyR0RUBCcOhNR9FWDAaRidOgf81mSPMzH0I5YqEpTC3mUfwCx/MQmXSIeDYudFlUVrTnw/0qOARfdzn3ioMj7QDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603212; c=relaxed/simple;
	bh=8Q8ta+VdsGwXMue9GbUVxrxwKkG+ginY8hWvOLa4dwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgIhPoFfifDMPlwJ/y8yBp5e5z/k+pk+gidMBiQrTSm3UCGOrxm+XiZTuyWkjHg4fZts4g1W6ho9WCrdlPBtNPaD5+h+2AMO8IHO4RX91qbY5FJcJXmvcplCi5zm96lGRaTKK6myBp4ItmhaKtqZNnU+qmKIpGetOH5b+4yM6WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a8ob7Q6V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HH6Wfm95; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a8ob7Q6V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HH6Wfm95"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNV8Z1667893
	for <linux-pci@vger.kernel.org>; Thu, 9 Jul 2026 13:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfOnLFZyqQTqLo/hudr5az1+iraPV0eym3RgxngeWko=; b=a8ob7Q6VZXWIFnhU
	PNVSutWcXNGnI3MQOV3ZUGgE9AHGqTeh9KORcBTyq771CENlkIPEsTdpRtg/FVcX
	7xI6N02YJFvGDVO1wkwL9HoImGdvS2VwX13qANcZqLzcMs7CAR3awH2Vkjp2PAdT
	I50Qbe+i5ypeLpVY8N76d0VpdWG7TY6LcPw/v4jKiOtVCkWPPXY40ho5MT6VOTki
	H/JTuDJr5ao66vYlHflvQfoqHQ1SYkSd6rw0xXcezIqAluFwVL0XqXetyMg+d++d
	vT1wpUPyRW6ZSct8wHXvIaf/nClXJiZsJqJxPDR0n3WrPg9UvjvuN7c18TIuNdMz
	ugRLRQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6kxf5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 13:20:09 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bf9df2eabso2257291cf.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783603208; x=1784208008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfOnLFZyqQTqLo/hudr5az1+iraPV0eym3RgxngeWko=;
        b=HH6Wfm95fHZaBwHsT0Hb3Ks0Z96rkPnpueUgpEYRotHz2cWeqSMot8PafLi9EATkze
         m6fKESmG22gdNdiTPi1nMcSAZ25+paTs1Sj6zS6iZGDerIH3pClXDu/LeQvSK2a7UmDH
         c0SGZWk+ZENJG375acuzcVShpXbEKv+QnBbhZUo4Q2JFwrjqjse+Lym7KF5F+CyWY7yB
         IFk5P83yaC+Q6g/U326tTRWiOYOl6e66w26D3hpdAmU5q6U19c0sagnFPz4IURzRSg5H
         ygM0yyELHTz/qvMXoVIcDRZ+KE9/AWFbnWGqQZ3B2sKUAMfRgjGTeytm0HTZqoeKpIcU
         YQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783603208; x=1784208008;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfOnLFZyqQTqLo/hudr5az1+iraPV0eym3RgxngeWko=;
        b=SPLFginn/0FBuVAHo/n3jkrZdGhk//OImQTC1STH3OQcRjYQ6nQfKZK+odCOhmM5kU
         LE42w6bS+HnKNdDlIhaq/xiiDebbj+p9P+smEY0BfkC5XjMiATtG/ILyQemE+Vun2zKM
         QTg7h2WZbnkAvQJzwQhQn1aLZ59+x9fQZqD95Sc9hgFHghN2Wv2hMfzM/rvjeRmd6Eac
         ft9Q9rmPf6Mdi68ugAmsLDB0eXFAJ8/JQrtQDdHw/YW6wSfygRaC58KKJmZLtGPKozEu
         WZ+RzUhl8WYTWt7YyfQkm4G4pVU5qMI8Oj7vsIfZE5IzxK7Ed+JA95EARAZ49tK1OI7u
         YiEg==
X-Forwarded-Encrypted: i=1; AHgh+RqQw/w0/SL8xIqCtUYbShSIh/U4p9VnFNDgNXIp2aRMeWgYwGJQ1zTETrrUMkMhJHu5T3LOtmoICOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNgAQAq4yFPjRQSYqrjbtOU3YPaPgC3wTGOyCdKrcBPGXlVjPk
	dtRChYxbWSjLOskhU6iKS86mcFHop+utm4Z+qAJkz0w2VlWSzjJC1SgldyB+jqDGXWUkkpOLr4+
	T61MScfAO4YcVDGZNF0+jZmL8HRfGT6CLigmEftVUhSBtqpe6nHmDMt7+mVpvwd4=
X-Gm-Gg: AfdE7ckd+lYcTvutjtZpAuAPo7tH3hkx9SUsIRrCI53B8r6if74K8R2fiAWLB+umUPf
	5camTTeWpZklnZni5vlN6uHD4cFX0Fi9jT+AxWsP2PopXm3KrNRu3uIMs4m6KhOZNz49X3ZIES6
	VBoyyFZ+cPgyO50TWhhs7GBrFu7KqhYW3zUSaBdBSPlChLkiVqexhhIMjSVVC5TEBTC5WLE1WzQ
	WukVdTwJh6+j+RFQw6N8X5VqoD2UAoCzvwPoQIp3HDxS0Mfu1+Nqdc538HgSxwPLlQeZXsRNq8N
	2TckWIcZmedE7rpYWYhBEJkHG+Wi7vVWLdlm7UHNTwHlYK6I8BcxImP680hZTkMDrPJmYmZAMTj
	7spRqR3NgbDq6Wd9x/SX/aECVTQgrhsf+Mkw=
X-Received: by 2002:ac8:5a07:0:b0:517:5e32:f3ac with SMTP id d75a77b69052e-51c964106e8mr34227561cf.0.1783603203366;
        Thu, 09 Jul 2026 06:20:03 -0700 (PDT)
X-Received: by 2002:ac8:5a07:0:b0:517:5e32:f3ac with SMTP id d75a77b69052e-51c964106e8mr34227131cf.0.1783603202833;
        Thu, 09 Jul 2026 06:20:02 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15df03dccfsm159720566b.62.2026.07.09.06.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 06:20:02 -0700 (PDT)
Message-ID: <814763aa-d102-4b1e-95aa-01dad1bb3c0e@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 15:19:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] PCI: qcom: enable Link retain logic for Hamoa
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20260709-link_retain-v3-0-81a9d187bb61@oss.qualcomm.com>
 <20260709-link_retain-v3-4-81a9d187bb61@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260709-link_retain-v3-4-81a9d187bb61@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEzMCBTYWx0ZWRfX5lhiZ1VSVI8D
 6ktQ225mlstiQtNKUmhR1EntiCgSifZHMWt1kZ9oEfc5VueU45wWFXW/8bhRgNpBaNvYj6bqzqk
 icVbHt7LWsudy6wxG/NQ6ctWhhl0rKA=
X-Proofpoint-GUID: UFxuUUWYAbfLrHb9cDnJEeog3JYWnakG
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4fa009 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6pHcnep46kEejBPVP2gA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: UFxuUUWYAbfLrHb9cDnJEeog3JYWnakG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEzMCBTYWx0ZWRfX+3lNyMUGdyR1
 e50IYMhkoETwY0tnVO6z98dbKRYnijgFw4b2zYgUXSX/KNZPX6VHtdJZoEp0/AsllUNqqQMVa6Y
 5+W4j425I/sv3eO9nA/0Ygpxcre0tawAjl/P3B53PKrn6ZTSOgHGoXwWQGzWtc760Qk2+vxz7sL
 c7kC9PnDRtkM+dnqERHY7llFiuj6rL9KUYg/NLTcYUG7k8muTaja0jlpqU3oVCV2gi7ZL0YSjfv
 3CxfAt10axH6Bb4bTRvwZ16fmnWmBQHwAPzjzSFht+XEA83It3ewzEMsCSQaDyVs30pl6PqVIYs
 i53xPwk2QPMU83uvu/CDzJJGe9K881gm75a5+a3zCK5ZHm8hE73B/5VGO6ou5hzyJtLOWT8jMng
 sxw63mKjpuH5wWqI4xYgxx36kG+j03oK6vrDKQts5NG6RYFMoePUsTZ99NSz7RGxVLywX8hXAGD
 p+/S8N4HyISwPXdUteQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090130

On 7/9/26 8:35 AM, Krishna Chaitanya Chundru wrote:
> The Hamoa platform supports keeping the PCIe link active across
> bootloader and kernel handoff. To take advantage of this, introduce a
> specific configuration (cfg_x1e80100) with link_retain = true and
> update the device match table to use it.
> 
> Tested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
