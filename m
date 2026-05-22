Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470053BA237
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442287; cv=none; b=H+E+Dnck8x5WdsbdIwoSppI8zldHMSnwG+HmfCungtAsjkKO6jMjQaWcga2lW7w35w2+KvKzHHCL6IQVUKM8zPfxbQYeVyQ+9xfDA5dbxd3MjOb652Si2+NEUOAk8ZTt9kyL5cl2ERmmm7CvtjoDmJapMrxFtFAii6LK+LFenC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442287; c=relaxed/simple;
	bh=ReQQM/7igDEjQztdU+albgNOdhmDe20jo44TvforNaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pW/U+cxWK564RTh4XzDAmHZzvkq6IZD2Ebg6f6BF5Slh0ArdxBBj6xINnvLTIos3sEyL2JxLDea4J0f/WW/5Yw4CV3piZihYQ33dtdYQbJV72qz0U+68WIjbET7yZbAOCwcSQmQGEtIScB3eKP903rly5GJ2yFhdi8malZVdce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YHicWvgI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=busEow4t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YHicWvgI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="busEow4t"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M5ZIcV313099
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 09:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CmuyIiSD8BrtuoCQP+CAPpqrC+rs5hG3BsCae1P/mCs=; b=YHicWvgIi1t1p7dy
	a53VKRNrD/g7G30Spr4USby0aatZy/IbRFe86lZr31rcihEBfAhGBsSRRmeQ4I/0
	SgHEuUunAOE+sXrQO2oH6dFz+vkG4JzXFDQQYihTv8m8EczHzOKkvXArQhrIWC/K
	5IBg/PzZy/m0W5HYfV3LcNk/CBwvUO2+3EJFMqq1elHuVY9dMmMp8vjqoKHtyx3B
	rIdTEeMCrcAcw0u9xWXsagl0W4xJ8O9hiX+Lk816HvLR1WVElA2+M7sppAZoj9U6
	JEKE0PUXNER/UnrSTAcI1+dOF9IUgJfB1bZXVEPUWoNlnZsyqsogdoPSFrUJvFQN
	6DOXYA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea88334sa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 09:31:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-369ef27fd09so5405022a91.3
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779442283; x=1780047083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CmuyIiSD8BrtuoCQP+CAPpqrC+rs5hG3BsCae1P/mCs=;
        b=busEow4too8KLMDLtIrekVpmW6IXdJMcI0BxOfmPL3EcDLj5zN6pYox11/fFP55Pq8
         FOtJ6p19sgRWARmuqCc6kU6lGpuQuRGxOLiIMyVqnu5HhMFqQOfGd/HkJtScF/Poahqg
         CO+etRpczQj0RAxCbQa9yuO1yIBdPQh0TaHo7lUWSEEVGHtBuf3UwuopIg1weBQzEJVk
         VCgEhzv05dMDg5nZGHHnE4tAIgMBVfVIX9hjAcWwaaRG8c26vx+/KZZtaS3CbEMMDSdf
         fq9L94MsAl8XDBSfZOGm0xbX77zdyOSqXnhw6EQ/umeok6w/84h90mtJH7Ub01CEoJ5q
         xV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779442283; x=1780047083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmuyIiSD8BrtuoCQP+CAPpqrC+rs5hG3BsCae1P/mCs=;
        b=WnipZXJo9itc0+1o3cPTDYbbs6i9OwzNCrWdLPM5DrSaQeAXvsuqao5AE7HqhqqxzI
         4xE8twiUCkYDr37PDe68n8oz6/0mKAm24Bns14l9lZGDqr6RPw8bK/T7yTsAO7qWZh4K
         8o4pMb8FIUQZI4Dg/N+Q/R3bRjvhT6nKocCVrqpoArdOurxUFDQkN9+fUejP63nGbHD6
         ZziqZaxcF7WllZT0XtjRo95GlxKL54iKnTXlGC8D4VMqrpzGApsizRz1H6mN08JCkepg
         +2s1dMOAz+pSk49Mb9RpNDVTGQogbUf1xPgEZ7RYwNAC46ZIk7hc6JiJFvFdEvNRH+B/
         ttIA==
X-Forwarded-Encrypted: i=1; AFNElJ/WFM+wk3YQ92Q9UN6Fzfk77CQ9Hdq53mvQP5QjHzEpEeSObIqRzsOUkfZWoHgQ46R06IA07hKN/og=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc46JPR1Q7esMPj4Sqp5EayXSZ6Yv0zhSMCVeQaF9O5q7/xMm9
	K0B9fGTw8acqJccRKMMBoVqQdsx9h8BL0MIbaE3PRnFDoknYnJF0lmyObii5Az6GQWtw7htl7Xj
	XqUtgMXqy2AebkK0LHM9I785wLrjeBL0azlCCwHGhg9S2fA27EzWjxF7krWhcoMc=
X-Gm-Gg: Acq92OHJnwJ0ZXw/yN/WHSDT7f7JfvaqE831vyQVloRPJow4Nrn1LWYp8mtHBFW6i6L
	Bmz07v5gY5as1GTulqVNSntPDmibv6DoPSt+WnUwvCArRiAZEwGHZb9qjF2IEv37y+EdhAyLjEA
	vrptBVVNX+2vPvVEVpqo21/t0tuc1+COF4V0XGmz8CzF1EPiWmy4azDLLc1hqdJx0srza2WPM5J
	BC1tFHNZImsEyCEgb/0SftZkDifJw5cBZpQkQMGyZwdQUAFTa9DO/Ex1PX+MeyIARt8/Yd97qKj
	ikfd6YrTnWhE4QnsyYhQIuRQnPtSFqol3AYZh31+3+JDOr3MslWsgbpxqOlJNWVCXpUGuuAKaT4
	mwc3vnIi0yNcw1gpu0CEkiAXURs/GV7XLjsEhCW38dM0oy+clLd+9JbkFRgKQBFqN
X-Received: by 2002:a17:90b:2584:b0:368:6159:980c with SMTP id 98e67ed59e1d1-36a676276b9mr2733215a91.20.1779442283316;
        Fri, 22 May 2026 02:31:23 -0700 (PDT)
X-Received: by 2002:a17:90b:2584:b0:368:6159:980c with SMTP id 98e67ed59e1d1-36a676276b9mr2733193a91.20.1779442282825;
        Fri, 22 May 2026 02:31:22 -0700 (PDT)
Received: from [10.92.193.94] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6772f486sm936162a91.2.2026.05.22.02.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:31:22 -0700 (PDT)
Message-ID: <5593d136-569e-4ba9-9a2f-e635125899aa@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:01:16 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] PCI: qcom: Add Support for Eliza
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260521-eliza-v1-0-97cdbe88389d@oss.qualcomm.com>
 <20260521-eliza-v1-3-97cdbe88389d@oss.qualcomm.com>
 <20260522-discerning-sympathetic-moth-daa9e7@quoll>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260522-discerning-sympathetic-moth-daa9e7@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NCBTYWx0ZWRfX7amMXD7Vb3dz
 cHzU9jcV3MM67N8Xn3k8Z4MGcFPwR005LcLEiRGraHLeNjpueQG+W45ny8h0upHjwtCSCIUOXpr
 WEfZCCHJaT9917KHJldngt/QNyZoB26xea0Pxrw10EgZlTu4/XieE9Jv2ibUxRPfzFNWJC21rue
 JpMaNt6dTNZ5DwXM0TsIZOIUdwZOxB7DWWno+rqzu5AAY7Yu0cp+7/wOIy0nFks1LBBfjqFUFUa
 ArISPG7D44A2LXJ+/kK1jUfzXgliaIkT4/HB/9xh8XERg3BJ87dFldm/RQ524SI09x60FrDSgbp
 9Smam7fpSkyiWcReRSvKRFTEnojLsnEYfpyy673ddcrlSe5BE06cXjpTvYOkV7fI5Aad5787AEh
 olqJbEEil2/kL57MJesmJx9DblAeTZRBS695CVPkGz8/3nihtu+TdRFpqrYdgn1iw1rv+GqGeUB
 riyDoTujb8z9aF2U+Sg==
X-Proofpoint-GUID: pYiHp0dRqn9Nqf9aRlinKIakM3Dy3yOM
X-Proofpoint-ORIG-GUID: pYiHp0dRqn9Nqf9aRlinKIakM3Dy3yOM
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=6a10226c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=jbukJSVhv8iEu2CO0E0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220094



On 5/22/2026 12:21 PM, Krzysztof Kozlowski wrote:
> On Thu, May 21, 2026 at 07:35:31PM +0530, Krishna Chaitanya Chundru wrote:
>> Add support for Eliza soc, which has two PCIe controllers capable
>> of 8GT/s X1 and 8GT/s X2, using the cfg_1_9_0 configuration.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index af6bf5cce65b..40f0a5f247eb 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -2123,6 +2123,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>>  static const struct of_device_id qcom_pcie_match[] = {
>>  	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
>>  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
>> +	{ .compatible = "qcom,pcie-eliza", .data = &cfg_1_9_0 },
> So compatible with sm8550. Why isn't this explained in commit msg of
> the binding?
No, PCIe controller is not compatible with sm8550, we are just re using the boot
sequence used by the sm8550.
> Anyway, drop the change, pointless. Look how other devices handle this -
> do you see kaanapali here? No.
As we are going to use different dts schema for this controller we can't
really re-use
like how we have done in kaanapali case.  kaanpali is reusing sm8550 schema, where
this controller can't use sm8550 schema, as some clocks are different.

- Krishna Chaitanya.
>
> Best regards,
> Krzysztof
>

