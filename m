Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B302A47F2CD
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328192; cv=none; b=V8VRbBg+gof5kVltqprVBg765YWFw1TKqe1UPBsj4+qqsJlkaEPijtxnaRbGE61PzLoV2g6WShpDXUuWBkwLlCRcY5oZdgT/gBthZunlu/wcYAoSD1uHwM6k+fyUbNhKHcZ7xg4jiA6nDeYtn7sDRtoxGYwvhWCXrH/TcraKUm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328192; c=relaxed/simple;
	bh=eU3rIagD/DJkspdzzDXpQLbCoAx9UdH+KUAOnRqLvQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDA+U3QtBYWIw3gOYW69Z/c6b3aXRh+3S4TSnosqqUL4WSURUHDfVti5SBK5tuZEy96W9oSGKxaGT/q/k2Dw7ciRL9q84onJBQVyMEXT4ByLQGxyHQx674deBNaBhL8YO20kecekEwNMBTAbHQrobnNXkZyW2XSKWHT72N/klxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R5zwqaXs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jl2q0GQ7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R5zwqaXs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jl2q0GQ7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TCIedI1727966
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 12:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xP3ywTkDvhhxUcM07PGoh5VmOojNwTFiUi/voo4w34o=; b=R5zwqaXsVQskLj4h
	cPx8jKeFWgDQkG8+6lQkJbuYaN7v5nkUmN+stni7jjCyKbve85qqHhfgwlUdW4Hx
	Hr3owy5LP8SfPElGTtoT3VLrBhDNrHIrgX1iWtzXwIZlvHj8GSNKWKjpSDc89q+5
	Huak3p5J8nZV8s6+1raiWwHphhhYxHv3mCSW7dnkreOODRqYTPv/fSJz/j9c7ycb
	WTUTKGyTErt1OsfESHkGtFS0nk76YJU5aOn4Uuf+3DBht2txoanqqUXlO5VXrnn4
	ssQqVD2TQuJp6jkMQOa0hqgK5Ecujighw2NljBSoAh0e9GTI36Dwzkbw7JUrALLX
	6VdfvA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqhdp81e7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 12:29:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51e9d892f0dso2761251cf.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785328185; x=1785932985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xP3ywTkDvhhxUcM07PGoh5VmOojNwTFiUi/voo4w34o=;
        b=Jl2q0GQ7ztfNDmD1lrTWrj8/CfZnjEPlOSUg9PlG5vikD8k3EeThvrEodA0H2AsXUq
         rlR7b5nvi+iTRN4QblpW4sHq9kLzBkShSqK6KrIjgQFdtvuYyQRRRzeZsJzdsdmhg2F9
         yLmlwXhkHjEblwRcS459eZs0l8De8V3TuLQ0f0EPkquRs6q9uUn/Q/ILgxasJmgpFseQ
         CikwHqxViAGZHAflXa4F+t2wYJisPwJCoz4Up6IATLOtsz+Do0X9sMLcfy/bJ7g2ghAj
         lDNtJq/pLrUdWokrTq65pa84AksFPd2DJxb4tw0x2X301/vbNKG/yKshd8ANHsTOIlII
         UAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785328185; x=1785932985;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xP3ywTkDvhhxUcM07PGoh5VmOojNwTFiUi/voo4w34o=;
        b=s4BMznKrnrN6d2leK8pDyROoiBhc0mhZs+wMxSgtGpXAP7jTvbBfkkZPUtY5zc85jL
         CniOuBvsOHTNKQSQp2KiY4AcDxWG1CPFW6EQAR+ISX2SAI8vTZVsYbxzCkcLlD4NCgiZ
         ebSpDJilACIsxrIMa5H6w/vpSafVKuXuw2K9lSuKU6QVuaJ3gc1aNpCA5FcZFPI9VxOZ
         qm9phvqC72F5p6IesAZCFA5c+9Mc9xEg6hrKdXhOZocFwFieivHZq0xGRuX56fP3nbbj
         65w9LXtSvlNDIGwWkzN+50I9Yzls2TSrX1GAPBqwetpfIVage4q1lNPAyndrNZzlX49c
         eDxw==
X-Forwarded-Encrypted: i=1; AHgh+Royj328kJsCBD9tdMSMdo2D1UX1ZRwO8hOL25sHSJ1Qr4vzUnizPdrZqwuZzvz++zuWZ/FRxE0q/UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ8jViN3rm6R3g90a7D+iuyUOq2LlzSae3JMCBgKXRUD0W879O
	UvdZ1lB4P/HpUbHUN2NF8NKymiEryA5KuSNzmryrmsmN64BBFNV1TfmsuJ4Rk4lEiAbmiRQK0cD
	HF9ueDbFYYyJUu2f13OaT2cZtbz01pGOxdwuunPgUj1YW1nos11OXb2uxefvhkYc=
X-Gm-Gg: AR+sD12TBToOUKAoedjzmmQg5dO5wC57awZIcnee9WN1X5sEz0L0f/qyXjQ4t8rJVN/
	ADSX/lAnz0b9IjtK5jcvCj+7Cyt8w+GRnON70jS5xIgzSeFBchf53LvvKfNUuU9pvGhWRSALmtw
	ul+lzpWPuZvXgMBdaU1yZwv5OJfwnl83XOsSNGml6xpKm/JK2OvYd3nJq+UpyHI/XahMqsIRhCm
	pO72d2CJTXRtrvpA0xwiRnmDOkydDIuKv4mFFoI4anllnDQdEJOFsg5ZaiIYzp8FqOy8gtALnJx
	Mb7CDDzm18EZYlortmQzBIJgXm96eCuIdibTYJkxV1GllX0MTsbDS0rCicvJL+y6jw67JTHIeRW
	49wfLEYlOIV0uq/1kxQXinTAo
X-Received: by 2002:a05:620a:469e:b0:92e:5ef1:9072 with SMTP id af79cd13be357-93302679f1amr590483685a.2.1785328184521;
        Wed, 29 Jul 2026 05:29:44 -0700 (PDT)
X-Received: by 2002:a05:620a:469e:b0:92e:5ef1:9072 with SMTP id af79cd13be357-93302679f1amr590478085a.2.1785328183945;
        Wed, 29 Jul 2026 05:29:43 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f8f981705sm53805166b.9.2026.07.29.05.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 05:29:43 -0700 (PDT)
Message-ID: <95c33eec-8eec-4d01-b0f0-1ae33ebb0bd9@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:29:40 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: kodiak: mark PCIe root port as
 bridge
To: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-5-2d100f30e202@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-5-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mSMwzJhF3IKq_ypuv9vXO7uUvHjMTu3g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMyBTYWx0ZWRfXyKmp08IVSByx
 ibzxM6Id+0sSmIhYAzbCmuLjFB9/R6eJsm2cFYh4KPAWi+ZhG64fAkUfckZ1OxqYaVLMTCJH1BG
 iG4QmFnCLHnubmuw8PLSXpEPoHrMnJI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMyBTYWx0ZWRfXwoPu82sRnO5J
 AYANpguaq1YK0CF7VsslcvhILRtJ9S+0d1J3xn360jtQVuQaT2+XTTn9ccS3flAbuhheMZ8mMf/
 qV4+Dto0kEYLUR2YSjNYxkt5GA0HhmiDr3WhyQvS4SQKfZ5CTkIB/ESI2W7s85SNWPg3qHgE//+
 IEU9aIvQfUtm2sWxcTCGgP90SPvYPRD5qCeiDvpo8pfLUrhhuJhRFyevOS0jLdSUPNnn4sgrRnb
 uT71U3r9NOq/SYcDMTA5CIeFWimXBqdM11TT6IURzD4Jrv1nYtvQuYDU3nafErdAtOBKNer1H6P
 V5YkE65sdd9+G+FUxglFzxoWoqQKpXmiVq2SFiECNsWN/wLt4RQOOXzaO+rRrmn+MCscISzw/cP
 fXRWIxMS2S8AZZjYqGDpEkr9IWPNHR1GQ1lr7AHn50qqk/Wg1qf/OZen+rmQRPuVV8zZu2xDThN
 VDabus2xwg2MBApNIKQ==
X-Proofpoint-ORIG-GUID: mSMwzJhF3IKq_ypuv9vXO7uUvHjMTu3g
X-Authority-Analysis: v=2.4 cv=TPF1jVla c=1 sm=1 tr=0 ts=6a69f239 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=fipHztts28RoyCzfkYEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290103

On 7/27/26 5:45 PM, Rahul Samana wrote:
> The PCI core needs to associate the DT node below the QCS6490 PCIe host
> bridge with the enumerated PCI-to-PCI bridge device before child nodes can
> be matched against the PCI topology.
> 
> Add compatible = "pciclass,0604" to pcie0_port so child nodes below the
> bridge can be matched by the PCI device class.
> 
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
