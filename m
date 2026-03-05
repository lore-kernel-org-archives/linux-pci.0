Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C3530B509
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702735; cv=none; b=dRVZ8fLk9cwDt/P5ftdg7bTp0IBn5ax3+5qVzOQ4+kLiJPwhnQA+wW2VPffknLN8yYjkzLAfYmcOLhat4rUvA8/96TSZ96yG+i+pxg5ccJIqpuPRKBfIOGb3gPkpgL4Bh+E5vs96po3QStl+XjemI4fG5apbZ3Jaaq6P08ulNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702735; c=relaxed/simple;
	bh=/JCIQhJ7DqnlJxNz7YUsR6Ad68yHWeMmEyuU8m+NV5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YP4h+IPYRBCK9AcAjHruC5PCna8qLz5KfE8kte6pglydInRH2T18+sPtYpuPtJDzRbObjKPRFJ4QQ5p/66VvYqik4YYzZ5mYYF8SI+pGHuv1o6Q4nDQ0kBJTnIJVYxa1jwsYjXS0GH/vTX2LN7Kd+id/RVSC7OYr8Zq8dA/QNGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ePdi+N8X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JBoTXy18; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ePdi+N8X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JBoTXy18"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62591SAs3665436
	for <linux-pci@vger.kernel.org>; Thu, 5 Mar 2026 09:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YLqXdZqeswd7bsIzFoL7/R/GTqsNqM60xS7hO8DhIjg=; b=ePdi+N8Xes+9wQkc
	6yZ0QDYqIIMXACoK9fbxHTQffU9rP2Wdo+80WOSu+U2NErCpzJN/hSdhQsp0V6X9
	VjcUuG7wpMOAkMRs1eFiuNtjnUY9GSaIsCzQjN1JfUZ7oIKl+JaUybbkWHxN5rC+
	h5G3frbFl8iNp7lwjvbqfEmNe/83Ru3KYiBNS14JCZ82a2GVnZkPl0p1kOclzf/s
	4un5oWtnu9TmqYwDLBtDFt+f7LnFZQzthQZ+2wuoZFBfOwY7TM/9r60xkaMdlQy9
	k9THT4tfBsGu0Ro5enixdKEFblCbGcTpSyZN+7m+gaoj1kwQy83UiiOKPUg7OTTh
	nBKCAA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq04u1edg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 09:25:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c738f3fe31eso314635a12.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 01:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772702733; x=1773307533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLqXdZqeswd7bsIzFoL7/R/GTqsNqM60xS7hO8DhIjg=;
        b=JBoTXy187ZEwEh5r9si8nSsoJ2EkWfkDRQcbKxyruqCPwVq3nFEWGyoGAQpfI/LCD1
         4A1iXtSDfogKAGA/9rZkaaSH7CSz8QxTXy9lJA9KMmPDh5x3LfVNc5OjNRrTFCZ5h39W
         eCv29O0AswXrHZoCDZgeKddaPEEKUDDUwgHNbs1a1nnQAOvIgcLkAjEyJf53+8H9FAZV
         pxmzcvonNk7dgBKeXgTA4FPy0RGLM2MwslJC7TlagcDDGvBokP0P/LQA/ak9s4aZDmFr
         /zQDuorVpZ+LOgHx7v6SYFIQAUQtWl03yk3sR0EZpixAruwq0DpypsLvKIGF365lQCfI
         9ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772702733; x=1773307533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLqXdZqeswd7bsIzFoL7/R/GTqsNqM60xS7hO8DhIjg=;
        b=qUaaVVMHgvlUeCvq/qv+jnKzBJrXKOo7FeneQ3Q7eN0HEtuYiOpMLS5yf11AlWNON0
         hMGcHq/AFb9ldHLZwA5Sp1dCwni22ca+xfPRCFBIY939sY1uVnLV/l4QyG1hyItxe6VC
         UypassVZBsEQKqWoeLZE7jD7DloZuymf4CGjd2zkjG4zXi9wE3s/nBo2B9eAUlE1IcFb
         +ulkWRXWIecGYbO481ZtGjwT3A4LZZRSN7SWEJJ8SVSDNVWEPQ2I+HjmSqOaaxCFNJ1J
         t17SNzUFT9FdV5p3YGwMXC50ADrci1Wtfpux7LkFG0rI5umOnh7zOTd6vXsZuNM3U5z5
         NqlA==
X-Forwarded-Encrypted: i=1; AJvYcCVUAhpulBep52BTcLBkvHgZGn+Cubo52BmbxlCnhDU0MMfWEgma9O9CECITr0Fblwlztt1p10/TZCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1kIk6tYFxq9lHZHm3fmuBOi6EqkAyWjFJal0wPkg8fFHa71y7
	iTrl1c4sQ+7hwkjNDg9gkAKItkUmp4JnaFph1LkNVppL0WaNJmG+jeeiA9uP36j2v6HvUml1ENF
	6+NuevXHN7nZgNlibI2YcPmM7Z8WouvsqMDjjeXF03CaZcBIhIcLK7nPh4tl6LhQ=
X-Gm-Gg: ATEYQzyVKD7gecMrgzDvf7OFLLrSjVvNlXmi6rgwDbpz2dSeVi7GK/RXtYDI08jOwOF
	iMOA8CJDWt6yj+cMiEfbxEQkxW4/G1ikacGnqmoi6l7sfL8VlwRqxZ7oQc29dMDpAKjKzyVVVq4
	K3IyrPV4hG57p6dQSO+dpuYh74oFSmmdcbUItn8lx9yXTJKPj5InwoIF13LzseOIt6nnOgKOn47
	Ml0pr1MVpMO7KFKCATijdwJ9C73TRpkqRYQOYijNEfOsICD/pOyFASrTwn0IEMqOsloU0Ndxdp7
	9wQCWgreWAPh0bOX6LdS2XeXCOsofcGV5C0KefcxTXLtBD+QSZ9j8jGmSd6lvEGl3hZtLJqE86O
	1gi6fz+wrn06xw87BEw6XnEUm6J/3OChZF7IFzwTbdduGmqCobXceRw==
X-Received: by 2002:a05:6a00:1144:b0:81f:4a0c:c584 with SMTP id d2e1a72fcca58-82972b61defmr4432225b3a.1.1772702732601;
        Thu, 05 Mar 2026 01:25:32 -0800 (PST)
X-Received: by 2002:a05:6a00:1144:b0:81f:4a0c:c584 with SMTP id d2e1a72fcca58-82972b61defmr4432193b3a.1.1772702732107;
        Thu, 05 Mar 2026 01:25:32 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829722d0045sm4521429b3a.23.2026.03.05.01.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 01:25:31 -0800 (PST)
Message-ID: <9327c6a7-b2af-420d-bb1e-f2829ddaef7f@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 14:55:25 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] PCI: qcom: Add D3cold support
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jonathanh@nvidia.com,
        bjorn.andersson@oss.qualcomm.com
References: <20260217-d3cold-v2-0-89b322864043@oss.qualcomm.com>
 <20260217-d3cold-v2-5-89b322864043@oss.qualcomm.com>
 <om6t5hlnxadpmet5i2gochjmfjw6mdfllrdbgewiz4u6vj3zot@nse5rbl3je64>
 <c0cb73d6-262e-4529-8b07-4c545c76015b@oss.qualcomm.com>
 <miorzejq4sxcl7pucaa7fq7fplbs7bqcnflawnw4qnvntxohmf@xyttdgbfllvy>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <miorzejq4sxcl7pucaa7fq7fplbs7bqcnflawnw4qnvntxohmf@xyttdgbfllvy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tHC6dJd0XP8z_B-QH0EdUSA_yXrsyZH9
X-Authority-Analysis: v=2.4 cv=eqTSD4pX c=1 sm=1 tr=0 ts=69a94c0d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=uIgEQj9WjdynuVTCvEgA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: tHC6dJd0XP8z_B-QH0EdUSA_yXrsyZH9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3NSBTYWx0ZWRfX/CM5q42PEYwS
 Yw+YkEN4gDPXbL4llbf5lqe4lL/vUQgSVdhvqdH9AxScPK0xx+LNYSN5AG6tCBStGwZ3ZXZvS+E
 R1wPES2U6SjjvK17aYcwlbPsW9caOqpicYhpUjJOnHPcF0fTjgQW4Vpgmt2fr5kyhA5uv84F3FL
 P/sdISYaKxqMRyHfiKEP3MenpRjdZebROx5WgpQoyV37FiIQ6Ane6MEJJZlN6AKY+5B/HxERY5Z
 NG2VKZpIlzTDynYaY/7WBA/7n+yDkREruGIsNVhOxqu+qt9cANejR/nIWZ/xq5+aqKOFVvW2OAJ
 MPgsnDbvDUiT5VtyDqeawpf0uYb7aog47broSmy3wbqt/c69uaXDgmEopo7kArEoy2boNExiDEC
 oFrVCQdBNAt9+tHsMyvjVbRrIfJM2J6cweGFub4sVN+0GatkNGCF0dmTipt2YlDZm7gFPkJqE5/
 K4QHwZN0vsb/5nY+lEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050075



On 3/5/2026 2:44 PM, Manivannan Sadhasivam wrote:
> On Thu, Mar 05, 2026 at 02:30:17PM +0530, Krishna Chaitanya Chundru wrote:
>>
>> On 3/5/2026 1:28 PM, Manivannan Sadhasivam wrote:
>>> On Tue, Feb 17, 2026 at 04:49:10PM +0530, Krishna Chaitanya Chundru wrote:
>>>> Add support for transitioning Qcom PCIe controllers into D3cold by
>>> You cannot transition a 'PCIe controller' to D3Cold state, but only the
>>> endpoints and bridges.
>>>
>>>> integrating with the DWC core suspend/resume helpers.
>>>>
>>>> Implement PME_TurnOff message generation via ELBI_SYS_CTRL and hook it
>>>> into the DWC host operations so the controller follows the standard
>>>> PME_TurnOff-based power-down sequence before entering D3cold.
>>>>
>>>> When the link is suspended into D3cold, fully tear down interconnect
>>> You cannot suspend a link into D3Cold. Link and D-State are different.
>>>
>>>> bandwidth, OPP votes. If D3cold is not entered, retain existing behavior
>>>> by keeping the required interconnect and OPP votes.
>>>>
>>>> Drop the qcom_pcie::suspended flag and rely on the existing
>>>> dw_pcie::suspended state, which now drives both the power-management
>>>> flow and the interconnect/OPP handling.
>>>>
>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-qcom.c | 121 ++++++++++++++++++++-------------
>>>>    1 file changed, 74 insertions(+), 47 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> index b02c19bbdf2ea5db252c2a0281a569bb3a0cc497..37442bbe588c36b0b0414cc4d0016da2d8424a87 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> @@ -145,6 +145,7 @@
>>> [...]
>>>
>>>> -	if (pcie->suspended) {
>>>> -		ret = qcom_pcie_host_init(&pcie->pci->pp);
>>>> -		if (ret)
>>>> -			return ret;
>>>> +		ret = icc_enable(pcie->icc_mem);
>>>> +		if (ret) {
>>>> +			dev_err(dev, "Failed to enable PCIe-MEM interconnect path: %d\n", ret);
>>>> +			goto disable_icc_cpu;
>>>> +		}
>>>> -		pcie->suspended = false;
>>>> +		/*
>>>> +		 * Ignore -ETIMEDOUT here since it is expected when no endpoint is
>>>> +		 * connected to the PCIe link.
>>>> +		 */
>>>> +		ret = dw_pcie_resume_noirq(pcie->pci);
>>>> +		if (ret && (ret != -ETIMEDOUT))
>>> No, dw_pcie_resume_noirq() was reworked to return -ETIMEDOUT to indicate a hard
>>> failure. If the device is not found, it will return -ENODEV. So you should
>>> fail the resume if -ETIMEDOUT is returned.
>> Ack, didn't noticed the reworked changes, I will change -ETIMEDOUT to
>> -ENODEV.
>>
> No, that's what not I meant. I meant, you should do:
>
> 	if (ret == -ETIMEDOUT)
> 		goto fail;
there can be other failures also right, where we should fail,
like pci->pp.ops->init(&pci->pp); can return different error other than 
-ETIMEDOUT in that case we should fail here. - Krishna Chaitanya.
> - Mani
>

