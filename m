Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A83E8343
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776155; cv=none; b=I1y38pN7zWFxPTxX06s+Pwom15vKA2rKqBehIpFpI09AZ0Rz4K9lxz6gHc/Yteg6eKhVjC6Z3YrBxX8c7/UaiINimUD0wD/ZbYByhb489Qvw7TsXRYdnSID6wTmOLq+8PupL6lQHJ9LB99MJjdJEwrfZCBPCZLuK3ndgf/ux5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776155; c=relaxed/simple;
	bh=CqOnzpYUZ8jTECcLckHB51CXBNWr7PZ6ZzF5YP4P+74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVUhUt59cJR1u3DwqH9tqVyos//DERh2iI3z+mnv+DZHXskB2+UAwuGOeL7zLoaCAxxdc6Qbc9bW+3xzbFQw8651SQWv1uZbHbg5II+JNzrK6CpuJLPVCJ1SW4EQuRrkfpJmMBVT5EdnUkoIrHYE9Y1M2QoYrqLoqKB4ywm8sIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aQFd8ZVs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZVWok5VW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aQFd8ZVs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZVWok5VW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8G2Km1253181
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 09:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rvIyhITEyAEOhZ65DNKPLUJIvhMXvypBUBYo4XJWBDA=; b=aQFd8ZVsz0D6yGsv
	fxnVX2h5MqNYRkCRULpH519JHRTA+ug1V9C9aqvcqyLTgsHYk+iwB8pGxuoTO8vT
	s+oBCLAm9IlieNsyIkXWaKq9MN2Xyw8i8T7r8+M/WNlA77+OUjYHsLIsl2qfDov3
	ZNVqisZIBwsleFaS+nmHO3VxCfPw+5hQQWSeWYe++na9O82l5NIWECs4YFKyuy3D
	oybKgDHA3OHzYdCEa+eJdLihuZhdQxKMc6OA/vJ3c++Sni14xxdUhNgapXSK6HJE
	8HW02CvstE1lrm9t/dBFYg4vDjLG5c/BnuOJh6I3keon+eENpa7ukpk/iSrYLa1O
	VlZJSw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7k2wu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 09:49:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9156dc90fdaso21778785a.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 02:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781776150; x=1782380950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvIyhITEyAEOhZ65DNKPLUJIvhMXvypBUBYo4XJWBDA=;
        b=ZVWok5VWVtsi8Ljua1P0NHO5Hry6MGek+BlBKRUwo1zZtPVP5zIXEgLowHiEb1sN/U
         gNe1B0upoQf1WZ8dCMEO0+snUHlWPDhD4BvW8lzJrjlklrWTnTkAPEf5Kg8D/e1uxjUt
         Ri169WJhl8BvqrwemoTiQXcI9IZVHZZ3xHqUlblsKSKPaUtlGsVPfOE54I/nhmtJiiGG
         k+CXlo25QLTvK6BRY6q8H/gQyxnxPXetzUGU8UjbuYeY/lO00TRGKPzBBvwP975dILUQ
         d74NooesONLE/MRH7jwerfm4N+MRqCnmrJhZUwMoqMg1PujgStLBxIRIsswhTAkq65jO
         +OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781776150; x=1782380950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvIyhITEyAEOhZ65DNKPLUJIvhMXvypBUBYo4XJWBDA=;
        b=pMdXZwwgF1XcbRd9DDyb1jwjIK4UrcIkKO/0DeucMNsGlGe8WmPTmKwRH4cElPEMfi
         pISh5pjbock9DS9TTV///Bgvzmn9n8Up4h1wkumaTgxpMNE46N3Yaz2PIOHFGVFUJd2w
         9SvpDvnzRU5MWvRCh73PmJgEEFgQGvx8nYtGqzU7DCSf4lBYsXt0JGU2kTdBExx8m97y
         tLxX+52BGKb2W2wb64Mklj3TM+vzRnuUgezBMsq1/fybndyG9knf/1YvN/T/znX6lBMx
         /dX0YY6GpDvHNHBtY1mEhX23jeaXf9fHxynqg/4nDk8SIHGQdKcB0hA7YOuUq8mQTbkz
         1LnA==
X-Forwarded-Encrypted: i=1; AFNElJ96dAEfHXYfInfCjKWNPXUFfCbwclaoUb+iqAfPUVYonk9gA8DVZw67o2IBLMYeYd+R80nd6Ue95DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBUGvD8r06bGgGQYd2YnMAqsLTpej2yb/7Pkl4mAEay1eSfII5
	Y1Pbvd/vhmXivZ9Y4hmkKJD+eMzUf6MPMWHtgjULJ0BKTc2GD12N/h4AqszJKXavuW7buaVI/sn
	NFC6BsMhdBJ2GyVnzP+sarEItx+LJ5gYqmkqY9ejHzb14N0j2ctFDSNGqT+qXoXE=
X-Gm-Gg: Acq92OHu/47Pr6WAzpqcfmYhMAE13nyu1BQKde+VjPa4O5f5gaD9nK3MwBz1KziZGgS
	mS4VBCEFRsqNb06+wRoFHMyB80wtrrX1GvdO0noZz6sm3Ngi3cHBMfaLz8G6uTe3sIZygAtIZAF
	p88AZXD/yjPGHu1WFZY7a3e7UPxBRjAoasAx2sERoANabxbmHZ1k3jICJ0/a2ej6u9mJm8Pap/c
	IFhX9HVaUHvqLQWn57TpdkTFCoMKjMDGIY2ZADBNoFt0VV8xhsky2hRiZXVckbU5vL48Jjfz5fN
	xSc15I98ARUhYpLkrm5eGhyB0HWEH+U/+MgadjLpsBt8DhnVjvNhbfYTzAyM2jWcziT39QKoIAq
	4Q4h6smR8G5ps27W1UBLyrJh0Snx37ffHQlg=
X-Received: by 2002:a05:620a:17ab:b0:8d7:ed38:8189 with SMTP id af79cd13be357-91f24ff5a51mr281468185a.0.1781776150266;
        Thu, 18 Jun 2026 02:49:10 -0700 (PDT)
X-Received: by 2002:a05:620a:17ab:b0:8d7:ed38:8189 with SMTP id af79cd13be357-91f24ff5a51mr281464585a.0.1781776149836;
        Thu, 18 Jun 2026 02:49:09 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb7b6de2dsm919473466b.37.2026.06.18.02.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 02:49:08 -0700 (PDT)
Message-ID: <580db7de-321d-4f4e-99f9-3c9a1cc5a3f9@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 11:49:05 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: lemans-evk: Describe the PCIe M.2
 Key E connector
To: Wei Deng <wei.deng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
 <20260608091702.3797437-3-wei.deng@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608091702.3797437-3-wei.deng@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5MSBTYWx0ZWRfX9dwHSk4XrhSH
 YVWkF7YBDTqlqSp59qcOlDZ2Tn7V1tm2sbJV4L0tFoKIrB3hzQvohP3SVsN0fPW4CyQzJTDUguU
 97slcOwiuKdplnoPqhj58ovpGnlsuxbBT9eda6zwj0FWqOKR8h5szm49qtu/oK3LP6bF+HSisZR
 2VEWukvgry38cgS/lUvic2RbBI7ESWxlGyioX6EdLGzLfBgX8U7hLLzlF/48j6y4ryQT/dXz3PG
 CU0QNeK9KplDcujcZixtuFW7Klug0VHE4y5xmShhSvcqsAFuMG5ENAaewCIZDlAtvGbVgR6z95A
 zi0XY0mQCClqownNU6vrqxQwo1e+50EiZenFen9q+F4XsfmbWFtMyp3h421EcaS764K40mdUDRI
 YY4w5K/KwQqWMo+15nGALZ36QAU/tEpHy4joYaAYmbx4dyT1uceEN0nWVswgsb1ipM2f+Xqjchi
 gpzAaFSwNBQBaJcyASQ==
X-Proofpoint-GUID: QJASx-J6bhsHXLQf51qgm-bTON2GvUXS
X-Proofpoint-ORIG-GUID: QJASx-J6bhsHXLQf51qgm-bTON2GvUXS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5MSBTYWx0ZWRfX8Spzo+xUjQ+K
 cnAeG6ndARYHtUMU7R35AD9OIYasXOd64G+Wzdf0M2RxBH3yE9uHYMBFYI34jo4OI9E5YS7PFmt
 iJr1Oy/BH8rDISZDfEtPRziZJDBVU/E=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a33bf16 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=JePoLz6rm3lXWa06D34A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180091

On 6/8/26 11:17 AM, Wei Deng wrote:
> The lemans EVK has the PCIe M.2 Mechanical Key E connector to connect
> wireless connectivity cards over PCIe and UART interfaces. Hence,
> describe the connector node and link it with the PCIe 0 Root Port and
> UART17 nodes through graph port/endpoint.
> 
> Also add 'compatible = "pciclass,0604"' to the pcieport0 node in
> lemans.dtsi to allow the PCI subsystem to associate the DT node with
> the PCI-to-PCI bridge device.

Ideally this would be a separate change

Also, b4 can't grab this patch since there's something wrong with the
threading (multiple series in a single thread) - please switch to using
b4 for submissions yourself to avoid such mistakes.

https://b4.docs.kernel.org/en/latest/

Konrad
