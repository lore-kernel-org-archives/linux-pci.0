Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C342BC40
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225378; cv=none; b=hMYzo/uuP5EhZJl3QaZGekC07AGzeGMJ66GwcAqSKDNQ3DGT1dQ25b/qtX1hVV4BgqQ2A/OgLaHpY38ZCFpsUfTXJAmQrvhDcsDz+j/RHjHzGWc3gEjBUk4/FF6Ko95ASU7Js6xaerEbZbTdKdiItA1vv3IhdBKVS/f5WsdW6g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225378; c=relaxed/simple;
	bh=Cxd6pgPVZoXg5MbuWqBI98heC5T71zU/bEdaKDUim+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+VuwEtHgViqgZF8Bq/YjlNW5fGxO5V3KECz1Fe2oFNn13g4cyFwS0BEsmWH54ve4UIawdCn7rig6o5TELpTytJ+DdqSJYb079r+0F3yO7JBvqnW0kJ+JHrAeOJjCsPzebqDNZL3jypQWGv147QNuIfgu4Q9YYHVgTLvqg0ioMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IyvpxZQV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WnmDUxmc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IyvpxZQV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WnmDUxmc"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K7LEHL2753059
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 11:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z5RJHCDBjCYjzVbsGhsN2fKihT+Xn3HtNK94516A/Zg=; b=IyvpxZQVIU1sgyW/
	Hy+WKcvLnt9abqoJ1OeYePenNtbxyPvNCRhAfrssl5COYUYWtdnZpm80cOo4Zqpf
	tKasWkvx7bVttpc0NIxPnxEEXbeZzkYAr4a5gxqqqNVOL8K9+HTEHtSefJK+xZd4
	YuvcjNtTNxjmovsfOZZ+YHQ2L+E1MKl1PoLEngpu4s1WWghgH2OpDnWTCE8BCwTg
	vXPNQ7N8tQsLJUctMcyG+w/fA4azM9ikAr13uzvlzChMlEbx6Q823lcQUwzscrkl
	ivdvwGd2IdJBLNmECAIJGq71OjR1n0oB5VEvPWKTC4boxiuoejZqLaBw/sBoA5sH
	nHoGIA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5w498xmv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 11:29:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51ca37ce4c3so412131cf.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787225375; x=1787830175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z5RJHCDBjCYjzVbsGhsN2fKihT+Xn3HtNK94516A/Zg=;
        b=WnmDUxmc6jCAZfFtFz4ga0Vqk5gK74C4dReXZ4nisqlAq1egCSDCBRdvq/8VycLdxR
         mJ0r/TBuC065L3EQGajtEPaqLxJOK7F8lEGL+NBQrOFfXH2oQiodiSxMUEsgMzjKF600
         /4i7HEomIHgdCBhCrUzil5f4mlRZW9yF+kfQk0pa2HlTqGZQ+R+yi3viGk3bWV0lFyE7
         3zxTdfex+jUg/VsY+nS3ZvyOSfqRjp8pdIaVDtqN+b6s+pdNcR7c715e2V1zl28i6En5
         jMg4Y5nNIsdcdaPrND9fFpiidhqIyJbKps5pUAgVUdMVvFyu0vVi/lSJDmxXmrpU6Ffh
         rvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787225375; x=1787830175;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z5RJHCDBjCYjzVbsGhsN2fKihT+Xn3HtNK94516A/Zg=;
        b=c3x1MlBaHDhB4IP1XOSPa11PaUdlLq0ml1ivOPF3wxWIkjQdlBHSueVlC6aJefHY7d
         cJ2G77W4EmpJN+dFKBG0fVYrZfO2Zisu8f2I1/81llN8SApG3pCSwGNMReXqhlg36g3e
         D0XBdCu0CtMdIWKAXsIbt/ufhva/d/LElLyS0YvnC6FGWlSmyrMzeoGTOUds/Ujjk9q0
         d2NhEn0PNNVRGyEd/M4GVfXNt4VItzdcixovvdI5v/zg4YsVSISEMXurRLgV7DX9pEBM
         uAocdu+nqthLtvlTRDZT3lWzP/AYfzt7chYOnv0HjA0Nq1O3Wk6hTi7gT6P25tLq+Hs2
         WX5w==
X-Gm-Message-State: AOJu0YyW3ycV7E/8zQgJ6PprEObMj9eT8qhBgIP27SdQIlY4QXmTDoX7
	ZWi6Z//KREHvxxhfpzTMF+nl/+9oltmz0hK6lFTphCSrCIdKA1/UCJ81+KngnIok0oqaHqH3FmK
	jvXcD3DfbW9/QpTZkPI+KSE5XxrY9b9sYYVA46qH37jHzL0K5j9QZkx6XndqWe14=
X-Gm-Gg: AR+sD10RMqj+E1r7PVX6xJzqfAkvIekc9Jta+gyFcG/0PrPTn8xPPRSPtwiiRzjye3g
	zhhV1tUs0qeKEV1gKV6zxBq83k56q2nIEqG1Kp/o9PtFRTpWwxqn6J4N87iytm4vE5EJC1IbD+V
	NT8ystOPPM8MTUXaGIzHhVWHIJhZraxQzlQjlyKfOtvuBAStiNUqeIHehBSN1uT5d9WKhAnlLQe
	NrZmZ57T/WqFy0my7seStjJcacM5A9jTpofYwbGPcMpidNoJAyqNkkU20DSQUaplKC9SkLiYpAm
	0okaot5gmGZ9KxIoHMXw9oiD7YcAzeARx46nmOVF9Mk8IPRvCjWAtChivwEZQ4ZKJIzjb6RZ4eR
	VTsJp30SVNdpjVMCZ7LfEvRjf
X-Received: by 2002:ac8:5d08:0:b0:51b:f40b:2faf with SMTP id d75a77b69052e-52dd5cf7f84mr81389681cf.4.1787225375373;
        Thu, 20 Aug 2026 04:29:35 -0700 (PDT)
X-Received: by 2002:ac8:5d08:0:b0:51b:f40b:2faf with SMTP id d75a77b69052e-52dd5cf7f84mr81389421cf.4.1787225374978;
        Thu, 20 Aug 2026 04:29:34 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9e2esm1942826a12.5.2026.08.20.04.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 04:29:33 -0700 (PDT)
Message-ID: <e09c979b-0ac1-41c4-a48b-14549c780de2@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 13:29:30 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: qcom: Block accesses to downstream devices on
 link down
To: Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA4NSBTYWx0ZWRfX5GaCxs0OJsAM
 O6QOdpSxWzADGd6/L7VFETJE2yRxC6xmoXl13R7McvojRaluCbnmyCRBefJqb3SL78HkJTWesoO
 yqQV7U8G6d/eY80pIO9xMpkkXN0dhWU=
X-Authority-Analysis: v=2.4 cv=YP+vDxGx c=1 sm=1 tr=0 ts=6a86e520 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=J8a1EZ1zYi-ZQbc0NmkA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 0xgGa50sLGjOsa5FbnLG0308wkoK43fl
X-Proofpoint-GUID: 0xgGa50sLGjOsa5FbnLG0308wkoK43fl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA4NSBTYWx0ZWRfX5nVdiitEleux
 wAFLOqN8aspf+eEMa54AssAvNbluUqGGqXqMiee5pyZMsBB7I/VLxtpSe/6jhyBX85ux66FWQgu
 RRMETIZApnV4hlNp7YB5qS1dOyOsq4T+glgUq/gJ/mdGB+Q3TN6wlnSVOkfQ/UsWzwb2eUKN23M
 yd8wssoQBDg3/SXqg8AwHAKhlC6twOHwGh/HHyKBdh56pl+izvOrORvR8GN2CEzj+0n/wAZ2Srd
 GkuotdMBKnlwIXmI6AyXpbt7Fudj+Z7g82G8d7HLRDe6dQWtInOMpo7mM9izDmbbqfrocqSonWh
 hMw1Bwe+rTRdfLxQRUxCUnzclYdxuSN8uZxubLIFB87PyE4+7J3oGuFbcrgM2LhiVWrBSIyc3XS
 aef2QmI+tgwEwvN83nDysxbjDzRtyL64hjMRDeTWp5iSNoqaFZAF34bbW03285GCwW7TyXgiEN4
 J0f2GeVOiKigF32ZabQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200085

On 8/20/26 8:36 AM, Qiang Yu wrote:
> After a PCIe link goes down, software may still access the BAR (MMIO)
> space or configuration space of devices behind that link before recovery
> has run. As the link is down, these accesses never complete, resulting in
> a storm of Completion Timeout AERs.

[...]

>  static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -1775,13 +1832,15 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
>  	u32 val;
>  	int ret;
>  
> +	mutex_lock(&pcie->hw_lock);

guard(mutex)(&pcie->hw_lock)

This decreases the number of AERs I see while de-authorizing the
PCIe link on a TBT3 connection to an ASUS PA27AC monitor from
"a whole lot" to just 1 on X1E80100 CRD

Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # X1E80100 CRD + ASUS PA27AC

Konrad
