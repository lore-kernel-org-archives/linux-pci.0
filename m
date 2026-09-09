Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468EA55D890
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957764; cv=none; b=sxbZIRSrgYMSeGOdoxxEqYfJvawC241f37uVkrBbL/hTotOoekJ2AzDS3zlQ7LLJRcZXSmtULFJWlJA49uf5HP70l4VrqnkXFea/yQ84rHWdMdosnoyBnTxg4vLEGUmH9hAg6Wi+G68mjvOD061VpQt1rnXQ0DilHenwO/vPxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957764; c=relaxed/simple;
	bh=0hWrdz4q7rb7I/HCxd1hEn9K+roy/g583HdMM5Nqfwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8NNhaCwLZ59jj4Z9HmWRua/0yQkT1hgUwi40/RhYvb0K5gBz9xOFsAMKmjuTQ/XFdew/Guly78CSukluiiaflf+e3z1gf8d3dP/+0PHLr8FDedEM5V+BICp3dvJT9xbVdRHTNCLxhi+5FQL2VJ0JvGCI2JbgeWS9k3tEHXs9fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V86TYKj4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JwhlHyQh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V86TYKj4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JwhlHyQh"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUg4f2173678
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 12:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IqDBfWmpsbVcFz4ktvchUUk0YUbACLYsKQhJUiknkwc=; b=V86TYKj4QA7r5O+E
	eFBqgvx4oO+e680cr6J9GvM6DOoTjxM8P033ihrA8i0ZJey4nNFepfWdwAq3olyC
	kXzPWwyhGMmmRBPSTKizUEOyTteHtYTjZItSLy+dyPszLP2icApNnxvfHRFQjhCY
	VwDVZCjyBPqNy88IjyB+XL38TAsVEkIIsLi55dEnMosQcAViHMqBvy5WNcQI5ghh
	XLgG10687Y3r7UtHlTcq7kU+LZyjE1vk06jXZgOlD+46t7diSqAe7EVOWo6cSW9l
	yFp7dBCpmNAU3i+XVWLPLeOdR05EsUFEtExWP3LQCceIEkuFoKNXxx3hSdvCwxj+
	ZTLsYw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5rggf7g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 12:42:40 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7ee59eeb8c1so4017869a34.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 05:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788957760; x=1789562560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IqDBfWmpsbVcFz4ktvchUUk0YUbACLYsKQhJUiknkwc=;
        b=JwhlHyQhO6GBsbQC1bteQnnpKM/2K1vIVAwY+U89T9729bvJJGjY5fLeygdRSKsmxN
         AydiXVSy3+UDjpjMbleyxJ62BImYh7aQIotTdMoknQxJMjpOhtZv786SK44UtlvXvzcM
         JOm2b0OjNMR28Ep7hnhg5E2xoBxbYT34ANlvSfjbDsRQ0G635QYNFaWTvZPIVoY/0NC6
         gwwHtWLY1SEP7FrTs8J2UFZqktUL9FWdCN/UZJL+FxzZXvMTXr0UlFBVBNJ/nMhg8a6Y
         GvMcjCvZVUOsMinYZQMsjfmbb6YTyr9PfGFAyzsE/e6+3JIRXKOxSGJ6KZElz5T79MmK
         Dwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788957760; x=1789562560;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IqDBfWmpsbVcFz4ktvchUUk0YUbACLYsKQhJUiknkwc=;
        b=SouIiHImkHUF0rz6dYLyOkK7/fstUiaRNyCBSHcOP6zTlZeL3ynEc3yXcFOnGS8ZyQ
         eqDE1fn42+3RLXFKOx47lR6MQWRcy3KEUPeFsdIdeILWw6vya3r5bfoUhORLUGclYMGM
         JIVIs0P6ml64sTa4ZE/MGyk88/cm9ejF48GKviyigTlLkyGTBVAeMfZT/MKwYyqeyCyR
         pyfrke5Nj0OzG/dh49HKQTiBb+a9rl0fdI4blBQsLiRYCSAl7JOaJ8GqHLIal5HMxNSu
         bl3EV5ZHpEa0cLjXbnCt+Gg94CQGv+T4lP5nJa09KG8PQmA5jUEBjWMkClbegiB9rW11
         utdA==
X-Gm-Message-State: AFuF++ltBZrRWf0xy1bCY3ccVZfw7aJikDfz0dzHavk5pW3BaTWhCLQh
	L9gAIyzh5Sjv44XIk5G9gDAYvIduSSOa0GrvTDpewZeSBtKB6UonzUtIrGPYvKfhjVfE2sqtJjr
	FXHMZh8SoL3HzsFJMvfUnQfCBugoKA77rD4sDFDHyAF8cWD+2pqFFeiRh1hgc6Lw=
X-Gm-Gg: AYBFou3sxxHBLwx1oQoZkSPcEwnCxazpEk9owIEbAad5+BdIoK3txf8oQOoBjsOHvXy
	OjqzUx7zVs+l/C3Q9sNjvhbMnIIOPJswnLhMVJbenn0k//cZdCVIbwkyi40iIbELPkqwWKFXrQ2
	wr0UJ6UUdA1cNQgS0/eFPDgVl4OxuRVkPrbKNFbL3T/XAmkbOuFTyn52cr91FIqK8h7AJPIoWLD
	r+unAa1MpHIgOUCnn4Xf8yl8lCp3wNsDrVCio67de5piMoCzTfVMlAAzMPaNY0mkPjPqTypiV4r
	PSrT3+fbi4Mok3m9KmP9VrvP/oOG6K0E7Sz7/VpxuXEfIYYmjkvTTbto6lCXZ2rF41Cb8oRYm8F
	qyyc/3gj9eo3NYzSnjniuueh/Wr1j0GJv
X-Received: by 2002:a05:6830:3592:b0:7dc:4947:36a1 with SMTP id 46e09a7af769-7fa1ff60101mr23258957a34.12.1788957760018;
        Wed, 09 Sep 2026 05:42:40 -0700 (PDT)
X-Received: by 2002:a05:6830:3592:b0:7dc:4947:36a1 with SMTP id 46e09a7af769-7fa1ff60101mr23258934a34.12.1788957759647;
        Wed, 09 Sep 2026 05:42:39 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fa642bc562sm17603801a34.16.2026.09.09.05.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 05:42:39 -0700 (PDT)
Message-ID: <b4dbb384-9169-4892-8be7-5f5ef62be5ff@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 18:12:34 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] PCI: qcom: Implement shutdown() to avoid SMMU/NoC
 errors on reboot
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com>
 <85ea66bd-65f0-4e05-9928-3cc2e23f02ff@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <85ea66bd-65f0-4e05-9928-3cc2e23f02ff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0MiBTYWx0ZWRfX0ZYb8Ow7bwhV
 7yYlKYJdysdzVAoLZPfXiIsHsZtZDp/LlAdGjJ+E7zCBIaok63RadEqauoMOl91BbuNcSvI6VhL
 JzBqWkHTd7XZ0x+E181khUxl3JXx7QE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0MiBTYWx0ZWRfX8WPWgHmulHNL
 1t9XoA/sTgnzmWs6efFngs4ectlWUm2Qq0xcudgo0xmUE+9+sqTCJu3yC2XRKEY5JsQt7VzVSrS
 ZPAc4YyKmrtHjLJgXQRwYH9lefcdOWIJ6LtB2mwHrbmfbP0b4KBmIC4Ij6NCgN8PADh9RPAYA4J
 lvQ/ffPVa1m/q93Kh9eG2RdfyRHVcOfvOj3w+vQlPjdnNV80dKLwu/6HBCZeOW+F33us3RmMKbm
 mTgDizgGuyQ7q+9DxDmVUOfkvib2HJt//He9u5wWFBAAbw/XunP9OLZoLI6ZCD0lIl/kv148h4Q
 Gem0GEtXRYasppmJhBOPzw91qtdfZv36+8k2oP/6iWAM2Gk4kdHLB5axG5FrGFZmasJaa94jVSG
 1bkxcvfKzk2AZ9V6OIlhvLZSgqfaXzmR1WS6DYR1gaTuTVQhfMvAynb2jyTcawwWRa2OdWn1sXw
 jrMGbd1myUgm6Bl0hiw==
X-Authority-Analysis: v=2.4 cv=B6qJFutM c=1 sm=1 tr=0 ts=6aa15440 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=FOk9bOecH7u50CPTZhUA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: gLhWHXhsbHuz4JXjk0v1D6UWuB5FE3qx
X-Proofpoint-ORIG-GUID: gLhWHXhsbHuz4JXjk0v1D6UWuB5FE3qx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090142



On 9/9/2026 6:08 PM, Konrad Dybcio wrote:
> On 9/9/26 2:24 PM, Krishna Chaitanya Chundru wrote:
>> During system shutdown/reboot, power/clocks to the PCIe controller get
>> removed regardless of link state. If the link is still up when that
>> happens, it can trigger SMMU or NoC errors.
>>
>> This series adds a shutdown() callback to the Qualcomm PCIe host driver
>> that forces the link into L2/D3cold before shutdown proceeds, reusing
>> the existing suspend_noirq() path.
>>
>> Patch 1 fixes pci_host_common_d3cold_possible()'s underlying bus walk,
>> which aborts as soon as it finds a device outside D3hot and can
>> therefore miss a later PME-capable device -- something that becomes
>> common once patch 3 starts forcing D3cold entry during shutdown while
>> endpoints may still be in D0.
>>
>> Patch 2 adds a force parameter to  dw_pcie_suspend_noirq() so that callers can
>> set to make dw_pcie_suspend_noirq() force L2 entry during shutdown/
>> reboot, skipping the D3cold capability check that can otherwise leave
>> the link up if any endpoint hasn't suspended yet.
>>
>> Patch 3 adds qcom_pcie_shutdown() and wires it up as .shutdown.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>> Changes in v6:
>> - remove return 0 in d3cold_possible() (konrad)
> I re-read it once again and I'm not sure my comment was right..
If we return directly without checking the pme capability we might disable
power to the endpoint and wake up may be broken.
I taught you pointed that mistake only. we need to check pme capability even
when device is not in d3hot.

- Krishna Chaitanya.
>
> Konrad

