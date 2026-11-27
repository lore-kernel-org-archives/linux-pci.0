Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795752703;
	b=STbfLVnGBw2v4riqhJ9zO8oB+CwGRUfYNU4z92YaoL47C4YR6MTBnSXycqGz84+tp48/
	 snzZfwP10XtIwz86sqj+EVzy0RXWPTMR8lX7yTfCECOf8j6z0e9VtWeJzWkxZJSvFUwo1
	 8El6E7zCfUZOs8DJtgNBoovnRvQB4GF8rRTysq30KvytriwE4Phug/7Vt/dzYOxP1yyzs
	 c6yvmLxuN87VsJd716eCTbukG+nuB/m1A3nV1wKtAWuTrumqVJcWQ+aoCViI2dqKJL891
	 CouTOxI08b+4xtooYmQBtTLhonRugnvhUpS1rTB+7TyUd8q9NpZBdQFW9hAfiSus3kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795752703;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bSS+TfzotcLZLnDjx2lsRE7c4zYm7LtguQHz8ft9Q+8=;
	b=MKG8Nz6LLvRKCAO1ivbBSb8/MP0EHu5LHS0UIlr9Jrn6+6hFJ1UQ1MTTOMaiVw+r1ISI
	 LDQF84aM7+ZXk/Xrt7O+PVuGGZ3+mw8td/R04fQ+7gqPGa2kfhEdyILUCfeIn563P4hPu
	 IKSvtXZ7a0fWj5LI4T+Bs0zr7/TkVJCQjH9/ZgYh7NAooV2GSzd5XQtXdeZyiqs9frv+D
	 3ow7RhLThFvSTFiiXUdZrguJJ0AIJHYoYauAX2w7A3Lw7o4Aow+B8k7TkFiaNWXOc9M8f
	 H2kl/kwJxGP5euvTUTFomGTEYPDS86q/vPHIBZlOI7znoXv3gLE1CdTgKYyvCanUCOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PM1Pb6fs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iE+zJtoA;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8156A606A31C
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 04:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8156A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PM1Pb6fs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iE+zJtoA
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQJwaPC061673
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 04:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bSS+TfzotcLZLnDjx2lsRE7c4zYm7LtguQHz8ft9Q+8=; b=PM1Pb6fsJj8Pc+ev
	xL8J0l09Rn8y9r22af5x99M+UJjgOb0g3vXHprxTaDn6Ely61BEyzVurS4/OQMSK
	r6KfgTKeRE/L2faE9SoEcjsOg4172eAGDKvZxn4UTFxI2lRq7m9n18MNbwjUoVqa
	EcEIKx5eje+XTU2OXWKlpYmwTcXN3FzH+yQ/S3FBj7bIyiP+kIama3Oxu62Einby
	TGis3sGuwxVqiDaL8CMMe7WVwGX6VY2FOI5G20Shhc5HpWocUqFg+DjIu+QB+usT
	POI5WEbn2OR9no7cfekly636Wu1QjqhT2UPU1spr3RRh4Rf5/HR+ZCWEISlAwNAW
	CGt1gQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4hs5gd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 04:11:41 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3869865a304so3305831eec.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 20:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795752701; x=1796357501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bSS+TfzotcLZLnDjx2lsRE7c4zYm7LtguQHz8ft9Q+8=;
        b=iE+zJtoAuDdmx62d8h3yBqLMMxwVGuT5J+cv17489mzsjtQ+9qmMyAUSTSEl0hMfSc
         tUGYwHHu/1WKyIk7Ywl1CuWShLo5nfpnhxoEV/PyonjYvRLZPfd8kirxOKPbrOvsxql0
         pCa8jzYBpWAoOvf8/qfi/2+pbntSSvA3jDVf/rT2j9O3TuIO2ng6IogmVuUgn0PaFDWe
         75U5rZOxgn+qCEH/7zHvbQ4nZ0QYG6A++YxEdXywHiogd9LoiPqC5tG2Zkru/uBp2h8+
         IKqmn9wmoLT6FLjzATgQFoNOKPSl/t4RHbutrLhEGfrMCzTvGtAF/7cjjLcDGLRe5kP/
         9Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795752701; x=1796357501;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bSS+TfzotcLZLnDjx2lsRE7c4zYm7LtguQHz8ft9Q+8=;
        b=XaMMXolPOjgKFaPYQKWo+rJOUF1+ihUSEPr+dO7H7Q1fpghIXsiV7R80L/gP00JPpM
         gjk+OFNsB5dsnOmcYuKBDxopgCKKP3W3CHLkkiPY7jRYCjm2QaV5R0HJvMWX1w+YKMzW
         P9o+EDzBa10j16vPAvM6BNTdGU1EZsizL9CXdnQ6Wqh+pGCaenznlYsKPNJaugDA7d/w
         YB5Qh6h+/hiAupynvCkMJtqkhjBhVXrgZ7vAuCjSjtw4PrSsrZB/9uix9Dxn1CGu9vjb
         KqRzRcqKSTBuF3A79hEtywSLzRQMQuYwOpYWeFSlSyiMaUj5EaPa+WcmslT38Lx9dWMl
         ziiA==
X-Forwarded-Encrypted: i=1; AL+hErGw4u9/op6GUOemxrJx4L4K9nW+4wQiH3XqxMwoxKdzthOLebx91kawsKIqsv6YFC+Juj89karb3NU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RRI//rz9t1FMLCqtbq+/U5Upo0DSxbVsL6mXEL7lDyYusQbQ1
	FXj0fwYvJ+zc3CEVtE0bx9qnX0IKo3Xl/aObOxaAXiW0/sa40dsISRtbnNgRDXcc8q6QIxh4I1N
	rPY0Pq/HJDEVe8kCo04hJ8Rm8ugHBRSXHeHUea8ZikyaGUqsgQtbC3SexLFRkso8=
X-Gm-Gg: AZFdTZeYla3uZsQIPKUgP8ZY/9MHIOtr96o04cfmaOYxP/rDcAn/aGMURFTdupQ/mus
	ep4P3/7BzHKFO/niK06uKY1a7qd6snnsodv25fPM8ldmgKy6oNCAksZvLszfYD9LMXlLGv3H9lq
	Yy6NNYbT66aRqCZ3y4eegAw5EWBI6aArVLw3XEyxG2o7SWJtIg52YSlJbaItBucO4lY6ild0twC
	HbNenq7r5SulI3Q/EG3yBYVUcOsBVeo2Na54Jk5uYDTRdtKB2kXIJ2vkrBGGFUJP21JJ5bXS5J5
	VsviIimTqgveSBeaTkbposX+7v0jdJujMqH5yK7rB3FFF/CvmTqFpoVqQVt0ATwGlUux22/kwig
	4i3k++WmC8o2K4P12sotv5Z6YekuKS/7puvHErACXJsiOvKrMEReJmNxcMUfeK9xxN0PtHErLuT
	tT9+o3xg==
X-Received: by 2002:a05:7301:152f:b0:381:c532:3d88 with SMTP id 5a478bee46e88-3857093c38bmr25839628eec.23.1795752700955;
        Thu, 26 Nov 2026 20:11:40 -0800 (PST)
X-Received: by 2002:a05:7301:152f:b0:381:c532:3d88 with SMTP id 5a478bee46e88-3857093c38bmr25839603eec.23.1795752700431;
        Thu, 26 Nov 2026 20:11:40 -0800 (PST)
Received: from [10.218.42.145] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm82327331eec.5.2026.11.26.20.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 20:11:40 -0800 (PST)
Message-ID: <e8e6eb0b-9755-4f49-a4c1-03d2f0e52f73@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 09:41:35 +0530
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
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261126-qcom-aspm-resume-v1-1-a34625656e92@oss.qualcomm.com>
 <b4aa73a1-ccdb-4ea7-a800-3c4ef20024dd@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <b4aa73a1-ccdb-4ea7-a800-3c4ef20024dd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAxNiBTYWx0ZWRfX+4yz7H1wNR/F
 sv34waZaeFvLpWNUR7KZFWvauF8mBLGAp2vVCGjWzzI+uyeWl/o0zngnIBmoeBpbp5eYXqCiPSq
 5r/U6Gv33Xnwfz5r806bOVrUWnGlFRs=
X-Proofpoint-GUID: yKrRkRG52EupAwPAlEWSDFyFCeTz0qTQ
X-Proofpoint-ORIG-GUID: yKrRkRG52EupAwPAlEWSDFyFCeTz0qTQ
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b0902fd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=m2VWs-Z5JUpV_CLSMugA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAxNiBTYWx0ZWRfXwWQwCYQomp4u
 YfRx1tVkJX1H8xoYErdeRo0Y3cqFRmS1e55nOQpG28ggmYmOLq325cK3cD9xw4kvtumgrCr2yZ4
 zSc/69rU7i0byKahh2zCM/rbbfzJ7sfhk10wcGQ3tdDYuOR8F9j3snVjQn/iWn+mZcslqfYpAWg
 o+qCwhSHbGdCzQE+kpG7Uj+LaU54SFfdnqkEX+1AON2R1vnxa+rHtt9H3nY7QbvmkIyvahSrXEM
 WjTMIOYGN02t/QI5te9wIKnYj5BsUqtrT66WS+GQ8MbHGu+EWQw290w4qDfiPF90ZQIL+EubQIu
 2qWlxtBunXmcKCT7aSOgkbhAxhUPQ3gm1Ztq7nxQR5Z/vCFN2LT05VAz/LPiXUQ7hKqwB6q5+MJ
 EdY3ZW9szOSTRhTmRrSPMBgaEfGFPuSgKvkQBjczjCPRQ8EFdxqm427PbLnFHsR+gO1v1K5sYbd
 +90UZZDGyH/oS7v7iRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270016



On 11/26/2026 6:37 PM, Konrad Dybcio wrote:
> On 11/26/26 6:44 AM, Krishna Chaitanya Chundru wrote:
>> qcom_pcie_host_post_init_2_7_0() walks the bus and calls
>> pci_set_power_state(D0) and pci_enable_link_state() on every downstream
>> device. It runs from pp->ops->post_init(), which dw_pcie_resume_noirq()
>> invokes on the resume path in addition to the initial host init.
>>
>> On resume, the PCI core has not yet restored the downstream devices
>> saved config space, so the config accesses performed by the walk fail.
>> With a PCIe switch in the topology this is easily hit, producing errors
>> such as:
>>
>> pcieport 0000:02:01.0: Unable to change power state from D3hot to D0, device inaccessible
>> ath12k_wifi7_pci 0000:03:00.0: Unable to change power state from D3hot to D0, device inaccessible
>> pcieport 0000:02:02.0: Unable to change power state from D3hot to D0, device inaccessible
>> pci 0000:05:00.0: Unable to change power state from unknown to D0, device inaccessible
>>
>> The walk is also redundant on resume: the ASPM link state is restored by
>> the PCI core as part of the config space save/restore. Skip the walk when
>> the controller is resuming, which is the case while pci->suspended is
>> still set at post_init() time.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index a6a0e3ecd921..bd1ffbf5c21a 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1174,6 +1174,9 @@ static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
>>  {
>>  	struct dw_pcie_rp *pp = &pcie->pci->pp;
>>  
>> +	if (pcie->pci->suspended)
>> +		return;
> Is this going to regress hotplugged devices?
No it will not regress the hotplug devices, since it is taking effect after
suspend resume.
so before suspend if the device is enumerated the pci core will save the
config space and restore them after resume which enables ASPM back.
> Or do we need this bus walk anyway now that we have 
>
> eacf92a29af9 ("PCI/ASPM: Mask ASPM states based on Devicetree properties")
for hotplug devices we need to relay on the CONFIG_PCIEASPM_POWER_SUPERSAVE to
enable ASPM, controller driver is not getting a call (currently) to enable all
ASPM with out defconfig.

- Krishna Chaitanya.
> ?
>
> Konrad

