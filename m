Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA3537DE84
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266396; cv=none; b=OuvKhAmTyVNu+dFx/xsSyUCXMizbZqhalU/dO+0BltblI7mO/EhC22CD8hZ2yDEtYtH9h4vSaOsaVLZFtIdwO3zZumZDgjvmC7oS/m5qbGQol3qDZfJkKq2Wz9Q4Dxw+SnSrSGZFELl2erfx4YWFTPMWSpD7pgrRrCmKF87tNKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266396; c=relaxed/simple;
	bh=WoB/OmRTJJSpwrFDmSdgZWJFQWCDuGhALHK9eDbmU5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxOTqybCmncUPJSHAoKCgvY70kLaXj81qMALV/puPHh1H4TJC6TABr/AKWiLK7GcksSM4KvyXkITQEjWaNWWI41047RRMea9S9nY4SM/FtZjIZ3tKHKaKlddQcPJOiseZeO59k5kktgkplBVTtcPmua9A+xyR+l3PedwEINg9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cC9zX2zh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dUY/tBSI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cC9zX2zh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dUY/tBSI"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJl961713243
	for <linux-pci@vger.kernel.org>; Tue, 1 Sep 2026 12:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N1V5W/dk7uvrao3kIiYVC1yNFS+4miACgUKafvhC/tM=; b=cC9zX2zhsWv/2iHW
	nJz+YIv6Xhm9qbdp8ujaUqDifYvrkHk+jbv3mGUnOGkGexcckoGlV5jL+W+WO9My
	WuTbxpzrWVoEOo0RHQYD0xJFqIIebBaB7+TCoRIL/yngwCvk02qzd8oZJO+ba/9C
	AWvp6HEMqSEI/exf/sO/yAT130uNYmCgnwoBWhzxzuyvJWwEuRL2Buf0y0GfDJ72
	yV7adgL42wztd+jJ4VRNVozhKBjrhnXXlN8Bgx+s8J7Yr+YRvDrGIZqxEterP5SJ
	3ZLhu5LsaqX1GaO4nZunfg3lB5oOjQfTcH1pZZFDylLcYXg4oSpQccig+KgU19pf
	waFzhA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdndxahen-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 12:39:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930a312222dso92746285a.2
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 05:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788266394; x=1788871194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1V5W/dk7uvrao3kIiYVC1yNFS+4miACgUKafvhC/tM=;
        b=dUY/tBSIbHt2n6FLodAI0LA9yXQrHERH/l7Q4goph9ijFlHFGm42bm8YehiF+0qHTz
         5LMcyv3//lnmYMs9LVnAUuEcnXHYVTclUgxjs4nOqJXbcaIrNzijLBVNivo92KW6/VIN
         I1uxOGqNbF0F59+xBJdl9LpE5F1V8Ml2d3CWJ4BIdsjUhTNtKstzBp/cJSu2VECxrDF/
         X+xmqCmazkA16CilfZWpXPJjZAL7bblTrmU8YIpfaJQ2XcBaYMeD6mGkf6y/G0eBmYbD
         YluZdGzhD59YlASKcHUPWucXEYwKmneiVjYAuICWJUsjPtyOwG06s40O00h2P5C4hjfB
         6Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788266394; x=1788871194;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N1V5W/dk7uvrao3kIiYVC1yNFS+4miACgUKafvhC/tM=;
        b=mH36/kWVVhGwL5HQKdS8Ti7Cx5pHvo+2957sDkec5T8tl+2yvks2Xl3blAW8K3vgEW
         kLvUtsEfNTttfqQ38BfgT/M8zDD+BuMBMiWe9DdXee5iinH1/bYoUGGRHNdDdxVqtkWj
         HxBTR6tBJTMr6KU64n71WbVJhx5OA6fDRiwUYVaaRgl0NvOQH0P1LHzBjTf4/iKxMqvd
         XXkdTHkkSsPnf/aAqXvbJ5b1Z0SEtyG5wH/+BQIxxtYfGnH0iWiIffhX937W0Ck/f6Te
         d9DjLP3semS9064J6s3v6SXayasmuDNJGTqd1rvuLnk5GrZAFt8bHlVt41N10nR5hfL4
         291w==
X-Gm-Message-State: AFuF++kzzXKaqtJ3S5ln5lrpni5avEMFa4+3rmwZEDBPxD1U1vtcmfum
	SZ6F+BcrD79A6KNIrxPZIqjZBkCVKLqAjra3qqq1i/uEoOLtMLIkXTcyFas5kdrEz9pjTecURS+
	vnE3Fej2GenOoRSH4K2hZJ9avRTT94ZXhCaYDpGV3N+FUf8IXi3ipx/90VJAx+IiwFGVl0uY=
X-Gm-Gg: AR+sD13o5HZKG/ZMXg2B5vY6mnUVCMPzL561KSe2+r/gt5/xGWtcpRRUlwcesFgM1lx
	5O0/YrVD5LQZ8ih/UPuB5Yr/YlXS+T5QG36GZbpQDnGjmYNzi5VeFRduFZaUWiCJFF//zRpWemH
	E4lkNq91ks8YILyLKljA4TsEAVimbDv/pZSLl8lpHCackSXTHcxqNktVapdC8Kw7cav1VJoaV0H
	ucvBNfilWPeSFyDyoez70WTvz3XHlbFR8+4I5kfx8H+AteGJU25uoqCHT6Z2O2bpXjRakAgDY+R
	egRWsejnI7OLLO3Rxp6h/E4V+oYzI9aDXaQpBSdYXFh42nwr7ceYLqkJ+j285TcNQQWj+eNmkLS
	VlM4F1mffp/SeezD77Ifaeg==
X-Received: by 2002:a05:620a:f10:b0:939:216c:59dd with SMTP id af79cd13be357-939287b1e3bmr1525533385a.4.1788266393544;
        Tue, 01 Sep 2026 05:39:53 -0700 (PDT)
X-Received: by 2002:a05:620a:f10:b0:939:216c:59dd with SMTP id af79cd13be357-939287b1e3bmr1525530885a.4.1788266393064;
        Tue, 01 Sep 2026 05:39:53 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a66d052d81sm760433a12.23.2026.09.01.05.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 05:39:52 -0700 (PDT)
Message-ID: <74c0fc35-a56d-4297-9fcb-23e2df8646c3@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 14:39:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: qcom: Block accesses to downstream devices on
 link down
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>, Xilin Wu <sophon@radxa.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com>
 <178826612782.58092.15490835074765422013.b4-ty@b4>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <178826612782.58092.15490835074765422013.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3kzSc6y18tA23dj6CUBzqTTF_w1JQEuv
X-Proofpoint-ORIG-GUID: 3kzSc6y18tA23dj6CUBzqTTF_w1JQEuv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDExMiBTYWx0ZWRfXy6dQaLILi2dc
 PeD/Nqw3aMJhEFLdSIK7ObJ0wUD6MueFYWaMsg1cEXdLHypNmRJopbS7ZayA4vjBjxdE5qlztCt
 H81yLN1TGEAG+FEh5G/cvPspp56laU8=
X-Authority-Analysis: v=2.4 cv=U8eiy+ru c=1 sm=1 tr=0 ts=6a96c79a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AFY7VbZHp1LxXVr_yegA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDExMiBTYWx0ZWRfXyA0fCPMX3IOx
 9D3uOvfhQRBJ1hzcJptl1fe/Z5Qkm1jUzjJGnLMme5/0arOzyrlv3fy40NPZwqqg/Xkm3JMn/T3
 GiIm6gElyzTm6a6butNhicHmkt7MYMBn5U+A4g9jQOAr7lafFzZL3uiTQYrHIPs636L5rMzwnE3
 ykA5hW9+slermUuUEySNknktJgbccuk9P3jomSqnmuusjFy2Jd4Oy1pGylcROHSGsL50ISG7y0j
 qvT3Hmxc1xv9xddEVriMl9qV9oIn4FMPSWCSJS3/7qEIlWTG8336HIf3/zBzbw//icRKmnSm+8g
 qZo1BCDM3yyAgXaGJWDe7mpGV4SKARzw3xObHYrm8IGhg9t6Lrl193GI+a96NdWeomSZ88eSxac
 molcIpiIvemX8bl8MA3O8dF8veoseNzdECSoAfW0j9NR1ZCfXHMCavh66n4aAbYHvxHWJHf77Ey
 vgZNR/daBPMzJrDh+OA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010112

On 9/1/26 2:35 PM, Manivannan Sadhasivam wrote:
> 
> On Wed, 19 Aug 2026 23:36:54 -0700, Qiang Yu wrote:
>> After a PCIe link goes down, software may still access the BAR (MMIO)
>> space or configuration space of devices behind that link before recovery
>> has run. As the link is down, these accesses never complete, resulting in
>> a storm of Completion Timeout AERs.
>>
>> Use the controller's ECAM blocker to drop these accesses to the PCIe
>> address space as soon as the link-down interrupt fires, so that Completion
>> Timeout AERs are reduced. The blocked range covers the entire address
>> space (base 0x0, all-ones limit), since the Root Port's own DBI/iATU
>> register space remains accessible regardless.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] PCI: qcom: Block accesses to downstream devices on link down
>       commit: 86624b718f94517b26f96c1d7beb7632e5562afd

Could this be a fix for

https://lore.kernel.org/linux-arm-msm/b461c125-947b-4e06-b502-abb354e0cba6@oss.qualcomm.com/

?

(+Xilin)

Konrad
