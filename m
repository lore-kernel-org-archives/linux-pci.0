Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591605;
	b=QVcjm7J987JFk5+TtoetoxYOnEd/QXT1xP3wQBCK9qYfzPu1uzDnYQ15T4IBxisgJiU0
	 MFhfHPKHn+g4gLPpxP9wjYg495FS1hlBCMskIURjb2ujSNzAL8F6vySbC2zRPjEtRzdKX
	 RToSpiJZbodakVJzDGKFYz3J9ZgUezmMPiJ0dmiSg91P/OCzAIC2Rr2Y8fRht3ZXDW0D3
	 osNTjeK73RGsjazmf482a8rxh0IQhzQww1ardZPZLwXwedZRllc4XVqVuAHZGb+8wiu2p
	 RCBRm2NrLISYqzTplYVFzkEMy3VotQF0Wk+pIafDmmx0QEy4a+zJ7nhwWsM5cLIbONQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591605;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cER6PZfE63ZfwyWNRlY05y67PyxrF7hthCCcku5wocM=;
	b=kVUiPJ7NrdrHFJXYQZjI60niOmQapwATjDCP+nHpz+IGOzEFOgRUngnrahQoD0dXk7Gy
	 WP5mNTG9EAurhnqiofnxanNWg0WwsEQsujlZ+VZ+uXu68+X4NmAFjZqfmO0fDWH3FSQyq
	 HoqzfQJwKKZQ5tDRFcXk24H7GjxbuqxE7tG4rtQpvkMHk66iK4RrUTW9mstlOMQ464Np1
	 UDhc+yzS++t+h1/X83v1KqDmRm1s3weSp8iILZ1CQG+zcrQCNMFdfbPFYv5ZhPmoAWX27
	 Ek0PEgWE+a+E/mcp5pjko+l3zfKXqU0F35jiSHMkWUA9OP+zdkS1Hkr21BugAuXco7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Adlyp3EL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UzWpeguv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D513606A319
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 14:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D513606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Adlyp3EL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UzWpeguv
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBfxTg543869
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 14:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cER6PZfE63ZfwyWNRlY05y67PyxrF7hthCCcku5wocM=; b=Adlyp3ELYkFxysWG
	3RVFTj5LBb8w4ZBV7I2s2yUeBtlczF6YuA0iNy87MMGeGqalnyv/IbYCWMB1vmkl
	Z/eLhtrOTtq5oMOBsTiCOfUwObu4cU7SerYsgb07VQC2w3JpOHqpgXR0y97LLHrI
	3cgKS2PwO/OHcIUnd2H7WPGsTagh02hD5bID4/pM2VhqhFAt1e6QTlXRCWP4q016
	KXZ4Z5jfBgXQh1rFW9xTPwyvtH8BIPGWmufEetif451xR5ax5d/h2+4ObDTmWSXH
	DxPbQT0K0Y44R9oXurNEkhbmqOk64/2IgtmPp3gKb26SfA9Y21eObX9B8TYy4MSW
	K9zmBw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj49366-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 14:06:43 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-988b530df14so23210241.3
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792591603; x=1793196403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cER6PZfE63ZfwyWNRlY05y67PyxrF7hthCCcku5wocM=;
        b=UzWpeguv6FsfUh/0TnDvYebH1kzVmkID1zsEbawjqwJSvpcF+5h1dqSZmgKGfyOG7M
         j4mLmxhvDhxihQFfDcWFx7uWhluE/wxYQqWkTAdL7FbhRHw0s57vE/tZ7oiJDXRsyhop
         auichGK+GCAPCnEclqCip8gdpt+I4mar7UVxL83olscf3Oezn24S0oMyopQD1AGU6o3M
         ef3yS362X88I9Z/S3ieTnwBikKlz5cKbu0g2ufAbJH73vIRmJdHgPCROO+E5kLD10Non
         P3nq5BAOG5J0zZbE/a5xuTLc3j4Y44HuxcerJVn8DQOaO3fAdNWyEGloaQ7oYgUB2z75
         WZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792591603; x=1793196403;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cER6PZfE63ZfwyWNRlY05y67PyxrF7hthCCcku5wocM=;
        b=fLrkm/yPwOQlsZTwMBAkfWimhcHxmnUHbfaLgKajbAFvNVfIUOmFOESaV/tEbbvjB2
         20Yoe10iTSqBqKd1YSEFZw7PdLYje7uqgCln5c20JXRMjGMwTZUPDzXnY/8b8/yQwwta
         wXYrR7/GAhTRMf6WFA3gSrGOeF+mUksuDwqI1/hBJ3SVkePGkO0Cpn9FY9GrJeJJh2/2
         sMUZURkYg4RDH4tMEObXRo9GK04L+ohUnT9VrzMeGhsM1ghp1teoZkoYzvxgRiK8bQQt
         qlww4xWgPoIvR8k81ACiX1LIQBpx7+vB9hyYRAWVJ17S558nukhRoX5PcKKjGN+xAadh
         EjZQ==
X-Gm-Message-State: AFq9FYLmt6eKjmyuGtUvFC63NSHDYm6DpXICmdH57gguIlBK+WkFEc6j
	arDsYgG591gFn7NUQyH7OtieByQMB1hyljt8eYqw82IBg1swNGxYZ4Q6HuH84rItn2J+9jH6Cna
	QL28ihX59v4bUcEO51an1rFmsouyDwSouJDed3fLfdEH12HmTRPoUOFDXYiK+Ztg=
X-Gm-Gg: AYBFou2JdqDc4vzlBxmQG9r0ma/dqEuATTNd1NgVkBhKyBABWInYbJ/RaA/HhpDqoAt
	szIxlZzWaBPRGoeQ8+yjiSgut90xpZlGbod7i3IwvUWAc4A7PlAdcltJwhcRexHFwvIT0mFroci
	LjWOe26dcLCg8gAe0Gd7Sb0W/sAib6QePRKOGmnkX02ujoMOZKZLar3T9vHO/8UqbEV3d1qSDam
	glbTtcbeFuPvXusE+CPXmoq0HTMCzv1guaKOndYymlru6I15e2VbnZtlBMvWxALAfYRSHJhpjoe
	ptUAQT4DW+/DMcjyQ9BwVcFcE962g569iWGsCw8fUWcaVOIEeeqIaBLu4yHiefQTvwTePC+hSU2
	NJTUrTYVa54C9tStVJOFuog==
X-Received: by 2002:a05:6102:2d0d:b0:7c3:83a9:edb2 with SMTP id ada2fe7eead31-7cc9244d5f4mr680882137.1.1792591602779;
        Wed, 21 Oct 2026 07:06:42 -0700 (PDT)
X-Received: by 2002:a05:6102:2d0d:b0:7c3:83a9:edb2 with SMTP id ada2fe7eead31-7cc9244d5f4mr680854137.1.1792591602276;
        Wed, 21 Oct 2026 07:06:42 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a59ac2csm7665066b.51.2026.10.21.07.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 07:06:41 -0700 (PDT)
Message-ID: <5d3de423-e5e0-41b6-be5e-c1a46e53d570@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 16:06:39 +0200
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
Subject: Re: [PATCH 3/3] arm64: dts: qcom: glymur-crd: Describe the PCIe M.2
 Key B connector
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
 <20261021-pcie6_fix-v1-3-ad37134c35a3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261021-pcie6_fix-v1-3-ad37134c35a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -CfdAnI2SkqNAD59E-MMUeMOwkRvmtPX
X-Proofpoint-GUID: -CfdAnI2SkqNAD59E-MMUeMOwkRvmtPX
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad8c6f3 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=WydMKwGuG-e24Vm_Hi4A:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NiBTYWx0ZWRfX32jCfqHLBcxr
 f3KYbp1OAHPnD4MKWZLbpLt2ogZnCjVeMNuhu/xXs79pZEjvNKipeiHIqjrd4lozPo3x9KhDxZ+
 zKZkaSz5QCcMOv2iNdbvpFN3Y4+sVfET5pYMs9ca0Tf/L6pTshX5ybdv/7T9Rq8g4B+6ZfDv+cw
 kQ1McG581z2v3gbS2P6s3vPm/PK6SvGB3MnfSfceRdpJQygkuU53HugcG1QkENaQ4IMT+SFswc/
 Cu36Ja0c6DeIo0kBTQHnmRdcur1b94WntdKWGTdR513bcVxNpk3RkjRHEFTf7CePN9uNKfTkG+i
 lGSF/zHHqIFq1no8cO6Fyd5JX/4m104mDcR6WbW51WxESTrD8oi5aXXUifsdSxEhO0mNIwbMUxO
 rY+jyMxgYfWLOZscKyU8AFhtpuoClID5aPVqLPQW9MgV1LdQIV7rwM/uO2JWhorln/dibsVFyxl
 QsET+UwaxdFPcik7pRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NiBTYWx0ZWRfX0+T/mqCcjbj1
 nkfy4wB8wg0gFYasbuhMwlxiLJinRHnJwcd1y62GIZEZoRk+r8bfKhY08i62O0RZdXJKtWdCxR9
 STAmZ4y1TkY2Ln2jzqANOufhHcPrvm0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210056

On 10/21/26 3:51 PM, Krishna Chaitanya Chundru wrote:
> The Glymur CRD has a WWAN M.2 slot connected to PCIe6. Currently the
> vreg_wwan supply is described directly on the PCIe6 host bridge. As a
> result, the supply follows the PCIe controller power state and is turned
> off when the controller is powered down, regardless of the requirements
> of the device connected to the slot.

[...]

>  &pcie6 {
> -	vddpe-3v3-supply = <&vreg_wwan>;
> -
>  	pinctrl-0 = <&pcie6_default>;
>  	pinctrl-names = "default";
>  
> @@ -828,6 +847,12 @@ &pcie6_phy {
>  &pcie6_port0 {
>  	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
>  	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
> +
> +	port {
> +		pcie6_port0_ep: endpoint {
> +			remote-endpoint = <&wwan_m2_pcie_ep>;
> +		};
> +	};

This is already defined in glymur.dtsi, just reference it
directly as &pcie6_port0_ep {}

Konrad
