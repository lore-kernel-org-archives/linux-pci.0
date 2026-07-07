Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286583845A7
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 05:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783401977; cv=none; b=dRKYjOH3pu9aZiTy/eW2vqI8m79fJtOvNQV94TcJcNGn5y2loAmcAbyf8UQpTzENuH7B/97DZ3KiTvruDw1LaIgAHy8UcAr1p84FodKLqqIRTS9FZs2I4KwytoMAkBSy+CuwGR/P1mZpQXXcngLa7eweoumDoxIro9r00CE0QHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783401977; c=relaxed/simple;
	bh=tBLWUS0p+78feSlx7wJb1JVcWhYam+OtpokhW8l1Alc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Afo2DZr8mBlHl7Z8fLbALUULw0kt2sWq2JgHVr/NS7CLfHpRE5Gd6ZHEAP2umviohB01pvNtbpFRfQHeiaPutjVu2TTWWN5PW4Mfen3+PRkyL4VFC8QJmKirMZKU6QnGxX/FjZEPwveqxO1/j318wpkrOHr0igpMdCRNC1Q7zRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G7G/OMB3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jwaXSAG/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G7G/OMB3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jwaXSAG/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748lPS2674798
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 05:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bjSimyuCuoTARy8j7fWODIz6FAefwaPOvzjZM+C/y7w=; b=G7G/OMB3L1aCJ2Zc
	Vz0oJOUHdL6jBM4/RnhTo/xIh4i8cBshI+tCi8b3NOVuWAwiK+Fs8Ifhu4CYn2Ii
	vHAVg71HmTgx6QBuPvlj8W5zpHDx2JiV+S51cNMI0LRpoJPWn1+NF9ItNwj4+Uyl
	HT8mrsCB1xOvLD/jZ1ofSEiUU3ckMnz5lurARS11UDI4Sd1l1ASrRIoBPbp2eq9w
	5jQ1jLW0ep7xQDiREzXCoKrWV1RLt3d56D0OkyW+vE538tNHBvADjTmjW6efMopU
	o8Zrl0OC9p4KsQ4gsUbCuOBSKcTAnBGx+M3vI3v9orocYQezEdtzH/febBRj0ub9
	qyofzQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8qj78qm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 05:26:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38096521198so6043243a91.3
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 22:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783401974; x=1784006774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bjSimyuCuoTARy8j7fWODIz6FAefwaPOvzjZM+C/y7w=;
        b=jwaXSAG/FYPsDz8AfIzg7h9HtHVtcw6zOtfGPhQxdbJjGcgtXOO5EWwqLf22b/OEFB
         f4eduxaQ76tNXCUpiF2ybgWalHoe3fzOOcMYsBu4zkJOQHFeKG4Zw0eduAG733ZlJEcP
         VSrLkIkKS/OtHAITHt735SpExQzX6G7zEyS4geGgyNCpQ0oqTy+Dlls7wUDPrF1SegN5
         bQ5Ca8qbjGy8lMMmIQrZPAN4L1om7neKr7hF2cuuPb4Ddyko5OfrIIz4dYX9a2tn4R+x
         4QjwTvFxTHnJbooI72tiQPzbiF2glE/NnkGHW7UUXuN+6yWAC2ywtGl4a0VguLG4KRhB
         TH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783401974; x=1784006774;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bjSimyuCuoTARy8j7fWODIz6FAefwaPOvzjZM+C/y7w=;
        b=H4dN2hKMVLIlY2e/FBpUFjS1DhHXbSVv9eih9HuQkckClbawS8jxEE3CNwgOuIOvBh
         ae8Rgq5rarzlJbCjZpE3ofrB2GLV6ivJDSzLBWUl9uHq6fhv/0UT9LzjgZiOV4f8Q7T1
         S3hh/kMHLXzTtg1go+VdZoq3Ic2rNats0qzvgKJ7fianFFPNBOJaoMdUryQlpjBkCJLz
         QSlR6IEUNWcyg6Hp3CPgmfJdKFbYgQJIGYVUKw2olVKF4u2Y83H8BRHd3U1A6ANwSycf
         248Y/5HtnTrEiLpWRV3dF5Skl1DqeHeNxN8R0qgKqG0CX29Z5T3yGz5SQ4WYwALfZf7i
         jGRg==
X-Forwarded-Encrypted: i=1; AHgh+RqfZWQc5KfnqtteZFyaTdkLJbtYvZlnO0y3XfsnYkt0buS0MAxvsNJ3ZyRa5iKNf2iWa4cbJ2ANzF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhjYJb05pdECUxRoJtGN6v0GTKd3R4TUCxCI26iHenZZCbU1Sh
	nYUJcQuMeFFfYbMKGrTRKPoaTzXs1TpQj7aQKLuppciCTHyvpkbcGIroCcmBuyHifWUPrpjIpgb
	+3sMQQ3/LLpoqVycfS/6nvhiDFXDzT4xkiYTVqUm99yKohDv7eWM0pe1pDm0Ytqw=
X-Gm-Gg: AfdE7cnFB+XMmudovOSXMjXuzviBszuC7MKvUYX7r0f60P2Zs3F9AKrw1IXs+Eav3NP
	dhgUeZcIX6fh7T4WhM5PrQ25yv5kI4SfhHMUDVkI6w7MzB8WPXwKXXKSObnrQS2UZEtSVFVCDOB
	lC+uuRkmUqMvAORwT/B2fcqq/HzdqJzM7Usi6+VlUj3vDw4+rpV4xr7K2WzZQw11CQbljo8rlGM
	2LYlNHpBoTYK7iofsIRSiLz/rsM+PLmaMOLd/88NZI5lqodOW81j8xNeC+nh0zAIHsDyuon82gA
	edDfHqYKbiGukMiAYqBEcduvQFnDhmNrjHcXLyDrGmPc3qvCobxQLqmNu2r7a0h+wBLLkPBWmWo
	TwmZ4Wn2nQrnQtXsyxQYh4OeqT3RUR0XFCN7801impB2qyLvZaeiaWIR8dveId4tgZ2dok9YMrK
	lnojb6
X-Received: by 2002:a17:90b:5886:b0:36d:b9c5:e8f6 with SMTP id 98e67ed59e1d1-38758938d3bmr3634647a91.19.1783401974196;
        Mon, 06 Jul 2026 22:26:14 -0700 (PDT)
X-Received: by 2002:a17:90b:5886:b0:36d:b9c5:e8f6 with SMTP id 98e67ed59e1d1-38758938d3bmr3634604a91.19.1783401973687;
        Mon, 06 Jul 2026 22:26:13 -0700 (PDT)
Received: from ?IPV6:2405:201:c409:b03f:6d0b:bb83:7a67:4093? ([2405:201:c409:b03f:6d0b:bb83:7a67:4093])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d15f13f1sm429574a91.6.2026.07.06.22.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 22:26:13 -0700 (PDT)
Message-ID: <f0221345-e741-49b8-af7f-e0d7f8c973a4@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 10:56:05 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dt-bindings: PCI: Add bindings for endpoint gpios
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
 <20260701-shikra-upstream-v1-3-e1a721eb8943@oss.qualcomm.com>
 <59c96d6e-95f4-4b03-b1a7-21e7cf6ce43d@kernel.org>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <59c96d6e-95f4-4b03-b1a7-21e7cf6ce43d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: l4lTDuAEn8F8q1ZKSjttQLTLAQQRA-3p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA0OCBTYWx0ZWRfX7OaMohdeGslG
 tpvWYozTu23VlqThneUWT1tZX/tTf/Oms9OkSDy3izfD+KzQBF4hPV6IwX64fjUzdWf8d+rD2rT
 7E5vfEGKJGqHORfY/FZAxgFy+nGSYmem5RTf6Ax8si+FEGKK/0gzvvlLp8Y46bOH7vYrKgYUfAf
 0sCaPvO5I0IqQvD3Ly0BwNNsoIqQYkiWwLJqGX1zunIWtVXrQyxzKH+LDuj5IcKj5dfR1J4LumM
 skx3DLW/+qZ9cjRPBB41WMlH1jMNY2pS3PK1VZpp2aE893I232FNIOt/e45I9LQ26/6FXoGVUzS
 NmXH4/+4d1EOYS5U5+qzrMbUI6LXE6N3yxeVCSoDcpRc7+pUZMiF8k73rnY/Mp6lmHI+lPx0B6A
 WIm9h+3B0vn4ftcgQdJU65QdRLAaiLsQXiK5hX1qCSzKRxbw5pVNVU9lDK5S+bdEKPeJ2fed/wS
 pUad55b2BuA6XJs3Acw==
X-Authority-Analysis: v=2.4 cv=PIM/P/qC c=1 sm=1 tr=0 ts=6a4c8df7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=hW1Q8sUlsHAnT7hvDLMA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA0OCBTYWx0ZWRfX7zaTv0RsCVEG
 Ls6qoDkCFjEeaAyK/LUBqLQPeJ5ijRgpdk/mop3+qtu2QyV+gLoUfc7z625DPdAhwUY/4presbn
 se0WGz9avIEu4a/QltcxHvC07hWfnNA=
X-Proofpoint-GUID: l4lTDuAEn8F8q1ZKSjttQLTLAQQRA-3p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070048


On 7/1/2026 11:57 AM, Krzysztof Kozlowski wrote:
> On 30/06/2026 21:02, Sushrut Shree Trivedi wrote:
>>         toshiba,tx-amplitude-microvolt:
>>           description:
>>             Change Tx Margin setting for low power consumption.
>> @@ -104,7 +120,7 @@ examples:
>>           #address-cells = <3>;
>>           #size-cells = <2>;
>>   
>> -        pcie@0 {
>> +      tc9563: pcie@0 {
> And you change indentation because?
>
>
> Just like the other patch, this wasn't tested, right?
>
>
> Best regards,
> Krzysztof

That was a miss from my end, we only ran schema checks.
Will be fixed in v2.

Sushrut

