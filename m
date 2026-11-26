Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698449;
	b=lq8ugKa7FSnXhqPBriuj29tZ+UYzwx7LFIHV2uH8syjloac69EYIlDqLNgnzxSz0UA2m
	 ABUOWVNZRZuNSRxe1JJn9/d7Imqy3M2B8IuC+nrHhgVlz9k7B86cnYy74YXg1hk/+z5oy
	 N+sx4dYzJbybIE04BDDxRRssnd3QdyNaGCs3BqF2h8/eo15C8fY2Sri0aVvr6fJkTEj2R
	 kBp/yMZNzVfijB0/Xz4KXfNeldsltb48g6u0WVO8NeTXd8+SJvEvoTeAUm126fiWtIzfZ
	 o1fY5q7sQvmzfFn0WuxUb7O2BgmSNxw9kAyWBIfO3WY6KKMmZBRgQ0cGRpR66OyAjMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698449;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=m/r7tY+1cY+d5JvPnaKis6TXcnMWfsaA3A63jNKdj0k=;
	b=A07tWv+0oBhICQPT2V54gI9KfrWn4cIQM0byIbrYQX7JzOQz9TjO0jRsnvfDzrNQ2Scq
	 LXGmWzEWhiFkhzy0zXpo8i/HwyGnB3RbfcKsCYBrAjLMm8lfJToz8q1hwIrZ0QiEhVOzN
	 cVr0AtiIuIQb2fVgtriGt4LTg0jtC8ZrT4JZveJB1u1ImcaOQ5p68QKLHAqivg5AFzC7s
	 ZJ5+r2Ajc6uCc15V/UxPIyujTpVer7fYXT2M/JoapRM9l5Qne0Up4y6vN1A7zBb6LZJDl
	 1n/+czCi2wK90RJMTiwe4+9BPukOnTXA0zCB5yACQrfoWLgsjvf0jmLhYgY5XZl7h7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nPx75k5X;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cX5Le6vD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF6606A326
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 13:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FBF6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nPx75k5X;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cX5Le6vD
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVHI03476063
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 13:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m/r7tY+1cY+d5JvPnaKis6TXcnMWfsaA3A63jNKdj0k=; b=nPx75k5XdhHwI+L0
	l/r2eqJbKaVVDnx2nTTCCltg1LKiPpNOzgpta07hJ/bm+KUR+Y+4SPGfTz3BxCW5
	gCAJwzmwL1kZ+HqTQEZQVeSD050byW6vCtTtluuh9tu6uCy3hsRUQmTh7dSOJTsZ
	0Qs+unUZ1f/2DuthFfMKhOpUQaoqqOIbTL9WoiYOuYK0RMuWg0wATmQ+mZ1yWsPz
	dJGbDZppPbDsFD1Vla99Fpy3C/+FJQt2srhptHUKuFBS77Lu91NzwJUTcuhsEum2
	585k04oDxQD7Z7Re5ttPWlsBi577Vb3c+TH4RoVP8U6R1J/zKHsRgruoZSVR+0Kp
	VPQfFw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6f8rhh1t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 13:07:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-94993a54a73so62383785a.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795698446; x=1796303246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m/r7tY+1cY+d5JvPnaKis6TXcnMWfsaA3A63jNKdj0k=;
        b=cX5Le6vDhMfWVUNl2bNqqPkAXCbqN+DiLLUZwWEZp/+WzMJkVF7HhFlpZyvNOcGsTj
         hCCdhwse+WnkswWFnNe3nOAHI9rioVL8TWmi71E+n7USc+1g67uOoaYqxAYFHQrEzpsd
         K8jgqSFEdAo0bBObvKZrdkYkjFub/gILbQWyQgtqGpLBTRLWLqsAYhiwCua4RICGdIjq
         KzrcWTjCFJRidYJx4Y79V5tmrJ0i5ewv48cj4hqK9wz9v31CvV52ob1KM3NOjbD4h6H8
         32FaNk/CkAav3keVSeMifJLjXdizCdLdUBX+IAFcZTN4uurpuZv3lgqAmhMxBHyWMGBJ
         jnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795698446; x=1796303246;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/r7tY+1cY+d5JvPnaKis6TXcnMWfsaA3A63jNKdj0k=;
        b=M74KdrHlqBuOwWKjZFJ5ygFjdxQ19XjLM6ugVENrJlkV6Nc1kolfCJJfXbqvdpMSCe
         dMiaKTL53daG83Ps3XMmB9llmbb5MCcWjQsFhSRSRBSvPqSSsriv/kV4Je/VBn6ZwuOM
         Fd+8B6OXA9S945qBkGrMiYhVHrCfSbpmWCdOMxhgf7cdG4fOin7E4+YIw14iDmLbEe//
         KroVIs6WFKzFvITwnckAQD0muwXXZRtiJ1ah24iDQOmonSFe75aUftP4brvy26LQ7MiU
         X30L0dxfcRo1YY73hwAMXX5Bd+kBQk/gG5VDt7cFpvOS3mCIkk85Y8razw/SJCNz2bZt
         HdUg==
X-Forwarded-Encrypted: i=1; AL+hErFqCiMU/L6KNFpFjtuEW1FKtlHMYTF6qDyZSUykJn3BJeofaEdmTtn6xRc2waqeDwKV61qwFUmUSJg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3P4RR6vn+oHtX+Z9wPFpZxte2Plsv6X8QwgCJIyzfpU1hnX+f
	IF3/HEJtvnwRuEhM334Vv3gk80y5aPJf1UBH6GPJKYN4H1w/xLC50NQ3v9+5aOBdBGowr/XO83W
	gFZbP71FoxdrM47tuyBrtw63UPAKMoAxr5Vtku99u+HJ3xqM77rfPwAo2i+q3qEw=
X-Gm-Gg: AZFdTZcCYd+udLeYUjPCqustm9/XGjQSI66aJeyfSFBIFMtA6cUCL+RNZH298CA9RZW
	ti+VgDAUcUCSOheu4l54/YmoRznqy3xOrJGo72vbIhKGh9S8GX5b/OK1K6ybE1RVqrvZ5XIxcqX
	LPLM9lVnESOUX0T0jquGMgbnIDDAWx98Lb31XUsPIb6x2m0exjT+fmSNi1j26EE/uewlSAHOxdU
	+mfglvf16/DYR1+aSAFhrYoC+/kHzCC07i7+mkfwm9Qhg6llxzQaHLTa43yEX/ld55RyzTBhkZX
	snEH4hETCWtBo22VwY3VmCOve9oKMFNxleiofKtqR5yhf/RH90UyAqdPwXgV8cADI4adYnJfIez
	8zoteN0wbkryltZ1AU31LmqwJdi/FidW7ajbIwA1tbbNFrrmCUxP19XFEZCykL2+tqPfptkI=
X-Received: by 2002:a05:620a:72b5:b0:949:ee76:cfe3 with SMTP id af79cd13be357-949ee76d22fmr1906391485a.0.1795698446413;
        Thu, 26 Nov 2026 05:07:26 -0800 (PST)
X-Received: by 2002:a05:620a:72b5:b0:949:ee76:cfe3 with SMTP id af79cd13be357-949ee76d22fmr1906385785a.0.1795698445931;
        Thu, 26 Nov 2026 05:07:25 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370cbb80sm9687245a12.9.2026.11.26.05.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 05:07:25 -0800 (PST)
Message-ID: <b4aa73a1-ccdb-4ea7-a800-3c4ef20024dd@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 14:07:22 +0100
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
Subject: Re: [PATCH] PCI: qcom: Skip ASPM enablement walk on resume
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261126-qcom-aspm-resume-v1-1-a34625656e92@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261126-qcom-aspm-resume-v1-1-a34625656e92@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1MSBTYWx0ZWRfX7OVi7Kkyiz1N
 oxUdVT5DmzzzrMPNGpP4P4XQYJlshfSEoSiExVEFWToZU7Ky7qn+0xvyqZXDaSxzKDGYekWioh+
 9ERiRdgh4nYa+mv/Hg3n95+PHbG6IFYBGGfuTmM9aBs6G27snmfTeOxHJSz2BZ126pe/bEk2/ok
 yxMya5c7cqipFuDH1fxeWQsfkjQ3tq7jLrc6f8eRX9s0bGwgkFhPDo5LTAzIjFs2RXVVRADNtJh
 ED/TGmcfsfsbw3rohwRGCJRtKcHunfJ9UkwdrPl8buz+w3lSejaMnpoNBEa4bjyKFzTwrxmmmSU
 T07xuA2VE9P9dglNPbr1NX84PX2+auLLMqHUBpjAr2gi+30xXfOgzKCmEsFL2sc8xCEG1EmNsUy
 F1JmpDzX1gxKBZvskPsKFmz+hs6Lxs4XXmxtbJ7ODY1izGph6/yFvNH3CxXH3fNGep/FX64bCDJ
 XklUqt1jOf2ykmra6JA==
X-Proofpoint-GUID: TAibTClowcg90AvH7BCuT9AqWVKigVwx
X-Proofpoint-ORIG-GUID: TAibTClowcg90AvH7BCuT9AqWVKigVwx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1MSBTYWx0ZWRfXzTzkx+4sY0k9
 OnpRZR5CMLy2DE+6Kre9KKuDt+THDzpSd2YwM1fCV+92IMkK3risHwKHgLDASbqqqa1enV/3XqI
 NE0GvrJ5wFpdZUHR9qLQA+PE65n6Nsk=
X-Authority-Analysis: v=2.4 cv=FuOQbGrq c=1 sm=1 tr=0 ts=6b082f0f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=M-jGJTmE-ygQmRKCDXMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260051

On 11/26/26 6:44 AM, Krishna Chaitanya Chundru wrote:
> qcom_pcie_host_post_init_2_7_0() walks the bus and calls
> pci_set_power_state(D0) and pci_enable_link_state() on every downstream
> device. It runs from pp->ops->post_init(), which dw_pcie_resume_noirq()
> invokes on the resume path in addition to the initial host init.
> 
> On resume, the PCI core has not yet restored the downstream devices
> saved config space, so the config accesses performed by the walk fail.
> With a PCIe switch in the topology this is easily hit, producing errors
> such as:
> 
> pcieport 0000:02:01.0: Unable to change power state from D3hot to D0, device inaccessible
> ath12k_wifi7_pci 0000:03:00.0: Unable to change power state from D3hot to D0, device inaccessible
> pcieport 0000:02:02.0: Unable to change power state from D3hot to D0, device inaccessible
> pci 0000:05:00.0: Unable to change power state from unknown to D0, device inaccessible
> 
> The walk is also redundant on resume: the ASPM link state is restored by
> the PCI core as part of the config space save/restore. Skip the walk when
> the controller is resuming, which is the case while pci->suspended is
> still set at post_init() time.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a6a0e3ecd921..bd1ffbf5c21a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1174,6 +1174,9 @@ static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie_rp *pp = &pcie->pci->pp;
>  
> +	if (pcie->pci->suspended)
> +		return;

Is this going to regress hotplugged devices?

Or do we need this bus walk anyway now that we have 

eacf92a29af9 ("PCI/ASPM: Mask ASPM states based on Devicetree properties")

?

Konrad
